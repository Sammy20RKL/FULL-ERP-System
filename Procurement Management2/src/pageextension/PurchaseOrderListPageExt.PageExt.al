pageextension 53009 "Purchase Order List Page Ext" extends "Purchase Order List"
{
    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Posting Description "; Rec."Posting Description")
            {
                Caption = 'Description';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field';
            }
        }
        addafter(Status)
        {
             field("Email Sent";Rec."Email Sent")
            {
                 ApplicationArea = All;
                ToolTip = 'Specifies if email has already been sent';
            }
        }
    }
}





