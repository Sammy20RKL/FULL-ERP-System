page 53079 "Purchase Request Tracking Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
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
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
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
            action(Print)
            {
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Print/Preview action';

                trigger OnAction()
                begin
                    PurchReq.Reset();
                    PurchReq.SetRange("No.", Rec."No.");
                    REPORT.RUN(report::"Purchase Request Tracking", true, true, PurchReq);
                end;
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
        CanCancelApprovalForRecord: Boolean;
        CommentVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        RFQVisible: Boolean;
        ShowCommentFactbox: Boolean;
        ShowDim: Boolean;

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
















