page 60048 "Grant G/L Account Prices"
{
    ApplicationArea = All;
    Caption = 'Grant G/L Account Prices';
    PageType = Card;
    SourceTable = "Job-G/L Account Price";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                    ToolTip = 'Specifies the value of the Job No. field.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Caption = 'Job Task No.';
                    ToolTip = 'Specifies the value of the Job Task No. field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Unit Cost Factor"; Rec."Unit Cost Factor")
                {
                    Caption = 'Unit Cost Factor';
                    ToolTip = 'Specifies the value of the Unit Cost Factor field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                    ToolTip = 'Specifies the value of the Unit Cost field.';
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
    }
}

