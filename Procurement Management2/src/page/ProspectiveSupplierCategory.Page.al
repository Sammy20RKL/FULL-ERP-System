page 53133 "Prospective Supplier Category"
{
    Caption = 'Prospective Supplier Category';
    PageType = ListPart;
    SourceTable = "Prospective Supplier Category";

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
                    Enabled = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field.';
                    Enabled = false;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                    Enabled = false;
                }
            }
        }
    }
}






