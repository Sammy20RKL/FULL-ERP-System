page 53077 "Pending Store Request"
{
    CardPageID = "Approved/Post Store Req Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Internal Request Header";
    SourceTableView = where("Document Type" = const(Stock),
                            Status = filter("Pending Approval"),
                            Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting date field';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field';
                }
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
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Reason Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason Description field';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Collected By ID No."; Rec."Collected By ID No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To be Collected By ID No. field';
                }
                field("Collected By"; Rec."Collected By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To be Collected By field';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control20; Links)
            {
                ApplicationArea = All;
            }
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control5; MyNotes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                Image = Post;
                Promoted = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Post action';

                trigger OnAction()
                begin
                    /*if ApprovalsMgmt.PrePostApprovalCheckIntReq(Rec) then
                    if Posted then
                      Error(Text001)
                    else
                    */
                    ProcurementManager.PostInternalRequest(Rec);

                end;
            }
            action(SendApprovalRequest)
            {
                Caption = 'Send A&pproval Request';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Send A&pproval Request action';

                trigger OnAction()
                begin
                    /*if ApprovalsMgmt.CheckIntReqApprovalPossible(Rec) then
                      ApprovalsMgmt.OnSendIntReqDocForApproval(Rec);
                    */

                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Re&quest';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                ToolTip = 'Cancel the approval request.';
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // ApprovalsMgmt.OnCancelIntReqApprovalRequest(Rec);
                end;
            }
            action("Create Purchase Request")
            {
                Caption = 'Create Purchase Request';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Purchase Request action';

                trigger OnAction()
                begin
                    //IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                    //DocManager.CreatePurchaseRequest(Rec);
                end;
            }
            action(Approvals)
            {
                AccessByPermission = tabledata "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                Visible = false;

                trigger OnAction()
                begin
                    /*ApprovalEntries.Setfilters(Database::"Internal Request Header","Document Type","No.");
                    ApprovalEntries.Run();
                    */

                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Print action';

                trigger OnAction()
                begin
                    IR.Reset();
                    IR.SetRange("No.", Rec."No.");
                    Report.Run(39005475, true, true, IR);
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

        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("Requested By", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;

    var
        IR: Record "Internal Request Header";
        RequestLines: Record "Internal Request Line";
        UserSetup: Record "User Setup";
        ProcurementManager: Codeunit "Procurement Management";
        CanCancelApprovalForRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
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





