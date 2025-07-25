codeunit 53007 "Wkfl Event Resp Procurement"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle Procurement";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //Requisitions
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendReqForApprovalCode());
                    //Tender Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode());
                    //Quote Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunworkflowOnSendProcurementPlanforApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //Requisitions
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendReqForApprovalCode());
                    //Tender Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode());
                    //Quote Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnSendProcurementPlanforApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //Requisitions
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendReqForApprovalCode());
                    //Tender Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendFADisposalforApprovalCode());
                    //Quote Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunworkflowOnSendProcurementPlanforApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //Requisitions
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelReqForApprovalCode());
                    //Tender Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelTenderEvalApprovalRequestCode());
                    //Supplier Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelSupplierEvalApprovalRequestCode());
                    //FA Disposal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelFADisposalApprovalRequestCode());
                    //Quote Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelQuoteEvalApprovalRequestCode());
                    //Tender Committee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelTenderCommitteeApprovalRequestCode());
                    //Procurement Plan
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunworkflowOnCancelProcurementPlanApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //Requisitions
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelReqForApprovalCode());
                    //Tender Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelTenderEvalApprovalRequestCode());
                    //Supplier Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelSupplierEvalApprovalRequestCode());
                    //FA Disposal
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelFADisposalApprovalRequestCode());
                    //Quote Evaluation
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelQuoteEvalApprovalRequestCode());
                    //Tender Committee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelTenderCommitteeApprovalRequestCode());
                    //Procurement Plan
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunworkflowOnCancelProcurementPlanApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                begin

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FADisposal: Record "FA Disposal";
        IR: Record "Internal Request Header";
        TenderEval: Record "Procurement Evaluation Header";
        ProcurementPlan: Record "Procurement Plan";
        SupplierEval: Record "Supplier Evaluation Header";
        TenderCommittee: Record "Tender Committees";
        ReleaseReq: Codeunit "Release Requisition";
        WorkflowResponses: Codeunit "Workflow Responses Procurement";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            //Requisitions
            Database::"Internal Request Header":
                begin
                    IR.SetView((RecRef.GetView()));
                    Handled := true;
                    ReleaseReq.PerformManualRelease(VarVariant);
                end;
            //Tender Evaluation
            Database::"Procurement Evaluation Header":
                begin
                    TenderEval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseTenderEval(VarVariant);
                end;
            //Supplier Evaluation
            Database::"Supplier Evaluation Header":
                begin
                    SupplierEval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseSupplierEval(VarVariant);
                end;
            //FA Disposal
            Database::"FA Disposal":
                begin
                    FADisposal.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseFADisposal(VarVariant);
                end;
            //Tender Committee
            Database::"Tender Committees":
                begin
                    TenderCommittee.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseTenderCommittee(VarVariant);
                end;
            //Procurement Plan
            Database::"Procurement Plan":
                begin
                    ProcurementPlan.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseProcurementPlan(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        FADisposal: Record "FA Disposal";
        IR: Record "Internal Request Header";
        TenderEval: Record "Procurement Evaluation Header";
        ProcurementPlan: Record "Procurement Plan";
        SupplierEval: Record "Supplier Evaluation Header";
        TenderCommittee: Record "Tender Committees";
        ReleaseReq: Codeunit "Release Requisition";
        WorkflowResponses: Codeunit "Workflow Responses Procurement";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of
            //Requisitions
            Database::"Internal Request Header":
                begin
                    IR.SetView((RecRef.GetView()));
                    Handled := true;
                    ReleaseReq.PerformManualReopen(VarVariant);
                end;
            //Tender Evauation
            Database::"Procurement Evaluation Header":
                begin
                    TenderEval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenTenderEval(VarVariant);
                end;
            //Supplier Evaluation
            Database::"Supplier Evaluation Header":
                begin
                    SupplierEval.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenSupplierEval(VarVariant);
                end;
            //FA Disposal
            Database::"FA Disposal":
                begin
                    FADisposal.SetView((RecRef.GetView()));
                    Handled := true;
                    WorkflowResponses.ReleaseFADisposal(VarVariant);
                end;
            //Tender Committee
            Database::"Tender Committees":
                begin
                    TenderCommittee.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReOpenTenderCommittee(VarVariant);
                end;
            //Procurement Plan
            Database::"Procurement Plan":
                begin
                    ProcurementPlan.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReOpenProcurementPlan(VarVariant);
                end;
        end;
    end;
}





