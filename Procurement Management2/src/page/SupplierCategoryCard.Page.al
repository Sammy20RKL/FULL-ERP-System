page 53129 "Supplier Category Card"
{
    Caption = 'Supplier Category Card';
    PageType = Card;
    SourceTable = "Supplier Category";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
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
                field("No. Prequalified"; Rec."No. Prequalified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Prequalified field';
                }
            }

            part(Items; "Supplier Category Items")
            {
                Caption = 'Supplier Category Items';
                SubPageLink = "Category Code" = field("Code");
                ApplicationArea=All;
            }
        }
    }
}






