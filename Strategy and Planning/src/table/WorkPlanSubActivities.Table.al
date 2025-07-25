table 65019 "WorkPlan Sub-Activities"
{
    DrillDownPageId = "WorkPlan Sub Lines";
    LookupPageId = "WorkPlan Sub Lines";

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
        field(4; "Activities Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Responsible Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(6; Output; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "First Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Second Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Third Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Fourth Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Activities Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

