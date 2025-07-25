table 53048 "Tender Applicant"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[20])
        {
            Caption = 'Tender No.';
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";

            trigger OnValidate()
            begin
                /*  if ProcurementRequest.Get("Tender No.") then begin
                     "Supplier Category" := ProcurementRequest.Category;
                 end; */
            end;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Supplier Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(4; "Supplier Category"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Supplier Category';
        }
        field(5; Invited; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invited';
        }
        field(6; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", false);
            end;
        }
        field(8; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", false);
            end;
        }
        field(10; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(11; County; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(12; "Supplier Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Supplier Category" = filter(<> '')) "Prospective Supplier Category"."Supplier Code" where("Supplier Category" = field("Supplier Category"))
            else
            "Prospective Suppliers"."No.";
            Caption = 'Supplier Code';
            trigger OnValidate()
            var
                SupplierExistsErr: Label 'Supplier %1 already exists in Tender Applicants';
            begin
                /* TenderApplicants.Reset();
                TenderApplicants.SetRange("Tender No.", "Tender No.");
                TenderApplicants.SetRange("Supplier Category", "Supplier Category");
                TenderApplicants.SetRange("Supplier Code", "Supplier Code");
                if TenderApplicants.FindFirst() then
                    Error(SupplierExistsErr, TenderApplicants."Supplier Name"); */

                if PreqSuppliers.Get("Supplier Code") then begin
                    "Supplier Name" := PreqSuppliers.Name;
                    Address := PreqSuppliers."Postal Address";
                    City := PreqSuppliers.City;
                    "Phone No." := PreqSuppliers."Telephone No";
                    "Post Code" := PreqSuppliers."Post Code";
                    County := PreqSuppliers.County;
                    "Country/Region Code" := PreqSuppliers."Country/Region Code";
                    "Supplier Email" := PreqSuppliers."E-Mail";
                    Contact := PreqSuppliers."Contact Person Name";
                    TelephoneContact := PreqSuppliers."Mobile No";
                end;

                //Insert to Price Line
                ProcurementRequest.Get("Tender No.");
                if ProcurementRequest."Process Type" <> ProcurementRequest."Process Type"::"Supplier Prequalification" then
                    InsertBidPrices();

                //Insert Preliminary Lines
                InsertPreliminaryEvaluationItems();
            end;
        }
        field(13; Notified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Notified';
        }
        field(14; "Supplier Email"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Email';
        }
        field(15; Contact; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';
        }
        field(16; TelephoneContact; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TelephoneContact';
        }
        field(17; "Tender Applicant Stage"; Enum "Tender Applicant Stage")
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Applicant Stage';
        }
        field(18; "Total Bid Sum"; Decimal)
        {
            Caption = 'Total Bid Sum';
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Price Line"."Amount Inclusive VAT" where("Quote No" = field("Tender No."), "Vendor No" = field("Supplier Code")));
            Editable = false;
        }
        field(19; "Applicant Comments"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(20; "Process Type"; Enum "Procurement Process Type")
        {
            Caption = 'Process Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request"."Process Type" where("No." = field("Tender No.")));
            Editable = false;
        }
        field(21; "Date Submitted"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Tender No.", "Supplier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Supplier Code", "Supplier Name")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Submitted" := Today();
    end;

    trigger OnDelete()
    begin
        SupplierPriceLine.SetRange("Quote No", "Tender No.");
        SupplierPriceLine.SetRange("Vendor No", "Supplier Code");
        if SupplierPriceLine.FindSet() then
            SupplierPriceLine.DeleteAll();

        TenderApplicantEvaluation.SetRange("Tender No.", "Tender No.");
        TenderApplicantEvaluation.SetRange("Supplier Code", "Supplier Code");
        if TenderApplicantEvaluation.FindSet() then
            TenderApplicantEvaluation.DeleteAll();

        TenderOpeningRegister.SetRange("Tender No.", "Tender No.");
        TenderOpeningRegister.SetRange("Supplier No.", "Supplier Code");
        if TenderOpeningRegister.FindSet() then
            TenderOpeningRegister.DeleteAll();

        TenderApplicantCategory.SetRange("Tender No.", "Tender No.");
        TenderApplicantCategory.SetRange("Supplier Code", "Supplier Code");
        if TenderApplicantCategory.FindSet() then
            TenderApplicantCategory.DeleteAll();
    end;

    procedure InsertBidPrices()
    begin
        ProcRequestLine.Reset();
        ProcRequestLine.SetRange("Document No.", "Tender No.");
        if ProcRequestLine.FindSet() then begin
            /* SupplierPriceLine.SetRange("Quote No", "Tender No.");
            SupplierPriceLine.SetRange("Vendor No", "Supplier Code");
            if SupplierPriceLine.FindSet() then
                SupplierPriceLine.DeleteAll(); */
            repeat
                SupplierPriceLine.Init();
                SupplierPriceLine."Quote No" := "Tender No.";
                SupplierPriceLine.Validate("Vendor No", "Supplier Code");
                SupplierPriceLine.Validate(Type, ProcRequestLine.Type);
                SupplierPriceLine.Validate("No.", ProcRequestLine.No);
                SupplierPriceLine.Validate(Description, ProcRequestLine.Description);
                SupplierPriceLine.Quantity := ProcRequestLine.Quantity;
                SupplierPriceLine."Unit of Measure" := ProcRequestLine."Unit of Measure";
                ProcRequestLine.CalcFields(Specification);
                SupplierPriceLine.Specification := ProcRequestLine.Specification;
                if not SupplierPriceLine.Get("Tender No.", "Supplier Code", ProcRequestLine.Type, ProcRequestLine.No) then
                    SupplierPriceLine.Insert();
            until ProcRequestLine.Next() = 0;
        end;
    end;

    procedure InsertPreliminaryEvaluationItems()
    begin
        TenderEvaluationSetup.Reset();
        TenderEvaluationSetup.SetRange("Tender No.", "Tender No.");
        TenderEvaluationSetup.SetRange("Evaluation Criteria", TenderEvaluationSetup."Evaluation Criteria"::"Preliminary Evaluation");
        if TenderEvaluationSetup.FindSet() then begin
            //Delete first
            TenderApplicantEvaluation.SetRange("Tender No.", "Tender No.");
            TenderApplicantEvaluation.SetRange(Code, TenderEvaluationSetup."Evaluation Code");
            TenderApplicantEvaluation.SetRange("Supplier Code", "Supplier Code");
            if TenderApplicantEvaluation.FindSet() then
                TenderApplicantEvaluation.DeleteAll();
            repeat
                TenderEvaluationSetupLine.Reset();
                TenderEvaluationSetupLine.SetRange("Tender No.", "Tender No.");
                TenderEvaluationSetupLine.SetRange(Code, TenderEvaluationSetup."Evaluation Code");
                if TenderEvaluationSetupLine.FindSet() then begin
                    repeat
                        TenderApplicantEvaluation.Init();
                        TenderEvaluationSetupLine.CalcFields(Description);
                        TenderApplicantEvaluation.TransferFields(TenderEvaluationSetupLine);
                        TenderApplicantEvaluation.Validate("Supplier Code", "Supplier Code");
                        if not TenderApplicantEvaluation.Get("Tender No.", "Supplier Code", TenderApplicantEvaluation.Code, TenderApplicantEvaluation."Line No.") then
                            TenderApplicantEvaluation.Insert();
                    until TenderEvaluationSetupLine.Next() = 0;
                end;
            until TenderEvaluationSetup.Next() = 0;
        end;
    end;

    var
        PostCode: Record "Post Code";
        ProcurementRequest: Record "Procurement Request";
        PreqSuppliers: Record "Prospective Suppliers";
        TenderApplicants: Record "Tender Applicant";
        SupplierPriceLine: Record "Supplier Price Line";
        ProcRequestLine: Record "Procurement Request Lines";
        TenderApplicantEvaluation: Record "Tender Applicant Evaluation";
        TenderEvaluationSetup: Record "Tender Evaluation Setup";
        TenderEvaluationSetupLine: Record "Tender Evaluation Setup Line";
        TenderOpeningRegister: Record "Tender Opening Register";
        TenderApplicantCategory: Record "Tender Applicant Category";
}





