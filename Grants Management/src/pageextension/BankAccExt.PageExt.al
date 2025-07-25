pageextension 60000 "Bank Acc Ext" extends "Bank Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Payments No"; Rec."Payments No")
            {
                ApplicationArea = All;
                ToolTip = 'Payments No';
                Caption = 'Payments No';
            }
        }
    }
}
