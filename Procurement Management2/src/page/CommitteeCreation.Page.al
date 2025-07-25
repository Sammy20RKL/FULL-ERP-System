page 53055 "Committee Creation"
{
    Caption = 'Committee Creation';
    PageType = List;
    SourceTable = "Tender Committees";
    CardPageId = "Committee Creation Card";
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appointment No field';
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Quotation No field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part("Committee Members"; "Committee Members")
            {
                SubPageLink = "Appointment No" = field("Appointment No");
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}





