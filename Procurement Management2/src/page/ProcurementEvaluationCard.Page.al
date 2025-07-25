page 53095 "Procurement Evaluation Card"
{
    InsertAllowed = true;
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Procurement Evaluation Header";
    Caption = 'Financial Evaluation';
    PromotedActionCategories = 'New,Financial Analysis,Letters,Approvals,Attachments,Generate LPO/Contract,Summary,Send E-Mails';

    layout
    {
        area(content)
        {
            group(Group)
            {
                Editable = NOT Rec."LPO/Contract Generated";

                field("Quote No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                    Editable = false;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                    Editable = false;
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref No. field';
                    Editable = false;
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Criteria field.';
                }
                field("Tender Generated"; Rec."LPO/Contract Generated")
                {
                    Caption = 'LPO Generated';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LPO Generated field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field';
                    Editable = false;
                }
                // field("Award Date"; Rec."Date of Award")
                // {
                //     ApplicationArea = All;

                //     ToolTip = 'Specifies the value of the Creation Date field';

                // }

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
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Centre  field';
                    Editable = true;
                    ShowMandatory = true;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                // field(Period; Rec.Period)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Currency Code field.';
                // }

                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetControlApperance();
                    end;
                }
                field("LPO No."; Rec."LPO/Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LPO No. field.';
                    Editable = false;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Calculation Type field.';
                }
                field("Remarks"; RemarksTxt)
                {
                    Caption = 'General Remarks';
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Remarks field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Remarks);
                        Rec.Remarks.CreateInStream(InStrm);
                        RemarksBigTxt.Read(InStrm);

                        if RemarksTxt <> Format(RemarksBigTxt) then begin
                            Clear(Rec.Remarks);
                            Clear(RemarksBigTxt);
                            RemarksBigTxt.AddText(RemarksTxt);
                            Rec.Remarks.CreateOutStream(OutStrm);
                            RemarksBigTxt.Write(OutStrm);
                        end;

                    end;
                }
                group("Document Files")
                {
                    Caption = 'Document Files';
                    Visible = false;

                    field(DocCount; DocCount)
                    {
                        Caption = 'Attached Documents';
                        //Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Attached Documents field';
                    }
                }
            }
            group("Award Details")
            {
                Visible = Rec.Status = Rec.Status::Approved;
                Editable = NOT Rec."LPO/Contract Generated";

                field("Contact Person Name"; Rec."Contact Person Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Person Name field.';
                }
                field("Contact Job Position Title"; Rec."Contact Job Position Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Job Position Title field';
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Date field';
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms field';
                    Visible = false;
                }
                field("Date of Award"; Rec."Date of Award")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Award field';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Award field';
                    Caption = 'Acceptance Period';

                }
                field("Sign-Off Employee"; Rec."Sign-Off Employee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sign-Off Employee field';
                }
                field("Sign-Off Employee Name"; Rec."Sign-Off Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sign-Off Employee Name field';
                }
                field("Sign-Off Employee Title"; Rec."Sign-Off Employee Title")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sign-Off Employee Title field';
                }
                field("Award Comment"; CommentsTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the CommentsTxt field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Comments);
                        Rec.Comments.CreateInStream(InStrm);
                        CommentsBigTxt.Read(InStrm);

                        if CommentsTxt <> Format(CommentsBigTxt) then begin
                            Clear(Rec.Comments);
                            Clear(CommentsBigTxt);
                            CommentsBigTxt.AddText(CommentsTxt);
                            Rec.Comments.CreateOutStream(OutStrm);
                            CommentsBigTxt.Write(OutStrm);
                        end;

                    end;
                }
            }
            part(Control7; "Procurement Evaluation Lines")
            {
                Editable = (Rec.Status = Rec.Status::New) or (Rec.Status = Rec.Status::Approved);
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part(Control8; "Procurement Eva Criteria Lines")
            {
                Editable = (Rec.Status = Rec.Status::New) or (Rec.Status = Rec.Status::Approved);
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part("Commitee Members"; "Committee Members")
            {
                SubPageLink = "Tender No." = field("No.");
                Editable = false;
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146479),
                              "No." = FIELD("No.");
            }
            systempart(Notes; Notes)
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
        area(processing)
        {
            action(Check)
            {
                Caption = 'Commit Entries';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Commit Entries action';

                trigger OnAction()
                begin
                    // Committment.CheckPurchQuoteCommittment(Rec);
                    // Committment.PurchQuoteCommittment(Rec, ErrorMsg);
                    // if ErrorMsg <> '' then
                    //     Error(ErrorMsg);
                end;
            }
            action("LPO")
            {
                Caption = 'Generate LPO';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = Rec."LPO/Contract Generated" = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Generate LPO action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Generate an LPO?', false) then
                        ProcurementManagement.GenerateOrderFromProcurementEvaluation(Rec);

                    CurrPage.Close();
                end;
            }
            action("Contract")
            {
                Caption = 'Generate Contract';
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Enabled = Rec."LPO/Contract Generated" = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Generate Contract action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Generate a Contract for the awarded Supplier(s) ?', false) then
                        ProcurementManagement.GenerateContractFromProcurementEvaluation(Rec);

                    CurrPage.Close();
                end;
            }
            action("Calculate Financials")
            {
                Caption = 'Calculate Financials';
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Quotation Analysis action';
                Enabled = NOT Rec."LPO/Contract Generated";

                trigger OnAction()
                begin
                    ProcurementManagement.CalculateFinancialAnalysis(Rec);
                    Commit();
                end;
            }
            action("Financial Analysis Report2")
            {
                Caption = 'Financial Analysis Report';
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Quotation Analysis action';

                trigger OnAction()
                begin
                    /* ProcurementManagement.CalculateFinancialAnalysis(Rec);
                    Commit(); */

                    case Rec."Process Type" of
                        Rec."Process Type"::Tender,
                        Rec."Process Type"::RFP:
                            begin
                                Quote.Reset();
                                Quote.SetRange(Quote."No.", Rec."No.");
                                if Quote.FindFirst() then
                                    Report.Run(Report::"Tender Financial Evaluation", true, false, Quote);
                                //  Report.Run(Report::"COMPARATIVE BID ANALYSIS", true, false, Quote);

                            end;
                        else begin
                            Quote.Reset();
                            Quote.SetRange(Quote."No.", Rec."No.");
                            if Quote.FindFirst() then
                                // Report.Run(Report::"COMPARATIVE BID ANALYSIS", true, false, Quote);

                                Report.Run(Report::"Quote Financial Evaluation", true, false, Quote);
                        end;
                    end;
                end;
            }
            action("Financial Analysis Report-old")
            {
                Caption = 'Financial Analysis Report';
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Executes the Quotation Analysis action';

                trigger OnAction()
                begin
                    Quote.Reset();
                    Quote.SetRange(Quote."No.", Rec."No.");
                    if Quote.FindFirst() then
                        Report.Run(Report::"Tender Analysis", true, false, Quote);
                end;
            }
            action("Financial Analysis Report")
            {
                Caption = 'Financial Analysis Report';
                Image = SelectReport;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Quotation Analysis report';

                trigger OnAction()
                begin
                    /* ProcurementManagement.CalculateFinancialAnalysis(Rec);
                    Commit(); */

                    case Rec."Process Type" of
                        Rec."Process Type"::Tender,
                        Rec."Process Type"::RFP:
                            begin
                                Quote.Reset();
                                Quote.SetRange(Quote."No.", Rec."No.");
                                if Quote.FindFirst() then
                                    Report.Run(Report::"Tender Financial Evaluation", true, false, Quote);
                            end;
                        else begin
                            Quote.Reset();
                            Quote.SetRange(Quote."No.", Rec."No.");
                            if Quote.FindFirst() then
                                Report.Run(Report::"Quote Financial Evaluation", true, false, Quote);
                        end;
                    end;
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
                    Rec.TestField("Responsibility Centre");
                    //  Rec.Status := Rec.Status::Approved;
                    //  if ApprovalMgt.CheckProcurementEvaluationWorkflowEnabled(rec) then
                    ApprovalMgt.OnSendProcurementEvaluationForApproval(rec);
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
                    ApprovalMgt.OnCancelProcurementEvaluationApprovalRequest(rec);
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
                    Approvals.SetRange("Table ID", Database::"Procurement Evaluation Header");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            action(SendAward)
            {
                Caption = 'Send Award Letters';
                ApplicationArea = All;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if confirm('Are you sure you want to send Award Letters ?', false) then
                        ProcurementManagement.SendAwardLetter(Rec);
                end;
            }
            action(SendRegret)
            {
                Caption = 'Send Regret Letters';
                ApplicationArea = All;
                Image = Email;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if confirm('Are you sure you want to send Regret Letters ?', false) then
                        ProcurementManagement.SendRegretLetter(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action("Award Letter")
            {
                Image = Report;
                PromotedCategory = Report;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Award Letter action';
                Enabled = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                begin
                    Clear(AwardEval);
                    Commit();

                    TenderEvalLines.Reset();
                    TenderEvalLines.SetFilter("Document No.", Rec."No.");
                    if TenderEvalLines.FindSet() then begin
                        // AwardEval.SetTableView(TenderEvalLines);
                        // AwardEval.Run();

                        Report.Run(Report::"Supplier Award Letter", true, false, tenderEvalLines);
                    end;


                end;
            }
            action("Regret Letters")
            {
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                ApplicationArea = All;
                ToolTip = 'Executes the Regret Letters action';
                Enabled = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                begin
                    Clear(RegretLetter);
                    Commit();

                    TenderEval.Reset();
                    TenderEval.SetFilter("No.", Rec."No.");
                    if TenderEval.FindFirst() then begin
                        RegretLetter.SetTableView(TenderEval);
                        RegretLetter.Run();
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
    end;

    trigger OnOpenPage()
    begin
        SetControlApperance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlApperance();
    end;

    var
        Quote: Record "Procurement Evaluation Header";
        TenderEval: Record "Procurement Evaluation Header";
        TenderEvalLines: Record "Procurement Evaluation Line";
        ProcRequest: Record "Procurement Request";
        QuoteLines: Record "Procurement Evaluation Line";
        AwardEval: Report "Supplier Award Letter";
        RegretLetter: Report "Supplier Regret Letter";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
        ProcurementManagement: Codeunit "Procurement Management";
        CanCancelApprovalForPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;
        DocCount: Integer;
        RemarksBigTxt, CommentsBigTxt : BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        RemarksTxt, CommentsTxt : Text;

    local procedure SetControlApperance()
    var
        App2: Codeunit "Approvals Mgmt.";
    begin
        if (Rec."Status" = Rec."Status"::Approved) or (Rec."Status" = Rec."Status"::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForPayment := App2.CanCancelApprovalForRecord(Rec.RecordId);

        Rec.CalcFields(Remarks);
        Rec.Remarks.CreateInStream(InStrm);
        RemarksBigTxt.Read(InStrm);
        RemarksTxt := Format(RemarksBigTxt);

        Rec.CalcFields(Comments);
        Rec.Comments.CreateInStream(InStrm);
        CommentsBigTxt.Read(InStrm);
        CommentsTxt := Format(CommentsBigTxt);
    end;

    local procedure TestTheFields()
    begin
        QuoteLines.Reset();
        QuoteLines.SetRange(QuoteLines."Document No.", Rec."No.");
        if QuoteLines.FindSet() then
            repeat
                QuoteLines.TestField(Quantity);
                QuoteLines.TestField("Unit Amount");
                QuoteLines.TestField(Amount);
            until QuoteLines.Next() = 0;
    end;
}





