table 65025 "Project Reporting"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Reporting Requirement"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Notification Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Date Completed"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

