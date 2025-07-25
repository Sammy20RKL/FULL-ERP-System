page 65004 Strategies
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = Strategies;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic Issue';
                    ToolTip = 'Specifies the value of the Strategic Issue field.';
                }
                field("Objective Description"; Rec."Objective Description")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Strategic Code"; Rec."Strategic Code")
                {
                    Caption = 'Strategy';
                    ToolTip = 'Specifies the value of the Strategy field.';
                }
                field("Strategic Name"; Rec."Strategic Name")
                {
                    Caption = 'Strategic Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Strategic Name field.';
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(Output; Rec.Output)
                {
                    Caption = 'Outcome';
                    ToolTip = 'Specifies the value of the Outcome field.';
                }
                field("Performance Indicator"; Rec."Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator field.';
                }
                field("Total Target"; Rec."Total Target")
                {
                    ToolTip = 'Specifies the value of the Total Target field.';
                }
                field("Year 1 Target"; Rec."Year 1 Target")
                {
                    ToolTip = 'Specifies the value of the Year 1 Target field.';
                }
                field("Year 2 Target"; Rec."Year 2 Target")
                {
                    ToolTip = 'Specifies the value of the Year 2 Target field.';
                }
                field("Year 3 Target"; Rec."Year 3 Target")
                {
                    ToolTip = 'Specifies the value of the Year 3 Target field.';
                }
                field("Year 4 Target"; Rec."Year 4 Target")
                {
                    ToolTip = 'Specifies the value of the Year 4 Target field.';
                }
                field("Year 5 Target"; Rec."Year 5 Target")
                {
                    ToolTip = 'Specifies the value of the Year 5 Target field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
                field("Name of Responsible"; Rec."Name of Responsible")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Name of Responsible field.';
                }
                field("Total Actual"; Rec."Total Actual")
                {
                    ToolTip = 'Specifies the value of the Total Actual field.';
                }
                field("Year 1 Actual"; Rec."Year 1 Actual")
                {
                    ToolTip = 'Specifies the value of the Year 1 Actual field.';
                }
                field("Year 2 Actual"; Rec."Year 2 Actual")
                {
                    ToolTip = 'Specifies the value of the Year 2 Actual field.';
                }
                field("Year 3 Actual"; Rec."Year 3 Actual")
                {
                    ToolTip = 'Specifies the value of the Year 3 Actual field.';
                }
                field("Year 4 Actual"; Rec."Year 4 Actual")
                {
                    ToolTip = 'Specifies the value of the Year 4 Actual field.';
                }
                field("Year 5 Actual"; Rec."Year 5 Actual")
                {
                    ToolTip = 'Specifies the value of the Year 5 Actual field.';
                }
                field("Total Budget"; Rec."Total Budget")
                {
                    ToolTip = 'Specifies the value of the Total Budget field.';
                }
                field("Year 1 Budget"; Rec."Year 1 Budget")
                {
                    ToolTip = 'Specifies the value of the Year 1 Budget field.';
                }
                field("Year 2 Budget"; Rec."Year 2 Budget")
                {
                    ToolTip = 'Specifies the value of the Year 2 Budget field.';
                }
                field("Year 3 Budget"; Rec."Year 3 Budget")
                {
                    ToolTip = 'Specifies the value of the Year 3 Budget field.';
                }
                field("Year 4 Budget"; Rec."Year 4 Budget")
                {
                    ToolTip = 'Specifies the value of the Year 4 Budget field.';
                }
                field("Year 5 Budget"; Rec."Year 5 Budget")
                {
                    ToolTip = 'Specifies the value of the Year 5 Budget field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Activities)
            {
                RunObject = page Activities;
                RunPageLink = Code = field(Code);
                ToolTip = 'Executes the Activities action.';
            }
        }
    }
}

