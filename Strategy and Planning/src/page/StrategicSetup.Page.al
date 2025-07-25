page 65008 "Strategic Setup"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Strategic Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("KRA Nos."; Rec."KRA Nos.")
                {
                    ToolTip = 'Specifies the value of the KRA Nos. field.';
                }
                field("Objective Nos."; Rec."Objective Nos.")
                {
                    ToolTip = 'Specifies the value of the Objective Nos. field.';
                }
                field("Strategic Nos."; Rec."Strategic Nos.")
                {
                    ToolTip = 'Specifies the value of the Strategic Nos. field.';
                }
            }
            group(Process)
            {
                field("Work Plan Nos."; Rec."Work Plan Nos.")
                {
                    ToolTip = 'Specifies the value of the Work Plan Nos. field.';
                }
                field("Strategic Plan Nos."; Rec."Strategic Plan Nos.")
                {
                    ToolTip = 'Specifies the value of the Strategic Plan Nos. field.';
                }
                field("Project Nos."; Rec."Project Nos.")
                {
                    ToolTip = 'Specifies the value of the Project Nos. field.';
                }
            }
            group(Project)
            {
                field("Project E-Mail"; Rec."Project E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Reporting Notification Due"; Rec."Reporting Notification Due")
                {
                    ToolTip = 'Specifies the value of the Reporting Notification Due field.';
                }
                field("Workplan Due"; Rec."Workplan Due")
                {
                    ToolTip = 'Specifies the value of the Workplan Due field.';
                }
                field("Activities Due"; Rec."Activities Due")
                {
                    ToolTip = 'Specifies the value of the Activities Due field.';
                }
            }
            group("File Path")
            {
                field("Strategic Document Path"; Rec."Strategic Document Path")
                {
                    ToolTip = 'Specifies the value of the Strategic Document Path field.';
                }
            }
        }
    }

    actions
    {
    }
}

