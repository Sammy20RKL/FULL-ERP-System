page 65034 "Reporting Requirements"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Project Reporting";

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
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Reporting Requirement"; Rec."Reporting Requirement")
                {
                    ToolTip = 'Specifies the value of the Reporting Requirement field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Notification Period"; Rec."Notification Period")
                {
                    ToolTip = 'Specifies the value of the Notification Period field.';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.';
                }
                field("Date Completed"; Rec."Date Completed")
                {
                    ToolTip = 'Specifies the value of the Date Completed field.';
                }
            }
        }
    }

    actions
    {
    }
}

