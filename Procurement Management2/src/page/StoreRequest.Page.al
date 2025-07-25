page 53061 "Store Request"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Reject';
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = where("Document Type" = const(Stock));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                group(Control17)
                {
                    Editable = not OpenApprovalEntriesExist;
                    ShowCaption = false;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                    }
                }
                field("Reason Description"; Rec."Item Description")
                {
                    Caption = 'Request Description';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Description field';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Required Date';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Required Date field';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Issuing Store';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issuing Store field';
                }
                group(Control33)
                {
                    ShowCaption = false;

                    field("Collected By"; Rec."Collected By")
                    {
                        Caption = 'Received By';
                        Editable = DocReleased and not DocPosted;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Received By field';
                    }
                    field("Collected Name"; Rec."Collected Name")
                    {
                        Caption = 'Received Name';
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Received Name field';
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        Visible = not DocPosted;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Status field';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("SRN Type"; Rec."SRN Type")
                    {
                        Editable = Rec."Status" = Rec."Status"::Open;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SRN Type field';
                    }
                    field("Requested By"; Rec."Requested By")
                    {
                        Enabled = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Requested By field';
                    }
                    field(Posted; Rec.Posted)
                    {
                        Editable = false;
                        Visible = DocPosted;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        Caption = 'Issued By';
                        Editable = false;
                        Visible = DocPosted;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Issued By field';
                    }
                    field("Posting Date"; Rec."Posting Date")
                    {
                        Caption = 'Issue Date';
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Issue Date field';
                    }
                    field("Time Posted"; Rec."Time Posted")
                    {
                        Editable = false;
                        Visible = DocPosted;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Time Posted field';
                    }
                    field("Total Amount"; Rec."Total Amount")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Total Amount field';
                    }
                    field("Rejection Comment"; Rec."Rejection Comment")
                    {
                        Editable = false;
                        Style = Attention;
                        StyleExpr = true;
                        Visible = CommentVisible;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rejection Comment field';
                    }
                }
            }
            part(StoreRequestSubform; "Store Request Subform")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Caption = 'Store Request Subform';
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            systempart(Control12; Links)
            {
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = field("No.");
                Visible = ShowCommentFactbox;
            }
            systempart(Control23; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control20; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control9; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                ToolTip = 'Executes the Send A&pproval Request action';

                trigger OnAction()
                begin
                    // IF ApprovalsMgmt.CheckRequisitionsApprovalsWorkflowEnabled(Rec) THEN
                    //  ApprovalsMgmt.OnSendRequisitionsForApproval(Rec);
                    Rec.TestField("Shortcut Dimension 1 Code");
                    Rec.TestField("Shortcut Dimension 2 Code");
                    Rec.TestField("Location Code");
                    if Confirm('Send SRN for approval?', false) = true then begin
                        /* if Rec."SRN Type" = Rec."SRN Type"::Consumables then begin
                            Committment.CheckStoreReqCommittment(Rec);
                            Committment.StoreReqCommittment(Rec, ErrorMsg);
                            if ErrorMsg <> '' then
                                Error(ErrorMsg);
                        end;
                        Commit(); */

                        if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendReqRequestforApproval(Rec);

                        Commit();

                        //Check HOD approver
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."HOD User" then begin
                                ApprovalEntry.Reset();
                                ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                                ApprovalEntry.SetRange("Document No.", Rec."No.");
                                ModifyHODApprovals.SetTableView(ApprovalEntry);
                                ModifyHODApprovals.RunModal();
                            end;
                        end;
                    end;

                    Commit();
                    CurrPage.Close();
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Cancel the approval request.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approval Mgt Procurement Ext";
                begin
                    //ApprovalsMgmt.OnCancelRequisitionsApprovalRequest(Rec);
                    if Confirm('Cancelling this approval request will uncommit the previously committed amount in the budget. Continue', false) = true then begin
                        //Committment.UncommitStoreReq(Rec);
                        ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                        Commit();
                        Committment.CancelIRCommitments(Rec);
                    end;

                    CurrPage.Close();
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        //ShowDimFields();
    end;

    trigger OnInit()
    begin
        CommentVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
        //ShowDimFields();
    end;

    var
        ApprovalEntry: Record "Approval Entry";
        RequestLines: Record "Internal Request Line";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        ApprovalsMgmt: Codeunit "Approval Mgt Procurement Ext";
        Committment: Codeunit "Commitments Mgt Procurement";
        CanCancelApprovalForRecord: Boolean;
        CommentVisible: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowCommentFactbox: Boolean;
        ShowDim: Boolean;
        ErrorMsg: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        DocPosted := Rec.Posted;

        if Rec.Status = Rec.Status::Released then
            DocReleased := true;

        if Rec."Rejection Comment" <> '' then
            CommentVisible := true
        else
            CommentVisible := false;
    end;

    local procedure ShowDimFields()
    begin
        if Rec."Multi-Donor" then
            ShowDim := false
        else
            ShowDim := true;
        CurrPage.Update();
    end;

    local procedure testDimensions(DimId: Integer)
    begin
        case DimId of
            1:
                begin
                    RequestLines.Reset();
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 1 Code");
                        until RequestLines.Next() = 0;
                end;
            2:
                begin
                    RequestLines.Reset();
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next() = 0;
                end;
            3:
                begin
                    RequestLines.Reset();
                    RequestLines.SetRange("Document No.", Rec."No.");
                    RequestLines.SetRange("Document Type", Rec."Document Type");
                    if RequestLines.Find('-') then
                        repeat
                            RequestLines.TestField("Shortcut Dimension 3 Code");
                        until RequestLines.Next() = 0;
                end;
        end;
    end;
}





