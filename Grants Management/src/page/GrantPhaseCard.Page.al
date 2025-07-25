page 60053 "Grant Phase Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Grant Phases";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Phase)
            {
                Caption = 'Phase';
                Image = Intrastat;
                action("Reporting Schedules")
                {
                    Caption = 'Reporting Schedules';
                    Promoted = true;
                    RunObject = page "Phase Reporting Schedules";
                    RunPageLink = Phase = field(Code);
                    ToolTip = 'Executes the Reporting Schedules action.';
                }
                action("Reporting Audit Dates")
                {
                    Caption = 'Reporting Audit Dates';
                    ToolTip = 'Executes the Reporting Audit Dates action.';
                    //RunObject = Page Page39003977;
                }
            }
        }
    }
}

