page 53290 "Procurement Eva Criteria Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Procurement Ev Criteria Line";

    layout
    {
        area(Content)
        {
            repeater(EvalutionCritelia)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'The Tooltip property for PageField';
                    Visible = false;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ToolTip = 'The Tooltip property for PageField';
                }
                field("Vendor Name"; Rec."Vendor Name") { ToolTip = 'The Tooltip property for PageField'; }
                field("Total Amount"; Rec."Total Amount") { ToolTip = 'The Tooltip property for PageField'; }
                field("Price level (H/M/L)"; Rec."Price level (H/M/L)") { ToolTip = 'The Tooltip property for PageField'; }
                field("Quality (H/M/L)"; Rec."Quality (H/M/L)") { ToolTip = 'The Tooltip property for PageField'; }
                field("Delivery lead time- Days"; Rec."Delivery lead time- Days") { ToolTip = 'The Tooltip property for PageField'; }
                field("Delivery terms"; Rec."Delivery terms") { ToolTip = 'The Tooltip property for PageField'; }
                field("Payment terms"; Rec."Payment terms") { ToolTip = 'The Tooltip property for PageField'; }
                field("Quotation valid untill"; Rec."Quotation valid untill") { ToolTip = 'The Tooltip property for PageField'; }
                field("Supplier registration"; Rec."Supplier registration")
                {
                    ToolTip = 'The Tooltip property for PageField';
                }
                field("Supplier status"; Rec."Supplier status")
                {
                    ToolTip = 'The Tooltip property for PageField';
                }
            }
        }
        // area(Factboxes)
        // {

        // }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}