codeunit 53002 "Procurement Posting Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure CommitOnPostInvoice(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        Commitment: Codeunit "Commitments Mgt Procurement";
    begin
        if PurchHeader.Invoice then
            Commitment.ReversePostedLPOEntries(PurchInvHeader);

        if PurchHeader.Invoice then
            Commitment.ReversePostedPurchInvEntries(PurchInvHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCheckPurchaseApprovalPossible', '', false, false)]
    local procedure CommitPurchOrderOnAfterCheckPurchaseApprovalPossible(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        Commitment: Codeunit "Commitments Mgt Procurement";
        ErrorMsg: Text;
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchLine.Find('-') then
            repeat
                if PurchLine."Gen. Bus. Posting Group" <> '' then begin
                    PurchLine.TestField("Gen. Prod. Posting Group");
                    PurchLine.TestField("VAT Bus. Posting Group");
                    PurchLine.TestField("VAT Prod. Posting Group");
                end;
            until PurchLine.Next() = 0;

        Commitment.LPOCommittment(PurchaseHeader, ErrorMsg);
        if ErrorMsg <> '' then
            Error(ErrorMsg);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure UpdateProcurementContractLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ProcurementManagement: Codeunit "Procurement Management";
    begin
        if PurchHeader.Invoice then
            ProcurementManagement.UpdateProcurementContractLines(PurchHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnAfterSendVendor', '', false, false)]
    local procedure MarkLPOAsSentOnAfterSendVendor(RecordVariant: Variant; DocName: Text[150]; DocNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, DocNo) then begin
            PurchaseHeader.Validate("Email Sent", true);
            PurchaseHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeSendRecords', '', false, false)]
    local procedure CheckIfEmailSentOnBeforeSendRecords(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Email Sent" then
            Error('You have already sent this LPO to the vendor');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterProcessPurchLines', '', false, false)]
    local procedure TransferFieldsToPostedOrderOnPostPurchaseOrder(var PurchHeader: Record "Purchase Header")
    var
        PostedPurchaseHeader: Record "Posted Purchase Header";
        PostedPurchaseLine: Record "Posted Purchase Line";
        PurchaseLine: Record "Purchase Line";
    begin
        if (PurchHeader.Invoice) and (PurchHeader."Document Type" = PurchHeader."Document Type"::"Order") then begin
            PostedPurchaseHeader.Init();
            PostedPurchaseHeader.TransferFields(PurchHeader);
            if not PostedPurchaseHeader.Get(PurchHeader."No.") then
                PostedPurchaseHeader.Insert();

            PurchaseLine.SetRange("Document Type", PurchHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchHeader."No.");
            if PurchaseLine.FindSet() then
                repeat
                    PostedPurchaseLine.Init();
                    PostedPurchaseLine.CalcFields(Specification);
                    PostedPurchaseLine.TransferFields(PurchaseLine);
                    if not PostedPurchaseLine.Get(PurchHeader."No.", PurchaseLine."Line No.") then
                        PostedPurchaseLine.Insert();
                until PurchaseLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure CehckCancelledLPOBeforePost(var PurchaseHeader: Record "Purchase Header")
    var
        CannotPostErr: Label 'You can not post a cancelled/archived LPO';
    begin
        if PurchaseHeader.Status in [PurchaseHeader.Status::Cancelled, PurchaseHeader.Status::Archived] then
            Error(CannotPostErr);
    end;
}





