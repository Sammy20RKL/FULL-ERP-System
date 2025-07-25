page 53084 "EOI Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,EOI Opening,Preliminary/Technical Evaluation,Financial Evaluation,Evaluation Scores,Attachments,Portal Controls';
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
                    Caption = 'EOI No.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("EOI Item Type"; Rec."Tender Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EOI Item Type field.';
                    ShowMandatory = true;
                    Caption = 'EOI Item Type';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Award Criteria"; Rec."Award Criteria")
                {
                    ToolTip = 'Specifies the value of the Award Criteria field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                group(FormulaPassMark)
                {
                    ShowCaption = false;
                    Visible = false;//Rec."Evaluation Criteria" = Rec."Evaluation Criteria"::Formula;
                    field("Formula Pass Mark"; Rec."Formula Pass Mark")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Formula Pass Mark field.';
                        ShowMandatory = true;
                    }
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref No. field';
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan No field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field';
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                    Visible = false;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    Caption = 'EOI Deadline';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EOI Deadline field';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Time field';
                }
                group(Passmark)
                {
                    Visible = Rec."Tender Item Type" = Rec."Tender Item Type"::Services;

                    field("Technical Pass Mark"; Rec."Technical Pass Mark")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Technical Pass Mark field.';
                        ShowMandatory = true;
                    }
                }
                field("EOI Type"; Rec."Tender Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Type field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
                field("EOI Not Opened"; Rec."Tender Not Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Opened field.';
                    Visible = false;
                }
                field(TenderFullyOpen; TenderFullyOpen)
                {
                    Caption = 'EOI Fully Opened';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    Enabled = false;
                }
            }
            part(Control12; "Procurement Request Lines")
            {
                //Editable = false;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part(TenderEval; "Tender Evaluation Setup")
            {
                Caption = 'EOI Evaluation Setup';
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::New;
            }
            part(RFQApplicants; "Supplier Selection")
            {
                Caption = 'EOI Applicants';
                SubPageLink = "Reference No." = field("No.");
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::New;
            }
            part(Scope; "Tender Scope of Work")
            {
                Caption = 'EOI Scope of Work';
                //Editable = Rec."Submitted To Portal" = false;
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::New;
            }
            part(Amounts; "Tender Amounts")
            {
                Visible = false;
                Editable = Rec."Submitted To Portal" = false;
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
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
                Caption = 'Suppliers Qualified for Financials';
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
            action("Print RFQ's")
            {
                Caption = 'Print Tender''s';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Print Tender''s action';
                Visible = not IsEOI;

                trigger OnAction()
                begin
                    TestTheFields();

                    SupplierSelect.Reset();
                    SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                    Report.Run(Report::"Tender", true, false, SupplierSelect);
                end;
            }
            action("Tender Applicants")
            {
                Caption = 'EOI Applicants';
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
                Visible = not IsEOI;

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
                Visible = not IsEOI;

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
                Visible = not IsEOI;

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
            action("Financial Analysis Report")
            {
                Caption = 'Financial Analysis Report';
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Quotation Analysis action';
                Visible = not IsEOI;

                trigger OnAction()
                var
                    Quote: Record "Procurement Evaluation Header";
                begin
                    Quote.Reset();
                    Quote.SetRange("No.", Rec."No.");
                    if Quote.FindFirst() then
                        Report.Run(Report::"Tender Financial Evaluation", true, false, Quote);
                end;
            }
            action("Evaluation Scores")
            {
                Caption = 'Evaluation Scores Summary';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Image = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Evaluation Scores action';
                Visible = not IsEOI;

                trigger OnAction()
                var
                    TenderRec: Record "Procurement Request";
                begin
                    TenderRec.Reset();
                    TenderRec.SetRange("No.", Rec."No.");
                    if TenderRec.FindFirst() then
                        Report.Run(Report::"Tender Scores", true, false, TenderRec);
                end;
            }
            action("Tender Summary Report")
            {
                Caption = 'Tender Summary CEO Report';
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                Image = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Tender action';
                Visible = not IsEOI;

                trigger OnAction()
                var
                    TenderRec: Record "Procurement Request";
                begin
                    TenderRec.Reset();
                    TenderRec.SetRange("No.", Rec."No.");
                    if TenderRec.FindFirst() then
                        Report.Run(Report::"Tender Summary", true, false, TenderRec);
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::EOI;
        //Rec."Tender Type" := Rec."Tender Type"::Open;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::EOI;
        //Rec."Tender Type" := Rec."Tender Type"::Open;
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
        IsEOI: Boolean;

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
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

        case Rec."Process Type" of
            Rec."Process Type"::EOI:
                IsEOI := true
            else
                IsEOI := false;
        end;
    end;
}





