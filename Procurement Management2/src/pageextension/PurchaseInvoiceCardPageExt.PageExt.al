pageextension 53004 "PurchaseInvoiceCardPageExt" extends "Purchase Invoice"
{
    layout
    {
        modify("Vendor Invoice No.")
        {
            Visible = true;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        
        addlast(General)
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RFQ No. field';
            }
        }
        addlast(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }
}





