table 65008 "Key Results Area"
{
    //DrillDownPageID = "Case Management";
    //LookupPageID = "Case Management";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "KRA Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "KRA Codes"."No.";

            trigger OnValidate()
            begin
                Clear(Description);
                if KCodes.Get("KRA Code") then
                    Description := KCodes.Description;
                Purpose := KCodes.Purpose;
            end;
        }
        field(3; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Purpose; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "KRA Code", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        KCodes: Record "KRA Codes";
}

