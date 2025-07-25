page 53121 "Procurement Management Cues"
{
    Caption = 'Procurement Management Cues';
    PageType = CardPart;
    SourceTable = "Procurement Management Cue";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Self Service")
            {
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the value of the Purchase Orders field';
                }
                field("Purchase Invoice"; Rec."Purchase Invoice")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Invoices";
                    ToolTip = 'Specifies the value of the Purchase Invoice field';
                }
                field("Purchase Quotes"; Rec."Purchase Quotes")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Quotes";
                    ToolTip = 'Specifies the value of the Purchase Quotes field';
                }
                field("Purchase request list"; Rec."Purchase request list")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request List";
                    ToolTip = 'Specifies the value of the Purchase requests field';
                }
                field("Purchase request list Approved"; Rec."Purchase request list Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Request Approved";
                    ToolTip = 'Specifies the value of the Approved Purchase requests field';
                }
                field("Purchase return order"; Rec."Purchase return order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Return Order List";
                    ToolTip = 'Specifies the value of the Purchase return order field';
                }
                field("Blanket Purchase order"; Rec."Blanket Purchase order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Purchase Orders";
                    ToolTip = 'Specifies the value of the Blanket Purchase order field';
                }
                field("Purchase Credit Memo"; Rec."Purchase Credit Memo")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Credit Memos";
                    ToolTip = 'Specifies the value of the Purchase Credit Memo field';
                }
                field("Store Requests"; Rec."Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Request List";
                    ToolTip = 'Specifies the value of the Store Requests field';
                }
                field("Open Store Requests"; Rec."Open Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Store Request List";
                    ToolTip = 'Specifies the value of the Open Store Requests field';
                }
                field("Approved Store Requests"; Rec."Approved Store Requests")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Approved Store Request";
                    ToolTip = 'Specifies the value of the Approved Store Requests field';
                }
                field("Request for Quote & Order"; Rec."Request for Quote & Order")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Quotation List";
                    Caption = 'Request For Quotes';
                    ToolTip = 'Specifies the value of the Request for Quote and Order field';
                }
                field("Procurement Plans"; Rec."Procurement Plans")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Procurement Plans";
                    ToolTip = 'Specifies the value of the Procurement Plans field';
                }
            }
            cuegroup("Tender management")
            {
                Caption = 'Procurement Methods';
                field("Open Tenders"; Rec."Open Tenders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Tender List";
                    ToolTip = 'Specifies the value of the Open Tenders field';
                }
                field("Restricted Tenders"; Rec."Restricted Tenders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Tender List";
                    ToolTip = 'Specifies the value of the Restricted Tenders field';
                }
                field("Prospective Suppliers"; Rec."Prospective Suppliers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Prospective Supplier List";
                    ToolTip = 'Specifies the value of the Prospective Suppliers field';
                }
                field("Prequalified Suppliers"; Rec."Prequalified Suppliers")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Prequalified Suppliers";
                    ToolTip = 'Specifies the value of the Prequalified Suppliers field';
                }
                field(EOI; Rec.EOI)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "EOI List";
                    ToolTip = 'Specifies the value of the EOI field';
                }
                field("EOI under Evaluation"; Rec."EOI under Evaluation")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "EOI Evaluation List";
                    ToolTip = 'Specifies the value of the EOI under Evaluation field';
                }
                field("Request For Proposal"; Rec."Request For Proposal")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFP List";
                    ToolTip = 'Specifies the value of the Request For Proposal field';
                }
                field("RFP Evaluation List"; Rec."RFP Evaluation List")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "RFP Evaluation List";
                    ToolTip = 'Specifies the value of the RFP Evaluation List field';
                    Visible = false;
                }
                field("RFQ Evaluation List"; Rec."RFQ Evaluation List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFQ Evaluations field.';
                    DrillDownPageId = "Quote Evaluation List";
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the value of the Requests to Approve field';
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                    ToolTip = 'Specifies the value of the Requests Sent for Approval field';
                }
            }

            cuegroup(Transport)
            {
                // Visible = false;
                field("Travel Requests"; Rec."Travel Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Travel Requests field';
                }
                field("Travel Requests Approved"; Rec."Travel Requests Approved")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Travel Requests Approved field';
                }
                field("Ongoing Trips"; Rec."Ongoing Trips")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ongoing Trips field';
                }
                field("Completed Trips"; Rec."Completed Trips")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completed Trips field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);

        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}





