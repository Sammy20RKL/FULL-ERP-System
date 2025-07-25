page 53105 "Supplier Evaluation Card"
{
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Submit Scores,Tasks';
    SourceTable = "Supplier Evaluation Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                    Caption = 'No.';
                }
                field(Title; Rec.Title)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                    Caption = 'Title';
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
                    Caption = 'Supplier Code';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                    Caption = 'Supplier Name';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                    Caption = 'Description';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field';
                    Caption = 'Document Date';
                }
                field("Tender Item Type"; Rec."Tender Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Item Type field.';
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Stage field.';
                    Editable = false;
                    Caption = 'Evaluation Stage';
                }
                field(User; Rec.User)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                    Caption = 'User';
                }
                group("Preliminary Scores")
                {
                    Visible = (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Preliminary Evaluation") or
                                (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Failed Preliminary") or
                                (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Supplier Prequalification") or
                                (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Passed Supplier Prequalification") or
                                (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Failed Supplier Prequalification");
                    field(Pass; Rec.Pass)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Pass field.';
                    }
                    field("Overall Pass"; Rec."Overall Pass")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Overall Pass field.';
                    }
                }
                group("Technical Scores - Goods")
                {
                    Visible = TechnicalGoods;

                    field(Conform; Rec.Conform)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Conform field.';
                    }
                    field("Overall Conform"; Rec."Overall Conform")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Overall Conform field.';
                    }
                }
                group("Technical Scores - Services")
                {
                    Visible = TechnicalServices;

                    field("Total Technical Score"; Rec."Total Technical Score")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Total Technical Score field.';
                        Caption = 'My Total Technical Score';
                    }
                    field("Average Technical Score"; Rec."Average Technical Score")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Average Technical Score field.';
                        Caption = 'Average Technical Score';
                    }
                }
            }
            part("Supplier Technical Scores"; "Supplier Technical Scores")
            {
                Caption = 'Supplier Technical Evaluation';
                SubPageLink = "Document No." = field("No.");
                Visible = (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Technical Evaluation") or (Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Failed Technical");
                ApplicationArea = All;
            }
            part("Supplier Preliminary Scores"; "Supplier Preliminary Scores")
            {
                Caption = 'Supplier Preliminary Evaluation';
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part("Supplier Evaluation Documents"; "Supplier Evaluation Documents")
            {
                SubPageLink = "Quote No." = field("No.");
                ApplicationArea = All;
                Visible = false;
                Caption = 'Supplier Evaluation Documents';
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
                Caption = 'Approval Comments FactBox';
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

                action("Submit Scores")
                {
                    Caption = 'Submit Scores';
                    Image = CalculateSimulation;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to submit scores?', false) then
                            ProcMgt.SubmitEvaluationScores(Rec);
                        CurrPage.Close();
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
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Enabled = NOT OpenApprovalEntriesExist;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit Scores action';

                    trigger OnAction()
                    begin
                        if ApprovalMgt.CheckSupplierEvalWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendSupplierEvalForApproval(rec);

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
                    Visible = false;
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

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
        Rec.GetAverageScore();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Tender;
    end;

    var
        ProSuppliers: Record "Prospective Suppliers";
        SupEvaLine: Record "Supplier Evaluation Line";
        SupScores: Record "Supplier Evaluation Score";
        SupSetup: Record "Supplier Evaluation SetUp";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
        WorkflowResponses: Codeunit "Workflow Responses Procurement";
        ProcMgt: Codeunit "Procurement Management";
        DocumentAttachment: Page "Document Attachment Details";
        RecRef: RecordRef;
        CanCancelApproval: Boolean;
        OpenApprovalEntriesExist: Boolean;
        TechnicalServices, TechnicalGoods : Boolean;
        LineNo: Integer;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApproval := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);


        if ((Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Technical Evaluation") or ((Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Failed Technical")))
        and (Rec."Tender Item Type" = Rec."Tender Item Type"::Services) then
            TechnicalServices := true
        else
            TechnicalServices := false;

        if ((Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Technical Evaluation") or ((Rec."Evaluation Stage" = Rec."Evaluation Stage"::"Failed Technical")))
        and (Rec."Tender Item Type" = Rec."Tender Item Type"::Goods) then
            TechnicalGoods := true
        else
            TechnicalGoods := false;

        CurrPage."Supplier Technical Scores".Page.GetHeader();
        CurrPage."Supplier Technical Scores".Page.Update();
    end;

    local procedure TestTheFields()
    begin

    end;
}





