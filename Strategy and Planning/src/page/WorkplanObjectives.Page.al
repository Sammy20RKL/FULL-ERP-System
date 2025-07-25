page 65019 "Workplan Objectives"
{
    ApplicationArea = All;
    Caption = 'Objectives';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "WorkPlan Objectives";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Activities)
            {
                Image = HRSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Workplan Activities";
                RunPageLink = "Objective Code" = field(Code);
                ToolTip = 'Executes the Activities action.';
            }
        }
    }
}

