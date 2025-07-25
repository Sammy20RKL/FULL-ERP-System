page 60043 "Approved Concepts"
{
    ApplicationArea = All;
    Caption = 'Grant Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = const("Concept Formulation"), "Approval Status" = filter(Approved));

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
                field(Description; Rec.Description)
                {
                    Caption = 'Concept Title';
                    ToolTip = 'Specifies the value of the Concept Title field.';
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
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Caption = 'Address';
                    ToolTip = 'Specifies the value of the Address field.';
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
                field(Institution; Rec.Institution)
                {
                    Caption = 'Institution';
                    ToolTip = 'Specifies the value of the Institution field.';
                }
                field(Schools; Rec.Schools)
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
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
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    Caption = 'Cluster';
                    ToolTip = 'Specifies the value of the Cluster field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    ToolTip = 'Specifies the value of the Creation Date field.';
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
            systempart(Control23; Links)
            {
            }
            systempart(Control22; Notes)
            {
            }
            systempart(Control21; MyNotes)
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
            group("&Grant")
            {
                Caption = '&Grant';
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
                separator(Action64)
                {
                }
                action(Partners)
                {
                    Caption = 'Partners';
                    ToolTip = 'Executes the Partners action.';
                    //RunObject = Page Page51516308;
                }
                action(Donors)
                {
                    Caption = 'Donors';
                    RunObject = page "Project Donors";
                    RunPageLink = "Grant No" = field("No.");
                    ToolTip = 'Executes the Donors action.';
                }
                separator(Action1102755037)
                {
                }
                action("Personnel Cost Alloc.")
                {
                    Caption = 'Personnel Cost Alloc.';
                    ToolTip = 'Executes the Personnel Cost Alloc. action.';
                    //RunObject = Page Page5151656;
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
                        DocumentType := DocumentType::"Concept Note";
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
                    ToolTip = 'Executes the Send for Approval action.';

                    trigger OnAction()
                    begin
                        //Release the grant for Approval
                        Rec.TestField("Total Cost");
                        //IF ApprovalMgt.SendGrantApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        //  IF ApprovalMgt.CancelGrantApprovalRequest(Rec,TRUE,TRUE) THEN;
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
                action("Copy Grant")
                {
                    Caption = 'Copy Grant';
                    Ellipsis = true;
                    ToolTip = 'Executes the Copy Grant action.';
                    //RunObject = Report Report1084;
                }
                action("Convert To Proposal")
                {
                    Caption = 'Convert To Proposal';
                    Image = Continue;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ToolTip = 'Executes the Convert To Proposal action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                        Rec.ChangeProjectStatus();
                    end;
                }
                action(Open)
                {
                    Caption = 'Open';
                    ShortcutKey = 'Return';
                    ToolTip = 'Executes the Open action.';

                    trigger OnAction()
                    begin

                        if Rec."Converted To Proposal" = true then Error('You cannot open a converted concept');

                        // //   PAGE.RUN(Number [, Record] [, Field])
                        //  CommentLine.RESET;
                        //  CommentLine.SETRANGE(CommentLine."Table Name",CommentLine."Table Name"::Jobs);
                        //  CommentLine.SETRANGE(CommentLine."No.","No.");
                        //  IF CommentLine.FIND('-') THEN BEGIN
                        //   "Approval Status":="Approval Status"::Open;
                        //    MODIFY;
                        //  END ELSE
                        //  BEGIN
                        //  ERROR('Kindly give a comment to open');
                        //  END;
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
                    if Rec."Approval Status" = Rec."Approval Status"::"Approved" then
                        DocumentAttachmentDetails.Editable(false);
                    DocumentAttachmentDetails.RunModal();
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

