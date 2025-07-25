page 60015 "Approved Proposals Card"
{
    ApplicationArea = All;
    Caption = ' Approved Interactive Proposal Development Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = filter(Proposal), "Approval Status" = filter(Approved));

    layout
    {
        area(Content)
        {
            group("Route Sheet")
            {
                Caption = 'Route Sheet';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Project Title';
                    ToolTip = 'Specifies the value of the Project Title field.';
                }
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Principal Investigator';
                    ToolTip = 'Specifies the value of the Principal Investigator field.';
                }
                field("Principal Investigator name"; Rec."Principal Investigator name")
                {
                    Editable = false;
                    Caption = 'Principal Investigator name';
                    ToolTip = 'Specifies the value of the Principal Investigator name field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = ' Brief Description Of the Project';
                    ToolTip = 'Specifies the value of the  Brief Description Of the Project field.';
                }
                field("Bill-to Partner No."; Rec."Bill-to Partner No.")
                {
                    Caption = ' Donor';
                    ToolTip = 'Specifies the value of the  Donor field.';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Caption = 'Physical Address';
                    ToolTip = 'Specifies the value of the Physical Address field.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Caption = 'Email Address';
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'Search Description';
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Visible = false;
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Concept Approval Date"; Rec."Concept Approval Date")
                {
                    Visible = false;
                    Caption = 'Concept Approval Date';
                    ToolTip = 'Specifies the value of the Concept Approval Date field.';
                }
                field("Main Sub"; Rec."Main Sub")
                {
                    Caption = 'Grantee';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Grantee field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Funding Request"; Rec."Funding Request")
                {
                    Visible = false;
                    Caption = 'Funding Request';
                    ToolTip = 'Specifies the value of the Funding Request field.';
                }
                field(Budget; Rec.Budget)
                {
                    Visible = false;
                    Caption = 'Budget';
                    ToolTip = 'Specifies the value of the Budget field.';
                }
                field("Budget Justification"; Rec."Budget Justification")
                {
                    Visible = false;
                    Caption = 'Budget Justification';
                    ToolTip = 'Specifies the value of the Budget Justification field.';
                }
                field(Control16; Rec.Partners)
                {
                    Visible = false;
                    Caption = 'Collaborative Grants';
                    ToolTip = 'Specifies the value of the Collaborative Grants field.';
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    Caption = 'Thematic Area';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Thematic Area field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Project Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Project Status field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Visible = false;
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Caption = 'Responsible Officer';
                    ToolTip = 'Specifies the value of the Responsible Officer field.';
                }
                field("Proposal Application due Date"; Rec."Proposal Application due Date")
                {
                    Caption = 'Proposal Application due Date';
                    ToolTip = 'Specifies the value of the Proposal Application due Date field.';
                }
                field("RFA/A Receipt Date"; Rec."RFA/A Receipt Date")
                {
                    Visible = false;
                    Caption = 'RFA/A Receipt Date';
                    ToolTip = 'Specifies the value of the RFA/A Receipt Date field.';
                }
                field("Project Team"; Rec."Project Team")
                {
                    Visible = false;
                    Caption = 'Project Team';
                    ToolTip = 'Specifies the value of the Project Team field.';
                }
                field("Indirect Cost"; Rec."Indirect Cost")
                {
                    Visible = false;
                    Caption = 'Indirect Cost';
                    ToolTip = 'Specifies the value of the Indirect Cost field.';
                }
                field("Allowed Indirect Cost"; Rec."Allowed Indirect Cost")
                {
                    Visible = false;
                    Caption = 'Allowed Indirect Cost';
                    ToolTip = 'Specifies the value of the Allowed Indirect Cost field.';
                }
            }
        }
        area(FactBoxes)
        {
        }
    }

    actions
    {
        area(Navigation)
        {
            group("W&IP")
            {
                Caption = 'W&IP';
                Visible = false;
                action("Calculate WIP")
                {
                    Caption = 'Calculate WIP';
                    Ellipsis = true;
                    Image = CalculateWIP;
                    ToolTip = 'Executes the Calculate WIP action.';

                    trigger OnAction()
                    var
                        Job: Record Jobs;
                    begin
                        Rec.TestField("No.");
                        Job.Copy(Rec);
                        Job.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::"Job Calculate WIP", true, false, Job);
                    end;
                }
                action("Post WIP to G/L")
                {
                    Caption = 'Post WIP to G/L';
                    Ellipsis = true;
                    Image = Post;
                    ToolTip = 'Executes the Post WIP to G/L action.';

                    trigger OnAction()
                    var
                        Job: Record Jobs;
                    begin
                        Rec.TestField("No.");
                        Job.Copy(Rec);
                        Job.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::"Job Post WIP to G/L", true, false, Job);
                    end;
                }
                action("WIP Entries")
                {
                    Caption = 'WIP Entries';
                    ToolTip = 'Executes the WIP Entries action.';
                }
                action("WIP G/L Entries")
                {
                    Caption = 'WIP G/L Entries';
                    ToolTip = 'Executes the WIP G/L Entries action.';
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                Visible = false;
                action(Resource)
                {
                    Caption = 'Resource';
                    RunObject = page "Grant Resource Prices";
                    RunPageLink = "Job No." = field("No.");
                    ToolTip = 'Executes the Resource action.';
                }
                action(Item)
                {
                    Caption = 'Item';
                    RunObject = page "Grant Item Prices";
                    RunPageLink = "Job No." = field("No.");
                    ToolTip = 'Executes the Item action.';
                }
                action("G/L Account")
                {
                    Caption = 'G/L Account';
                    ToolTip = 'Executes the G/L Account action.';
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                Visible = false;
                action("Resource Allocated per Job")
                {
                    Caption = 'Resource Allocated per Job';
                    RunObject = page "Resource Allocated per Job";
                    ToolTip = 'Executes the Resource Allocated per Job action.';
                }
                separator(a)
                {
                    Caption = 'a';
                }
                action("Res. &Gr. Allocated per Job")
                {
                    Caption = 'Res. &Gr. Allocated per Job';
                    RunObject = page "Res. Gr. Allocated per Job";
                    ToolTip = 'Executes the Res. &Gr. Allocated per Job action.';
                }
                action(Attachments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Uploaded Proposal';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    // RunObject = page "Document Attachment Details";
                    // RunPageLink = "No." = field("No.");
                    ToolTip = 'Executes the View Uploaded Proposal action.';
                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        if Rec."Approval Status" = Rec."Approval Status"::Approved then
                            DocumentAttachmentDetails.Editable(false);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action("Page Proposal Check List")
                {
                    Caption = 'Proposal Check List';
                    ToolTip = 'Executes the Proposal Check List action.';
                    trigger OnAction()
                    begin
                        
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Job), "No." = field("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(39004330), "No." = field("No.");
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = page "Grant Ledger Entries";
                    RunPageLink = "Job No." = field("No.");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
                }
                action("Grant Task Lines")
                {
                    Caption = 'Grant Task Lines';
                    RunObject = page "Grant Task Lines";
                    RunPageLink = "Grant No." = field("No.");
                    ToolTip = 'Executes the Grant Task Lines action.';
                }
                action("Grant &Planning Lines")
                {
                    Caption = 'Grant &Planning Lines';
                    RunObject = page "Grant Planning List";
                    RunPageLink = "Grant No." = field("No.");
                    ToolTip = 'Executes the Grant &Planning Lines action.';
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Grant Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortcutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
                separator(Action64)
                {
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    ToolTip = 'Executes the Online Map action.';

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
                    end;
                }
                separator(Action1102755008)
                {
                }
                action(Partners)
                {
                    Caption = 'Partners';
                    RunObject = page "Project Partners";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Partners action.';
                }
                action(Donors)
                {
                    Caption = 'Donors';
                    RunObject = page "Project Donors";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Donors action.';
                }
                separator(Action1102755019)
                {
                }
            }
        }
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",None,"Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition",JV,"Grant Task","Concept Note",Proposal;
                    begin
                        DocumentType := DocumentType::Proposal;
                        //ApprovalEntries.Setfilters(DATABASE::Jobs, DocumentType, Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                separator(Action1102755018)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    begin
                        //Release the grant for Approval
                        //TESTFIELD("Total Cost");
                        //IF ApprovalMgt.SendProposalApprovalReq(Rec) THEN;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        // IF ApprovalMgt.CancelProposalAppRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755020)
                {
                }
                action("Copy Grant")
                {
                    Caption = 'Copy Grant';
                    Ellipsis = true;
                    //RunObject = Report Report1084;
                    Visible = false;
                    ToolTip = 'Executes the Copy Grant action.';
                }
                action("Revert to Concept")
                {
                    Caption = 'Revert to Concept';
                    Enabled = false;
                    Visible = false;
                    ToolTip = 'Executes the Revert to Concept action.';

                    trigger OnAction()
                    begin
                        // Status:=Status::"Concept Formulation";
                        // MODIFY;


                        //IF "Approval Status"= "Approval Status"::Open THEN ERROR('Concept must be approved first');
                        if Confirm('Revert proposal to concept?') then begin
                            Rec.Status := Rec.Status::"Concept Formulation";
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify()
                        end
                    end;
                }
                action("Convert to Grant Agreement")
                {
                    Caption = 'Convert to Grant Agreement';
                    Image = ContactFilter;
                    Promoted = true;
                    ToolTip = 'Executes the Convert to Grant Agreement action.';

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" = Rec."Approval Status"::Approved then Rec.ChangeProjectStatus();
                        CurrPage.Close();
                    end;
                }
                action(recordlinks)
                {
                    Caption = 'recordlinks';
                    Visible = false;
                    ToolTip = 'Executes the recordlinks action.';

                    trigger OnAction()
                    begin
                        objNewJob.Reset();
                        objNewJob.SetRange(objNewJob."No.", Rec."System Contract No");
                        if objNewJob.Find('-') then
                            Rec.RecordLinkMove(Rec, objNewJob);
                    end;
                }
                action(Open)
                {
                    Caption = 'Open';
                    ShortcutKey = 'Return';
                    Visible = false;
                    ToolTip = 'Executes the Open action.';

                    trigger OnAction()
                    begin
                        /*IF CONFIRM('Convert proposal to contract?') THEN BEGIN
                         "Approval Status":="Approval Status"::Open;
                        MODIFY;
                       END*/

                    end;
                }
            }
        }
        area(Reporting)
        {
            action("Proposal Route Sheet")
            {
                Caption = 'Proposal Route Sheet';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunPageOnRec = true;
                Visible = false;
                ToolTip = 'Executes the Proposal Route Sheet action.';

                trigger OnAction()
                begin
                    //      Report project Summary Sheet
                    objjobs.Reset();
                    objjobs.SetRange(objjobs."No.", Rec."No.");
                    if objjobs.Find('-') then
                        Report.Run(39005831, true, true, objjobs);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetPurchasesFilter;
    end;

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;*/

        //IF NOT MapMgt.TestSetup THEN
        //  CurrForm.MapPoint.VISIBLE(FALSE);
        if Rec."Approval Status" = Rec."Approval Status"::Approved then
            CurrPage.Editable := false;
        CurrencyCheck();

    end;

    var
        objjobs: Record Jobs;
        objNewJob: Record Jobs;

        "Currency CodeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;


    procedure CurrencyCheck()
    begin
        if Rec."Currency Code" <> '' then
            "Invoice Currency CodeEditable" := false
        else
            "Invoice Currency CodeEditable" := true;

        if Rec."Invoice Currency Code" <> '' then
            "Currency CodeEditable" := false
        else
            "Currency CodeEditable" := true;
    end;
}

