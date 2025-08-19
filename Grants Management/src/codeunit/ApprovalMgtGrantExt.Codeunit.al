codeunit 60050 "Approval Mgt Grant Ext"

{
    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle grant Ext";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        Employee: Record Employee;
        JobApp: Record Job;
        StaffAppraisalApprovalLbl: Label 'Staff Appraisal-%1 for the Period between %2 - %3', Comment = '%1 = Employee Name, %2 = Period Start, %3 = Period End';
    begin
        case RecRef.Number of
            //Travel Requests
            Database::Job:
                begin
                    RecRef.SetTable(JobApp);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Quote;
                    // ApprovalEntryArgument."Document No." := CopyStr(JobApp.no, 1, MaxStrLen(ApprovalEntryArgument."Document No."));
                    // ApprovalEntryArgument.Amount := JobApp."No. of Personnel";
                    // ApprovalEntryArgument."Amount (LCY)" := JobApp."No. of Personnel";
                end;

        // Database::Employee:
        //     begin
        //         RecRef.SetTable(Employee);
        //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"New Employee Application";
        //         ApprovalEntryArgument."Document No." := Employee."No.";
        //         ApprovalEntryArgument.Description := Employee.Name;
        //     end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        JobApp: Record Job;
        Employee: Record Employee;
        CloseOut: Record "Close Out Check List";
    begin
        case RecRef.Number of

            //Travel Requests
            Database::Job:
                begin
                    RecRef.SetTable(JobApp);
                    JobApp.Validate(Status, JobApp.Status::Planning);
                    JobApp.Modify(true);
                    Variant := JobApp;
                    IsHandled := true;
                end;
            //Grant Close Out
            Database::"Close Out Check List":
                begin
                    RecRef.SetTable(CloseOut);
                    CloseOut.Validate(Status, CloseOut.Status::"Pending Approval");
                    CloseOut.Modify(true);
                    IsHandled := true;
                    Variant := CloseOut;
                end;
        //Leave Application

        // // New Employee Approval
        // Database::Employee:
        //     begin
        //         RecRef.SetTable(Employee);
        //         Employee.Validate(sta, Employee."Approval Status"::"Pending Approval");
        //         Employee.Modify(true);
        //         Variant := Employee;
        //         IsHandled := true;
        //     end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        JobApp: Record Job;

    // Employee: Record Employee;
    begin
        //Employee Acting
        if JobApp.Get(ApprovalEntry."Document No.") then begin
            JobApp.Validate(Status, JobApp.Status::Quote);
            JobApp.Modify();
        end;


    end;




    procedure CheckJobAppWorkflowEnabled(var JobAppReq: Record Job): Boolean
    begin
        if not IsJobAppWorkflowEnabled(JobAppReq) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsJobAppWorkflowEnabled(var JobAppReq: Record Job): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(JobAppReq, WorkflowEventHandling.RunWorkflowOnSendJobAppForApprovalCode()));
    end;




    // New Employee Approval
    procedure CheckNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        if not IsNewEmployeeWorkflowEnabled(Emp) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Emp, WorkflowEventHandling.RunworkflowOnSendNewEmployeeforApprovalCode()));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendJobAppApprovalRequest(var JobAppReq: Record Job)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelJobAppApprovalRequest(var JobAppReq: Record Job)
    begin

    end;


    // New Employee Approval
    [IntegrationEvent(false, false)]
    procedure OnSendNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;
    //*********************************************************Grant Close Out****************************************
    [IntegrationEvent(false, false)]
    procedure OnSendCloseOutGrantApprovalRequest(var CloseOut: Record "Close Out Check List")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelCloseOutGrantApprovalRequest(var CloseOut: Record "Close Out Check List")
    begin
    end;

    procedure CheckGrantCloseOutWorkflowEnabled(var CloseOut: Record "Close Out Check List"): Boolean
    begin
        if not IsGrantCloseOutWorkflowEnabled(CloseOut) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsGrantCloseOutWorkflowEnabled(var CloseOut: Record "Close Out Check List"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(CloseOut, WorkflowEventHandling.RunWorkflowOnSendGrantCloseOutApprovalRequestCode()));
    end;


}





