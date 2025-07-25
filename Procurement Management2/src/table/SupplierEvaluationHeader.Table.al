table 53028 "Supplier Evaluation Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'Quote/Tender No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Procurement Request";
            trigger OnValidate()
            var
                ProcRequest: Record "Procurement Request";
            begin
                if ProcRequest.get("Quote No") then
                    Title := ProcRequest.Title;
            end;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            trigger OnValidate()
            begin
                User := UserId;

                PurchSetup.Get();
                if Type = Type::Tender then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."Supplier Evaluation Nos");
                end;

                if Type = Type::Existing then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."Vendor Evaluation Nos");
                end;
            end;

        }
        field(3; Title; Text[250])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(5; User; Code[60])
        {
            DataClassification = CustomerContent;
            Caption = 'User';
        }
        field(6; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'New,Approved,Rejected,Pending Approval';
            OptionMembers = New,Approved,Rejected,"Pending Approval";
            Caption = 'Status';
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(8; "Supplier Code"; Code[50])
        {
            // if Type = Type::Tender then TableRelation = "Prospective Suppliers";
            TableRelation = if (Type = const(Tender)) "Prospective Suppliers"
            else
            if (Type = const(Existing)) Vendor where("Vendor Type" = const(Vendor));
            DataClassification = CustomerContent;
            Caption = 'Supplier Code';

            trigger OnValidate()
            begin
                case Type of
                    Type::Tender:
                        begin
                            if ProspectRec.get("Supplier Code") then begin
                                "Supplier Name" := ProspectRec.Name;
                                Description := 'Supplier Evaluation for ' + "Supplier Name";
                            end;
                        end;
                    Type::Existing:
                        if Vendors.get("Supplier Code") then begin
                            "Supplier Name" := Vendors.Name;
                            Description := "Supplier Name";
                        end;
                end;
            end;
        }
        field(9; "Supplier Name"; text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';

        }
        field(10; Description; text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(11; "Committee No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Committee No.';

        }
        field(12; "Total Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score".Score where("Document No." = field("No.")));
            Editable = false;
            Caption = 'Total Score';
        }
        field(13; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Tender,Existing;
            Caption = 'Type';
        }
        field(14; Period; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Evaluation Periods" where(Active = const(true));
            Caption = 'Period';
        }
        field(15; "Evaluation Stage"; Enum "Tender Evaluation Stage")
        {
            DataClassification = CustomerContent;
            Caption = 'Evaluation Stage';
        }
        field(16; "Total Technical Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score Line".Score where("Document No." = field("No."),
                                                                            "Supplier Code" = field("Supplier Code"),
                                                                            "Evaluation Criteria" = const("Technical Evaluation"),
                                                                            "Score Criteria" = const(Score)));
            Caption = 'Total Technical Score';
        }
        field(17; "Average Technical Score"; Decimal)
        {
            Editable = false;
            Caption = 'Average Technical Score';
            DataClassification = CustomerContent;
        }
        field(18; "Tender Item Type"; Enum "Tender Item Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Item Type';
        }
        field(19; Pass; Boolean)
        {
            Editable = false;
            Caption = 'Pass';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Document No." = field("No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Pass/Fail"),
                                                                        "Pass/Fail" = filter(Fail | " ")));
        }
        field(20; "Overall Pass"; Boolean)
        {
            Editable = false;
            Caption = 'Overall Pass';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Tender No." = field("Quote No"),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Pass/Fail"),
                                                                        "Pass/Fail" = filter(Fail | " ")));
        }
        field(21; Conform; Boolean)
        {
            Editable = false;
            Caption = 'Conform';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Document No." = field("No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Conform/Not Conform"),
                                                                        "Conform/Not Conform" = filter("Not Conform" | " ")));
        }
        field(22; "Overall Conform"; Boolean)
        {
            Editable = false;
            Caption = 'Overall Conform';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Tender No." = field("Quote No"),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Conform/Not Conform"),
                                                                        "Conform/Not Conform" = filter("Not Conform" | " ")));
        }
        field(23; "Blank Pass"; Boolean)
        {
            Editable = false;
            Caption = 'Blank Pass';
            FieldClass = FlowField;
            CalcFormula = exist("Supplier Evaluation Score Line" where("Document No." = field("No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Pass/Fail"),
                                                                        "Pass/Fail" = const(" ")));
        }
        field(24; "Blank Conform"; Boolean)
        {
            Editable = false;
            Caption = 'Blank Conform';
            FieldClass = FlowField;
            CalcFormula = exist("Supplier Evaluation Score Line" where("Document No." = field("No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Criteria" = const("Conform/Not Conform"),
                                                                        "Conform/Not Conform" = const(" ")));
        }
        field(25; "Submitted Preliminary"; Boolean)
        {
            Caption = 'Submitted Preliminary';
            DataClassification = CustomerContent;

        }
        field(26; "Submitted Technical"; Boolean)
        {
            Caption = 'Submitted Technical';
            DataClassification = CustomerContent;
        }
        field(27; "Submitted Prequalification"; Boolean)
        {
            Caption = 'Submitted Prequalification';
            DataClassification = CustomerContent;
        }
        field(28; "Supplier Category"; Code[50])
        {
            Caption = 'Supplier Category';
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category".Code;
        }
        field(29; "Supplier Category Name"; Text[250])
        {
            Caption = 'Supplier Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field("Supplier Category")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(SortingKey; "Quote No", User)
        {
            MaintainSqlIndex = false;
        }
    }

    trigger OnInsert()
    begin

        PurchSetup.Get();
        case Type of
            Type::Tender:
                begin
                    PurchSetup.TestField("Supplier Evaluation Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."Supplier Evaluation Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    "Document Date" := today;
                end;
            Type::Existing:
                begin
                    PurchSetup.TestField("Vendor Evaluation Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."Vendor Evaluation Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    "Document Date" := today;
                end;

        end;
    end;

    var
        ProspectRec: Record "Prospective Suppliers";
        PurchSetup: Record "Purchases & Payables Setup";
        Vendors: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProcMgt: Codeunit "Procurement Management";

    procedure GetAverageScore()
    begin
        "Average Technical Score" := ProcMgt.GetAverageTechnicalScore("Quote No", "Supplier Code");
    end;

}












