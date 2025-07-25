page 53137 "Tender Committee Categories"
{
    Caption = 'Tender Committee Categories';
    PageType = ListPart;
    SourceTable = "Tender Committee Category";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Supplier Category"; Rec."Supplier Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category field.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Name field.';
                }
            }
        }
    }
}






