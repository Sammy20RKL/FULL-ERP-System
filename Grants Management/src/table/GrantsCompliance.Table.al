table 60032 "Grants Compliance"
{
    //DrillDownPageID = 39005897;
    //LookupPageID = 39005897;

    fields
    {
        field(1; "Grant No"; Code[20])
        {
        }
        field(2; "Compliance Code"; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Compliance; Boolean)
        {
        }
        field(5; User; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Comments; Text[250])
        {
        }
        field(8; "Date Issued"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Grant No", "Compliance Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

