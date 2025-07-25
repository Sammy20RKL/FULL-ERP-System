page 53028 "FA Disposal Card"
{
    Caption = 'FA Disposal Card';
    PageType = Card;
    SourceTable = "FA Disposal";
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Approvals,View Bids,Sales Order';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date-Time Created field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Caption = 'Created By Staff No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By Staff No. field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field';
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
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Comments field';
                }
            }
            part("FA Disposal Lines"; "FA Disposal Lines")
            {
                editable = not OpenApprovalEntriesExist;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            systempart(Attachements; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = not OpenApprovalEntriesExist;
                ApplicationArea = All;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                begin
                    Rec.TestField(Comments);

                    if ApprovalMgt.CheckFADisposalWorkflowEnabled(Rec) then
                        ApprovalMgt.OnSendFADisposalForApproval(rec);

                    CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Enabled = CanCancelApprovalForPayment;
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelFADisposalApprovalRequest(Rec);
                    CurrPage.Close();
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
                    Approvals.SetRange("Table ID", Database::"FA Disposal");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
            group("Order")
            {
                action(SalesOrder)
                {
                    Caption = 'Generate Sales Order for Selected Bidder';
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    Image = NewSalesQuote;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Generate Sales Order for Selected Bidder action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then
                            ProcMgt.MakeSalesOrderOnFADisposal(Rec);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("View Bids")
            {
                Promoted = true;
                PromotedOnly = true;
                Image = Report;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                ApplicationArea = All;
                ToolTip = 'Executes the View Bids action';

                trigger OnAction()
                begin
                    Commit();

                    if FADisposal.Get(Rec."No.") then begin
                        Report.Run(Report::"FA Disposal Quote Evaluation", true, false, FADisposal);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        FADisposal: Record "FA Disposal";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
        ProcMgt: Codeunit "Procurement Management";
        CanCancelApprovalForPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}





