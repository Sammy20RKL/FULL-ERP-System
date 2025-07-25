table 65027 "Project Budget"
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
        field(3; Activity; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Budgeted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Line"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GlAcc.Get("Budget Line") then
                    "Budgeted Amount" := GlAcc."Budgeted Amount"
            end;
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

    var
        GlAcc: Record "G/L Account";
}

