codeunit 60053 "Wkfl Event Handle grant Ext"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

        JobAppRequestCancelApprovalRequestDescTxt: Label 'An approval request for JobApp Request is cancelled ';
        JobAppRequestSendforApprovalDescTxt: Label 'An approval for JobApp Request is requested';
        NewEmployeeSendforApprovalDescTxt: Label 'An approval for a new Employee is requested';
        NewEmployeeCancelApprovalRequestDescTxt: Label 'An approval request for a new Employee has been cancelled';




    procedure RunWorkflowOnSendJobAppForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendJobAppForApproval'));
    end;

    procedure RunWorkflowOnCancelJobAppApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelJobAppApprovalRequest'));
    end;


    // New Employee
    procedure RunWorkflowOnSendNewEmployeeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendNewEmployeeForApproval'));
    end;

    procedure RunWorkflowOnCancelNewEmployeeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelNewEmployeeApprovalRequest'));
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin

        //JobApp Request
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendJobAppForApprovalCode(), Database::Job,
        JobAppRequestSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelJobAppApprovalRequestCode(), Database::Job,
        JobAppRequestCancelApprovalRequestDescTxt, 0, false);

        // New Employee
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendNewEmployeeForApprovalCode(), Database::"Employee",
        NewEmployeeSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Database::"Employee",
        NewEmployeeCancelApprovalRequestDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
    begin
        case EventFunctionName of

            //JobApp Requests
            RunWorkflowOnCancelJobAppApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelJobAppApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());

            // New Employee
            RunWorkflowOnCancelNewEmployeeApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());


            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());

                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());

                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());
                    ;
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Grant Ext", 'OnSendJobAppApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendJobAppForApproval(var JobAppReq: Record job)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendJobAppForApprovalCode(), JobAppReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt grant Ext", 'OnCancelJobAppApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelJobAppApprovalRequest(var JobAppReq: Record job)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelJobAppApprovalRequestCode(), JobAppReq);
    end;


    // New Employee
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt grant Ext", 'OnSendNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnSendNewEmployeeForApproval(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendNewEmployeeForApprovalCode(), Emp);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt grant Ext", 'OnCancelNewEmployeeApprovalRequest', '', false, false)]
    local procedure RunWorkflowOnCancelNewEmployeeApprovalRequest(var Emp: Record "Employee")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelNewEmployeeApprovalRequestCode(), Emp);
    end;
}





