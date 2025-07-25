page 53065 "Purchase Request Approved"
{
    CardPageID = "Purchase Request Approved Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approval Entries';
    SourceTable = "Internal Request Header";
    SourceTableView = where("Document Type" = const(Purchase),
                            //"Fully Ordered" = CONST(false),
                            Status = filter(Fulfilled | Released),
                            Archived = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field';
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Including VAT field';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Selected field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(MakeOrder)
            {
                Caption = 'Make Order From Selected';
                Image = BlanketOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Make Order From Selected action';

                trigger OnAction()
                begin
                    PopulateLines.MakeOrderFromSelected(Rec, true);
                end;
            }
            action(Approve)
            {
                Caption = 'Approve For Request For Quotation';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Approve For Request For Quotation action';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve PFR No. %1 and send it to Request For Quotation?', false, Rec."No.") = true then begin
                        Rec."Cleared For RFQ" := true;
                        Rec.Archived := true;
                        Rec.Modify();
                        Commit();
                        Message('%1 Approved Successfully', Rec."No.");
                    end else
                        exit;
                end;
            }
            action("Reject Approved PRF")
            {
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Released";
                ApplicationArea = All;
                ToolTip = 'Executes the Reject Approved PRF action';
                Caption = 'Reject Requisition';

                trigger OnAction()
                var
                    RejectApprovedPRF: Report "Reject Approved PRF";
                begin
                    if Confirm('Are you sure you want to reject PRF No. %1 ?', false, Rec."No.") = true then begin
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
            action(Approvals)
            {
                AccessByPermission = tabledata "Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'View Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

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
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    trigger OnInit()
    begin
        RfqVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    var
        IR: Record "Internal Request Header";
        PopulateLines: Codeunit "Procurement Management";
        RfqVisible: Boolean;

    local procedure SetPageView()
    begin
        if Rec.Status = Rec.Status::Released then
            RfqVisible := true
        else
            RfqVisible := false;
    end;
}





