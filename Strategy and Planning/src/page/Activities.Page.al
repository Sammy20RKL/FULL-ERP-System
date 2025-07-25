page 65006 Activities
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Strategic Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Strategy Code"; Rec."Strategy Code")
                {
                    ToolTip = 'Specifies the value of the Strategy Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(Output; Rec.Output)
                {
                    ToolTip = 'Specifies the value of the Output field.';
                }
                field("Performance Indicator"; Rec."Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Sub Activities")
            {
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Sub Activities";
                RunPageLink = "Activity Code" = field("Strategy Code");
                ToolTip = 'Executes the Sub Activities action.';
                Visible = false;
            }
        }
    }
}

