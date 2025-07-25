codeunit 53006 "Wkfl Event Handle Procurement"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        ReqCancelApprovalRequestDescTxt: Label 'An approval request for a Requisition is cancelled ';
        ReqSendforApprovalDescTxt: Label 'An approval request for a Requisition is requested';
        FADisposalApprReqCancelledEventDescTxt: Label 'An approval request for a FA Disposal has been canceled.';
        FADisposalSendForApprovalEventDescTxt: Label 'Approval of a FA Disposal is requested.';
        QuoteEvalApprReqCancelledEventDescTxt: Label 'An approval request for a Quote Evaluation has been canceled.';
        QuoteEvalSendForApprovalEventDescTxt: Label 'Approval of a Quote Evaluation is requested.';
        SupplierEvalApprReqCancelledEventDescTxt: Label 'An approval request for a Supplier Evaluation has been canceled.';
        SupplierEvalSendForApprovalEventDescTxt: Label 'Approval of a Supplier Evaluation is requested.';
        TenderEvalApprReqCancelledEventDescTxt: Label 'An approval request for a Tender Evaluation has been canceled.';
        TenderEvalSendForApprovalEventDescTxt: Label 'Approval of a Tender Evaluation is requested.';
        TenderCommitteeCancelApprovalRequestDescTxt: Label 'An approval request for a Tender Committee is cancelled ';
        TenderCommitteeSendforApprovalDescTxt: Label 'An approval for a Tender Committee is requested';
        ProcurementPlanCancelApprovalRequestDescTxt: Label 'An approval request for a Procurement Plan is cancelled ';
        ProcurementPlanSendforApprovalDescTxt: Label 'An approval for a Procurement Plan is requested';


    procedure RunWorkflowOnSendReqForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendReqForApproval'));
    end;

    procedure RunWorkflowOnCancelReqForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelReqForApproval'));
    end;

    procedure RunWorkflowOnSendTenderEvalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTenderEvalForApproval'));
    end;

    procedure RunWorkflowOnCancelTenderEvalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTenderEvalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendSupplierEvalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSupplierEvalForApproval'));
    end;

    procedure RunWorkflowOnCancelSupplierEvalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSupplierEvalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendFADisposalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFADisposalForApproval'));
    end;

    procedure RunWorkflowOnCancelFADisposalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFADisposalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendQuoteEvalForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendQuoteEvalForApproval'));
    end;

    procedure RunWorkflowOnCancelQuoteEvalApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelQuoteEvalApprovalRequest'));
    end;

    procedure RunWorkflowOnSendTenderCommitteeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTenderCommitteeForApproval'));
    end;

    procedure RunWorkflowOnCancelTenderCommitteeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTenderCommitteeApprovalRequest'));
    end;

    procedure RunWorkflowOnSendProcurementPlanForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProcurementPlanForApproval'));
    end;

    procedure RunWorkflowOnCancelProcurementPlanApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProcurementPlanApprovalRequest'));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Requisitions
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendReqforApprovalCode(), Database::"Internal Request Header",
          ReqSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelReqForApprovalCode(), Database::"Internal Request Header",
          ReqCancelApprovalRequestDescTxt, 0, false);
        //Tender Evaluation
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTenderEvalForApprovalCode(), Database::"Procurement Evaluation Header",
        TenderEvalSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTenderEvalApprovalRequestCode(), Database::"Procurement Evaluation Header",
        TenderEvalApprReqCancelledEventDescTxt, 0, false);
        //Supplier Evaluation
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendSupplierEvalForApprovalCode(), Database::"Supplier Evaluation Header",
        SupplierEvalSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelSupplierEvalApprovalRequestCode(), Database::"Supplier Evaluation Header",
        SupplierEvalApprReqCancelledEventDescTxt, 0, false);
        //FA Disposal
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendFADisposalForApprovalCode(), Database::"FA Disposal",
        FADisposalSendForApprovalEventDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelFADisposalApprovalRequestCode(), Database::"FA Disposal",
        FADisposalApprReqCancelledEventDescTxt, 0, false);
        //Tender Committee
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendTenderCommitteeForApprovalCode(), Database::"Tender Committees",
        TenderCommitteeSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelTenderCommitteeApprovalRequestCode(), Database::"Tender Committees",
        TenderCommitteeCancelApprovalRequestDescTxt, 0, false);
        //Procurement Plan
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendProcurementPlanForApprovalCode(), Database::"Procurement Plan",
        ProcurementPlanSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelProcurementPlanApprovalRequestCode(), Database::"Procurement Plan",
        ProcurementPlanCancelApprovalRequestDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            //Requisitions
            RunWorkflowOnCancelReqForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelReqForApprovalCode(), RunWorkflowOnSendReqForApprovalCode());
            //Tender Evaluation
            RunworkflowOnCancelTenderEvalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTenderEvalApprovalRequestCode(), RunworkflowOnSendTenderEvalforApprovalCode());
            //Supplier Evaluation
            RunworkflowOnCancelSupplierEvalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelSupplierEvalApprovalRequestCode(), RunworkflowOnSendSupplierEvalforApprovalCode());
            //FA disposal
            RunworkflowOnCancelFADisposalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelFADisposalApprovalRequestCode(), RunworkflowOnSendFADisposalforApprovalCode());
            //Quote Evaluation
            RunworkflowOnCancelQuoteEvalApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelQuoteEvalApprovalRequestCode(), RunworkflowOnSendQuoteEvalforApprovalCode());
            //Tender Committeee
            RunworkflowOnCancelTenderCommitteeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelTenderCommitteeApprovalRequestCode(), RunworkflowOnSendTenderCommitteeforApprovalCode());
            //Procurement Plan
            RunworkflowOnCancelProcurementPlanApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunworkflowOnCancelProcurementPlanApprovalRequestCode(), RunworkflowOnSendProcurementPlanforApprovalCode());


            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    //Requisitions
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendReqforApprovalCode());
                    //Tender Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendFADisposalforApprovalCode());
                    //Quote Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendProcurementPlanforApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    //Requisitions
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendReqforApprovalCode());
                    //Tender Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendSupplierEvalforApprovalCode());
                    //Quote Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendProcurementPlanforApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    //Requisitions
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendReqforApprovalCode());
                    //Tender Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendTenderEvalforApprovalCode());
                    //Supplier Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendSupplierEvalforApprovalCode());
                    //FA Disposal
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendFADisposalforApprovalCode());
                    //Quote Evaluation
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendQuoteEvalforApprovalCode());
                    //Tender Committee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendTenderCommitteeforApprovalCode());
                    //Procurement Plan
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendProcurementPlanforApprovalCode());
                end;
        end;
    end;

    //Requisitions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendReqRequestforApproval', '', false, false)]
    local procedure RunWorkflowOnSendReqForApproval(var Req: Record "Internal Request Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendReqForApprovalCode(), Req);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelReqApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelReqForApproval(var Req: Record "Internal Request Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelReqForApprovalCode(), Req);
    end;

    //Tender Evaluation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendProcurementEvaluationForApproval', '', false, false)]
    local procedure RunWorkflowOnSendTenderEvalForApproval(var TenderEval: Record "Procurement Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderEvalForApprovalCode(), TenderEval);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelProcurementEvaluationApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelTenderEvalApprovalRequest(var TenderEval: Record "Procurement Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderEvalApprovalRequestCode(), TenderEval);
    end;

    //Supplier Evaluation
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendSupplierEvalForApproval', '', false, false)]
    local procedure RunWorkflowOnSendSupplierEvalForApproval(var Evaluation: Record "Supplier Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSupplierEvalForApprovalCode(), Evaluation);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelSupplierEvalApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelSupplierEvalApprovalRequest(var Evaluation: Record "Supplier Evaluation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSupplierEvalApprovalRequestCode(), Evaluation);
    end;

    //FA Disposal
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendFADisposalForApproval', '', false, false)]
    local procedure RunWorkflowOnSendFADisposalForApproval(var FADisposal: Record "FA Disposal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendFADisposalForApprovalCode(), FADisposal);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelFADisposalApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelFADisposalApprovalRequest(var FADisposal: Record "FA Disposal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelFADisposalApprovalRequestCode(), FADisposal);
    end;

    //Tender Committee
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendTenderCommitteeForApproval', '', false, false)]
    local procedure RunWorkflowOnSendTenderCommitteeForApproval(var TenderCommittee: Record "Tender Committees")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTenderCommitteeForApprovalCode(), TenderCommittee);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelTenderCommitteeRequest', '', false, false)]
    local procedure RunWorkflowOnCancelTenderCommitteeApprovalRequest(var TenderCommittee: Record "Tender Committees")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTenderCommitteeApprovalRequestCode(), TenderCommittee);
    end;

    //Procurement Plan
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnSendProcurementPlanForApproval', '', false, false)]
    local procedure RunWorkflowOnSendProcurementPlanForApproval(var ProcurementPlan: Record "Procurement Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurementPlanForApprovalCode(), ProcurementPlan);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Procurement Ext", 'OnCancelProcurementPlanRequest', '', false, false)]
    local procedure RunWorkflowOnCancelProcurementPlanApprovalRequest(var ProcurementPlan: Record "Procurement Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurementPlanApprovalRequestCode(), ProcurementPlan);
    end;
}





