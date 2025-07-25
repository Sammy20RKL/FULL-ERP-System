codeunit 65003 "Wkfl Resp Handle SP Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle SP Ext";
        WorkFlowResponse: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkFlowResponse.SetStatusToPendingApprovalCode():
                begin
                    //Projects
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SetStatusToPendingApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendWorkplansForApprovalCode());
                end;
            WorkFlowResponse.CreateApprovalRequestsCode():
                begin
                    //Projects
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CreateApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnSendWorkplansForApprovalCode());
                end;
            WorkFlowResponse.SendApprovalRequestForApprovalCode():
                begin
                    //Projects
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.SendApprovalRequestForApprovalCode(), WorkflowEventHandling.RunWorkflowOnSendWorkplansForApprovalCode());
                end;
            WorkFlowResponse.OpenDocumentCode():
                begin
                    //Projects
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelProjectsForApprovalCode());
                    //Workplans
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.OpenDocumentCode(), WorkflowEventHandling.RunWorkflowOnCancelWorkplansApprovalRequestCode());
                end;
            WorkFlowResponse.CancelAllApprovalRequestsCode():
                begin
                    //Projects
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelProjectsForApprovalCode());
                    //Workplans
                    WorkFlowResponse.AddResponsePredecessor(WorkFlowResponse.CancelAllApprovalRequestsCode(), WorkflowEventHandling.RunWorkflowOnCancelWorkplansApprovalRequestCode());
                end;
            WorkFlowResponse.ReleaseDocumentCode():
                begin

                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Projects: Record "Project Header";
        Workplans: Record "Work Plan Header";
        WorkflowResponses: Codeunit "Workflow Responses SP";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;
        case RecRef.Number of
            //Projects
            Database::"Project Header":
                begin
                    Projects.SetView((RecRef.GetView()));
                    Handled := true;
                    WorkflowResponses.ReleaseProjects(VarVariant);
                end;
            //Workplans
            Database::"Work Plan Header":
                begin
                    Workplans.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReleaseWorkplan(VarVariant);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Projects: Record "Project Header";
        Workplans: Record "Work Plan Header";
        WorkflowResponses: Codeunit "Workflow Responses SP";
        VarVariant: Variant;
    begin
        VarVariant := RecRef;

        case RecRef.Number of
            //Projects
            Database::"Project Header":
                begin
                    Projects.SetView((RecRef.GetView()));
                    Handled := true;
                    WorkflowResponses.ReopenProjects(VarVariant);
                end;
            //Workplans
            Database::"Work Plan Header":
                begin
                    Workplans.SetView(RecRef.GetView());
                    Handled := true;
                    WorkflowResponses.ReopenWorkplan(VarVariant);
                end;
        end;
    end;
}
