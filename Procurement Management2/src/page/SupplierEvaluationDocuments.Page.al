page 53116 "Supplier Evaluation Documents"
{
    Caption = 'Supplier Evaluation Documents';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Document";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Code field';
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document Name field';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Mandatory field';
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitted field';
                }
            }
        }
    }
}





