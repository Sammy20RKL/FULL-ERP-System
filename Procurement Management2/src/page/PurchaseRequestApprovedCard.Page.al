page 53082 "Purchase Request Approved Card"
{
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals,Attachments';
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = where("Document Type" = const(Purchase));

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field("Order Date"; Rec."Order Date")
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan field';
                }
                field("Reason Description"; Rec."Item Description")
                {
                    Caption = 'Reason/Description';
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason/Description field';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field';
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field';
                }
                field("Combine Order"; Rec."Combine Order")
                {
                    Caption = 'Combine Quote';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Combine Quote field';
                }
                group(Control22)
                {
                    Editable = not OpenApprovalEntriesExist;
                    ShowCaption = false;
                    Visible = ShowDim;
                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Status field';
                    }
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
            part(PurchaseRequestSubform; "Purchase Request Subform")
            {
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = field("No."),
                              "Procurement Plan" = field("Procurement Plan"),
                              "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code");
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
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146446),
                              "No." = FIELD("No.");
            }
            systempart(Control12; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control35; Notes)
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
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Send A&pproval Request action';

                trigger OnAction()
                begin
                    //BudgetControl.CheckBudgetPurchase(Rec);

                    // Committment.CheckPurchReqCommittment(Rec);
                    // Committment.PurchReqCommittment(Rec,ErrorMsg);
                    // IF ErrorMsg<>'' THEN
                    //   ERROR(ErrorMsg);

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
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approval Mgt Procurement Ext";
                begin
                    ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
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
                    ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            action(Print)
            {
                Caption = 'Print Requisition';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Print Requisition action';

                trigger OnAction()
                begin
                    PurchReq.Reset();
                    PurchReq.SetRange("No.", Rec."No.");
                    REPORT.RUN(report::"Purchase Request", true, true, PurchReq);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve For Request For Quotation';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Approve For Request For Quotation action';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm('Are you sure you want to approve PFR No. %1 and send it to Request For Quotation?', false, Rec."No.") = true then begin
                        Rec."Cleared For RFQ" := true;
                        Rec.Modify();
                        Commit();
                        Message('%1 Approved Successfully', Rec."No.");
                    end else
                        exit;
                end;
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            action("Reject Approved PRF")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RFQVisible;
                ApplicationArea = All;
                ToolTip = 'Executes the Reject Approved PRF action';
                Caption = 'Reject Requisition';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reject PFR No. %1 ?', false, Rec."No.") = true then begin
                        IR.Reset();
                        IR.SetRange("No.", Rec."No.");
                        if IR.FindFirst() then begin
                            RejectApprovedPRF.SetTableView(IR);
                            RejectApprovedPRF.RunModal();
                        end;
                    end else
                        exit;
                end;
            }
            group(Action10)
            {
                Visible = false;
                action("Raise RFQ")
                {
                    Caption = 'Raise RFQ';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Raise RFQ action';

                    trigger OnAction()
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                        DocManager.CreateRFQRequest(Rec);
                        */

                    end;
                }
                action("Make Order")
                {
                    Caption = 'Create &LPO';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create &LPO action';

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.Check(Rec) THEN
                        //DocManager.MakeOrder(Rec);
                        /*
                        OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(RECORDID);
                        IF OpenApprovalEntriesExist=TRUE THEN
                          ERROR(Text002)
                        ELSE
                          */
                        if Rec.Status <> Rec.Status::Released then
                            Error('This requisition must be fully approved before ordering');

                        if Rec.Status = Rec.Status::Released then
                            ProcurementMgt.MakeOrder(Rec);
                        Commit();

                        CurrPage.Close();

                    end;
                }
                action("Create RFQ")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create RFQ action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create an RFQ for this requisition?', false) = true then begin
                            Rec.TestField(Status, Rec.Status::Released);
                            ProcurementMgt.CreateRFQ(Rec);
                        end;

                        Commit();
                        CurrPage.Close();
                    end;
                }
                action("Create LPO")
                {
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create LPO action';

                    trigger OnAction()
                    begin
                        // IF CONFIRM('Are you sure you want to create an RFQ for this requisition?',FALSE)=TRUE THEN
                        //  BEGIN
                        //    TESTFIELD(Status,Status::Released);
                        //    ProcurementMgt.CreateRFQ(Rec);
                        //  END;
                        //
                        // COMMIT;
                        // CurrPage.CLOSE;
                    end;
                }
                action("Create Order")
                {
                    Caption = 'Create &LPO';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Create &LPO action';

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.Check(Rec) THEN
                        //DocManager.MakeOrder(Rec);
                        /*
                        OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(RECORDID);
                        IF OpenApprovalEntriesExist=TRUE THEN
                          ERROR(Text002)
                        ELSE
                          */
                        if Rec.Status <> Rec.Status::Released then
                            Error('This requisition must be fully approved before ordering');

                        if Rec.Status = Rec.Status::Released then
                            ProcurementMgt.MakeOrder(Rec);
                        Commit();

                        CurrPage.Close();

                    end;
                }
                action("Raise RFP")
                {
                    Caption = 'Raise RFP';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Raise RFP action';

                    trigger OnAction()
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                        DocManager.CreateRFPRequest(Rec);
                        */

                    end;
                }
                action("Raise Tender")
                {
                    Caption = 'Raise Tender';
                    Image = DocInBrowser;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Raise Tender action';

                    trigger OnAction()
                    begin
                        /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                        DocManager.CreateTenderRequest(Rec);
                        */

                    end;
                }
                action("Check Budget")
                {
                    Image = BreakRulesOff;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Check Budget action';

                    trigger OnAction()
                    begin
                        /*BudgetControl.CheckBudgetPurchase(Rec);
                        MESSAGE(Text001);
                        */

                    end;
                }
                action("Request Over Expenditure")
                {
                    Image = BreakRulesOn;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Request Over Expenditure action';

                    trigger OnAction()
                    begin
                        Message('Complete');
                        //BudgetControl.CheckBudgetPurchase();
                    end;
                }
                action("Reverse Committment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the Reverse Committment action';

                    trigger OnAction()
                    begin
                        Committment.ReversePurchReqCommittment(Rec);
                    end;
                }
                action("Commit Erroneous Entries")
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the Commit Erroneous Entries action';

                    trigger OnAction()
                    begin
                        Committment.CheckPurchReqCommittment(Rec);
                        Committment.PurchReqCommittment(Rec, ErrorMsg);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then begin
            ShowCommentFactbox := CurrPage.CommentsFactBox.PAGE.SetFilterFromApprovalEntry(ApprovalEntry);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        // ShowDimFields();
        // COMMIT;
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);
        //
        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;
    end;

    trigger OnInit()
    begin
        ShowDim := true;
        RFQVisible := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;
    end;

    trigger OnOpenPage()
    begin
        //ShowDimFields();
        //SetControlAppearance;
        Commit();

        /*Carol
        IF (Status=Status::Released) THEN Field supplier editable TRUE
        ELSE IF (Status=Status::Open); editable FALSE
        END
        */
        // DocStatus:=PaymentRec.FormatStatus(Status);
        //DocStatus:=FormatStatus(Status);

        // IF DocStatus=DocStatus::New THEN
        //  CombineVisible:=FALSE
        // ELSE
        //  CombineVisible:=TRUE;

    end;

    var
        ApprovalEntry: Record "Approval Entry";
        IR: Record "Internal Request Header";
        PurchReq: Record "Internal Request Header";
        UserSetup: Record "User Setup";
        ModifyHODApprovals: Report "Modify HOD Approvals";
        RejectApprovedPRF: Report "Reject Approved PRF";
        ApprovalsMgmt: Codeunit "Approval Mgt Procurement Ext";
        Committment: Codeunit "Commitments Mgt Procurement";
        ProcurementMgt: Codeunit "Procurement Management";
        CanCancelApprovalForRecord: Boolean;
        CommentVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        RFQVisible: Boolean;
        ShowCommentFactbox: Boolean;
        ShowDim: Boolean;
        ErrorMsg: Text;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        if Rec.Status <> Rec.Status::Released then
            RFQVisible := false
        else
            RFQVisible := true;

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
}
















