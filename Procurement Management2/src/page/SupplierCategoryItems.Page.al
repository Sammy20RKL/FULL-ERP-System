page 53130 "Supplier Category Items"
{
    Caption = 'Supplier Category Items';
    PageType = ListPart;
    SourceTable = "Supplier Category Item";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Type field.';
                    ShowMandatory = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}






