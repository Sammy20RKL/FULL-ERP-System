pageextension 60001 "GL Acc Ext" extends "G/L Account Card"
{
    layout
    {
        addlast(General)
        {
            field("Budget Line Item"; Rec."Budget Line Item")
            {
                ApplicationArea = All;
                ToolTip = 'Budget Line Item';
                Caption = 'Budget Line Item';
            }
            field("Donor defined Account"; Rec."Donor defined Account")
            {
                ApplicationArea = All;
                ToolTip = 'Donor defined Account';
                Caption = 'Donor defined Account';
            }
        }
    }
}
