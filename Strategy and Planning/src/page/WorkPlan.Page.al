page 65039 "Work Plan"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Work Plan Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field("Strategic Plan Code"; Rec."Plan Code")
                {
                    Caption = 'Source Code';
                    ToolTip = 'Specifies the value of the Source Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';

                    trigger OnValidate()
                    begin
                        Rec.TestField("Plan Code")
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    Visible = false;
                }
                field(User_ID; Rec.User_ID)
                {
                    ToolTip = 'Specifies the value of the User_ID field.';
                }
                field(Responsible; Rec.Responsible)
                {
                    ToolTip = 'Specifies the value of the Responsible field.';
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    Visible = false;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    Caption = 'Fiscal Year';
                    ToolTip = 'Specifies the value of the Fiscal Year field.';

                    trigger OnValidate()
                    begin
                        Rec.TestField("Plan Code")
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    ToolTip = 'Specifies the value of the Fiscal Year field.';
                    Visible = false;
                }
            }
            part(Objectives; "Workplan Line Objectives")
            {
                Caption = 'Objectives';
                SubPageLink = Code = field(Code);
            }
            part(Activities; "Workplan Line Activities")
            {
                Caption = 'Activities';
                SubPageLink = Code = field(Code);
                Visible = false;
            }
            part("Work Plan Lines"; "Workplan Line Sub-Activities")
            {
                Caption = 'Work Plan Lines';
                SubPageLink = Code = field(Code);
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(WorkPlan)
            {
                Caption = 'WorkPlan';
                Image = AllocatedCapacity;
                ToolTip = 'Executes the WorkPlan action.';

                trigger OnAction()
                begin
                    /*wHeader.RESET;
                    wHeader.SETRANGE(Code,Code);
                    IF wHeader.FIND('-') THEN
                      REPORT.RUN(REPORT::"Work Plan Matrix",TRUE,FALSE,wHeader);*/

                    Rec.Reset();
                    Rec.SetRange(Code, Rec.Code);
                    Report.Run(Report::"Work Plan Matrix", true, false, Rec);

                end;
            }
        }
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action("Cancel Document")
                {
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Document action.';

                    trigger OnAction()
                    var
                        PurchSetup: Record "Purchases & Payables Setup";
                    begin
                        CurrPage.Close();
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtSPExt;
                    begin
                        if ApprovalsMgmt.CheckWorklPlanWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendWorkplansForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtSPExt;
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelWorkplansApprovalRequest(Rec);
                    end;
                }
                action("Technical WorkPlan ")
                {
                    Image = PickLines;
                    ToolTip = 'Executes the Technical WorkPlan  action.';

                    trigger OnAction()
                    begin
                        Rec.Reset();
                        Rec.SetRange(Code, Rec.Code);
                        Report.Run(Report::"Technical Work Plan", true, false, Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                actionref("Technical WorkPlan _Promoted"; "Technical WorkPlan ")
                {
                }
                actionref(WorkPlan_Promoted; WorkPlan)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Approvals';
                actionref("Cancel Document_Promoted"; "Cancel Document")
                {
                }
                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
                actionref(Delegate_Promoted; Delegate)
                {
                }
                actionref(Comment_Promoted; Comment)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Status <> Rec.Status::Open then
            Error('You cannot edit an approved work plan');
    end;

    var
        InteractionTmplLanguage: Record "Interaction Tmpl. Language";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CreateIncomingDocumentEnabled: Boolean;
        DocNoVisible: Boolean;
        DocumentIsPosted: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    local procedure SetExtDocNoMandatoryCondition()
    begin
    end;
}

