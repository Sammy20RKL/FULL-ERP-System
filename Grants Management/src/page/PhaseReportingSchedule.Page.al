page 60047 "Phase Reporting Schedule"
{
    ApplicationArea = All;
    DelayedInsert = true;
    Editable = false;
    PageType = Card;
    SourceTable = "Phase Reporting Schedules";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Project; Rec.Project)
                {
                    Caption = 'Project';
                    ToolTip = 'Specifies the value of the Project field.';
                }
                field(Phase; Rec.Phase)
                {
                    Caption = 'Phase';
                    ToolTip = 'Specifies the value of the Phase field.';
                }
                field(Months; Rec.Months)
                {
                    Caption = 'Months';
                    ToolTip = 'Specifies the value of the Months field.';
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    Caption = 'Reporting Date';
                    ToolTip = 'Specifies the value of the Reporting Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

