table 53054 "Tender Opening Register"
{
    Caption = 'Tender Opening Register';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[50])
        {
            Caption = 'Tender No.';
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request"."No." where("Process Type" = filter(Tender | "Supplier Prequalification"));
        }
        field(2; Title; Text[250])
        {
            Caption = 'Title';
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request".Title where("No." = field("Tender No.")));
            Editable = false;
        }
        field(3; "Supplier No."; Code[50])
        {
            Caption = 'Supplier No.';
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
        }
        field(4; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers".Name where("No." = field("Supplier No.")));
            Editable = false;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(6; "Date-Time Created"; DateTime)
        {
            Caption = 'Date-Time Created';
            DataClassification = CustomerContent;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(8; "Tender Opened"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Opened';
        }
        field(9; "Tender Committee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Committee No.';
        }
        field(10; "Opened By"; Code[50])
        {
            Caption = 'Opened By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Editable = false;
        }
        field(11; "Date-Time Opened"; DateTime)
        {
            Caption = 'Date-Time Opened';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "Document Type"; Option)
        {
            OptionMembers = Tender,"Supplier Prequalification";
            OptionCaption = 'Tender,Supplier Prequalification';
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(13; "Total Bid Sum"; Decimal)
        {
            Caption = 'Total Bid Sum';
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Price Line"."Amount Inclusive VAT" where("Quote No" = field("Tender No."), "Vendor No" = field("Supplier No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Tender No.", "Supplier No.", "User ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Date-Time Created" := CurrentDateTime();
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}






