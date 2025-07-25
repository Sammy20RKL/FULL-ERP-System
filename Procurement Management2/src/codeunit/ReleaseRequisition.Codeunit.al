codeunit 53001 "Release Requisition"
{
    TableNo = "Internal Request Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then
            exit;

        OnBeforeReleaseRequisition(Rec);

        Rec.Status := Rec.Status::Released;
        Rec.Modify(true);

        NotifyProcurementOfficerOnRequisitionApproval(Rec);

        OnAfterReleaseRequisition(Rec);
    end;

    procedure PerformManualRelease(var Requisition: Record "Internal Request Header")
    begin

        // IF ApprovalsMgmt.IsRequisitionsApprovalsWorkflowEnabled(Requisition) AND (Requisition.Status = Requisition.Status::Open) THEN
        //  ERROR(Text002);
        Codeunit.Run(Codeunit::"Release Requisition", Requisition);
    end;

    procedure PerformManualReopen(var Requisition: Record "Internal Request Header")
    begin
        // IF Requisition.Status = Requisition.Status::"Pending Approval" THEN
        //  ERROR(Text003);

        Reopen(Requisition);
    end;

    procedure Reopen(var Requisition: Record "Internal Request Header")
    var
        Committment: Codeunit "Commitments Mgt Procurement";
    begin
        OnBeforeReopenRequisition(Requisition);

        if Requisition.Status = Requisition.Status::Open then
            exit;
        Requisition.Status := Requisition.Status::Open;

        Requisition.Modify(true);
        Commit();
        //Uncommit
        Committment.ReversePurchReqCommittment(Requisition);

        OnAfterReopenRequisition(Requisition);
    end;

    procedure NotifyProcurementOfficerOnRequisitionApproval(PurchReq: Record "Internal Request Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NotifyMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">To Procurement,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that Requisition No. <strong>%1</strong> with description <strong>%2</strong> has been approved. <p style="font-family:Verdana,Arial;font-size:10pt">Please proceed to initiate the procurement process.</p> <p style="font-family:Verdana,Arial;font-size:10pt"> Thank you.<br><br>Kind regards,<br>Procurement Department<br><Strong>%3<Strong></p>';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        PurchSetup.Get();
        PurchSetup.TestField("Procurement E-Mail");

        case PurchReq."Document Type" of
            PurchReq."Document Type"::Purchase:
                begin
                    Clear(Receipient);
                    Receipient.Add(PurchSetup."Procurement E-Mail");
                    Subject := 'Initiate Procurement Process';
                    FormattedBody := StrSubstNo(NotifyMsg, PurchReq."No.", PurchReq."Item Description", CompanyInfo.Name);
                    EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                    Email.Send(EmailMessage);
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleaseRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenRequisition(var Requisition: Record "Internal Request Header")
    begin
    end;
}





