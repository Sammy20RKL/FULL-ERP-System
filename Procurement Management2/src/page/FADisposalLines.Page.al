page 53029 "FA Disposal Lines"
{
    Caption = 'FA Disposal Lines';
    PageType = ListPart;
    SourceTable = "FA Disposal Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA No. field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Residual Value"; Rec."Residual Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Residual Value field.';
                }
                field(Bids; Rec.Bids)
                {
                    ApplicationArea = All;
                    Caption = 'Submitted Bids';
                    ToolTip = 'Specifies the value of the Submitted Bids field';
                    Visible = false;
                }
                field("Highest Bid"; Rec."Highest Bid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Highest Bid field';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Bids")
            {
                Image = CalculateDiscount;
                RunObject = page "FA Disposal Quote Bids";
                RunPageLink = "FA Disposal Doc No." = field("Document No."),
                                No = field("FA No."),
                                "Line No" = field("Line No."),
                                "Bid Submitted" = const(true);
                ApplicationArea = All;
                ToolTip = 'Executes the View Bids action';
            }
        }
    }
}





