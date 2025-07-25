page 65032 "Project Activities"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Project Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Visible = false;
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(Objective; Rec.Objective)
                {
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Strategic Objective"; Rec."Strategic Objective")
                {
                    ToolTip = 'Specifies the value of the Strategic Objective field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("No of Days"; Rec."No of Days")
                {
                    ToolTip = 'Specifies the value of the No of Days field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Completion Date"; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                    Visible = false;
                }
                field("Cmmencement Date"; Rec."Cmmencement Date")
                {
                    Caption = 'Comencement Date';
                    ToolTip = 'Specifies the value of the Comencement Date field.';
                    Visible = false;
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    ToolTip = 'Specifies the value of the Budget Line field.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ToolTip = 'Specifies the value of the Budgeted Amount field.';
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ToolTip = 'Specifies the value of the Actual Spent field.';
                }
                field(Assumption; Rec.Assumption)
                {
                    ToolTip = 'Specifies the value of the Assumption field.';
                }
                field(Milestone; Rec.Milestone)
                {
                    ToolTip = 'Specifies the value of the Milestone field.';
                }
                field(KPI; Rec.KPI)
                {
                    ToolTip = 'Specifies the value of the KPI field.';
                }
                field("Budgetary Requirement"; Rec."Budgetary Requirement")
                {
                    ToolTip = 'Specifies the value of the Budgetary Requirement field.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Project.Reset();
        Project.SetRange(Code, Rec.Code);
        if Project.FindFirst() then begin
            //Project.TESTFIELD("WorkPlan Code");
            Rec."Workplan No." := Project."WorkPlan Code";
        end;
    end;

    var
        Project: Record "Project Header";
}

