page 60041 "Concept note Card"
{
    ApplicationArea = All;
    Caption = 'Concept Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approvals';
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = const("Concept Formulation"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Caption = 'Concept Note ID';
                    ToolTip = 'Specifies the value of the Concept Note ID field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Concept Title';
                    ToolTip = 'Specifies the value of the Concept Title field.';
                }
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Concept Lead';
                    ToolTip = 'Specifies the value of the Concept Lead field.';
                }
                field("Principal Investigator name"; Rec."Principal Investigator name")
                {
                    Caption = 'Lead Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Lead Name field.';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Caption = 'Address';
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Caption = 'Email Address';
                    ToolTip = 'Specifies the value of the Email Address field.';
                }
                field("Response To fund Opportunity"; Rec."Response To fund Opportunity")
                {
                    Caption = 'Response To fund Opportunity';
                    ToolTip = 'Specifies the value of the Response To fund Opportunity field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = 'Objective';
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'Search Description';
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Project Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Project Status field.';
                }
                field("Consistence with inst. Objs."; Rec."Consistence with inst. Objs.")
                {
                    Caption = 'Consistence with inst. Objs.';
                    ToolTip = 'Specifies the value of the Consistence with inst. Objs. field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control8; Links)
            {
            }
            systempart(Control9; Notes)
            {
            }
            systempart(Control11; MyNotes)
            {
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
                        // TESTFIELD("No.");
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
                    Image = Resource;
                    Promoted = true;
                    RunObject = page "Resource Allocated per Job";
                    Visible = false;
                    ToolTip = 'Executes the Resource Allocated per Job action.';
                }
                separator(a)
                {
                    Caption = 'a';
                }
                action("Res. &Gr. Allocated per Job")
                {
                    Caption = 'Res. &Gr. Allocated per Job';
                    Image = ResourceCosts;
                    Promoted = true;
                    RunObject = page "Res. Gr. Allocated per Job";
                    Visible = false;
                    ToolTip = 'Executes the Res. &Gr. Allocated per Job action.';
                }
            }
            group("&Grant")
            {
                Caption = '&Grant';
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
                        Rec.TestField("Bill-to Partner No.");

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
                separator(Action64)
                {
                }
                action(Partners)
                {
                    Caption = 'Partners';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = page "Project Partners";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Partners action.';
                }
                action(Donors)
                {
                    Caption = 'Donors';
                    Image = Customer;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = page "Project Donors";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Donors action.';
                }
                separator(Action1102755035)
                {
                }
                action(Compliance)
                {
                    Caption = 'Compliance';
                    Image = Task;
                    Promoted = true;
                    RunObject = page "Compliance main List";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Compliance action.';
                }
                action("Personnel Cost Alloc.")
                {
                    Caption = 'Personnel Cost Alloc.';
                    Image = Resource;
                    Promoted = true;
                    RunObject = page "Project Personnel Cost Alloc";
                    RunPageLink = Project = field("No.");
                    ToolTip = 'Executes the Personnel Cost Alloc. action.';
                }
                action("Reporting Timelines")
                {
                    Caption = 'Reporting Timelines';
                    Image = AgreementQuote;
                    Promoted = true;
                    RunObject = page "Phase Reporting SchedulesAudit";
                    RunPageLink = Project = field("No.");
                    ToolTip = 'Executes the Reporting Timelines action.';
                }
            }
        }
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                separator(Action1102755018)
                {
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
                action("Convert to Proposal")
                {
                    Caption = 'Convert to Proposal';
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ToolTip = 'Executes the Convert to Proposal action.';

                    trigger OnAction()
                    begin
                        // ChangeProjectStatus;
                        if Rec."Approval Status" = Rec."Approval Status"::Open then Error('Concept must be approved first');
                        if Confirm('Convert concept to proposal?') then begin
                            Rec.Status := Rec.Status::Proposal;
                            Rec.Modify()
                        end
                    end;
                }
                action("View Donor Proposal")
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewOrder;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;
                    Caption = 'View Donor Proposal';
                    ToolTip = 'Executes the View Donor Proposal action.';

                    trigger OnAction()
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec.Id);
                    end;
                }
                action(Attachments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Concept  Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    // RunObject = page "Document Attachment Details";
                    // RunPageLink = "No." = field("No.");
                    ToolTip = 'Executes the Concept  Attachments action.';
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
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                    /* IF Rec."Approval Status" IN [Rec."Approval Status"::Open] THEN BEGIN
                            IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSend_GRANTS_DocForApproval(Rec);
                        END;*/

                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec.Modify();
                        //CurrPage.CLOSE;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

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
                action(Approvals)
                {
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Caption = 'Approvals';
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
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
        // CurrForm.MapPoint.VISIBLE(FALSE);

        CurrencyCheck();

    end;

    var
        IncomingDocument: Record "Incoming Document";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

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

