page 60017 "Grant Task Dimensions"
{
    ApplicationArea = All;
    Caption = 'Grant Activity Dimensions';
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Job-Task Dimension";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Dimension Code"; Rec."Dimension Code")
                {
                    Caption = 'Dimension Code';
                    ToolTip = 'Specifies the value of the Dimension Code field.';
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    Caption = 'Dimension Value Code';
                    ToolTip = 'Specifies the value of the Dimension Value Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

