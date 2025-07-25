pageextension 60003 "Vend Card Ext" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("Vendor Type"; Rec."Vendor Type-Grants")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Type field.', Comment = '%';
                Caption = 'Vendor Type-Grants';
            }
        }
    }
}
