table 53012 "Tender Mandatory Requirements"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender No';
        }
        field(2; "Mandatory Requirement"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory Requirement';
        }
    }

    keys
    {
        key(Key1; "Tender No", "Mandatory Requirement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





