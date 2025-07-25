page 65007 "Sub Activities"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Sub Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Activity Code field.';
                }
                field("Strategic Code"; Rec."Strategic Code")
                {
                    ToolTip = 'Specifies the value of the Strategic Code field.';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ToolTip = 'Specifies the value of the Responsible Employee field.';
                }
                field("Sub Activity"; Rec."Sub Activity")
                {
                    ToolTip = 'Specifies the value of the Sub Activity field.';
                }
            }
        }
    }

    actions
    {
    }
}

