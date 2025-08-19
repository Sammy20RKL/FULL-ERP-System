page 60054 "Contract Card"
{
    ApplicationArea = All;
    Caption = 'Contract Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Jobs;
    SourceTableView = where(Status = const(Contract), "Approval Status" = filter(Open | "Pending Approval"));

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
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Project Title';
                    ToolTip = 'Specifies the value of the Project Title field.';
                }
                field("Proposal No"; Rec."Proposal No")
                {
                    Editable = true;
                    Caption = 'Proposal No';
                    ToolTip = 'Specifies the value of the Proposal No field.';
                }
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Funder Contact';
                    ToolTip = 'Specifies the value of the Funder Contact field.';
                }
                field("Prime PI"; Rec."PI Name")
                {
                    Caption = 'Funder Contact Name';
                    ToolTip = 'Specifies the value of the Funder Contact Name field.';
                }
                field("Performance Period Starting Date"; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Performance Period Ending Date"; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field("Payment Method"; Rec."Payment Methods")
                {
                    Visible = false;
                    Caption = 'Payment Methods';
                    ToolTip = 'Specifies the value of the Payment Methods field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Amount Awarded"; Rec."Amount Awarded")
                {
                    Caption = 'Amount Awarded';
                    ToolTip = 'Specifies the value of the Amount Awarded field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
            }
            group("Summary on Ammendment")
            {
                Caption = 'Summary';
                Visible = false;
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
                    ToolTip = 'Executes the WIP Entries action.';
                    //RunObject = Page Page51516541;
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
            group("&Contract")
            {
                Caption = '&Contract';
                Visible = true;
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
                separator(Action1102755026)
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
                separator(Action1102755017)
                {
                }
                action("Personnel Cost Alloc.")
                {
                    Caption = 'Personnel Cost Alloc.';
                    ToolTip = 'Executes the Personnel Cost Alloc. action.';
                    //RunObject = Page Page51516565;
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
                    Visible = ItemVisible;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    begin
                        //DocumentType:=DocumentType::Proposal;
                        //ApprovalEntries.Setfilters(DATABASE::Jobs,ApprovalEntry."Document Type"::Proposal,"No.");
                        //ApprovalEntries.RUN;
                    end;
                }
                separator(Action21)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = ItemVisible;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Amount Awarded");
                        /* IF Rec."Approval Status" IN [Rec."Approval Status"::Open] THEN BEGIN
                            IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                ApprovalsMgmt.OnSend_GRANTS_DocForApproval(Rec);
                        END; */

                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec.Modify();

                        Workflow_User_Group_Member.Reset();
                        Workflow_User_Group_Member.SetRange(Workflow_User_Group_Member."Workflow User Group Code", 'DONOR_PROPOSAL');
                        if Workflow_User_Group_Member.FindFirst() then begin
                            Approval_User_Setup.Reset();
                            Approval_User_Setup.SetRange("User ID", Workflow_User_Group_Member."User Name");
                            if Approval_User_Setup.Find('-') then
                                Body :=
                                '<p> Hi,' +
                                '<p> Donor Contract ' + Rec.Description + ' requires your approval.' +
                                '<p> Created by: ' + UserId + '.' +
                                '<p>  ' +
                                '<p> Regards,' +
                                '<p> Grants Management Office.';
                                //Emails_kcdf.SendEmail(Approval_User_Setup."E-Mail", 'Request for approval', Body, 'jobs', USERID, 'Donor Contract', Source_::Contract, Rec."No.");
                                // END;
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        if Rec."Approval Status" in [Rec."Approval Status"::"Pending Approval"] then begin
                            /*  IF ApprovalsMgmt.Check_GRANTS_ApprovalPossible(Rec) THEN
                                 ApprovalsMgmt.OnCancel_GRANTS_ApprovalRequest(Rec); */
                            Rec."Approval Status" := Rec."Approval Status"::Open;
                            Rec.Modify();
                        end;
                        CurrPage.Close();
                    end;
                }
                separator(Action18)
                {
                }
                action("Revert to Proposal")
                {
                    Caption = 'Revert to Proposal';
                    Visible = false;
                    ToolTip = 'Executes the Revert to Proposal action.';

                    trigger OnAction()
                    begin
                        //Status:=Status::Contract;
                        //MODIFY;
                    end;
                }
            }
            group("Grant Attachments")
            {
                Image = Documents;
                Caption = 'Grant Attachments';
                action(Attachments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Upload Contract';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Document Attachment Details";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'Executes the Upload Contract action.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Currency CodeEditable" := true;
        "Invoice Currency CodeEditable" := true;
        Rec.Status := Rec.Status::Contract;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetPurchasesFilter;
        Rec.Status := Rec.Status::Contract;
    end;

    trigger OnOpenPage()
    begin
        /*IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;
        */
        if Rec."Approval Status" <> Rec."Approval Status"::"Pending Approval" then
            ItemVisible := true
        else
            CurrPage.Editable := false;

        CurrencyCheck();

    end;

    var
        //Emails_kcdf: Codeunit "FAWE Emails";
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

