page 60030 "Grant Surrender"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Grant Surrender Header";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    Caption = 'No';
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Editable = "Surrender DateEditable";
                    Caption = 'Surrender Date';
                    ToolTip = 'Specifies the value of the Surrender Date field.';
                }
                field(Grant; Rec.Grant)
                {
                    Caption = 'Grant';
                    ToolTip = 'Specifies the value of the Grant field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = "Account No.Editable";
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field.';

                    trigger OnValidate()
                    begin
                        //AccountName:=GetCustName("Account No.");
                        GrantDetails.Reset();
                        GrantDetails.SetRange(GrantDetails."Surrender Doc No.", Rec.No);
                        GrantDetails.DeleteAll();


                        AutopopulateLines();
                        CurrPage.ImprestLines.Page.refreshform();
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    Caption = 'Account Name';
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Grant Phase"; Rec."Grant Phase")
                {
                    Editable = "Grant PhaseEditable";
                    Caption = 'Grant Phase';
                    ToolTip = 'Specifies the value of the Grant Phase field.';
                }
                field("Job-Planning Line No"; Rec."Job-Planning Line No")
                {
                    Caption = 'Job-Planning Line No';
                    ToolTip = 'Specifies the value of the Job-Planning Line No field.';
                }
                field("Payment Voucher Doc. No"; Rec."Payment Voucher Doc. No")
                {
                    Caption = 'Payment Voucher Doc. No';
                    ToolTip = 'Specifies the value of the Payment Voucher Doc. No field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';

                    trigger OnValidate()
                    begin
                        DimName1 := GetDimensionName(Rec."Global Dimension 1 Code", 1);
                    end;
                }
                field(DimName1; DimName1)
                {
                    Editable = false;
                    Caption = 'DimName1';
                    ToolTip = 'Specifies the value of the DimName1 field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';

                    trigger OnValidate()
                    begin
                        DimName2 := GetDimensionName(Rec."Shortcut Dimension 2 Code", 2);
                    end;
                }
                field(DimName2; DimName2)
                {
                    Editable = false;
                    Caption = 'DimName2';
                    ToolTip = 'Specifies the value of the DimName2 field.';
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    Caption = 'Posted';
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                    Caption = 'Date Posted';
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    Editable = false;
                    Caption = 'Cashier';
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = "Responsibility CenterEditable";
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Surrender Posting Date"; Rec."Surrender Posting Date")
                {
                    Editable = "Surrender Posting DateEditable";
                    Caption = 'Surrender Posting Date';
                    ToolTip = 'Specifies the value of the Surrender Posting Date field.';
                }
                field("Allow Overexpenditure"; Rec."Allow Overexpenditure")
                {
                    Caption = 'Allow Overexpenditure';
                    ToolTip = 'Specifies the value of the Allow Overexpenditure field.';
                }
                field("Open for Overexpenditure by"; Rec."Open for Overexpenditure by")
                {
                    Caption = 'Open for Overexpenditure by';
                    ToolTip = 'Specifies the value of the Open for Overexpenditure by field.';
                }
                field("Date opened for OvExpenditure"; Rec."Date opened for OvExpenditure")
                {
                    Caption = 'Date opened for OvExpenditure';
                    ToolTip = 'Specifies the value of the Date opened for OvExpenditure field.';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                    ToolTip = 'Specifies the value of the User ID field.';
                }
            }
            part(ImprestLines; "Grant Surrender Details")
            {
                Editable = true;
                SubPageLink = "Surrender Doc No." = field(No);
                Caption = 'Grant Surrender Details';
            }
            group(Statistics)
            {
                Caption = 'Statistics';
                field("Actual Spent"; Rec."Actual Spent")
                {
                    Caption = 'Actual Spent';
                    ToolTip = 'Specifies the value of the Actual Spent field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Approve action.';

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Pending then
                        Error('The document has already been processed.');

                    if Rec.Amount < 0 then
                        Error('Amount cannot be less than zero.');

                    if Rec.Amount = 0 then
                        Error('Please enter amount.');

                    if Confirm('Are you sure you would like to approve the payment?', false) = true then begin
                        Rec.Status := Rec.Status::"2nd Approval";
                        Rec.Modify();
                        Message('Document approved successfully.');
                    end;
                end;
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    begin

                        DocumentType := 19;
                        //ApprovalEntries.Setfilters(DATABASE::"Grant Surrender Header", DocumentType, Rec.No);
                        ApprovalEntries.Run();
                    end;
                }
                separator(Action1102755058)
                {
                }
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Post action.';

                    trigger OnAction()
                    begin
                        //TESTFIELD(Status,Status::Approved);
                        Rec.TestField("Surrender Posting Date");

                        if Rec.Posted then
                            Error('The transaction has already been posted.');

                        //Ensure actual spent does not exceed the amount on original document
                        //CALCFIELDS("Actual Spent","Cash Receipt Amount") ;
                        // IF "Actual Spent"+"Cash Receipt Amount" <> Amount THEN
                        //    ERROR('The actual Amount spent should not exceed the amount issued ');

                        //Get the Cash office user template
                        //Temp.GET(USERID);
                        SurrBatch := 'PAYMENTS';//Temp."Advance Surr Batch";
                        SurrTemplate := 'SURRENDER';//Temp."Advance Surr Template";


                        //HOW ABOUT WHERE ONE RETURNS ALL THE AMOUNT??
                        //THERE SHOULD BE NO GENJNL ENTRIES BUT REVERSE THE COMMITTMENTS
                        //CALCFIELDS("Actual Spent");
                        if Rec."Actual Spent" = 0 then
                            if Confirm(Text000, true) then
                                UpdateforNoActualSpent()
                            else
                                Error(Text001);

                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        if GenledSetup.Get() then begin
                            GenJnlLine.Reset();
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", SurrTemplate);
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", SurrBatch);
                            GenJnlLine.DeleteAll();
                        end;

                        if DefaultBatch.Get(SurrTemplate, SurrBatch) then
                            DefaultBatch.Delete();

                        DefaultBatch.Reset();
                        DefaultBatch."Journal Template Name" := SurrTemplate;
                        DefaultBatch.Name := SurrBatch;
                        DefaultBatch.Insert();
                        LineNo := 0;

                        GrantDetails.Reset();
                        GrantDetails.SetRange(GrantDetails."Surrender Doc No.", Rec.No);
                        if GrantDetails.Find('-') then begin
                            repeat
                                //Post Surrender Journal
                                //Compare the amount issued =amount on cash reciecied.
                                //Created new field for zero spent
                                //

                                //GrantDetails.TESTFIELD("Actual Spent");
                                //GrantDetails.TESTFIELD("Actual Spent");
                                /*
                                IF (GrantDetails."Cash Receipt Amount"+GrantDetails."Actual Spent")<>GrantDetails.Amount THEN
                                   ERROR(Txt0001);
                                */
                                Rec.TestField("Global Dimension 1 Code");


                                LineNo := LineNo + 1000;
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := SurrTemplate;
                                GenJnlLine."Journal Batch Name" := SurrBatch;
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Source Code" := 'PAYMENTJNL';
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                GenJnlLine."Account No." := GrantDetails."Account No:";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //Set these fields to blanks
                                GenJnlLine."Posting Date" := Rec."Surrender Posting Date";
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine.Validate("Gen. Posting Type");
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Bus. Posting Group");
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine.Validate("Gen. Prod. Posting Group");
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine.Validate("VAT Bus. Posting Group");
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine.Validate("VAT Prod. Posting Group");
                                GenJnlLine."Document No." := Rec.No;
                                GenJnlLine.Amount := GrantDetails."Actual Spent";
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                                GenJnlLine."Bal. Account No." := Rec."Account No.";
                                GenJnlLine.Description := 'Grant Surrender';
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine."Currency Code" := Rec."Currency Code";
                                GenJnlLine.Validate("Currency Code");
                                //Take care of Currency Factor
                                //  GenJnlLine."Currency Factor":="Currency Factor";
                                //  GenJnlLine.VALIDATE("Currency Factor");

                                GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                                GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

                                //Application of Surrender entries
                                if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then begin
                                    GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                    GenJnlLine."Applies-to Doc. No." := Rec."Payment Voucher Doc. No";
                                    GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                                    GenJnlLine."Applies-to ID" := Rec."Apply to ID";
                                end;

                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert();
                            //End Post Surrender Journal

                            until GrantDetails.Next() = 0;

                            //Post Entries
                            GenJnlLine.Reset();
                            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", SurrTemplate);
                            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", SurrBatch);
                            //Adjust Gen Jnl Exchange Rate Rounding Balances
                            AdjustGenJnl.Run(GenJnlLine);
                            //End Adjust Gen Jnl Exchange Rate Rounding Balances

                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", GenJnlLine);
                        end;

                        //IF JournalPostSuccessful.PostedSuccessfully THEN BEGIN
                        Rec.Posted := true;
                        Rec.Status := Rec.Status::Posted;
                        Rec."Date Posted" := Today;
                        Rec."Time Posted" := Time;
                        Rec."Posted By" := UserId;
                        Rec.Modify();


                        //tag the lines as posted
                        GrantDetails.SetRange(GrantDetails."Surrender Doc No.", Rec.No);
                        if GrantDetails.Find('-') then
                            repeat
                                GrantDetails.Posted := true;
                                GrantDetails.Modify();
                            until GrantDetails.Next() = 0;

                        /*
                        //Tag the Source Imprest Requisition as Surrendered
                        ImprestReq.RESET;
                        ImprestReq.SETRANGE(ImprestReq."No.","Payment Voucher Doc. No");
                        IF ImprestReq.FIND('-') THEN BEGIN
                          ImprestReq."Surrender Status":=ImprestReq."Surrender Status"::Full;
                          ImprestReq.MODIFY;
                        END;
                        */
                        /*
                        //End Tag
                        //Post Committment Reversals
                        Doc_Type:=Doc_Type::GrantSurrender;
                        BudgetControl.ReverseEntries(Doc_Type,No);
                        */
                        //END;

                    end;
                }
                separator(Action1102755060)
                {
                }
                action("Check Budgetary Availability")
                {
                    Caption = 'Check Budgetary Availability';
                    Visible = false;
                    ToolTip = 'Executes the Check Budgetary Availability action.';

                    trigger OnAction()
                    begin

                        //Ensure actual spent does not exceed the amount on original document
                        Rec.CalcFields("Actual Spent", "Cash Receipt Amount");
                        if Rec."Actual Spent" + Rec."Cash Receipt Amount" > Rec.Amount then
                            Error('The actual Amount spent should not exceed the amount issued ');
                        /*
                          //Post Committment Reversals of the Staff Advance if it had not been reversed
                            Commitments.RESET;
                            Commitments.SETRANGE(Commitments."Document Type",Commitments."Document Type"::Grant Surrender);
                            Commitments.SETRANGE(Commitments."Document No.","Imprest Issue Doc. No");
                            Commitments.SETRANGE(Commitments.Committed,FALSE);
                              IF NOT Commitments.FIND('-') THEN BEGIN
                               Doc_Type:=Doc_Type::StaffAdvance;
                               BudgetControl.ReverseEntries(Doc_Type,"Imprest Issue Doc. No");
                              END;
                         */
                        //First Check whether other lines are already committed.
                        Commitments.Reset();
                        Commitments.SetRange(Commitments."Commitment Type", Commitments."Commitment Type"::"Grant Surrender");
                        Commitments.SetRange(Commitments."Document No.", Rec.No);
                        if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?', false) = false then
                                exit;
                            Commitments.Reset();
                            Commitments.SetRange(Commitments."Commitment Type", Commitments."Commitment Type"::"Grant Surrender");
                            Commitments.SetRange(Commitments."Document No.", Rec.No);
                            Commitments.DeleteAll();
                        end;

                        //Check the Budget here
                        // CheckBudgetAvail.CheckGrantSurr(Rec);
                        //Update document to Committed
                        Rec."Commitment Status" := true;
                        Rec.Modify();

                    end;
                }
                action("Cancel Budgetary Allocation")
                {
                    Caption = 'Cancel Budgetary Allocation';
                    Visible = false;
                    ToolTip = 'Executes the Cancel Budgetary Allocation action.';

                    trigger OnAction()
                    begin
                        if Confirm('Do you Wish to Cancel the Commitment Entries for this document', false) = false then
                            exit;

                        Commitments.Reset();
                        Commitments.SetRange(Commitments."Commitment Type", Commitments."Commitment Type"::"Grant Surrender");
                        Commitments.SetRange(Commitments."Document No.", Rec.No);
                        Commitments.DeleteAll();

                        Payline.Reset();
                        Payline.SetRange(Payline."Surrender Doc No.", Rec.No);
                        if Payline.Find('-') then
                            repeat
                                Payline.Committed := false;
                                Payline.Modify();
                            until Payline.Next() = 0;
                        //Update Document to Uncommitted
                        Rec."Commitment Status" := false;
                        Rec.Modify();
                    end;
                }
                separator(Action1102755063)
                {
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send Approval Request action.';

                    trigger OnAction()
                    begin
                        /*
                        
                           //Ensure actual spent does not exceed the amount on original document
                           CALCFIELDS("Actual Spent","Cash Receipt Amount") ;
                           IF "Actual Spent"+"Cash Receipt Amount" <> Amount THEN
                           ERROR('The actual Amount spent should not exceed the amount issued ');
                        */

                        /*
                        //First Check whether all amount entered tally
                        ImprestDetails.RESET;
                        ImprestDetails.SETRANGE(ImprestDetails."Surrender Doc No.",No);
                        IF ImprestDetails.FIND('-') THEN BEGIN
                        REPEAT
                          IF (ImprestDetails."Cash Receipt Amount"+ImprestDetails."Actual Spent")<>ImprestDetails.Amount THEN
                              ERROR(Txt0001);
                        
                        UNTIL ImprestDetails.NEXT = 0;
                        END;
                        */
                        //Ensure No Items That should be committed that are not
                        // IF LinesCommitmentStatus THEN
                        //   ERROR('There are some lines that have not been committed');
                        //
                        // //Release the ImprestSurrender for Approval
                        //  IF ApprovalMgt.SendGrantSurrApprovalRequest(Rec) THEN;

                    end;
                }
                action("Cancel Approval Request")
                {
                    Caption = 'Cancel Approval Request';
                    ToolTip = 'Executes the Cancel Approval Request action.';

                    trigger OnAction()
                    begin
                        // IF ApprovalMgt.CancelGrantSurrApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755066)
                {
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    ToolTip = 'Executes the Cancel Document action.';

                    trigger OnAction()
                    begin
                        //Post Committment Reversals
                        /*TESTFIELD(Status,Status::Approved);
                        IF CONFIRM(Text002,TRUE) THEN BEGIN
                          Doc_Type:=Doc_Type::Imprest;
                          BudgetControl.ReverseEntries(Doc_Type,"Payment Voucher Doc. No");
                          Status:=Status::Cancelled;
                          MODIFY;
                        END;
                        *///MUTINDA

                    end;
                }
                separator(Action1102755068)
                {
                }
                action("Open for OverExpenditure")
                {
                    Caption = 'Open for OverExpenditure';
                    ToolTip = 'Executes the Open for OverExpenditure action.';

                    trigger OnAction()
                    begin
                        //only allow for over expenditure if grant allows for over expenditure
                        job.TestField("Allow OverExpenditure", true);
                        //Opening should only be for Pending Documents
                        Rec.TestField(Status, Rec.Status::Pending);
                        //Open for Overexpenditure
                        Rec."Allow Overexpenditure" := true;
                        Rec."Open for Overexpenditure by" := UserId;
                        Rec."Date opened for OvExpenditure" := Today;
                        Rec.Modify();
                        //Open lines
                        Payline.Reset();
                        Payline.SetRange(Payline."Surrender Doc No.", Rec.No);
                        if Payline.Find('-') then
                            repeat
                                Payline."Allow Overexpenditure" := true;
                                Payline."Open for Overexpenditure by" := UserId;
                                Payline."Date opened for OvExpenditure" := Today;
                                Payline.Modify();
                            until Payline.Next() = 0;
                        //End open for Overexpenditure
                    end;
                }
                action("Import Tasks")
                {
                    Caption = 'Import Tasks';
                    ToolTip = 'Executes the Import Tasks action.';

                    trigger OnAction()
                    begin
                        AutopopulateLines();
                    end;
                }
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Print action.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetFilter(No, Rec.No);
                    Report.Run(5000, true, true, Rec);
                    Rec.Reset();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ImprestLinesEditable := true;
        ShortcutDimension2CodeEditable := true;
        GlobalDimension1CodeEditable := true;
        "Currency CodeEditable" := true;
        "Grant PhaseEditable" := true;
        "Surrender Posting DateEditable" := true;
        "Responsibility CenterEditable" := true;
        "Account No.Editable" := true;
        "Surrender DateEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    var
        GenledSetup: Record "Cash Management Setup";
        Commitments: Record "New Commitment Entries";
        DefaultBatch: Record "Gen. Journal Batch";
        //RecPayTypes: Record "Transaction Types";
        GenJnlLine: Record "Gen. Journal Line";
        GrantDetails: Record "Grant Surrender Details";
        Payline: Record "Grant Surrender Details";
        job: Record Jobs;
        PVLines: Record "Grant PV Lines";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        ApprovalEntries: Page "Approval Entries";

        "Account No.Editable": Boolean;

        "Currency CodeEditable": Boolean;

        GlobalDimension1CodeEditable: Boolean;

        "Grant PhaseEditable": Boolean;

        ImprestLinesEditable: Boolean;

        "Responsibility CenterEditable": Boolean;

        ShortcutDimension2CodeEditable: Boolean;

        "Surrender DateEditable": Boolean;

        "Surrender Posting DateEditable": Boolean;
        SurrBatch: Code[10];
        SurrTemplate: Code[10];
        LineNo: Integer;
        Text000: Label 'You have not specified the Actual Amount Spent. This document will only reverse the committment and you will have to receipt the total amount returned.';
        Text001: Label 'Document Not Posted';
        //ImprestReq: Record "Request Header";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",None,"Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,GrantSurrender;
        DimName1: Text[60];
        DimName2: Text[60];


    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset();
        GLSetup.Get();

        DimVal.Reset();
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code")
        else
            if DimNo = 2 then
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
        if DimVal.Find('-') then
            Name := DimVal.Name;

    end;


    procedure UpdateControl()
    begin
        if Rec.Status <> Rec.Status::Pending then begin
            "Surrender DateEditable" := false;
            "Account No.Editable" := false;
            //   CurrForm."Payment Voucher Doc. No".EDITABLE:=FALSE;
            "Responsibility CenterEditable" := false;
            "Surrender Posting DateEditable" := true;
            //CurrForm.Amount.EDITABLE:=FALSE;
            "Grant PhaseEditable" := false;
            "Currency CodeEditable" := false;
            GlobalDimension1CodeEditable := false;
            ShortcutDimension2CodeEditable := false;
            ImprestLinesEditable := false;

        end else begin
            "Surrender DateEditable" := true;
            "Account No.Editable" := true;
            //   CurrForm."Payment Voucher Doc. No".EDITABLE:=TRUE;
            "Responsibility CenterEditable" := true;
            "Surrender Posting DateEditable" := false;
            //CurrForm.Amount.EDITABLE:=TRUE;
            "Grant PhaseEditable" := true;
            "Currency CodeEditable" := true;
            GlobalDimension1CodeEditable := true;
            ShortcutDimension2CodeEditable := true;
            ImprestLinesEditable := true;

        end;
    end;


    procedure GetCustName(No: Code[20]) Name: Text[100]
    var
        Cust: Record Customer;
    begin
        Name := '';
        if Cust.Get(No) then
            Name := Cust.Name;
        exit(Name);
    end;


    procedure UpdateforNoActualSpent()
    begin
        /*
          Posted:=TRUE;
          Status:=Status::Posted;
          "Date Posted":=TODAY;
          "Time Posted":=TIME;
          "Posted By":=USERID;
          MODIFY;
        //Tag the Source Imprest Requisition as Surrendered
           ImprestReq.RESET;
           ImprestReq.SETRANGE(ImprestReq."No.","Payment Voucher Doc. No");
           IF ImprestReq.FIND('-') THEN BEGIN
             ImprestReq."Surrender Status":=ImprestReq."Surrender Status"::Full;
             ImprestReq.MODIFY;
           END;
        //End Tag
        //Post Committment Reversals
        Doc_Type:=Doc_Type::StaffSurrender;
        BudgetControl.ReverseEntries(Doc_Type,"Payment Voucher Doc. No");
        */

    end;


    procedure CompareAllAmounts()
    begin
    end;


    procedure LinesCommitmentStatus() Exists: Boolean
    var
    //BCsetup: Record "Cash Management Setup";
    begin
        /*IF BCsetup.GET() THEN  BEGIN
           IF NOT BCsetup.Mandatory THEN BEGIN
              Exists:=FALSE;
              EXIT;
           END;
        END ELSE BEGIN
              Exists:=FALSE;
              EXIT;
        END;
          Exists:=FALSE;
         Payline.RESET;
         Payline.SETRANGE(Payline."Surrender Doc No.",No);
         Payline.SETRANGE(Payline.Committed,FALSE);
         Payline.SETRANGE(Payline."Budgetary Control A/C",TRUE);
          IF Payline.FIND('-') THEN
             Exists:=TRUE;
          */

    end;


    procedure AutopopulateLines()
    begin

        PVLines.Reset();
        PVLines.SetRange(PVLines."Grant No", Rec.Grant);
        PVLines.SetRange(PVLines."Account No", Rec."Account No.");
        //PVLines.SETRANGE(PVLines."Job-Planning Line No","Job-Planning Line No");
        if PVLines.Find('-') then begin
            GrantDetails.Init();
            GrantDetails."Line No." := 0;
            repeat
            begin

                GrantDetails."Surrender Doc No." := Rec.No;
                GrantDetails."Line No." := GrantDetails."Line No." + 1000;
                GrantDetails."PV No" := PVLines."PV No";
                GrantDetails."Grant No" := PVLines."Grant No";
                GrantDetails."Job-Planning Line No" := PVLines."Job-Planning Line No";
                GrantDetails.Validate(GrantDetails."Grant No");
                // GrantDetails."Posting Date":=PVLines."Date Posted";
                GrantDetails.Partner := PVLines."Account No";
                GrantDetails."Amount LCY" := PVLines."Gross Amount";
                GrantDetails."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                GrantDetails."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                GrantDetails."Shortcut Dimension 3 Code" := Rec."Shortcut Dimension 3 Code";
                GrantDetails."Shortcut Dimension 4 Code" := Rec."Shortcut Dimension 4 Code";
                GrantDetails."Currency Code 1" := Rec."Currency Code";
                GrantDetails.Insert(true);
            end;
            until PVLines.Next() = 0;
        end else
            Error('No posted payments Lines were found for Project no.' + ' ' + Rec.Grant + ' ' + 'account' + ' ' + Rec."Account No.");
    end;
}

