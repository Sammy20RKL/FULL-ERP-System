table 65024 "Project Activities"
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
        field(3; Activity; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "End Date" := CalcDate(Format("No of Days") + 'D', "Start Date")
            end;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Not Started,In Progress,Completed,Overdue,Cancelled';
            OptionMembers = ,"Not Started","In Progress",Completed,Overdue,Cancelled;
        }
        field(7; "Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Cmmencement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Objective; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Line Objectives"."Objective Code" where(Code = field("Workplan No."));

            trigger OnValidate()
            begin
                Clear("Strategic Objective");
                WorkPlanObj.Reset();
                WorkPlanObj.SetRange(Code, "Workplan No.");
                WorkPlanObj.SetRange("Objective Code", Objective);
                if WorkPlanObj.FindFirst() then
                    "Strategic Objective" := WorkPlanObj.Description;
            end;
        }
        field(10; "Strategic Objective"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Budgeted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual Spent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "No of Days"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Start Date" <> 0D then
                    Validate("Start Date");
            end;
        }
        field(15; "Budget Line"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GlAcc.Get("Budget Line") then
                    "Budgeted Amount" := GlAcc."Budgeted Amount"
            end;
        }
        field(16; Remarks; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Workplan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; Assumption; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Milestone; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; KPI; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Budgetary Requirement"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        ProjectHeader: Record "Project Header";
        StrObj: Record "Strategic Objectives";
        WorkPlan: Record "Work Plan Header";
        WorkPlanObj: Record "WorkPlan Line Objectives";
}

