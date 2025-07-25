table 53027 "Prospective Suppliers"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Prospective Supplier Drilldown";

    fields
    {
        field(1; "Ref No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Ref No.';
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Name';
        }
        field(3; "Physical Address"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Physical Address';
        }
        field(4; "Postal Address"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address';
        }
        field(5; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(6; "E-mail"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'E-mail';

            trigger OnValidate()
            begin
                MailMgt.CheckValidEmailAddress("E-mail");
            end;
        }
        field(7; "Telephone No"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Telephone No';
        }
        field(8; "Mobile No"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Mobile No';
        }
        field(10; "KBA Bank Code"; Code[5])
        {
            DataClassification = CustomerContent;
            TableRelation = Banks;
            Caption = 'KBA Bank Code';
        }
        field(11; "KBA Branch Code"; Code[3])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field("KBA Bank Code"));
            Caption = 'KBA Branch Code';
        }
        field(12; "Bank account No"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank account No';
        }
        field(13; Category; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Category';
        }
        field(14; "Fiscal Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Fiscal Year';
        }
        field(15; Selected; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Selected';
        }
        field(16; "Pre Qualified"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pre Qualified';
        }
        field(17; "Fax No"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax No';
        }
        field(18; "Category Name"; Text[250])
        {
            Caption = 'Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field(Category)));
            Editable = false;
        }
        field(19; "Registration No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Registration No';
        }
        field(21; "Vendor No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
            Caption = 'Vendor No';

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No") then begin
                    Name := UpperCase(Vendor.Name);
                    "Physical Address" := Vendor.Address;
                    "Postal Address" := Vendor.Address;
                    City := Vendor.City;
                    "E-mail" := Vendor."E-Mail";
                    "Telephone No" := Vendor."Phone No.";
                    "Fax No" := Vendor."Fax No.";
                    "Fax No." := Vendor."Fax No.";
                    "Country/Region Code" := Vendor."Country/Region Code";
                    "Post Code" := Vendor."Post Code";
                end;
            end;
        }
        field(22; "Vendor Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "  ",Medical,Law;
            Caption = 'Vendor Type';
        }
        field(23; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Approved,Closed';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,Approved,Closed;
            Caption = 'Status';
        }
        field(24; Attachment; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Attachment';
        }
        field(25; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(27; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode(City, "Post Code", County, "Country/Region Code");
                if "Country/Region Code" <> xRec."Country/Region Code" then;
                //  VATRegistrationValidation;
            end;
        }
        field(28; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(29; "Sub County"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sub County';
        }
        field(30; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(31; "Contract Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Period';

            trigger OnValidate()
            begin
                if "Contract Start Date" <> 0D then
                    "Contract End Date" := CalcDate("Contract Period", "Contract Start Date");
            end;
        }
        field(32; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(33; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(34; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(35; "Project Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Project Code';
        }
        field(36; Prospective; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prospective';
        }
        field(37; Score; Decimal)
        {
            CalcFormula = sum("Supplier Evaluation Line".Score where(Supplier = field("No."),
                                                                "Quote No" = field("Project Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Score';
        }
        field(38; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(39; "Company PIN No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Company PIN No.';

            trigger OnValidate()
            begin
                /*Vendor.Reset();
                Vendor.SetRange("KRA PIN", "Company PIN No.");
                if Vendor.FindFirst() then
                    Error('Vendor with PIN %1 already exists');*/

                //Get Similar KRA PIN
                /*ProspectiveRec.Reset();
                ProspectiveRec.SetRange(ProspectiveRec."Company PIN No.", "Company PIN No.");
                if ProspectiveRec.FindFirst() then
                    TransferFields(ProspectiveRec, false);*/
            end;
        }
        field(40; Title; Enum Salutations)
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(41; "Organization Type"; Enum OrganizationTypes)
        {
            DataClassification = CustomerContent;
            Caption = 'Organization Type';
        }
        field(42; "Bank Account Type"; Enum SupplierBankAccountTypes)
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Type';
        }
        field(43; "Supplier Types"; Enum SupplierTypes)
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Types';
        }
        field(44; "Company Reg No."; Code[50])
        {
            Caption = 'Company Registration No.';
            DataClassification = CustomerContent;
        }
        field(45; "Contact Person Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Person Name';
        }
        field(46; "Job Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Title';
        }
        field(47; "Contact Phone No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Phone No.';
        }
        field(48; "Contact E-Mail Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact E-Mail Address';

            trigger OnValidate()
            begin
                MailMgt.CheckValidEmailAddress("Contact E-Mail Address");
            end;
        }
        field(49; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
        }
        field(50; "PIN Certificate Expiry"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Certificate Expiry';
        }
        field(51; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request" where("Process Type" = const(Tender), "Tender Type" = const(Open));
            Caption = 'Tender No.';

            trigger OnValidate()
            begin
                if TenderRec.Get("Tender No.") then begin
                    TenderLine.Reset();
                    TenderLine.SetRange(TenderLine."Document No.", TenderRec."No.");
                    if TenderLine.FindFirst() then begin
                        repeat
                            ProspectiveSupplierLine.Init();
                            ProspectiveSupplierLine."Response No" := "No.";
                            ProspectiveSupplierLine."Line No" := TenderLine."Line No";
                            ProspectiveSupplierLine.Type := TenderLine.Type;
                            ProspectiveSupplierLine.No := TenderLine."No";
                            ProspectiveSupplierLine.Description := TenderLine.Description;
                            ProspectiveSupplierLine.Quantity := TenderLine.Quantity;
                            ProspectiveSupplierLine."Unit of Measure" := TenderLine."Unit of Measure";
                            ProspectiveSupplierLine."Procurement Plan" := TenderLine."Procurement Plan";
                            ProspectiveSupplierLine."Procurement Plan Item" := TenderLine."Procurement Plan Item";
                            ProspectiveSupplierLine."Budget Line" := TenderLine."Budget Line";
                            ProspectiveSupplierLine."Shortcut Dimension 1 Code" := TenderLine."Shortcut Dimension 1 Code";
                            ProspectiveSupplierLine.Validate("Shortcut Dimension 1 Code");
                            ProspectiveSupplierLine."Shortcut Dimension 2 Code" := TenderLine."Shortcut Dimension 2 Code";
                            ProspectiveSupplierLine.Validate("Shortcut Dimension 2 Code");
                            ProspectiveSupplierLine."Request Date" := TenderRec.TenderOpeningDate;
                            ProspectiveSupplierLine."Expected Receipt Date" := DT2Date(TenderRec.TenderClosingDate);
                            ProspectiveSupplierLine.Committed := TenderLine.Committed;
                            ProspectiveSupplierLine.Specification := TenderLine.Specification;
                            ProspectiveSupplierLine."VAT Prod. Posting Group" := TenderLine."VAT Prod. Posting Group";
                            ProspectiveSupplierLine."VAT %" := TenderLine."VAT %";
                            ProspectiveSupplierLine."Amount Inclusive VAT" := TenderLine."Amount Inclusive VAT";
                            if not ProspectiveSupplierLine.Get(ProspectiveSupplierLine."Response No", ProspectiveSupplierLine."Line No") then
                                ProspectiveSupplierLine.Insert(true);
                        until TenderLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(52; "Supplier Status"; Enum "Supplier Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Status';
        }
        field(53; "Committee Code"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Committee Code';
        }
        field(54; "Tenders Applied"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prospective Supplier Tender" where("Prospect No." = field("No.")));
            Editable = false;
            Caption = 'Tenders Applied';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name)
        {
        }
    }

    trigger OnInsert()
    begin
        PurchSetup.Get();
        if "No." = '' then begin
            PurchSetup.TestField("Prospective Suppliers Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Prospective Suppliers Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Date := Today;
    end;

    var
        PostCode: Record "Post Code";
        TenderRec: Record "Procurement Request";
        TenderLine: Record "Procurement Request Lines";
        ProspectiveSupplierLine: Record "Prospective Supplier Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Vendor: Record Vendor;
        MailMgt: Codeunit "Mail Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure CreateVend(var Prequalifiedlist: Record "Prospective Suppliers")
    var
        CategoryRec: Record "Supplier Category";
        Vend: Record Vendor;
    begin
        Prequalifiedlist.TestField(Prequalifiedlist."Company PIN No.");
        Vend.SetCurrentKey("KRA PIN");
        Vend.SetRange(Vend."KRA PIN", Prequalifiedlist."Company PIN No.");
        if Vend.FindFirst() then
            Error('The Vendor %1 PIN No %2 already exists in the system', Vend.Name, Vend."KRA PIN");
        Vend.Init();
        Vend."No." := '';
        Vend.Name := Prequalifiedlist.Name;
        Vend.Address := Prequalifiedlist."Physical Address";
        Vend."Address 2" := Prequalifiedlist."Postal Address";
        Vend."E-Mail" := Prequalifiedlist."E-mail";
        Vend."Phone No." := Prequalifiedlist."Telephone No";
        Vend."Telex No." := Prequalifiedlist."Mobile No";
        Vend.Contact := Prequalifiedlist."Contact Person Name";
        //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
        //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
        Vend."Our Account No." := Prequalifiedlist."Bank account No";
        //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
        Vend."KRA PIN" := Prequalifiedlist."Company PIN No.";
        //Vend.v:=Prequalifiedlist."Registration No";
        if CategoryRec.Get(Prequalifiedlist.Category) then begin
            Vend."Gen. Bus. Posting Group" := CategoryRec."Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group" := CategoryRec."VAT Bus. Posting Group";
            Vend."Vendor Posting Group" := CategoryRec."Vendor Posting Group";
        end;
        Vend.Insert(true);
        Prequalifiedlist."Vendor No" := Vend."No.";
        Prequalifiedlist.Modify();
    end;

    procedure CreateVendr(var Prequalifiedlist: Record "Prospective Suppliers"): Code[50]
    var
        PSetup: Record "Purchases & Payables Setup";
        Vend: Record Vendor;
    begin
        PSetup.Get();
        PSetup.TestField("Def Gen. Bus. Posting Group");
        PSetup.TestField("Default Vendor Posting Group");

        Vend.Reset();
        Vend.SetRange(Vend."Prospective No.", Prequalifiedlist."No.");
        if Vend.FindFirst() then
            exit(Vend."No.")
        else begin
            Vend.Init();
            Vend."No." := '';
            Vend.Name := Prequalifiedlist.Name;
            Vend.Address := Prequalifiedlist."Physical Address";
            Vend."Address 2" := Prequalifiedlist."Postal Address";
            Vend."E-Mail" := Prequalifiedlist."E-mail";
            Vend."Phone No." := Prequalifiedlist."Telephone No";
            Vend."Telex No." := Prequalifiedlist."Mobile No";
            Vend.Contact := Prequalifiedlist."Contact Person Name";
            Vend."Our Account No." := Prequalifiedlist."Bank account No";
            Vend."KRA PIN" := Prequalifiedlist."Company PIN No.";
            Vend."Vendor Posting Group" := PSetup."Default Vendor Posting Group";
            Vend."Gen. Bus. Posting Group" := PSetup."Def Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group" := PSetup."Def VAT Bus. Posting Group";
            /*if CategoryRec.Get(Prequalifiedlist.Category) then begin
                Vend."Gen. Bus. Posting Group" := CategoryRec."Gen. Bus. Posting Group";
                Vend."VAT Bus. Posting Group" := CategoryRec."VAT Bus. Posting Group";
                Vend."Vendor Posting Group" := CategoryRec."Vendor Posting Group";
            end;*/
            Vend."PIN Certificate Expiry" := Prequalifiedlist."PIN Certificate Expiry";
            Vend."Prospective No." := Prequalifiedlist."No.";
            Vend.Insert(true);

            Prequalifiedlist."Vendor No" := Vend."No.";
            Prequalifiedlist.Modify();

            exit(Vend."No.");
        end;
    end;
}





