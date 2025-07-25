table 53044 "Project Team"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "New Project Header";
            Caption = 'Project No';
        }
        field(2; "Full Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Full Name';
        }
        field(3; "ID No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ID No';
        }
        field(4; Company; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Company';
        }
    }

    keys
    {
        key(Key1; "Project No", "ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





