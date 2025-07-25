page 53151 "Tender Archive Card"
{
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks,Evaluation Scores';
    SourceTable = "Procurement Request";
    Caption = 'Tender Awarded Report';

    layout
    {
        area(content)
        {
            group(Group)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                    Caption = 'Tender No.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Tender Item Type"; Rec."Tender Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Item Type field.';
                    ShowMandatory = true;
                }
                field("Award Criteria"; Rec."Award Criteria")
                {
                    ToolTip = 'Specifies the value of the Evaluation Criteria field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                group(FormulaPassMark)
                {
                    ShowCaption = false;
                    Visible = false;// Rec."Evaluation Criteria" = Rec."Evaluation Criteria"::Formula;
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
                    Caption = 'Tender Deadline';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Deadline field';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Time field';
                }
                field("Technical Pass Mark"; Rec."Technical Pass Mark")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Technical Pass Mark field.';
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Tender Type"; Rec."Tender Type")
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
            }
            part(Control12; "Procurement Request Lines")
            {
                Editable = false;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
            part(TenderEval; "Tender Evaluation Setup")
            {
                Caption = 'Tender Evaluation Setup';
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = false;
            }
            part(Applicants; "Tender Applicants")
            {
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = false;
            }
            part(Scope; "Tender Scope of Work")
            {
                //Editable = Rec."Submitted To Portal" = false;
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
                Editable = false;
            }
            part(Amounts; "Tender Amounts")
            {
                Visible = false;
                Editable = Rec."Submitted To Portal" = false;
                SubPageLink = "Tender No." = field("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Request for Tender")
            {
                Caption = 'Request for Tender';

                action("Select Suppliers")
                {
                    Caption = 'Select Suppliers for Financials';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Bidders Selection";
                    RunPageLink = "Reference No." = field("No.");
                    ApplicationArea = All;
                    RunPageMode = View;
                    ToolTip = 'Executes the Select Suppliers action';
                    Enabled = Rec.Status = Rec.Status::New;

                    trigger OnAction()
                    begin
                        TestTheFields();
                    end;
                }
                action("Request for Quotations")
                {
                    Caption = 'Request for Tender';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Request for Tender action';
                    Enabled = Rec.Status = Rec.Status::New;
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
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Generate Tender Evaluation action';
                    Enabled = Rec.Status = Rec.Status::New;

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                    begin
                        TestTheFields();

                        if Confirm('Are you sure you want to generate a Tender Evaluation?', false) = true then begin
                            SupplierSelection.Reset();
                            SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."No.");
                            SupplierSelection.SetRange(SupplierSelection.Invited, true);
                            if SupplierSelection.Find('-') then begin
                                repeat
                                    ProcurementManagement.CreateProcurementEvaluation(SupplierSelection);
                                until SupplierSelection.Next() = 0;
                                Message('Suppliers Sent to Financial Evaluation Successfully');
                            end;
                        end;

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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ProcurementManagement.EvaluateTenderApplicants(Rec);
                    end;
                }
            }
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;
                    Image = AddContacts;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Submit To Portal action';
                    Enabled = false;

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
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ApplicationArea = All;
                    Enabled = false;
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
        }
        area(Reporting)
        {
            action("Evaluation Scores-old")
            {
                Promoted = true;
                Visible = false;
                PromotedCategory = Category6;
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

            action("Evaluation Scores")
            {
                Caption = 'Evaluation Scores Summary';
                Promoted = true;
                PromotedCategory = Category6;
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
                PromotedCategory = Category6;
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
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Open;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::Tender;
        Rec."Tender Type" := Rec."Tender Type"::Open;
    end;

    var
        SupplierSelect: Record "Supplier Selection";
        ProcurementManagement: Codeunit "Procurement Management";
        CommiteeRec: Record "Tender Committees";

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
    end;
}





