pageextension 53012 "PurchaseReturnOrderExt" extends "Purchase Return Order"
{
    layout
    {
        addafter("Campaign No.")
        {

            field("Cancel Comments"; Rec."Cancel Comments")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cancel Comments field';
                Caption = 'Return Comments';
                MultiLine = true;
            }
        }
    }
}






