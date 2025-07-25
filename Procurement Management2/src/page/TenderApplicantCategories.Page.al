page 53135 "Tender Applicant Categories"
{
    Caption = 'Tender Applicant Categories';
    PageType = ListPart;
    SourceTable = "Tender Applicant Category";

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
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    Enabled = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field.';
                    Enabled = false;
                }
            }
        }
    }
}






