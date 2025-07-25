page 60044 "Reporing Period"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Reporting Date";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("code"; Rec.code)
                {
                    Caption = 'code';
                    ToolTip = 'Specifies the value of the code field.';
                }
                field("Financial Reporting Date"; Rec."Financial Reporting Date")
                {
                    Caption = 'Financial Reporting Date';
                    ToolTip = 'Specifies the value of the Financial Reporting Date field.';
                }
                field("Technical Reporting Date"; Rec."Technical Reporting Date")
                {
                    Caption = 'Technical Reporting Date';
                    ToolTip = 'Specifies the value of the Technical Reporting Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

