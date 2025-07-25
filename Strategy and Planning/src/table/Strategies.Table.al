table 65007 Strategies
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Strategic Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Purpose; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Objective Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Objective Codes"."No.";

            trigger OnValidate()
            begin
                Clear("Objective Description");
                Objectiv.Reset();
                Objectiv.SetRange("No.", "Objective Code");
                if Objectiv.FindFirst() then
                    "Objective Description" := Objectiv.Description;
            end;
        }
        field(6; "Objective Description"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Strategic Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Codes"."No.";

            trigger OnValidate()
            begin
                Clear("Strategic Description");
                if SCodes.Get("Strategic Code") then
                    "Strategic Name" := SCodes.Description;
                "Strategic Description" := SCodes.Description;
                Purpose := SCodes.Purpose;
            end;
        }
        field(8; "Header No."; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Strategic Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Activity; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Output; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Performance Indicator"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Responsible Person"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Emp.Reset();
                if Emp.Get("Responsible Person") then
                    "Name of Responsible" := Emp.FullName();
            end;
        }
        field(15; "Year 1 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Target" := "Year 1 Target" + "Year 2 Target" + "Year 3 Target" + "Year 4 Target" + "Year 5 Target";
            end;
        }
        field(16; "Year 2 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Target" := "Year 1 Target" + "Year 2 Target" + "Year 3 Target" + "Year 4 Target" + "Year 5 Target";
            end;
        }
        field(17; "Year 3 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Target" := "Year 1 Target" + "Year 2 Target" + "Year 3 Target" + "Year 4 Target" + "Year 5 Target";
            end;
        }
        field(18; "Year 4 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Target" := "Year 1 Target" + "Year 2 Target" + "Year 3 Target" + "Year 4 Target" + "Year 5 Target";
            end;
        }
        field(19; "Year 5 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Target" := "Year 1 Target" + "Year 2 Target" + "Year 3 Target" + "Year 4 Target" + "Year 5 Target";
            end;
        }
        field(20; "Total Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "Year 1 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Actual" := "Year 1 Actual" + "Year 2 Actual" + "Year 3 Actual" + "Year 4 Actual" + "Year 5 Actual"
            end;
        }
        field(23; "Year 2 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Actual" := "Year 1 Actual" + "Year 2 Actual" + "Year 3 Actual" + "Year 4 Actual" + "Year 5 Actual"
            end;
        }
        field(24; "Year 3 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Actual" := "Year 1 Actual" + "Year 2 Actual" + "Year 3 Actual" + "Year 4 Actual" + "Year 5 Actual"
            end;
        }
        field(25; "Year 4 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Actual" := "Year 1 Actual" + "Year 2 Actual" + "Year 3 Actual" + "Year 4 Actual" + "Year 5 Actual"
            end;
        }
        field(26; "Year 5 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Actual" := "Year 1 Actual" + "Year 2 Actual" + "Year 3 Actual" + "Year 4 Actual" + "Year 5 Actual"
            end;
        }
        field(27; "Total Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Year 1 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget" := "Year 1 Budget" + "Year 2 Budget" + "Year 3 Budget" + "Year 4 Budget" + "Year 5 Budget"
            end;
        }
        field(29; "Year 2 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget" := "Year 1 Budget" + "Year 2 Budget" + "Year 3 Budget" + "Year 4 Budget" + "Year 5 Budget"
            end;
        }
        field(30; "Year 3 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget" := "Year 1 Budget" + "Year 2 Budget" + "Year 3 Budget" + "Year 4 Budget" + "Year 5 Budget"
            end;
        }
        field(31; "Year 4 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget" := "Year 1 Budget" + "Year 2 Budget" + "Year 3 Budget" + "Year 4 Budget" + "Year 5 Budget"
            end;
        }
        field(32; "Year 5 Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Budget" := "Year 1 Budget" + "Year 2 Budget" + "Year 3 Budget" + "Year 4 Budget" + "Year 5 Budget"
            end;
        }
        field(33; "Total Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(34; "Name of Responsible"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Objective Code", "Header No.", "Strategic Code", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Strategic Name", "Entry No.", Activity, Output)
        {
        }
    }

    var
        Emp: Record Employee;
        Objectiv: Record "Objective Codes";
        SCodes: Record "Strategic Codes";
}

