table 65030 "Attachment_"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Table Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Attached; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "File Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

