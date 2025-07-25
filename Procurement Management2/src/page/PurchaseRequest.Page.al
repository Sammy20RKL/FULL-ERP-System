page 53064 "Purchase Request"
{
    DeleteAllowed = false;
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
                field("Order Date"; Rec."Order Date")
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field';
                    ShowMandatory = true;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = false;
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
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan field';
                }
                field("Reason Description"; Rec."Item Description")
                {
                    Caption = 'Reason/Description';
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason/Description field';
                    ShowMandatory = true;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field';
                    ShowMandatory = true;
                }
                field("Requested By"; Rec."Requested By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field(Amount; Rec.Amount)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field';
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Combine Quote field';

                }
                group(Control22)
                {
                    Caption = 'Dimensions';
                    //Editable = not OpenApprovalEntriesExist;
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
                Editable = Rec.Status = Rec.Status::Open;
                Caption = 'Purchase Request Subform';
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {

                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
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
                ApplicationArea = All;
                ToolTip = 'Executes the Send A&pproval Request action';

                trigger OnAction()
                begin
                    //BudgetControl.CheckBudgetPurchase(Rec);
                    Rec.TestField("Order Date");
                    Rec.TestField("Item Description");
                    Rec.TestField("Expected Receipt Date");
                    if Rec."Responsibility Center" = '' then Error('Please specify the Responsibility Center to indicate who should approve this.');
                    Rec.TestField("Responsibility Center");

                    // InternalRequestLine.reset();
                    // InternalRequestLine.SetRange("Document No.", Rec."No.");
                    // if InternalRequestLine.Find('-') then
                    //     repeat
                    //         //InternalRequestLine.TestField("Procurement Plan Item");
                    //         InternalRequestLine.TestField(Quantity);

                    //         InternalRequestLine.CalcFields(Specification);
                    //         if not InternalRequestLine.Specification.HasValue then
                    //             Error('Please input specifications on item %1', InternalRequestLine.Description);
                    //     until InternalRequestLine.Next() = 0;

                    // Committment.CheckPurchReqCommittment(Rec);
                    // Committment.PurchReqCommittment(Rec, ErrorMsg);
                    // if ErrorMsg <> '' then
                    //     ERROR(ErrorMsg);

                    if ApprovalsMgmt.CheckReqWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendReqRequestforApproval(Rec);

                    /* //Check HOD approver
                    if UserSetup.Get(UserId) then begin
                        if UserSetup."HOD User" then begin
                            ApprovalEntry.Reset;
                            ApprovalEntry.SetRange("Table ID", Database::"Internal Request Header");
                            ApprovalEntry.SetRange("Document No.", "No.");
                            ModifyHODApprovals.SetTableView(ApprovalEntry);
                            ModifyHODApprovals.RunModal;
                        end;
                    end; */

                    //Commit();
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
                    Committment.ReversePurchReqCommittment(Rec);
                    ApprovalsMgmt.OnCancelReqApprovalRequest(Rec);
                end;
            }
            action(Approvals)
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;
                ToolTip = 'Executes the View Approvals action';

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
            // action(Approve)
            // {
            //     Caption = 'Approve For Request For Quotation';
            //     Image = Approve;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = "Status" = "Status"::"Released";

            //     trigger OnAction()
            //     begin
            //         TestField(Status, Status::Released);
            //         if Confirm('Are you sure you want to approve PFR No. %1 and send it to Request For Quotation?', false, "No.") = true then begin
            //             "Cleared For RFQ" := true;
            //             Modify;
            //             Commit;
            //             Message('%1 Approved Successfully', "No.");
            //         end else
            //             exit;
            //     end;
            // }
            // action("Reject Approved PRF")
            // {
            //     Image = Reject;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = RFQVisible;

            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure you want to reject PFR No. %1 ?', false, "No.") = true then begin
            //             IR.Reset;
            //             IR.SetRange("No.", "No.");
            //             if IR.FindFirst then begin
            //                 RejectApprovedPRF.SetTableView(IR);
            //                 RejectApprovedPRF.RunModal;
            //             end;
            //         end else
            //             exit;
            //     end;
            // }
            group(Action10)
            {
                Visible = true;
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
                    Visible = Rec.Status = Rec.Status::Released;
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
                // action("Commit Erroneous Entries")
                // {

                //     trigger OnAction()
                //     begin
                //         Committment.CheckPurchReqCommittment(Rec);
                //         Committment.PurchReqCommittment(Rec, ErrorMsg);
                //     end;
                // }
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
                // action("Create LPO")
                // {
                //     Image = MakeOrder;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     Visible = true;

                //     trigger OnAction()
                //     begin
                //         IF CONFIRM('Are you sure you want to create an LPO for this requisition?', FALSE) = TRUE THEN BEGIN
                //             TESTFIELD(Status, Status::Released);
                //             ProcurementMgt.CreateRFQ(Rec);
                //         END;

                //         COMMIT;
                //         CurrPage.CLOSE;
                //     end;
                // }
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
                // action("Raise Tender")
                // {
                //     Caption = 'Raise Tender';
                //     Image = DocInBrowser;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Visible = false;

                //     trigger OnAction()
                //     var
                //         ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                //     begin
                //         /*IF ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) THEN
                //         DocManager.CreateTenderRequest(Rec);
                //         */

                //     end;
                // }
                // action("Check Budget")
                // {
                //     Image = BreakRulesOff;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         /*BudgetControl.CheckBudgetPurchase(Rec);
                //         MESSAGE(Text001);
                //         */

                //     end;
                // }
                // action("Request Over Expenditure")
                // {
                //     Image = BreakRulesOn;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     Visible = false;

                //     trigger OnAction()
                //     begin
                //         Message('Complete');
                //         //BudgetControl.CheckBudgetPurchase();
                //     end;
                // }
                // action("Reverse Committment")
                // {

                //     trigger OnAction()
                //     begin
                //         Committment.ReversePurchReqCommittment(Rec);
                //     end;
                // }

                // action(Archive)
                // {
                //     Image = Archive;
                //     Promoted = true;
                //     PromotedCategory = Process;

                //     trigger OnAction()
                //     begin
                //         if Confirm('Are you sure you want to archive this document?', false) = true then begin
                //             Status := Status::Archived;
                //             Modify;
                //         end;
                //     end;
                // }
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
        SetControlAppearance();
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
        PurchReq: Record "Internal Request Header";
        InternalRequestLine: Record "Internal Request Line";
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
















