codeunit 60054 "Wkflw Event Response grant Ext"
{
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle grant Ext";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //JobApp Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendJobAppForApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //JobApp Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendJobAppForApprovalCode());
                    //emlop
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //JobApp Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendJobAppForApprovalCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //JobApp Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelJobAppApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //JobApp Request
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelJobAppApprovalRequestCode());
                    // New Employee
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelNewEmployeeApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                ;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        JobApp: Record Job;
        Emp: Record "Employee";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of


            //JobApp Request
            Database::Job:
                begin
                    JobApp.SetView(RecRef.GetView());
                    Handled := true;
                    // WorkflowResponses.ReleaseJobAppReq(VarVariant);
                end;



        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        JobApp: Record Job;
        Emp: Record "Employee";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of


            //JobApp Request
            Database::Job:
                begin
                    JobApp.SetView(RecRef.GetView());
                    Handled := true;
                    //  WorkflowResponses.ReopenJobAppReq(VarVariant);
                end;

        end;
    end;

}





