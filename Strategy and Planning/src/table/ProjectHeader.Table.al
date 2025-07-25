table 65023 "Project Header"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Cost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(7; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Existing From Workplan';
            OptionMembers = New,"Existing From Workplan";
        }
        field(10; "WorkPlan Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Plan Header";

            trigger OnValidate()
            begin
                UpdatePlanLines(Code);
            end;
        }
        field(11; Progress; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Not Started,Ongoing,Completed,Cancelled';
            OptionMembers = ,"Not Started",Ongoing,Completed,Cancelled;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(14; "Language Code (Default)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Has Attachment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            StrategicSetup.Get();
            StrategicSetup.TestField("Project Nos.");
            NoSeriesMgt.InitSeries(StrategicSetup."Project Nos.", xRec."No Series", Today, Code, "No Series");
        end;
    end;

    var
        StrategicSetup: Record "Strategic Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure LineExists(): Boolean
    var
        ProjectLines: Record "Project Activities";
    begin
        ProjectLines.Reset();
        ProjectLines.SetRange(Code, Code);
        ProjectLines.SetFilter("Workplan No.", '<>%1', '');
        exit(ProjectLines.FindFirst());
    end;

    procedure UpdatePlanLines(ProjNum: Code[20])
    var
        ProjectLines: Record "Project Activities";
    begin
        ProjectLines.Reset();
        ProjectLines.SetRange(Code, ProjNum);
        if ProjectLines.FindFirst() then begin
            ProjectLines.DeleteAll();

            ProjectLines.Code := ProjNum;
            ProjectLines."Line No." := 10000;
            ProjectLines."Workplan No." := "WorkPlan Code";
            ProjectLines.Activity := '';
            ProjectLines.Objective := '';
            ProjectLines."Strategic Objective" := '';
            ProjectLines.Insert();
        end;
    end;
}

