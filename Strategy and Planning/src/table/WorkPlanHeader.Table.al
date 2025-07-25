table 65016 "Work Plan Header"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Shortcut Dimension 1 Code"; Code[20])
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
        field(4; "Shortcut Dimension 2 Code"; Code[20])
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
        field(5; Responsible; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Name; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(10; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Plan Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if (Source = const("Strategic Plan")) "Strategic Plan".Code where(Status = const(Approved)) else if (Source = const("Performance Contract")) "Performance Contracting" where(Closed = const(false));

            trigger OnValidate()
            begin
                Clear(Description);
                if Source = Source::"Strategic Plan" then begin
                    if StrategicPlan.Get("Plan Code") then
                        Description := StrategicPlan.Description;
                end else begin
                    if PerformancePlan.Get("Plan Code") then
                        Description := PerformancePlan.Decription;
                end;
            end;
        }
        field(12; "Financial Year"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name where(Blocked = const(false));

            trigger OnValidate()
            begin
                if Budgt.Get("Financial Year") then begin
                    "Start Date" := Budgt."Start Date";
                    "End Date" := Budgt."End Date";
                end;
            end;
        }
        field(13; "Fiscal Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; User_ID; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Progress; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Not Started,In Progress,Completed,Overdue,Cancelled';
            OptionMembers = ,"Not Started","In Progress",Completed,Overdue,Cancelled;
        }
        field(16; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Strategic Plan,Performance Contract';
            OptionMembers = " ","Strategic Plan","Performance Contract";
        }
        field(17; "Unit of Measure"; Text[250])
        {
            DataClassification = ToBeClassified;
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
            StrategicSetup.TestField("Work Plan Nos.");
            NoSeriesMgt.InitSeries(StrategicSetup."Work Plan Nos.", xRec."No Series", Today, Code, "No Series");
        end;


        User_ID := UserId;
        if UserSetup.Get(UserId) then begin
            UserSetup.TESTFIELD("Employee No.");
            EmpRecs.GET(UserSetup."Employee No.");
            EmpRecs.TestField("Global Dimension 1 Code");
            "Shortcut Dimension 1 Code" := EmpRecs."Global Dimension 1 Code";
        end;
    end;

    var
        EmpRecs: Record Employee;
        Budgt: Record "G/L Budget Name";
        PerformancePlan: Record "Performance Contracting";
        StrategicPlan: Record "Strategic Plan";
        StrategicSetup: Record "Strategic Setup";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

