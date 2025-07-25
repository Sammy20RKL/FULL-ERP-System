page 60012 "Phase Reporting Schedules"
{
    ApplicationArea = All;
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Phase Reporting Schedules";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Table ID"; Rec."Table ID")
                {
                    Caption = 'Table ID';
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field(Project; Rec.Project)
                {
                    Caption = 'Project';
                    ToolTip = 'Specifies the value of the Project field.';
                }
                field("Partner/Donor"; Rec."Partner/Donor")
                {
                    Caption = 'Partner/Donor';
                    ToolTip = 'Specifies the value of the Partner/Donor field.';
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
                field("Audit Dates"; Rec."Audit Dates")
                {
                    Caption = 'Audit Dates';
                    ToolTip = 'Specifies the value of the Audit Dates field.';
                }
                field(AlertSent; Rec.AlertSent)
                {
                    Caption = 'AlertSent';
                    ToolTip = 'Specifies the value of the AlertSent field.';
                }
            }
        }
    }

    actions
    {
    }
}

