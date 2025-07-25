table 53033 "Supplier Evaluation Document"
{
    Caption = 'Supplier Evaluation Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quote No."; Code[50])
        {
            Caption = 'Quote No.';
            DataClassification = CustomerContent;
        }
        field(2; "Document Code"; Code[50])
        {
            Caption = 'Document Code';
            DataClassification = CustomerContent;
        }
        field(3; "Document Name"; Text[250])
        {
            Caption = 'Document Name';
            DataClassification = CustomerContent;
        }
        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = CustomerContent;
        }
        field(5; Submitted; Boolean)
        {
            Caption = 'Submitted';
            DataClassification = CustomerContent;
        }
        field(6; "Supplier Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Code';
        }
    }

    keys
    {
        key(PK; "Quote No.", "Document Code")
        {
            Clustered = true;
        }
    }
}





