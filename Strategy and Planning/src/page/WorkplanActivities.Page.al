page 65020 "Workplan Activities"
{
    ApplicationArea = All;
    Caption = 'Activities';
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "WorkPlan Activities";

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
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Sub Activities")
            {
                Image = HRSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Workplan Sub-Activities";
                RunPageLink = "Activities Code" = field(Code);
                ToolTip = 'Executes the Sub Activities action.';
            }
        }
    }
}

