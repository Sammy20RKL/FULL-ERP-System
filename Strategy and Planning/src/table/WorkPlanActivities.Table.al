table 65018 "WorkPlan Activities"
{
    DrillDownPageId = "WorkPlan Activity";
    LookupPageId = "WorkPlan Activity";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Objective Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Objectives";
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Objective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

