page 60001 "Project Personnel Cost Alloc"
{
    ApplicationArea = All;
    DelayedInsert = true;
    PageType = Card;
    SourceTable = "Project Personnel Cost Alloc";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Employee No';
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Caption = 'Employee Name';
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Project Role"; Rec."Project Role")
                {
                    Caption = 'Project Role';
                    ToolTip = 'Specifies the value of the Project Role field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(comment; Rec.comment)
                {
                    Caption = 'comment';
                    ToolTip = 'Specifies the value of the comment field.';
                }
                field("% Allocation Value"; Rec."% Allocation Value")
                {
                    Caption = '% Allocation Value';
                    ToolTip = 'Specifies the value of the % Allocation Value field.';
                }
            }
        }
    }

    actions
    {
    }
}

