pageextension 53003 "PurchaseOrderCardPageExt" extends "Purchase Order"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Vendor Shipment No.")
        {
            Caption = 'Delivery Note Number';
        }
        addafter("Vendor Shipment No.")
        {
            field("Delivery Address"; Rec."Delivery Address")
            {
                ApplicationArea = All;
                Caption = 'Delivery Address';
                ToolTip = 'Specifies the delivery address for the purchase order.';
                Visible = true;
                Editable = true;
            }
        }

        addlast(General)
        {
            field("RFQ No."; Rec."RFQ No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RFQ No. field';
            }
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requisition No. field';
            }
            field("Email Sent"; Rec."Email Sent")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if email has already been sent';
            }

        }
        addlast(factboxes)
        {
            part(Attachment; "Document Attachment Factbox")
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            begin
                CurrPage.Close();
            end;
        }
        addlast(processing)
        {
            // action("Print LPO")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = Print;
            //     PromotedIsBig = true;
            //     Caption = 'Print Purchase Order';

            //     trigger OnAction()
            //     var
            //         PurchHeader: Record "Purchase Header";
            //         LPOReport: Report LPO;
            //     begin
            //         PurchHeader.SetRange("No.", Rec."No.");
            //         if PurchHeader.FindSet() then begin
            //             LPOReport.SetTableView(PurchHeader);
            //             LPOReport.Run();
            //         end;
            //     end;
            // }

        }
        addlast(Print)
        {
            action(SendEmail)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Email;
                PromotedIsBig = true;
                Caption = 'Send Purchase Order';

                trigger OnAction()
                var
                    ProcurementManagement: Codeunit "Procurement Management";
                begin
                    if confirm('Are you sure you want to send LPO ?', false) then
                        ProcurementManagement.SendLPO(Rec);
                    CurrPage.Close();
                end;
            }
        }
        addlast(processing)
        {
            action(CancelLPO)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Cancel;
                PromotedIsBig = true;
                Caption = 'Cancel Purchase Order';

                trigger OnAction()
                var
                    CancelLPOConfirmMsg: Label 'Are you sure you want to cancel LPO %1?';
                begin
                    if Confirm(CancelLPOConfirmMsg, false, Rec."No.") then begin
                        ProcMgt.CancelLPO(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
            action("Print LPO")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                // Image = Print;
                PromotedIsBig = true;
                Caption = 'Print Purchase Order';

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    LPOReport: Report "LPO New";
                begin
                    PurchHeader.SetRange("No.", Rec."No.");
                    if PurchHeader.FindSet() then begin
                        LPOReport.SetTableView(PurchHeader);
                        LPOReport.Run();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        PurchHeader: Record "Purchase Header";
        ProcMgt: Codeunit "Procurement Management";
}





