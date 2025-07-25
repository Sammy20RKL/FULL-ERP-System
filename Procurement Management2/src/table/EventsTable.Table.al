table 53051 "Events.Table"
{
    Caption = 'Events.Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[100])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if No <> xRec.No then
                    NoSeriesMgt.TestManual(PurchandPayableSetup."Event Nos");
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(3; From; Date)
        {
            Caption = 'From';
            DataClassification = ToBeClassified;
        }
        field(4; "To"; Date)
        {
            Caption = 'To';
            DataClassification = ToBeClassified;
        }
        field(5; "No of Days"; Date)
        {
            Caption = 'No of Days';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; Location; Code[100])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
        }
        field(8; "Approval Status"; Enum "Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }

    var

        NoSeriesMgt: Codeunit NoSeriesManagement;

        PurchandPayableSetup: Record "Purchases & Payables Setup";
}






