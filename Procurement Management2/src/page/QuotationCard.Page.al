page 53072 "Quotation Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Print RFQ,Suppliers,Evaluation,Attachments,Portal Controls';
    SourceTable = "Procurement Request";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
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
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field';
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Centre field';
                    ShowMandatory = true;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Issue Date field.';
                }
                field("Quotation Deadline"; Rec."Quotation Deadline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quotation Deadline field';
                }
                field("Expected Closing Time"; Rec."Expected Closing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Closing Time field';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field';
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ToolTip = 'Specifies the value of the Payment Terms field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    Editable = false;
                }
                field("Specify Body"; Rec."Specify Body")
                {
                    Caption = 'Specify E-Mail Body For Supplier Notification';
                    ApplicationArea = All;
                    ToolTip = 'This allows you to specify the E-Mail to be sent to suppliers instead of using the system generated E-Mail.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                group(Email)
                {
                    Caption = 'Supplier Notification E-Mail';
                    Visible = Rec."Specify Body";
                    field("E-Mail Subject"; Rec."E-Mail Subject")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the E-Mail Subject field.';
                        ShowMandatory = true;
                    }
                    field(EmailBodyTxt; EmailBodyTxt)
                    {
                        Caption = 'E-Mail Body';
                        Description = 'E-Mail Body';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Specification field';
                        ShowMandatory = true;
                        MultiLine = true;

                        trigger OnValidate()
                        begin
                            Rec.CalcFields("E-Mail Body Text");
                            Rec."E-Mail Body Text".CreateInStream(InStrm);
                            EmailBodyBigTxt.Read(InStrm);

                            if EmailBodyTxt <> Format(EmailBodyBigTxt) then begin
                                Clear(Rec."E-Mail Body Text");
                                Clear(EmailBodyBigTxt);
                                EmailBodyBigTxt.AddText(EmailBodyTxt);
                                Rec."E-Mail Body Text".CreateOutStream(OutStrm);
                                EmailBodyBigTxt.Write(OutStrm);
                            end;
                        end;
                    }
                }
            }
            part(Control12; "Procurement Request Lines")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
                //Editable = false;
            }
            part(RFQApplicants; "Supplier Selection")
            {
                Caption = 'RFQ Applicants';
                SubPageLink = "Reference No." = field("No.");
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
        area(navigation)
        {
            group("Request for Quotation")
            {
                Caption = 'Request for Quotation';

                action("Select Suppliers")
                {
                    Caption = 'Select Suppliers';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Supplier Selection";
                    RunPageLink = "Reference No." = field("No.");//, "Supplier Category" = field(Category);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Select Suppliers action';

                    trigger OnAction()
                    begin
                        TestTheFields();
                    end;
                }
                // action("Print RFQ's")
                // {
                //     Caption = 'Print RFQ''s';
                //     Image = Print;
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedIsBig = true;
                //     ApplicationArea = All;
                //     ToolTip = 'Executes the Print RFQ''s action';

                //     trigger OnAction()
                //     begin
                //         TestTheFields();

                //         SupplierSelect.Reset();
                //         SupplierSelect.SetFilter(SupplierSelect."Reference No.", Rec."No.");
                //         Report.Run(Report::"RFQ", true, false, SupplierSelect);
                //     end;
                // }
                action("Print RFQ's")
                {
                    Caption = 'Print RFQ''s';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Print RFQ''s action';

                    trigger OnAction()

                    begin
                        TestTheFields();

                        ProcurementRequest.Reset();
                        ProcurementRequest.SetFilter(ProcurementRequest."No.", Rec."No.");
                        Report.Run(Report::"RFQnew", true, false, ProcurementRequest);
                    end;
                }
                action(Notify)
                {
                    Caption = 'Notify Suppliers';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Notify Suppliers action';

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
                    Caption = 'Generate Quote Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Generate Quote Evaluation action';

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                        QuoteEvaluationHeader: Record "Procurement Evaluation Header";
                        QuoteEvaluation: Record "Procurement Evaluation Line";
                    begin
                        TestTheFields();

                        if Confirm('Are you sure you want to generate a Quote Evaluation?', false) = true then begin
                            SupplierSelection.Reset();
                            SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."No.");
                            SupplierSelection.SetRange(SupplierSelection.Invited, true);
                            if SupplierSelection.FindSet() then begin
                                //Delete existing header if quote resent
                                QuoteEvaluationHeader.Reset();
                                QuoteEvaluationHeader.SetRange("No.", Rec."No.");
                                if QuoteEvaluationHeader.FindFirst() then
                                    QuoteEvaluationHeader.Delete(true);

                                //Delete existing lines if quote resent
                                QuoteEvaluation.Reset();
                                QuoteEvaluation.SetRange("Document No.", Rec."No.");
                                if QuoteEvaluation.FindSet() then
                                    QuoteEvaluation.DeleteAll();

                                repeat
                                    ProcurementManagement.CreateProcurementEvaluation(SupplierSelection);
                                until SupplierSelection.Next() = 0;

                                Message('Quote Evaluation generated successfully');
                            end else
                                Error('Please invite at least one supplier');

                            CurrPage.Close();
                        end;
                    end;
                }
            }
        }
        area(Processing)
        {
            group("Portal Controls")
            {
                action("Submit To Portal")
                {
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    Image = AddContacts;
                    ApplicationArea = All;
                    //Visible = false;
                    ToolTip = 'Executes the Submit To Portal action';

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
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    Image = RemoveContacts;
                    ApplicationArea = All;
                    //Visible = false;
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
                PromotedCategory = Category6;
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
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::RFQ;
        Clear(Rec."E-Mail Body Text");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::RFQ;
        Clear(Rec."E-Mail Body Text");
        Clear(EmailBodyBigTxt);
        EmailBodyTxt := '';
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("E-Mail Body Text");
        Rec."E-Mail Body Text".CreateInStream(InStrm);
        EmailBodyBigTxt.Read(InStrm);
        EmailBodyTxt := Format(EmailBodyBigTxt);
    end;

    var
        SupplierSelect: Record "Supplier Selection";
        ProcurementManagement: Codeunit "Procurement Management";
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBodyTxt: Text;
        EmailBodyBigTxt: BigText;
        ProcurementRequest: Record "Procurement Request";

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
    end;
}





