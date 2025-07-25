codeunit 65001 ApprovalMgtSPExt
{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle SP Ext";
        WorkflowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

    //Projects
    procedure CheckProjectsWorkflowEnabled(var Projects: Record "Project Header"): Boolean
    begin
        if not IsProjectsWorkflowEnabled(Projects) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsProjectsWorkflowEnabled(var Projects: Record "Project Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Projects, WorkflowEventHandling.RunworkflowOnSendProjectsforApprovalCode()));
    end;

    //Workplans
    procedure CheckWorklPlanWorkflowEnabled(var Workplans: Record "Work Plan Header"): Boolean
    begin
        if not IsWorklPlanWorkflowEnabled(Workplans) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsWorklPlanWorkflowEnabled(var Workplans: Record "Work Plan Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Workplans, WorkflowEventHandling.RunWorkflowOnSendWorkplansForApprovalCode()));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ProjectHeader: Record "Project Header";
        WorkPlanHeader: Record "Work Plan Header";
    begin
        case RecRef.Number of
            Database::"Project Header":
                begin
                    RecRef.SetTable(ProjectHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Project;
                    ApprovalEntryArgument."Document No." := ProjectHeader.Code;
                end;
            Database::"Work Plan Header":
                begin
                    RecRef.SetTable(WorkPlanHeader);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Workplan;
                    ApprovalEntryArgument."Document No." := WorkPlanHeader.Code;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ProjectHeader: Record "Project Header";
        WorkPlanHeader: Record "Work Plan Header";
    begin
        case RecRef.Number of
            Database::"Project Header":
                begin
                    RecRef.SetTable(ProjectHeader);
                    ProjectHeader.Validate(Status, ProjectHeader.Status::Pending);
                    ProjectHeader.Modify(true);
                    Variant := ProjectHeader;
                    IsHandled := true;
                end;
            Database::"Work Plan Header":
                begin
                    RecRef.SetTable(WorkPlanHeader);
                    WorkPlanHeader.Validate(Status, WorkPlanHeader.Status::Pending);
                    WorkPlanHeader.Modify(true);
                    Variant := WorkPlanHeader;
                    IsHandled := true;
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendProjectsForApproval(var Projects: Record "Project Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelProjectsApprovalRequest(var Projects: Record "Project Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendWorkplansForApproval(var Workplans: Record "Work Plan Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelWorkplansApprovalRequest(var Workplans: Record "Work Plan Header")
    begin
    end;
}
