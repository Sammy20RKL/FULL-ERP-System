table 65010 "Performance Contracting"
{
    LookupPageId = "Performance Contracting List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Decription; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Time Closed"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Closed BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Strategic Plan"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Plan".Code where(Status = const(Approved));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

