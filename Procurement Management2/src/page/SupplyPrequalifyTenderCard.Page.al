page 53020 "Supply Prequalify Tender Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Tender Opening,Prequalification Evaluation,Qualified Suppliers,Evaluation Scores,Attachments,Portal Controls,Approvals';
    SourceTable = "Procurement Request";

    layout
    {
        area(content)
        {
            group(Group)
            {
                Editable = Rec.Status = Rec.Status::New;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Name field.';
                    Visible = false;
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref No. field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    Caption = 'Tender Deadline';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Deadline field';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Time field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
                field(TenderFullyOpen; TenderFullyOpen)
                {
                    Caption = 'Tender Fully Opened';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field.';
                }
            }
            part(TenderEval; "Tender Evaluation Setup")
            {
                Caption = 'Tender Evaluation Setup';
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::New;
            }
            part(Applicants; "Tender Applicants")
            {
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::New;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146475),
                              "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Select Suppliers")
            {
                Caption = 'Suppliers Qualified for Prequalification';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                RunObject = page "Bidders Selection";
                RunPageLink = "Reference No." = field("No.");
                RunPageMode = View;
                ApplicationArea = All;
                ToolTip = 'Executes the Select Suppliers action';
                trigger OnAction()
                begin
                    TestTheFields();
                end;
            }
            action("Tender Applicants")
            {
                Caption = 'Tender Applicants';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Tender Applicants action';

                trigger OnAction()
                var
                    TenderRec: Record "Procurement Request";
                    TenderApplicants: Report "Tender Applicants";
                begin
                    TenderRec.Reset();
                    TenderRec.SetRange("No.", Rec."No.");
                    if TenderRec.FindFirst() then begin
                        TenderApplicants.SetTableView(TenderRec);
                        TenderApplicants.RunModal();
                    end;
                end;
            }
            action(Notify)
            {
                Caption = 'Notify Suppliers';
                Image = Email;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Notify Suppliers action';
                Enabled = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    TestTheFields();

                    if Confirm('Are you sure you want to notify the selected suppliers via mail?', false) = true then
                        ProcurementManagement.NotifyRFQSuppliers(Rec."No.")
                    else
                        exit;
                end;
            }
            action("Generate Quote Evaluation")
            {
                Caption = 'Send to Financial Evaluation';
                Image = CreatePutAway;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Generate Tender Evaluation action';
                Enabled = Rec.Status = Rec.Status::New;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to send to Financial Evaluation?', false) then
                        ProcurementManagement.SendToFinancialEvaluation(Rec);

                    Commit();
                    CurrPage.Close();
                end;
            }
            action(SendForEvaluation)
            {
                Caption = 'Send Suppliers For Evaluation';
                Image = Email;
                Enabled = not Rec."Sent For Evaluation";
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if confirm('Send Suppliers For Evaluation?', false) then
                        ProcurementManagement.EvaluateTenderApplicants(Rec);
                end;
            }
            action(SendForOpening)
            {
                Caption = 'Start Tender Opening Process';
                Image = CopyDocument;
                Enabled = not Rec."Sent For Opening";
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if confirm('Are you sure you want to start the tender opening process ?', false) then
                        ProcurementManagement.TenderOpening(Rec);
                end;
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    Visible = true;
                    Image = AddContacts;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit To Portal action';
                    Enabled = Rec.Status = Rec.Status::New;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := true;
                            Rec.Modify();
                        end;
                    end;
                }
                action("Remove from Portal")
                {
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Remove from Portal action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure?', false) then begin
                            Rec."Submitted To Portal" := false;
                            Rec.Modify();
                        end;
                    end;
                }
            }
            group(Approvals)
            {
                action("Send Approval Request")
                {
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    Image = SendApprovalRequest;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Remove from Portal action';

                    trigger OnAction()
                    var
                        WorkflowResp: Codeunit "Workflow Responses Procurement";
                    begin
                        if Confirm('Are you sure?', false) then begin
                            WorkflowResp.ReleaseProcurementRequest(Rec);
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    Image = CancelApprovalRequest;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Remove from Portal action';

                    trigger OnAction()
                    var
                        WorkflowResp: Codeunit "Workflow Responses Procurement";
                    begin
                        if Confirm('Are you sure?', false) then begin
                            WorkflowResp.ReOpenProcurementRequest(Rec);
                        end;
                    end;
                }
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category8;
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
        }
        area(Reporting)
        {
            action("Evaluation Scores")
            {
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Image = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Evaluation Scores action';

                trigger OnAction()
                begin
                    CommiteeRec.Reset();
                    CommiteeRec.SetRange("Tender/Quotation No", Rec."No.");
                    if CommiteeRec.FindFirst() then
                        Report.Run(Report::"Tender Evaluation Scores", true, false, CommiteeRec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::"Supplier Prequalification";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::"Supplier Prequalification";
    end;

    trigger OnInit()
    begin
        TenderFullyOpen := false;
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
        SupplierSelect: Record "Supplier Selection";
        ProcurementManagement: Codeunit "Procurement Management";
        CommiteeRec: Record "Tender Committees";
        TenderFullyOpen: Boolean;

    local procedure TestTheFields()
    begin
        Rec.TestField(Category);
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
    end;

    local procedure SetControlAppearance()
    begin
        Rec.CalcFields("Tender Not Opened");

        if not Rec."Sent For Opening" then
            TenderFullyOpen := false;

        if (Rec."Sent For Opening") and (Rec."Tender Not Opened") then
            TenderFullyOpen := false;

        if (Rec."Sent For Opening") and (not Rec."Tender Not Opened") then
            TenderFullyOpen := true;
    end;
}





