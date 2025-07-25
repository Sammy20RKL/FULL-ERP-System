page 53054 "Tender Manadatory Requirements"
{
    Caption = 'Tender Manadatory Requirements';
    PageType = ListPart;
    SourceTable = "Tender Mandatory Requirements";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Mandatory Requirement"; Rec."Mandatory Requirement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mandatory Requirement field';
                }
            }
        }
    }
}





