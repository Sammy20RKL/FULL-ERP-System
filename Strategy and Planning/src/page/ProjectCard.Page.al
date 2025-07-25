page 65031 "Project Card"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approval,Document';
    SourceTable = "Project Header";

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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.';
                }
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field("WorkPlan Code"; Rec."WorkPlan Code")
                {
                    ToolTip = 'Specifies the value of the WorkPlan Code field.';
                }
                field("Has Attachment"; Rec."Has Attachment")
                {
                    ToolTip = 'Specifies the value of the Has Attachment field.';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(Control9; "Project Activities")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(Creation)
        {
            group(Action31)
            {
                action("Project Team")
                {
                    Caption = 'Project Team';
                    Image = Resource;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "Project Resources";
                    RunPageLink = Code = field(Code);
                    ToolTip = 'Executes the Project Team action.';
                }
                action(Reporting)
                {
                    Caption = 'Reporting';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "Reporting Requirements";
                    RunPageLink = Code = field(Code);
                    ToolTip = 'Executes the Reporting action.';
                }
                action(Budget)
                {
                    Caption = 'Budget';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Project Budget";
                    RunPageLink = Code = field(Code);
                    ToolTip = 'Executes the Budget action.';
                    Visible = false;
                }
                action("Risks and Mitigations")
                {
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "Record Risks";
                    RunPageLink = Code = field(Code);
                    ToolTip = 'Executes the Risks and Mitigations action.';
                }
                action(Attachment)
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Attachment action.';
                }
            }
            group(Action36)
            {
                Visible = false;
                action(Open)
                {
                    ToolTip = 'Executes the Open action.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if InteractionTmplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then
                            InteractionTmplLanguage.OpenAttachment();
                    end;
                }
                action(Import)
                {
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Import action.';

                    trigger OnAction()
                    begin
                        if not InteractionTmplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractionTmplLanguage.Init();
                            InteractionTmplLanguage."Interaction Template Code" := Rec.Code;
                            InteractionTmplLanguage."Language Code" := Rec."Language Code (Default)";
                            //InteractionTmplLanguage.Description := Description;
                            InteractionTmplLanguage.Insert();
                        end;
                        InteractionTmplLanguage.ImportAttachment();
                        CurrPage.Update();
                        Rec."Has Attachment" := true;
                        Rec.Modify();
                    end;
                }
                action(Export)
                {
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Export action.';

                    trigger OnAction()
                    begin
                        if InteractionTmplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then
                            InteractionTmplLanguage.ExportAttachment();
                    end;
                }
                action(Remove)
                {
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Remove action.';

                    trigger OnAction()
                    begin
                        if InteractionTmplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractionTmplLanguage.RemoveAttachment(true);
                            Rec."Has Attachment" := false;
                            Rec.Modify();
                        end;
                    end;
                }
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
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
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    Promoted = true;
                    PromotedCategory = Category4;
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
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtSPExt;
                    begin
                        if ApprovalsMgmt.CheckProjectsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendProjectsForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit ApprovalMgtSPExt;
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelProjectsApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
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

