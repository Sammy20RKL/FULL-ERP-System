page 53149 "Events.Page"
{
    Caption = 'Events.Page';
    PageType = Card;
    SourceTable = "Events.Table";



    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }

                field("From"; Rec.From)
                {
                    ApplicationArea = All;
                }

                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }

                field("Location"; Rec.Location)
                {
                    ApplicationArea = All;
                }

                field("No of  Days"; Rec."No of Days")
                {
                    ApplicationArea = All;
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }



            }
        }
    }
}






