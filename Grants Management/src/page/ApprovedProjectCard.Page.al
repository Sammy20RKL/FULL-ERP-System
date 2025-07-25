page 60014 "Approved Project Card"
{
    ApplicationArea = All;
    Caption = 'Project Summary ';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = const(Project), "Approval Status" = filter(Approved));

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'File Name';
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Period of Performance"; Rec."Period of Performance")
                {
                    Caption = 'Implementation Period';
                    ToolTip = 'Specifies the value of the Implementation Period field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Caption = 'Project Start Date';
                    ToolTip = 'Specifies the value of the Project Start Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Caption = 'Project End Date';
                    ToolTip = 'Specifies the value of the Project End Date field.';
                }
                field(Contractor; Rec.Contractor)
                {
                    Caption = 'Implementing Partner';
                    ToolTip = 'Specifies the value of the Implementing Partner field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = 'Objective';
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Project Location"; Rec."Project Location")
                {
                    Caption = 'Project Location';
                    ToolTip = 'Specifies the value of the Project Location field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Funder Contact';
                    ToolTip = 'Specifies the value of the Funder Contact field.';
                }
                field("Principal Investigator name"; Rec."Principal Investigator name")
                {
                    Caption = 'Principal Investigator';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Principal Investigator field.';
                }
                field("Project Coordinator"; Rec."Project Coordinator")
                {
                    Caption = 'Project Coordinator';
                    ToolTip = 'Specifies the value of the Project Coordinator field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Project Status"; Rec."Project Status")
                {
                    Editable = false;
                    Caption = 'Project Status';
                    ToolTip = 'Specifies the value of the Project Status field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Caption = 'Budgeted Cost';
                    ToolTip = 'Specifies the value of the Budgeted Cost field.';
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                    Caption = 'Budgeted Cost LCY';
                    ToolTip = 'Specifies the value of the Budgeted Cost LCY field.';
                }
                field("Amount Awarded"; Rec."Amount Awarded")
                {
                    Caption = 'Amount Awarded';
                    ToolTip = 'Specifies the value of the Amount Awarded field.';
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    Editable = false;
                    Caption = 'Received Amount';
                    ToolTip = 'Specifies the value of the Received Amount field.';
                }
                field("Accounted Amount"; Rec."Accounted Amount")
                {
                    Caption = 'Total Expenditure';
                    ToolTip = 'Specifies the value of the Total Expenditure field.';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Caption = 'Commitment Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Commitment Amount field.';
                }
                field("""Total Cost(LCY)"" - ""Accounted Amount"" - ""Committed Amount"""; Rec."Total Cost(LCY)" - Rec."Accounted Amount" - Rec."Committed Amount")
                {
                    Caption = 'Remaining Balance';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Remaining Balance field.';
                }
                field("Obligated Amount %"; Rec."Obligated Amount %")
                {
                    Caption = 'Obligated Amount %';
                    ToolTip = 'Specifies the value of the Obligated Amount % field.';
                }
                field("Obligated Amount"; Rec."Obligated Amount")
                {
                    Caption = 'Obligated Amount';
                    ToolTip = 'Specifies the value of the Obligated Amount field.';
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Disbursed Amount';
                    ToolTip = 'Specifies the value of the Disbursed Amount field.';
                }
                field("Amount Invoiced"; Rec."Amount Invoiced")
                {
                    Caption = 'Amount Invoiced To Donors';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount Invoiced To Donors field.';
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    Caption = 'Allow OverExpenditure';
                    ToolTip = 'Specifies the value of the Allow OverExpenditure field.';
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                    Caption = 'Invoice Currency Code';
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
                }
                field("Indirect Cost"; Rec."Indirect Cost")
                {
                    Caption = 'Indirect Cost';
                    ToolTip = 'Specifies the value of the Indirect Cost field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
            }
            group("Reporting Dates")
            {
                Caption = 'Reporting Dates';
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Approved Funding Start Date"; Rec."Approved Funding Start Date")
                {
                    Caption = 'Approved Project Start Date';
                    ToolTip = 'Specifies the value of the Approved Project Start Date field.';
                }
                field("Approved Funding End Date"; Rec."Approved Funding End Date")
                {
                    Caption = 'Approved Project End Date';
                    ToolTip = 'Specifies the value of the Approved Project End Date field.';
                }
                field("Approved Budget Start Date"; Rec."Approved Budget Start Date")
                {
                    Caption = 'Approved Budget Start Date';
                    ToolTip = 'Specifies the value of the Approved Budget Start Date field.';
                }
                field("Approved Budget End Date"; Rec."Approved Budget End Date")
                {
                    Caption = 'Approved Budget End Date';
                    ToolTip = 'Specifies the value of the Approved Budget End Date field.';
                }
                field("Financial Reporting Due Date"; Rec."Financial Reporting Due Date")
                {
                    Caption = 'Financial Reporting Due Date';
                    ToolTip = 'Specifies the value of the Financial Reporting Due Date field.';
                }
                field("Technical  Reporting Due Date"; Rec."Technical  Reporting Due Date")
                {
                    Caption = 'Technical  Reporting Due Date';
                    ToolTip = 'Specifies the value of the Technical  Reporting Due Date field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control11; Links)
            {
                Editable = false;
                Visible = true;
            }
            systempart(Control9; Notes)
            {
                Visible = true;
            }
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
                    RunObject = page "Grant WIP Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.", "Job Posting Group", "WIP Posting Date");
                    ToolTip = 'Executes the WIP Entries action.';
                }
                action("WIP G/L Entries")
                {
                    Caption = 'WIP G/L Entries';
                    RunObject = page "Grant WIP G/L Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.");
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
                    RunObject = page "Grant G/L Account Prices";
                    RunPageLink = "Job No." = field("No.");
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
            }
            group("&Project")
            {
                Caption = '&Project';
                action("Budget Lines")
                {
                    Caption = 'Budget Lines';
                    ToolTip = 'Executes the Budget Lines action.';

                    trigger OnAction()
                    var
                        JTLines: Page "Grant Task Lines";
                    begin
                        JTLines.SetJobNo(Rec."No.");
                        JTLines.Run();
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
                action(Action87)
                {
                    Caption = 'Budget Lines';
                    Promoted = true;
                    ToolTip = 'Executes the Budget Lines action.';

                    trigger OnAction()
                    var
                        JTLines: Page "Grant Task Lines";
                    begin
                        JTLines.SetJobNo(Rec."No.");
                        JTLines.Run();
                    end;
                }
                separator(Action1102755035)
                {
                }
                action("Reporting phase schedule")
                {
                    Caption = 'Reporting phase schedule';
                    Image = AgreementQuote;
                    RunObject = page "Phase Reporting SchedulesAudit";
                    RunPageLink = Project = field("No.");
                    ToolTip = 'Executes the Reporting phase schedule action.';
                }
            }
            action("Project Partners")
            {
                Image = Vendor;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Project Partners";
                RunPageLink = "Grant No" = field("No.");
                Caption = 'Project Partners';
                ToolTip = 'Executes the Project Partners action.';
            }
            action("Grant Financial Report")
            {
                Caption = 'Grant Financial Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Grant Financial Report action.';

                trigger OnAction()
                begin
                    objJobs.Reset();
                    objJobs.SetRange(objJobs."No.", Rec."No.");
                    if objJobs.Find('-') then
                        Report.Run(51511479, true, true, objJobs);
                end;
            }
            action("Project Donors")
            {
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = page "Project Donors";
                RunPageLink = "Grant No" = field("No.");
                Caption = 'Project Donors';
                ToolTip = 'Executes the Project Donors action.';
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
                    Visible = false;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",None,"Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","Employee Transfer","Salary Advance","Staff Clearance",Payroll;
                    begin
                        DocumentType := DocumentType::Grant;
                        //ApprovalEntries.Setfilters(DATABASE::Jobs, DocumentType, Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                separator(Action1102755018)
                {
                }
                action("Send for Approval")
                {
                    Caption = 'Send for Approval';
                    Visible = false;
                    ToolTip = 'Executes the Send for Approval action.';

                    trigger OnAction()
                    begin
                        //Release the grant for Approval

                        //TESTFIELD(Donors);
                        //TESTFIELD("Total Cost");
                        //TESTFIELD("Bill-to Partner No.");

                        ///IF NOT RecordLinkCheck(Rec) THEN ERROR('You have no documents attached hence cant proceed');

                        //IF ApprovalMgt.SendConceptNoteApprovalReq(Rec,Status::Project) THEN;   //
                        //IF ApprovalMgt.SendLabRequestApprovalReq(Rec) THEN;   //
                        /*IF ApprovalMgt.OnCancelleavePlannerReqApprovalRequest(Rec) THEN
                            ApprovalMgt.IsHrtransportApprovalsWorkflowEnabled(Rec);*/

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Visible = false;
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        // IF ApprovalMgt.CancelConceptNoteAppRequest(Rec,TRUE,TRUE,Status::Project) THEN;
                    end;
                }
                separator(Action1102755020)
                {
                }
            }
        }
        area(Reporting)
        {
            action("Project Summary Sheet")
            {
                Caption = 'Project Summary Sheet';
                Enabled = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunPageOnRec = true;
                Visible = false;
                ToolTip = 'Executes the Project Summary Sheet action.';

                trigger OnAction()
                begin
                    //      Report project Summary Sheet
                    objJobs.Reset();
                    objJobs.SetRange(objJobs."No.", Rec."No.");
                    if objJobs.Find('-') then
                        Report.Run(51516335, true, true, objJobs);
                end;
            }
            action("Project FactSheet")
            {
                Caption = 'Project FactSheet';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                ToolTip = 'Executes the Project FactSheet action.';

                trigger OnAction()
                begin
                    objJobs.Reset();
                    objJobs.SetRange(objJobs."No.", Rec."No.");
                    if objJobs.Find('-') then
                        Report.Run(51516334, true, true, objJobs);
                end;
            }
            action("View Grant Agreement")
            {
                ApplicationArea = Basic, Suite;
                Image = ViewOrder;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'View Grant Agreement';
                ToolTip = 'Executes the View Grant Agreement action.';

                trigger OnAction()
                begin

                    //"Proposal No"
                    /*IdNo:=Id;
                    RESET;
                    SETRANGE("No.","Proposal No");
                    SETRANGE(Status,Status::Proposal);
                    IF FINDFIRST() THEN BEGIN
                      IncomingDocument.ShowCardFromEntryNo(Id);
                    END;
                    SETRANGE(Id,IdNo);*/

                    IncomingDocument.ShowCardFromEntryNo(Rec.RefId);

                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        Rec.Status := Rec.Status::Project;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetPurchasesFilter;

        Rec.Status := Rec.Status::Project;
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
        IncomingDocument: Record "Incoming Document";
        objJobs: Record Jobs;

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


    procedure RecordLinkCheck(job: Record Jobs) RecordLnkExist: Boolean
    var
        objRecordLnk: Record "Record Link";
        TableCaption: RecordId;
        objRecord_Link: RecordRef;
    begin
        objRecord_Link.GetTable(job);
        TableCaption := objRecord_Link.RecordId;
        objRecordLnk.Reset();
        objRecordLnk.SetRange(objRecordLnk."Record ID", TableCaption);
        if objRecordLnk.Find('-') then exit(true) else exit(false);
    end;
}

