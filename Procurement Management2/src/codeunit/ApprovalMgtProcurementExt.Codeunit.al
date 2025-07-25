codeunit 53005 "Approval Mgt Procurement Ext"

{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle Procurement";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

    //Requisitions
    procedure CheckReqWorkflowEnabled(var Req: Record "Internal Request Header"): Boolean
    begin
        if not IsReqWorkflowEnabled(Req) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsReqWorkflowEnabled(var Req: Record "Internal Request Header"): Boolean
    begin
        exit(WorkFlowManagement.CanExecuteWorkflow(Req, WorkflowEventHandling.RunWorkflowOnSendReqForApprovalCode()));
    end;

    //Tender evaluation
    procedure CheckProcurementEvaluationWorkflowEnabled(var Tender: Record "Procurement Evaluation Header"): Boolean
    begin
        if not IsProcurementEvaluationWorkflowEnabled(Tender) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProcurementEvaluationWorkflowEnabled(var TenderEval: Record "Procurement Evaluation Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TenderEval, WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode()));
    end;

    //Supplier evaluation
    procedure CheckSupplierEvalWorkflowEnabled(var Evaluation: Record "Supplier Evaluation Header"): Boolean
    begin
        if not IsSupplierEvalWorkflowEnabled(Evaluation) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsSupplierEvalWorkflowEnabled(var Evaluation: Record "Supplier Evaluation Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Evaluation, WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode()));
    end;

    //FA Disposal
    procedure CheckFADisposalWorkflowEnabled(var FADisposal: Record "FA Disposal"): Boolean
    begin
        if not IsFADisposalWorkflowEnabled(FADisposal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsFADisposalWorkflowEnabled(var FADisposal: Record "FA Disposal"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(FADisposal, WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode()));
    end;

    //Tender Committee
    procedure CheckTenderCommitteeWorkflowEnabled(var TenderCommittee: Record "Tender Committees"): Boolean
    begin
        if not IsTenderCommitteeWorkflowEnabled(TenderCommittee) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsTenderCommitteeWorkflowEnabled(var TenderCommittee: Record "Tender Committees"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(TenderCommittee, WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode()));
    end;

    //Procurement Plan
    procedure CheckProcurementPlanWorkflowEnabled(var ProcurementPlan: Record "Procurement Plan"): Boolean
    begin
        if not IsProcurementPlanWorkflowEnabled(ProcurementPlan) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProcurementPlanWorkflowEnabled(var ProcurementPlan: Record "Procurement Plan"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ProcurementPlan, WorkflowEventHandling.RunworkflowOnSendProcurementPlanforApprovalCode()));
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        FADisposal: Record "FA Disposal";
        Req: Record "Internal Request Header";
        TenderEval: Record "Procurement Evaluation Header";
        ProcurementPlan: Record "Procurement Plan";
        SupEval: Record "Supplier Evaluation Header";
        TenderCommittee: Record "Tender Committees";
        NoSeries: Codeunit NoSeriesManagement;
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;
    begin
        case RecRef.Number of
            //Requisitions
            Database::"Internal Request Header":
                begin
                    RecRef.SetTable(Req);
                    Req.CalcFields(Amount, "Amount Including VAT");

                    case req."Document Type" of
                        req."Document Type"::Purchase:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Purchase Requisitions";
                        req."Document Type"::Stock:
                            ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Store Requisitions";
                    end;
                    ApprovalEntryArgument."Document No." := Req."No.";
                    ApprovalEntryArgument.Amount := Req.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := Req.Amount;
                    ApprovalEntryArgument.Description := Req."Item Description";
                end;
            //Tender Evaluation
            Database::"Procurement Evaluation Header":
                begin
                    RecRef.SetTable(TenderEval);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Procurement Evaluation";
                    ApprovalEntryArgument."Document No." := TenderEval."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                    ApprovalEntryArgument.Description := TenderEval.Title;
                end;
            //Supplier Evaluation
            Database::"Supplier Evaluation Header":
                begin
                    RecRef.SetTable(SupEval);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Supplier Evaluation";
                    ApprovalEntryArgument."Document No." := SupEval."No.";
                    ApprovalEntryArgument.Description := SupEval.Description;
                end;
            //FA Disposal
            Database::"FA Disposal":
                begin
                    RecRef.SetTable(FADisposal);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"FA Disposal";
                    ApprovalEntryArgument."Document No." := FADisposal."No.";
                    ApprovalEntryArgument.Description := FADisposal.Comments;
                end;
            //Tender Committees
            Database::"Tender Committees":
                begin
                    RecRef.SetTable(TenderCommittee);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Tender Committee";
                    ApprovalEntryArgument."Document No." := TenderCommittee."Appointment No";
                    ApprovalEntryArgument.Description := TenderCommittee.Title;
                end;
            //Procurement Plan
            Database::"Procurement Plan":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Procurement Plan";
                    ApprovalEntryArgument."Document No." := ProcurementPlan.Name;
                    ApprovalEntryArgument.Description := ProcurementPlan.Description;
                    ProcurementPlan.CalcFields("Total Budget Allocation");
                    ApprovalEntryArgument.Amount := ProcurementPlan."Total Budget Allocation";
                    ApprovalEntryArgument."Amount (LCY)" := ProcurementPlan."Total Budget Allocation";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        FADisposal: Record "FA Disposal";
        Req: Record "Internal Request Header";
        TenderEval: Record "Procurement Evaluation Header";
        ProcurementPlan: Record "Procurement Plan";
        SupEval: Record "Supplier Evaluation Header";
        TenderCommittee: Record "Tender Committees";
    begin
        case RecRef.Number of
            //Requisitions
            Database::"Internal Request Header":
                begin
                    RecRef.SetTable(Req);
                    Req.Validate(Status, Req.Status::"Pending Approval");
                    Req.Modify(true);
                    Variant := Req;
                    IsHandled := true;
                end;
            Database::"Procurement Evaluation Header":
                begin
                    RecRef.SetTable(TenderEval);
                    TenderEval.Validate(Status, TenderEval.Status::"Pending Approval");
                    TenderEval.Modify(true);
                    Variant := TenderEval;
                    IsHandled := true;
                end;
            Database::"Supplier Evaluation Header":
                begin
                    RecRef.SetTable(SupEval);
                    SupEval.Validate(Status, SupEval.Status::"Pending Approval");
                    SupEval.Modify(true);
                    Variant := SupEval;
                    IsHandled := true;
                end;
            //FA Disposal
            Database::"FA Disposal":
                begin
                    RecRef.SetTable(FADisposal);
                    FADisposal.Validate(Status, FADisposal.Status::"Pending Approval");
                    FADisposal.Modify(true);
                    Variant := FADisposal;
                    IsHandled := true;
                end;
            //Tender Committees
            Database::"Tender Committees":
                begin
                    RecRef.SetTable(TenderCommittee);
                    TenderCommittee.Validate(Status, TenderCommittee.Status::"Pending Approval");
                    TenderCommittee.Modify(true);
                    Variant := TenderCommittee;
                    IsHandled := true;
                end;
            //Procurement Plan
            Database::"Procurement Plan":
                begin
                    RecRef.SetTable(ProcurementPlan);
                    ProcurementPlan.Validate(Status, ProcurementPlan.Status::"Pending Approval");
                    ProcurementPlan.Modify(true);
                    Variant := ProcurementPlan;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequestProcurement(var ApprovalEntry: Record "Approval Entry")
    var
        ProcurementPlan: Record "Procurement Plan";
    begin
        //Procurement Plan
        if ProcurementPlan.Get(ApprovalEntry."Document No.") then begin
            ProcurementPlan.Validate(Status, ProcurementPlan.Status::Rejected);
            ProcurementPlan.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnAfterPopulateApprovalEntryArgument(WorkflowStepInstance: Record "Workflow Step Instance"; var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; var IsHandled: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        case RecRef.Number of
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    PurchaseHeader.TestField("Posting Description");
                    ApprovalEntryArgument.Description := PurchaseHeader."Posting Description";
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendReqRequestforApproval(var Req: Record "Internal Request Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelReqApprovalRequest(var Req: Record "Internal Request Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendProcurementEvaluationForApproval(var TenderEval: Record "Procurement Evaluation Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProcurementEvaluationApprovalRequest(var TenderEval: Record "Procurement Evaluation Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendSupplierEvalForApproval(var Evaluation: Record "Supplier Evaluation Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSupplierEvalApprovalRequest(var Evaluation: Record "Supplier Evaluation Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendFADisposalForApproval(var FADisposal: Record "FA Disposal")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFADisposalApprovalRequest(var FADisposal: Record "FA Disposal")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTenderCommitteeForApproval(var TenderCommittee: Record "Tender Committees")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTenderCommitteeRequest(var TenderCommittee: Record "Tender Committees")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Plan")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProcurementPlanRequest(var ProcurementPlan: Record "Procurement Plan")
    begin

    end;
}





