table 65006 "Strategic Activities"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Strategy Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Strategies."Strategic Code";

            trigger OnValidate()
            begin
                Clear(Description);
                Strategies.Reset();
                Strategies.SetRange("Strategic Code", "Strategy Code");
                if Strategies.FindFirst() then
                    Description := Strategies."Objective Description"
            end;
        }
        field(4; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Activity; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Output; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Performance Indicator"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }
        field(14; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(16; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Fiscal Year" := Date2DMY("End Date", 3)
            end;
        }
        field(18; "Fiscal Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No", "Strategy Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Strategies: Record Strategies;
}

