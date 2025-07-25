page 53087 "EOI Archive List"
{
    CardPageID = "EOI Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Request";
    SourceTableView = where("Process Type" = const(EOI),
                            Status = filter(<> New));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan No field';
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
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quotation Deadline field';
                }
            }
        }
    }

    actions
    {
    }
}





