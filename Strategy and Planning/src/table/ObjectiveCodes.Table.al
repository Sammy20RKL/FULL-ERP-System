table 65002 "Objective Codes"
{
    DrillDownPageId = "Objective Codes";
    LookupPageId = "Objective Codes";

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    StrategicSetup.Get();
                    NoSeriesMgt.TestManual(StrategicSetup."Objective Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Purpose; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Year := Date2DMY("End Date", 3)
            end;
        }
        field(6; Year; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Objective No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            StrategicSetup.Get();
            StrategicSetup.TestField("Objective Nos.");
            NoSeriesMgt.InitSeries(StrategicSetup."Objective Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        StrategicSetup: Record "Strategic Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

