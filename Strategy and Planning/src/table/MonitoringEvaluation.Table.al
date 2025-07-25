table 65028 "Monitoring & Evaluation"
{

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Mission; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Vision; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Closed BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Time Closed"; Time)
        {
            DataClassification = ToBeClassified;
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
    }
}

