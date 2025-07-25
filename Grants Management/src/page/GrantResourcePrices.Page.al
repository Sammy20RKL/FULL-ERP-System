page 60022 "Grant Resource Prices"
{
    ApplicationArea = All;
    Caption = 'Grant Resource Prices';
    PageType = Card;
    SourceTable = "Job-Resource Price";

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
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                    ToolTip = 'Specifies the value of the Work Type Code field.';
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

