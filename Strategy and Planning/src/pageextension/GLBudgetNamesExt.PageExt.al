pageextension 65000 "G/L Budget Names Ext" extends "G/L Budget Names"
{
    layout
    {
        addlast(Control1)
        {
            field("Start Date"; Rec."Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Start Date field.';
            }
            field("End Date"; Rec."End Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the End Date field.';
            }
        }
    }
}
