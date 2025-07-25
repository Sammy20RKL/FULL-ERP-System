table 65021 "WorkPlan Line Activities"
{

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
            TableRelation = "WorkPlan Objectives".Code;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Activity Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Activities";

            trigger OnValidate()
            begin
                fnActivity.Reset();
                fnActivity.SetRange(Code, "Activity Code");
                if fnActivity.FindFirst() then
                    Description := fnActivity.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Activity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        fnActivity: Record "WorkPlan Activities";
}

