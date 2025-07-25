page 53034 "Prospective Supplier Tenders"
{
    Caption = 'Prospective Supplier Tenders';
    PageType = ListPart;
    SourceTable = "Prospective Supplier Tender";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
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
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quotation Deadline field';
                }
                field(TenderOpeningDate; Rec.TenderOpeningDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TenderOpeningDate field';
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TenderClosingDate field';
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Status field';
                }
                field("Sent for Evaluation"; Rec."Sent for Evaluation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sent for Evaluation field';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Time field';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field';
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                }
                field("Prospect No."; Rec."Prospect No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prospect No. field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Show Tender Items")
            {
                Image = Item;
                RunObject = page "Prospective Tender Lines";
                RunPageLink = "Tender No." = field("Tender No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Show Tender Items action';
            }
        }
    }
}





