table 53022 "Supplier Selection"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reference No."; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";

            trigger OnValidate()
            begin
                if ProcurementRequest.Get("Reference No.") then begin
                    "Supplier Category" := ProcurementRequest.Category;
                end;
            end;
        }
        field(2; "Supplier Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(3; "Supplier Category"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Supplier Category';
        }
        field(4; Invited; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Invited';
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(6; City; Text[30])
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
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Post Code"; Code[20])
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
        field(9; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(10; County; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(11; "Supplier Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if ("Supplier Category" = filter(<> '')) "Prospective Supplier Category"."Supplier Code" where("Supplier Category" = field("Supplier Category"))
            else
            "Prospective Suppliers"."No.";
            Caption = 'Supplier Code';

            trigger OnValidate()
            begin
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
                InsertBidPrices();

                ProcurementRequest.Get("Reference No.");
                if ProcurementRequest."Process Type" in [ProcurementRequest."Process Type"::RFP,
                                                        ProcurementRequest."Process Type"::EOI] then
                    InsertPreliminaryEvaluationItems();
            end;
        }
        field(12; Notified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Notified';
        }
        field(13; "Supplier Email"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Email';
        }
        field(14; Contact; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';
        }
        field(15; TelephoneContact; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'TelephoneContact';
        }
        field(16; "Applicant Stage"; Enum "Tender Applicant Stage")
        {
            DataClassification = ToBeClassified;
            Caption = 'Applicant Stage';
        }
        field(17; "Total Bid Sum"; Decimal)
        {
            Caption = 'Total Bid Sum';
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Price Line"."Amount Inclusive VAT" where("Quote No" = field("Reference No."), "Vendor No" = field("Supplier Code")));
            Editable = false;
        }
        field(18; "Applicant Comments"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(19; "Process Type"; Enum "Procurement Process Type")
        {
            Caption = 'Process Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request"."Process Type" where("No." = field("Reference No.")));
            Editable = false;
        }
        field(20; "Date Submitted"; Date)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Reference No.", "Supplier Code")
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
        Invited := true;
    end;

    trigger OnDelete()
    begin
        SupplierPriceLine.SetRange("Quote No", "Reference No.");
        SupplierPriceLine.SetRange("Vendor No", "Supplier Code");
        if SupplierPriceLine.FindSet() then
            SupplierPriceLine.DeleteAll();

        TenderApplicantEvaluation.SetRange("Tender No.", "Reference No.");
        TenderApplicantEvaluation.SetRange("Supplier Code", "Supplier Code");
        if TenderApplicantEvaluation.FindSet() then
            TenderApplicantEvaluation.DeleteAll();
    end;

    var
        PostCode: Record "Post Code";
        ProcurementRequest: Record "Procurement Request";
        PreqSuppliers: Record "Prospective Suppliers";
        SupplierPriceLine: Record "Supplier Price Line";
        ProcRequestLine: Record "Procurement Request Lines";
        TenderApplicantEvaluation: Record "Tender Applicant Evaluation";
        TenderEvaluationSetup: Record "Tender Evaluation Setup";
        TenderEvaluationSetupLine: Record "Tender Evaluation Setup Line";

    procedure InviteSuppliersByCategory()
    var
        SupplierCategories: page "Supplier Categories";
        SelectionFilter: Text;
    begin
        SelectionFilter := SupplierCategories.SelectMultipleCategories();

        if SelectionFilter <> '' then
            AddSuppliersByCategory(SelectionFilter);
    end;

    local procedure AddSuppliersByCategory(SelectionFilter: Text)
    var
        SupplierCategory: Record "Supplier Category";
        ProspectiveSuppliers: Record "Prospective Suppliers";
        ProspectiveSupplierCategory: Record "Prospective Supplier Category";
        SupplierSelection: Record "Supplier Selection";
    begin
        SupplierCategory.SetFilter(Code, SelectionFilter);
        if SupplierCategory.FindSet() then begin
            repeat
                ProspectiveSupplierCategory.Reset();
                ProspectiveSupplierCategory.SetRange("Supplier Category", SupplierCategory.Code);
                ProspectiveSupplierCategory.SetFilter("Supplier Code", '<>%1', '');
                if ProspectiveSupplierCategory.FindSet() then
                    repeat
                        SupplierSelection.Init();
                        SupplierSelection."Reference No." := Rec."Reference No.";
                        SupplierSelection.Validate("Supplier Category", ProspectiveSupplierCategory."Supplier Category");
                        SupplierSelection.Validate("Supplier Code", ProspectiveSupplierCategory."Supplier Code");
                        SupplierSelection.Validate(Invited, true);
                        if not SupplierSelection.Get("Reference No.", ProspectiveSupplierCategory."Supplier Code") then
                            SupplierSelection.Insert(true);
                    until ProspectiveSupplierCategory.Next() = 0;
            until SupplierCategory.Next() = 0;
        end;
    end;

    local procedure InsertBidPrices()
    begin
        ProcRequestLine.Reset();
        ProcRequestLine.SetRange("Document No.", "Reference No.");
        if ProcRequestLine.FindSet() then begin
            /* SupplierPriceLine.SetRange("Quote No", "Reference No.");
            SupplierPriceLine.SetRange("Vendor No", "Supplier Code");
            if SupplierPriceLine.FindSet() then
                SupplierPriceLine.DeleteAll(); */
            repeat
                SupplierPriceLine.Init();
                SupplierPriceLine."Quote No" := "Reference No.";
                SupplierPriceLine.Validate("Vendor No", "Supplier Code");
                SupplierPriceLine.Validate(Type, ProcRequestLine.Type);
                SupplierPriceLine.Validate("No.", ProcRequestLine.No);
                SupplierPriceLine.Validate("Line No", ProcRequestLine."Line No");
                SupplierPriceLine.Validate(Description, ProcRequestLine.Description);
                SupplierPriceLine.Quantity := ProcRequestLine.Quantity;
                SupplierPriceLine."Unit of Measure" := ProcRequestLine."Unit of Measure";
                ProcRequestLine.CalcFields(Specification);
                SupplierPriceLine.Specification := ProcRequestLine.Specification;
                if not SupplierPriceLine.Get("Reference No.", "Supplier Code", ProcRequestLine.Type, ProcRequestLine.No, ProcRequestLine."Line No") then
                    SupplierPriceLine.Insert();
            until ProcRequestLine.Next() = 0;
        end;
    end;

    procedure InsertPreliminaryEvaluationItems()
    var
        TenderApplicantEvaluation: Record "Tender Applicant Evaluation";
        TenderEvaluationSetup: Record "Tender Evaluation Setup";
        TenderEvaluationSetupLine: Record "Tender Evaluation Setup Line";
    begin
        TenderEvaluationSetup.Reset();
        TenderEvaluationSetup.SetRange("Tender No.", "Reference No.");
        TenderEvaluationSetup.SetRange("Evaluation Criteria", TenderEvaluationSetup."Evaluation Criteria"::"Preliminary Evaluation");
        if TenderEvaluationSetup.FindSet() then begin
            //Delete first
            TenderApplicantEvaluation.SetRange("Tender No.", "Reference No.");
            TenderApplicantEvaluation.SetRange(Code, TenderEvaluationSetup."Evaluation Code");
            TenderApplicantEvaluation.SetRange("Supplier Code", "Supplier Code");
            if TenderApplicantEvaluation.FindSet() then
                TenderApplicantEvaluation.DeleteAll();
            repeat
                TenderEvaluationSetupLine.Reset();
                TenderEvaluationSetupLine.SetRange("Tender No.", "Reference No.");
                TenderEvaluationSetupLine.SetRange(Code, TenderEvaluationSetup."Evaluation Code");
                if TenderEvaluationSetupLine.FindSet() then begin
                    repeat
                        TenderApplicantEvaluation.Init();
                        TenderEvaluationSetupLine.CalcFields(Description);
                        TenderApplicantEvaluation.TransferFields(TenderEvaluationSetupLine);
                        TenderApplicantEvaluation.Validate("Supplier Code", "Supplier Code");
                        if not TenderApplicantEvaluation.Get("Reference No.", "Supplier Code", TenderApplicantEvaluation.Code, TenderApplicantEvaluation."Line No.") then
                            TenderApplicantEvaluation.Insert();
                    until TenderEvaluationSetupLine.Next() = 0;
                end;
            until TenderEvaluationSetup.Next() = 0;
        end;
    end;
}





