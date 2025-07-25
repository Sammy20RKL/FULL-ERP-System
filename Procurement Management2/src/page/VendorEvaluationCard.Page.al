page 53123 "Vendor Evaluation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Supplier Evaluation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(User; Rec.User)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                }
                field("Total Score"; TotalScoring)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TotalScoring field';
                }
            }
            part(Control12; "Vendor Evaluation SubForm")
            {
                SubPageLink = No = field("No."), Supplier = field("Supplier Code");
                Visible = true;
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Group)
            {
                Caption = 'Submit';

                action("Select Suppliers")
                {
                    Caption = 'Submit';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit action';

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Rec.Status := Rec.Status::Approved;
                        Message('successfully submitted');
                    end;
                }
                action("Reject")
                {
                    Caption = 'Reject Supplier Evaluation';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Reject Supplier Evaluation action';

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Rejected then
                            Rec.Status := Rec.Status::New;
                    end;
                }
                action("Apply Lines")
                {
                    Caption = 'Apply Lines';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Apply Lines action';

                    trigger OnAction()
                    begin
                        SupEvaLine.Reset();
                        SupEvaLine.SetRange("Quote No", Rec."Quote No");
                        if SupEvaLine.Find('-') then begin
                            SupEvaLine.Delete();
                        end;
                        LineNo := 0;
                        ProSuppliers.Reset();
                        ProSuppliers.SetRange("Project Code", Rec."Quote No");
                        if ProSuppliers.Find('-') then
                            repeat
                                LineNo := LineNo + 1000;
                                SupEvaLine.Init();
                                SupEvaLine."Line No." := LineNo;
                                SupEvaLine."Quote No" := Rec."Quote No";
                                SupEvaLine.Supplier := ProSuppliers."No.";
                                SupEvaLine."Supplier Name" := ProSuppliers.Name;
                                SupEvaLine.Insert();
                            until ProSuppliers.Next() = 0;


                        SupSetup.Reset();
                        SupSetup.SetFilter(Active, '%1', true);
                        if SupSetup.Find('-') then
                            repeat
                                if SupEvaLine.Get(Rec."Quote No") then
                                    SupEvaLine."Evaluation Type" := SupSetup.Code;
                                SupEvaLine."Evaluation Description" := SupSetup."Evaluation Description";
                                SupEvaLine."Max Score" := SupSetup."Maximum Score";
                                SupEvaLine.Modify(true);
                            until SupSetup.Next() = 0;
                    end;
                }
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Caption = 'Submit Scores';
                    Image = SendApprovalRequest;
                    //Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit Scores action';

                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckSupplierEvalWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendSupplierEvalForApproval(rec);

                        Message('Scores Submitted Successfully');
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApproval;
                    Image = CancelApprovalRequest;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Cancel Approval Request action';

                    trigger OnAction()
                    begin
                        ApprovalMgt.OnCancelSupplierEvalApprovalRequest(rec);
                    end;
                }
                action("View Approvals")
                {
                    Caption = 'View Approvals';
                    Image = Approvals;
                    Visible = true;
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
                        Approvals.SetRange("Table ID", Database::"Supplier Evaluation Header");
                        Approvals.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(Approvals);
                        ApprovalEntries.RunModal();
                    end;
                }
            }
            action(Attachments)
            {
                Caption = 'Upload attachment';
                ApplicationArea = all;
                Image = Attach;
                ToolTip = 'Executes the Upload attachment action';

                trigger OnAction()
                begin
                    Clear(DocumentAttachment);
                    RecRef.GetTable(Rec);
                    DocumentAttachment.OpenForRecRef(RecRef);
                    DocumentAttachment.RunModal();
                end;
            }
        }
    }

    //SourceTableView = where(Type = const(Existing));
    trigger OnAfterGetRecord()
    begin
        TotalScoring := 0;

        SupScores.Reset();
        SupScores.SetRange("Document No.", Rec."No.");
        if SupScores.Find('-') then begin
            repeat
                SupScores.CalcFields("Total Parameter Score");
                TotalScoring := TotalScoring + SupScores."Total Parameter Score";
            until SupScores.Next() = 0;
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Existing;
    end;

    var
        ProSuppliers: Record "Prospective Suppliers";
        SupEvaLine: Record "Supplier Evaluation Line";
        SupScores: Record "Supplier Evaluation Score";
        SupSetup: Record "Supplier Evaluation SetUp";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
        DocumentAttachment: Page "Document Attachment Details";
        RecRef: RecordRef;
        CanCancelApproval: Boolean;
        TotalScoring: Decimal;
        LineNo: Integer;

    local procedure TestTheFields()
    begin

    end;
}





