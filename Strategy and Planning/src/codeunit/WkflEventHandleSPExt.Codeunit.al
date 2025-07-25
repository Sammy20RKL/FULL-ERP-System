codeunit 65002 "Wkfl Event Handle SP Ext"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        ProjectCancelApprovalRequestDescTxt: Label 'An approval request for a Project is cancelled ';
        ProjectSendforApprovalDescTxt: Label 'An approval for a Project is requested';
        WorkplanCancelApprovalRequestDescTxt: Label 'An approval request for a Workplan is cancelled ';
        WorkplanSendforApprovalDescTxt: Label 'An approval for a Workplan is requested';


    procedure RunWorkflowOnSendProjectsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendProjectsForApproval'));
    end;

    procedure RunWorkflowOnCancelProjectsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelProjectsForApproval'));
    end;

    procedure RunWorkflowOnSendWorkplansForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendWorkplansForApproval'));
    end;

    procedure RunWorkflowOnCancelWorkplansApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelWorkplansApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //Projects
        WorkflowEvent.AddEventToLibrary(RunworkflowOnSendProjectsforApprovalCode(), Database::"Project Header",
          ProjectSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelProjectsForApprovalCode(), Database::"Project Header",
          ProjectCancelApprovalRequestDescTxt, 0, false);

        //Workplans
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendWorkPlansForApprovalCode(), Database::"Work Plan Header",
        WorkplanSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelWorkPlansApprovalRequestCode(), Database::"Work Plan Header",
        WorkplanCancelApprovalRequestDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of
            //Projects
            RunWorkflowOnCancelProjectsForApprovalCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelProjectsForApprovalCode(), RunWorkflowOnSendProjectsForApprovalCode());
            //Workplans
            RunWorkflowOnCancelWorkplansApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelWorkplansApprovalRequestCode(), RunWorkflowOnSendWorkplansForApprovalCode());

            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin
                    //Projects
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendWorkplansForApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin
                    //Projects
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendWorkplansForApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin
                    //Projects
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendProjectsForApprovalCode());
                    //Workplans
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendWorkplansForApprovalCode());
                end;
        end;
    end;

    //Projects
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtSPExt, 'OnSendProjectsForApproval', '', false, false)]
    local procedure RunWorkflowOnSendProjectsForApproval(var Projects: Record "Project Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProjectsForApprovalCode(), Projects);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtSPExt, 'OnCancelProjectsApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelReqForApproval(var Projects: Record "Project Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProjectsForApprovalCode(), Projects);
    end;

    //Workplan
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtSPExt, 'OnSendWorkplansForApproval', '', false, false)]
    local procedure RunWorkflowOnSendTenderEvalForApproval(var Workplans: Record "Work Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendWorkplansForApprovalCode(), Workplans);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtSPExt, 'OnCancelWorkplansApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelTenderEvalApprovalRequest(var Workplans: Record "Work Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelWorkplansApprovalRequestCode(), Workplans);
    end;
}
