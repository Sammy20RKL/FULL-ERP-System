table 65005 "Strategic Objectives"
{
    DrillDownPageId = "Strategic Objectives";
    LookupPageId = "Strategic Objectives";

    fields
    {
        field(1; "Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Objective Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Objective Codes"."No.";

            trigger OnValidate()
            begin
                Clear("Objective description");
                if SCodes.Get("Objective Code") then
                    "Objective description" := SCodes.Description;
                Purpose := SCodes.Purpose;
            end;
        }
        field(4; "Objective description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "KRA Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Key Results Area"."KRA Code" where("Document No." = field("Document No."));

            trigger OnValidate()
            begin
                Clear("KRA Description");
                KeyResultsArea.Reset();
                KeyResultsArea.SetRange("KRA Code", "KRA Code");
                if KeyResultsArea.FindFirst() then
                    "KRA Description" := KeyResultsArea.Description;
            end;
        }
        field(6; "KRA Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Purpose; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Objective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        KeyResultsArea: Record "Key Results Area";
        SCodes: Record "Strategic Codes";
}

