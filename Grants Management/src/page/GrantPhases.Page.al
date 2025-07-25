page 60052 "Grant Phases"
{
    ApplicationArea = All;
    CardPageId = "Grant Phase Card";
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "Grant Phases";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
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
                field("Technical Reporting Date"; Rec."Technical Reporting Date")
                {
                    Caption = 'Disbursement Date';
                    ToolTip = 'Specifies the value of the Disbursement Date field.';
                }
                field("Financial Reporting Date"; Rec."Financial Reporting Date")
                {
                    Caption = 'Next Disbursment due Date';
                    ToolTip = 'Specifies the value of the Next Disbursment due Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

