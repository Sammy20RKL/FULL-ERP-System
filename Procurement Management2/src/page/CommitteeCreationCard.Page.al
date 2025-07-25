page 53057 "Committee Creation Card"
{
    Caption = 'Committee Creation Card';
    PageType = Card;
    SourceTable = "Tender Committees";
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = DocEditable;

                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appointment No field';
                }
                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Quotation No field';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Committee ID field';
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Committee Name field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Creation Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
            }
            part("Committee Members"; "Committee Members")
            {
                //Editable = DocEditable;
                SubPageLink = "Appointment No" = field("Appointment No");
                ApplicationArea = All;
            }
            part("Categories"; "Tender Committee Categories")
            {
                Caption = 'Supplier Categories';
                Visible = Rec."Process Type" = Rec."Process Type"::"Supplier Prequalification";
                ApplicationArea = All;
                SubPageLink = "Appointment No." = field("Appointment No"), "Tender No." = field("Tender/Quotation No");
                Editable = DocEditable;
            }
            part("Committee Suppliers"; "Committee Suppliers")
            {
                Editable = false;
                SubPageLink = "Tender No." = field("Tender/Quotation No");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Committee For Approval")
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = SendApprovalRequest;
                Enabled = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                Caption = 'Send Committee For Approval';
                ToolTip = 'Executes the Send Approval Committee action';

                trigger OnAction()
                var
                    ConfirmApprovalMsg: Label 'Are you sure you want to send an approval request?';
                    DefineCommitteeMemberTypeErr: Label 'Please define a Committee Member Type for %1';
                    CommitteeMember: Record "Committee Member";
                begin
                    if Confirm(ConfirmApprovalMsg, false) then begin
                        CommitteeMember.SetRange("Appointment No", Rec."Appointment No");
                        if CommitteeMember.FindSet() then
                            repeat
                                if CommitteeMember."Committee Member Type" = CommitteeMember."Committee Member Type"::" " then
                                    Error(DefineCommitteeMemberTypeErr, CommitteeMember.Name);
                            until CommitteeMember.Next() = 0;
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify()
                        // if ApprovalMgt.CheckTenderCommitteeWorkflowEnabled(Rec) then
                        //     ApprovalMgt.OnSendTenderCommitteeForApproval(Rec);
                    end;
                    CurrPage.Close();
                end;
            }
            action("Cancel Committee Approval Request")
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";
                ApplicationArea = All;
                Caption = 'Cancel Committee Approval Request';
                ToolTip = 'Executes the Cancel Approval Committee action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelTenderCommitteeRequest(Rec);
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Tender Committees");
                    Approvals.SetRange("Document No.", Rec."Appointment No");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            action("Notify Members")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ProcMgt.NotifyTenderCommitteeMembers(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action(COI)
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                // Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetFilter("Appointment No", Rec."Appointment No");
                    if CommiteeRec.FindFirst() then
                        Report.Run(Report::"Conflict of Interest(COI)", true, false, CommiteeRec);
                end;
            }
            action("Commitee Scores")
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Commitee Scores action';

                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetFilter("Appointment No", Rec."Appointment No");
                    if CommiteeRec.FindFirst() then
                        Report.Run(Report::"Tender Committee Scores", true, false, CommiteeRec);
                end;
            }
            action("Evaluation Scores")
            {
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Evaluation Scores action';

                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetFilter("Appointment No", Rec."Appointment No");
                    if CommiteeRec.FindFirst() then
                        Report.Run(Report::"Tender Evaluation Scores", true, false, CommiteeRec);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        DocEditable := true;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        CommiteeRec: Record "Tender Committees";
        ProcMgt: Codeunit "Procurement Management";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
        DocEditable: Boolean;

    local procedure SetControlAppearance()
    begin
        if Rec.Status = Rec.Status::Open then
            DocEditable := true
        else
            DocEditable := false;
    end;
}





