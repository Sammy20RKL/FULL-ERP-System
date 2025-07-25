page 60003 "Proposal Check List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Proposal Check List";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Task; Rec.Task)
                {
                    Caption = 'Task';
                    ToolTip = 'Specifies the value of the Task field.';
                }
                field("Responsible Office"; Rec."Responsible Office")
                {
                    Caption = 'Responsible Office';
                    ToolTip = 'Specifies the value of the Responsible Office field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control11; Notes)
            {
            }
            systempart(Control12; MyNotes)
            {
            }
            systempart(Control13; Links)
            {
            }
            systempart(Control14; Outlook)
            {
            }
        }
    }

    actions
    {
    }
}

