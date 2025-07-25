page 60036 "Grants Project Card"
{
    ApplicationArea = All;
    Caption = 'Project Summary ';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = const(Project), "Approval Status" = filter(<> Approved));

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
                field("Period of Performance"; Rec."Period of Performance")
                {
                    Caption = 'Implementation Period';
                    ToolTip = 'Specifies the value of the Implementation Period field.';
                }
                field(Partners; Rec.Partners)
                {
                    Caption = 'Collaborative Grants';
                    ToolTip = 'Specifies the value of the Collaborative Grants field.';
                }
                field(Contractor; Rec.Contractor)
                {
                    Caption = 'Implementing Partner';
                    ToolTip = 'Specifies the value of the Implementing Partner field.';
                }
                field("Grant Phases"; Rec."Grant Phases")
                {
                    Caption = 'Grant Life';
                    ToolTip = 'Specifies the value of the Grant Life field.';
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
                field("Main Sub"; Rec."Main Sub")
                {
                    Caption = 'Main Sub';
                    ToolTip = 'Specifies the value of the Main Sub field.';
                }
                field("Main Donor"; Rec."Main Donor")
                {
                    Caption = 'Main Donor';
                    ToolTip = 'Specifies the value of the Main Donor field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = 'Objective';
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Project Location"; Rec."Project Location")
                {
                    Caption = 'Project Location';
                    ToolTip = 'Specifies the value of the Project Location field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'E-Mail';
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
            }
            group("Additional Information")
            {
                Caption = 'Additional Information';
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Funder Contact';
                    ToolTip = 'Specifies the value of the Funder Contact field.';
                }
                field("Principal Investigator name"; Rec."Principal Investigator name")
                {
                    Caption = 'Funder Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Funder Name field.';
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
            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    Caption = 'Allow OverExpenditure';
                    ToolTip = 'Specifies the value of the Allow OverExpenditure field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
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
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Grant Currency Code';
                    Editable = "Currency CodeEditable";
                    ToolTip = 'Specifies the value of the Grant Currency Code field.';

                    trigger OnValidate()
                    begin
                        CurrencyCheck();
                    end;
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Editable = "Invoice Currency CodeEditable";
                    Visible = false;
                    Caption = 'Invoice Currency Code';
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
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
                field("Indirect Cost"; Rec."Indirect Cost")
                {
                    Caption = 'Indirect Cost';
                    ToolTip = 'Specifies the value of the Indirect Cost field.';
                }
                field("Allowed Indirect Cost"; Rec."Allowed Indirect Cost")
                {
                    Caption = 'Allowed Indirect Cost %';
                    ToolTip = 'Specifies the value of the Allowed Indirect Cost % field.';
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
                action(Compliance)
                {
                    Caption = 'Compliance';
                    Image = Task;
                    RunObject = page "Compliance main List";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Compliance action.';
                }
                action("Close Out Check List")
                {
                    Caption = 'Close Out Check List';
                    Image = Task;
                    RunObject = page "Grants Lookup Values List";
                    RunPageLink = "Grants no." = field("No.");
                    ToolTip = 'Executes the Close Out Check List action.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Job), "No." = field("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = page "Grant Ledger Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.", "Job Task No.", "Entry Type", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
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
                action("Budget Lines")
                {
                    Caption = 'Budget Lines';
                    Image = BarChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Budget Lines action.';

                    trigger OnAction()
                    var
                        JTLines: Page "Grant Task Lines";
                    begin
                        JTLines.SetJobNo(Rec."No.");
                        JTLines.Run();
                    end;
                }
                action("Sub Budget Lines")
                {
                    Caption = 'Sub Budget Lines';
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Grant Planning List";
                    RunPageLink = "Grant No." = field("No.");
                    ToolTip = 'Executes the Sub Budget Lines action.';
                }
                action("Project Objectives")
                {
                    Caption = 'Project Objectives';
                    Image = AgreementQuote;
                    ToolTip = 'Executes the Project Objectives action.';
                    //RunObject = Page Page51516868;
                }
                separator(Action1102755035)
                {
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
                separator(Action23)
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
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Send for Approval action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Amount Awarded");
                        if Rec."Approval Status" in [Rec."Approval Status"::Open] then begin
                            /* IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSend_GRANTS_DocForApproval(Rec); */

                            Rec."Approval Status" := Rec."Approval Status"::Approved;
                            Rec.Modify();
                        end;

                        Workflow_User_Group_Member.Reset();
                        Workflow_User_Group_Member.SetRange(Workflow_User_Group_Member."Workflow User Group Code", 'DONOR_PROPOSAL');
                        if Workflow_User_Group_Member.FindFirst() then begin
                            Approval_User_Setup.Reset();
                            Approval_User_Setup.SetRange("User ID", Workflow_User_Group_Member."User Name");
                            if Approval_User_Setup.Find('-') then
                                Body :=
                                '<p> Dear Sir/Mada,,' +
                                '<p> Donor Project ' + Rec.Description + ' requires your approval.' +
                                '<p> Created by: ' + UserId + '.' +
                                '<p>  ' +
                                '<p> Regards,' +
                                '<p> Programs Office.';
                                //Emails_fawe.SendEmail(Approval_User_Setup."E-Mail", 'Request for approval', Body, 'jobs', USERID, 'Donor Project', Source_::Project, Rec."No.");
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" in [Rec."Approval Status"::"Pending Approval"] then begin
                            /* IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnCancel_GRANTS_ApprovalRequest(Rec); */

                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify();
                        end;
                        CurrPage.Close();
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
            action("Grant Financial Report")
            {
                Caption = 'Grant Financial Report';
                Enabled = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;
                ToolTip = 'Executes the Grant Financial Report action.';

                trigger OnAction()
                begin
                    objJobs.Reset();
                    objJobs.SetRange(objJobs."No.", Rec."No.");
                    if objJobs.Find('-') then
                        Report.Run(51516333, true, true, objJobs);
                end;
            }
            action(Attachments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Grant Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Proposal Attachments";
                RunPageLink = "Incoming Document Entry No." = field(RefId);
                ToolTip = 'Executes the Grant Attachments action.';
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
        objJobs: Record Jobs;
        //Emails_fawe: Codeunit "FAWE Emails";
        Approval_User_Setup: Record "User Setup";
        Workflow_User_Group_Member: Record "Workflow User Group Member";

        "Currency CodeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;
        Body: Text[250];


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

