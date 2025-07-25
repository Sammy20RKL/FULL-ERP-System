page 53143 "Procurement Plan Approved Card"
{
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    DelayedInsert = false;
    PageType = Card;
    SourceTable = "Budget Approval Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::"Open";

                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Time Created"; Rec."Time Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Created field';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan';
                    ToolTip = 'Specifies the value of the Budget Name field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Editable = false;
                }
            }
            part(Control17; "Proc Plan Item Approval")
            {
                Editable = Rec."Status" = Rec."Status"::"Open";
                SubPageLink = "Document No." = field("Document No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                Visible = ShowCommentFactbox;
            }
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control16; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApproval)
            {
                Caption = 'Send Approval Request';
                Enabled = Rec."Status" = Rec."Status"::"Open";
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckBudgetWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendBudgetApproval(Rec)
                    else
                        WorkflowResposes.ReleaseBudget(Rec);
                end;
            }
            action(CancelApproval)
            {
                Caption = 'Cancel Approval Request';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelBudgetApproval(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Table ID", Database::"Budget Approval Header");
                    ApprovalEntry.SetRange("Document No.", Rec."Document No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."Document No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        WorkflowResposes: Codeunit "Workflow Responses Procurement";
        CanCancelApprovalRequest: Boolean;
        OpenApprovalsExist: Boolean;
        ShowCommentFactbox: Boolean;
        OpenApprovalsExistForCurrUser: Boolean;

    local procedure SetControlAppearance()
    var
        BudgetApprovalHeader: Record "Budget Approval Header";
        ApprovalsMgmt2: Codeunit "Approvals Mgmt.";
    begin
        if BudgetApprovalHeader.Get(Rec."Document No.") then begin
            OpenApprovalsExistForCurrUser := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            OpenApprovalsExist := ApprovalsMgmt2.HasOpenApprovalEntries(BudgetApprovalHeader.RecordId);
            CanCancelApprovalRequest := ApprovalsMgmt2.CanCancelApprovalForRecord(BudgetApprovalHeader.RecordId);
        end;
    end;
}





