page 60010 "Proposal Card"
{
    ApplicationArea = All;
    Caption = 'Interactive Proposal Development Card';
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;

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
                    Caption = 'Donor Contact';
                    ToolTip = 'Specifies the value of the Donor Contact field.';
                }
                field("Principal Investigator name"; Rec."Principal Investigator name")
                {
                    Caption = 'Donor Contact Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Donor Contact Name field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = ' Brief Description Of the Project';
                    ToolTip = 'Specifies the value of the  Brief Description Of the Project field.';
                }
                field("Bill-to Partner No."; Rec."Bill-to Partner No.")
                {
                    Caption = ' Funder';
                    ToolTip = 'Specifies the value of the  Funder field.';
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
                field(Control1102755008; Rec.Partners)
                {
                    Visible = false;
                    Caption = 'Collaborative Grants';
                    ToolTip = 'Specifies the value of the Collaborative Grants field.';
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    Visible = false;
                    Caption = 'Kind of Program';
                    ToolTip = 'Specifies the value of the Kind of Program field.';
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
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
            }
            group(Action57)
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
            group("&Proposal")
            {
                Caption = '&Proposal';
                action("Page Proposal Check List")
                {
                    Caption = 'Proposal Check List';
                    Image = ProjectExpense;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Proposal Check List";
                    RunPageLink = "Proposal Code" = field("No.");
                    ToolTip = 'Executes the Proposal Check List action.';
                }
                action("Area")
                {
                    Caption = 'Area';
                    ToolTip = 'Executes the Area action.';
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
                    RunPageView = sorting("Job No.", "Job Task No.", "Entry Type", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
                }
                action("Grant Task Lines")
                {
                    Caption = 'Grant Task Lines';
                    ToolTip = 'Executes the Grant Task Lines action.';

                    trigger OnAction()
                    var
                        JTLines: Page "Grant Task Lines";
                    begin
                        JTLines.SetJobNo(Rec."No.");
                        JTLines.Run();
                    end;
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
                separator(Action23)
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
                separator(Action21)
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
                separator(Action17)
                {
                }
                action("Personnel Cost Alloc.")
                {
                    Caption = 'Personnel Cost Alloc.';
                    RunObject = page "Project Personnel Cost Alloc";
                    RunPageLink = Project = field("No.");
                    ToolTip = 'Executes the Personnel Cost Alloc. action.';
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Visible = ItemVisible;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    begin
                        //DocumentType:=DocumentType::Proposal;
                        //ApprovalEntries.Setfilters(DATABASE::Jobs,ApprovalEntry."Document Type"::Proposal,"No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                separator(Action1102755018)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = ItemVisible;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" in [Rec."Approval Status"::Open] then begin
                            Rec."Approval Status" := Rec."Approval Status"::Approved;
                            Rec.Modify();
                            /* IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSend_GRANTS_DocForApproval(Rec); */
                        end;

                        Workflow_User_Group_Member.Reset();
                        Workflow_User_Group_Member.SetRange(Workflow_User_Group_Member."Workflow User Group Code", 'DONOR_PROPOSAL');
                        if Workflow_User_Group_Member.FindFirst() then begin
                            Approval_User_Setup.Reset();
                            Approval_User_Setup.SetRange("User ID", Workflow_User_Group_Member."User Name");
                            if Approval_User_Setup.Find('-') then
                                Body :=
                                '<p> Hi,' +
                                '<p> Donor Proposal ' + Rec.Description + ' requires your approval.' +
                                '<p> Created by: ' + UserId + '.' +
                                '<p>  ' +
                                '<p> Regards,' +
                                '<p> FAWE Management Office.';
                                //Emails_FAWE.SendEmail(Approval_User_Setup."E-Mail", 'Request for approval', Body, 'JOBS', USERID, 'Donor Proposal', Source_::Proposal, Rec."No.");
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" in [Rec."Approval Status"::"Pending Approval"] then begin
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify();
                            /* IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnCancel_GRANTS_ApprovalRequest(Rec); */
                        end;
                        CurrPage.Close();
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
                    Visible = false;
                    ToolTip = 'Executes the Revert to Concept action.';

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Proposal;
                        Rec.Modify();
                    end;
                }
            }
            group("Proposal Attachment")
            {
                Image = Documents;
                Caption = 'Proposal Attachment';
                action(Attachments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposal  Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    // RunObject = page "Document Attachment Details";
                    // RunPageLink = "No." = field("No.");
                    ToolTip = 'Executes the Proposal  Attachments action.';
                    trigger OnAction()
                    var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*OpenApprovalEntriesExist := ApprovalMgt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalMgt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist :=TRUE;
        IF Rec."Approval Status"="Approval Status"::Approved THEN BEGIN
          OpenApprovalEntriesExist:=FALSE;
          CanCancelApprovalForRecord:=FALSE;
          EnabledApprovalWorkflowsExist:=FALSE;
          END;
          */

    end;

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        Rec.Status := Rec.Status::Proposal;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ///"Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec.Status := Rec.Status::Proposal;
    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;
        */
        //IF NOT MapMgt.TestSetup THEN
        //  CurrForm.MapPoint.VISIBLE(FALSE);
        if Rec."Approval Status" <> Rec."Approval Status"::"Pending Approval" then
            ItemVisible := true
        else
            CurrPage.Editable := false;
        CurrencyCheck();

    end;

    var
        //Emails_FAWE: Codeunit "FAWE Emails";
        Approval_User_Setup: Record "User Setup";
        Workflow_User_Group_Member: Record "Workflow User Group Member";

        "Currency CodeEditable": Boolean;

        "Invoice Currency CodeEditable": Boolean;
        ItemVisible: Boolean;
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
    begin
    end;
}

