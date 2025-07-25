page 60023 "Grant Item Prices"
{
    ApplicationArea = All;
    Caption = 'Grant Item Prices';
    PageType = Card;
    SourceTable = "Job-Item Price";

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
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    Caption = 'Variant Code';
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
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
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Apply Job Discount"; Rec."Apply Job Discount")
                {
                    Visible = false;
                    Caption = 'Apply Job Discount';
                    ToolTip = 'Specifies the value of the Apply Job Discount field.';
                }
                field("Apply Job Price"; Rec."Apply Job Price")
                {
                    Visible = false;
                    Caption = 'Apply Job Price';
                    ToolTip = 'Specifies the value of the Apply Job Price field.';
                }
            }
        }
    }

    actions
    {
    }
}

