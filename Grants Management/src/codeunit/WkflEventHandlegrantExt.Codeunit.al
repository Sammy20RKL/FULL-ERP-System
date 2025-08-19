codeunit 60053 "Wkfl Event Handle grant Ext"
{
    var
        WorkflowEvent: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";

        JobAppRequestCancelApprovalRequestDescTxt: Label 'An approval request for JobApp Request is cancelled ';
        JobAppRequestSendforApprovalDescTxt: Label 'An approval for JobApp Request is requested';
        NewEmployeeSendforApprovalDescTxt: Label 'An approval for a new Employee is requested';
        NewEmployeeCancelApprovalRequestDescTxt: Label 'An approval request for a new Employee has been cancelled';
        GrantCloseOutSendforApprovalDescTxt: Label 'An approval request for Grant Close Out is requested';
        GrantCloseOutCancelApprovalDescTxt: Label 'An approval request for Grant Close Out is cancelled';


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

        //***********************Grant Close Out************************************
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnSendGrantCloseOutApprovalRequestCode(), Database::"Close Out Check List",
        GrantCloseOutSendforApprovalDescTxt, 0, false);
        WorkflowEvent.AddEventToLibrary(RunWorkflowOnCancelGrantCloseOutApprovalRequestCode(), Database::"Close Out Check List",
        GrantCloseOutCancelApprovalDescTxt, 0, false);
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

            //Grant Close Out
            RunWorkflowOnCancelGrantCloseOutApprovalRequestCode():
                WorkflowEvent.AddEventPredecessor(RunWorkflowOnCancelGrantCloseOutApprovalRequestCode(), RunWorkflowOnSendGrantCloseOutApprovalRequestCode());

            WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());

                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());

                    //Grant CloseOut
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnApproveApprovalRequestCode(),RunWorkflowOnSendGrantCloseOutApprovalRequestCode());
                end;

            WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());

                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());

                    //Grant Close Out
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnRejectApprovalRequestCode(), RunWorkflowOnSendGrantCloseOutApprovalRequestCode());
                end;
            WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode():
                begin

                    //JobApp Request
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendJobAppForApprovalCode());
                    
                    // New Employee
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendNewEmployeeForApprovalCode());

                    //Grant Close Out
                    WorkflowEvent.AddEventPredecessor(WorkflowEvent.RunWorkflowOnDelegateApprovalRequestCode(), RunWorkflowOnSendGrantCloseOutApprovalRequestCode());
                end;
        end;
    end;

    procedure RunWorkflowOnSendJobAppForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendJobAppForApproval'));
    end;

    procedure RunWorkflowOnCancelJobAppApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelJobAppApprovalRequest'));
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
    procedure RunWorkflowOnSendNewEmployeeForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendNewEmployeeForApproval'));
    end;

    procedure RunWorkflowOnCancelNewEmployeeApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelNewEmployeeApprovalRequest'));
    end;

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

    //************************************Grant Close Out***********************
    procedure RunWorkflowOnSendGrantCloseOutApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGrantCloseOutforAApproval'));
    end;

    procedure RunWorkflowOnCancelGrantCloseOutApprovalRequestCode(): Code[128];
    begin
        exit(UpperCase('RunWorkflowOnCancelGrantCloseOutApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Grant Ext", 'OnSendCloseOutGrantApprovalRequest', '', false, false)]
    local procedure RunWorkFlowOnSendGrantCloseOutForApproval(var CloseOut: Record "Close Out Check List")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGrantCloseOutApprovalRequestCode(), CloseOut);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgt Grant Ext", 'OnCancelCloseOutGrantApprovalRequest', '', false, false)]
    local procedure RunWorkFlowOnCancelGrantCloseOutForApproval(var CloseOut: Record "Close Out Check List")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGrantCloseOutApprovalRequestCode(), CloseOut);
    end;
}





