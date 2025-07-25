table 65009 "Sub Activities"
{

    fields
    {
        field(1; "Activity Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Responsible Employee"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(3; "Sub Activity"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Strategic Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Activities"."Strategy Code";
        }
    }

    keys
    {
        key(Key1; "Activity Code", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

