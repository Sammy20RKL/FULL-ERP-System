page 53035 "Prospective Tender Lines"
{
    Caption = 'Prospective Tender Lines';
    PageType = List;
    SourceTable = "Prospective Tender Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Response No field';
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specifications field';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Inclusive VAT field';
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount LCY field';
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT % field';
                }
            }
        }
    }
}





