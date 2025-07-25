codeunit 53003 "Commitments Mgt Procurement"
{
    trigger OnRun()
    begin
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
        UncommittmentDate: Date;

    procedure CancelIRCommitments(IR: Record "Internal Request Header")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset();
        CommitmentEntries.SetRange("Commitment No", IR."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll();
        //Commit();
    end;

    procedure CancelOrderCommitments(PurchaseHeader: Record "Purchase Header")
    var
        CommitmentEntries: Record "Commitment Entries";
    begin
        CommitmentEntries.Reset();
        CommitmentEntries.SetRange("Commitment No", PurchaseHeader."No.");
        CommitmentEntries.SetRange("Commitment Type", CommitmentEntries."Commitment Type"::Commitment);
        CommitmentEntries.DeleteAll();
        //Commit();
    end;

    procedure CheckPurchInvoiceCommittment(IR: Record "Purchase Header")
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Purchase Line";
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        Expenses: Decimal;
        ErrorMsg: Label 'You have Exceeded Budget for G/L Account No %1 Fund %5 By %2 Budget Available %3 CommittedAmount %4';
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-') then begin
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(IRLine."No.") then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Posting Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount := GLAccount."Budgeted Amount";
                        Expenses := GLAccount."Net Change";
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then
                        Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.") then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then
                            Error(ErrorMsg
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable, CommittedAmount, IRLine."Shortcut Dimension 1 Code");
                    end;
                end;
            until IRLine.Next() = 0;
        end;
    end;

    procedure CheckPurchQuoteCommittment(IR: Record "Procurement Evaluation Header")
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Procurement Evaluation Line";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        IRLine.SetRange(Awarded, true);
        if IRLine.Find('-') then begin
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get();
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Today);
                if GenLedSetup."Use Dimensions For Budget" then
                    GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                if GLAccount.Find('-') then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount := 0;
                CommitmentEntries.Reset();
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                //     IF IR."Posting Date"=0D THEN
                //        ERROR('Please insert the posting date');
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                           Today);
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount := CommitmentEntries."Committed Amount";
                if GLAccount.Get(IRLine."No.") then;
                if GLAccount."Votebook Entry" then begin
                    if CommittedAmount + IRLine.Amount > BudgetAvailable then
                        Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                       , Committments.Account,
                        Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until IRLine.Next() = 0;
        end;
    end;

    procedure CheckPurchReqBeforeOrder(IR: Record "Internal Request Header")
    begin
        IR.CalcFields("Original Committed Amount", "Amount Including VAT");
        if IR."Amount Including VAT" > IR."Original Committed Amount" then
            Error('You have Exceeded Budget for the original committed amount of %1 By %2, Current Total %3'
            , IR."Original Committed Amount",
             Abs(IR."Original Committed Amount" - (IR."Amount Including VAT")), IR."Amount Including VAT");
    end;

    procedure CheckPurchReqCommittment(IR: Record "Internal Request Header")
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Internal Request Line";
        Items: Record Item;
        CommittmentAccount: Code[100];
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        Expenses: Decimal;
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SetRange(Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-') then begin
            repeat
                case IRLine.Type of
                    IRLine.Type::"G/L Account":
                        CommittmentAccount := IRLine."No.";
                    IRLine.Type::Item:
                        begin
                            Items.Get(IRLine."No.");
                            Items.TestField("Item G/L Budget Account");
                            CommittmentAccount := Items."Item G/L Budget Account";
                        end;
                end;
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                if IsAccountVotebookEntry(CommittmentAccount) then begin
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount := GLAccount."Budgeted Amount";
                        Expenses := GLAccount."Net Change";
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Posting Date" = 0D then
                        Error('Please insert the posting date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               IR."Posting Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    if GLAccount.Get(IRLine."No.") then;
                    if GLAccount."Votebook Entry" then begin
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then
                            Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                           , Committments.Account,
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                    end;
                end;
            until IRLine.Next() = 0;
        end;
    end;

    procedure CheckStoreReqCommittment(IR: Record "Internal Request Header")
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Internal Request Line";
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SETRANGE(Type,IRLine.Type::"G/L Account");
        if IRLine.Find('-') then begin
            repeat
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get();
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                if IRLine.Type = IRLine.Type::"G/L Account" then
                    GLAccount.SetRange(GLAccount."No.", IRLine."No.")
                else
                    GLAccount.SetRange(GLAccount."No.", IRLine."Item G/L Budget Account");
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Document Date");
                if GenLedSetup."Use Dimensions For Budget" then
                    GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                if GLAccount.Find('-') then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount := 0;
                CommitmentEntries.Reset();
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                /*if IR."Posting Date"=0D then
                   Error('Please insert the posting date');*/
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                           IR."Document Date");
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount := CommitmentEntries."Committed Amount";
                if GLAccount.Get(IRLine."No.") then;
                if GLAccount."Votebook Entry" then begin
                    if CommittedAmount + IRLine.Amount > BudgetAvailable then
                        Error('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3'
                       , Committments.Account,
                        Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount);
                end;
            until IRLine.Next() = 0;
        end;

    end;

    procedure EncumberPO(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        Committments.Init();
        Committments."Commitment No" := PurchLine."Document No.";
        Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
        Committments."Document Type" := Committments."Document Type"::LPO;
        //Insert same Commitment Date
        Committments."Commitment Date" := UncommittmentDate;
        Committments."Uncommittment Date" := PurchHeader."Posting Date";
        Committments."Dimension Set ID" := PurchLine."Dimension Set ID";
        Committments."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
        Committments.Account := PurchLine."No.";
        Committments."Account No." := PurchLine."No.";
        Committments."Committed Amount" := PurchLine.Amount;
        Committments.User := UserId;
        Committments."Document No" := PurchHeader."No.";
        Committments.No := PurchLine."No.";
        Committments."Line No." := PurchLine."Line No.";
        Committments."Entry No" := EntryNo;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
        Committments.Insert();
    end;

    procedure EncumberPOStaffReq(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        Committments.Init();
        Committments."Commitment No" := PurchLine."Document No.";
        Committments."Commitment Type" := Committments."Commitment Type"::Encumberance;
        //Insert same Commitment Date
        Committments."Commitment Date" := UncommittmentDate;
        Committments."Uncommittment Date" := PurchHeader."Posting Date";
        Committments."Dimension Set ID" := PurchHeader."Dimension Set ID";
        //Committments."Global Dimension 1 Code":=IRLine."Global Dimension 1 Code";
        //Committments."Global Dimension 2 Code":=IRLine."Global Dimension 2 Code";
        Committments.Account := PurchLine."No.";
        Committments."Committed Amount" := PurchLine.Amount;
        Committments.User := UserId;
        Committments."Document No" := PurchHeader."No.";
        Committments.No := PurchLine."No.";
        Committments."Line No." := PurchLine."Line No.";
        Committments."Entry No" := EntryNo;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code" := GetCommittedBudget(PurchLine."Document No.");
        Committments.Insert();
    end;

    procedure FetchDimValue(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20]; var DimValueName: array[8] of Text)
    var
        DimSetEntry: Record "Dimension Set Entry";
        i: Integer;
    begin
        GetGLSetup();
        for i := 1 to 8 do begin
            ShortcutDimCode[i] := '';
            if GLSetupShortcutDimCode[i] <> '' then
                if DimSetEntry.Get(DimSetID, GLSetupShortcutDimCode[i]) then begin
                    DimSetEntry.CalcFields("Dimension Name", "Dimension Value Name");
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                    DimValueName[i] := DimSetEntry."Dimension Value Name";
                end;
        end;
    end;

    procedure GetCommittedBudget(CommittedNo: Code[50]): Code[50]
    var
        CommEntries: Record "Commitment Entries";
        GLSetup: Record "General Ledger Setup";
    begin
        CommEntries.Reset();
        CommEntries.SetRange("Commitment No", CommittedNo);
        CommEntries.SetRange("Commitment Type", CommEntries."Commitment Type"::Commitment);
        if CommEntries.FindFirst() then
            exit(CommEntries."Budget Code")
        else begin
            GLSetup.Get();
            exit(GLSetup."Current Budget");
        end;
    end;

    procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        CashManagementSetups: Record "General Ledger Setup";
    begin
        /* GLAccountRec.Reset();
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst() then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false); */
        CashManagementSetups.Get();
        exit(CashManagementSetups."Check For Commitments");
    end;

    procedure LastCommittment(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer) CommittmentAmt: Decimal
    var
        Committed: Record "Commitment Entries";
    begin
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-') then
            exit(Committed."Committed Amount");
    end;

    procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer) Exists: Boolean
    var
        Committed: Record "Commitment Entries";
    begin
        //Modified by Brian
        // Exists:=FALSE;
        // Committed.RESET;
        // Committed.SETRANGE(Committed."Commitment No",CommittmentNo);
        // Committed.SETRANGE(Committed.No,No);
        // Committed.SETRANGE(Committed."Line No.",LineNo);
        // Committed.SETFILTER(Committed."Commitment Type",'%1|%2',Committed."Commitment Type"::Commitment,Committed."Commitment Type"::"Commitment Reversal");
        // IF Committed.FIND('-') THEN
        //  BEGIN
        //    Committed.CALCSUMS("Committed Amount");
        //    IF Committed."Committed Amount"=0 THEN
        //      Exists:=FALSE
        //    ELSE
        //      Exists:=TRUE;
        //  END;

        Exists := false;
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed.No, No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-') then
            Exists := true;
    end;

    procedure LPOCommittment(var PurchHeader: Record "Purchase Header"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchaseLines: Record "Purchase Line";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        AcquisitionAccount: Code[20];
        InventoryAccount: Code[20];
        ShortcutDimCode: array[8] of Code[20];
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        DisbursedAmount: Decimal;
        Expenses: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
        FA: Record "Fixed Asset";
    begin
        PurchaseLines.Reset();
        PurchaseLines.SetRange(PurchaseLines."Document No.", PurchHeader."No.");
        PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Order);
        if PurchaseLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(GetLPOAccountNo(PurchaseLines)) then begin
                    Committments.Init();
                    Committments."Commitment No" := PurchHeader."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::LPO;
                    PurchHeader.Validate("Order Date");
                    if PurchHeader."Order Date" = 0D then
                        Error('Please enter the order date');
                    Committments."Commitment Date" := PurchHeader."Order Date";
                    Committments."Global Dimension 1 Code" := PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PurchaseLines."Shortcut Dimension 2 Code";
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchaseLines.Type of
                        PurchaseLines.Type::Item:
                            begin
                                Item.Reset();
                                if Item.Get(PurchaseLines."No.") then
                                    if Item."Inventory Posting Group" = '' then
                                        Error('Assign Posting Group to Item No %1', Item."No.");
                                InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
                                //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                Item.TestField("Item G/L Budget Account");
                                InventoryAccount := Item."Item G/L Budget Account";
                                Committments.Account := InventoryAccount;
                            end;
                        PurchaseLines.Type::"G/L Account":
                            begin
                                Committments.Account := PurchaseLines."No.";
                            end;
                        PurchaseLines.Type::"Fixed Asset":
                            begin
                                if FixedAssetPG.Get(PurchaseLines."Posting Group") then begin
                                    FixedAssetPG.TestField("Acquisition Cost Account");
                                    AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                    Committments.Account := AcquisitionAccount;
                                end;

                            end;
                    end;
                    Committments."Committed Amount" := PurchaseLines."Amount Including VAT";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    case PurchaseLines.Type of
                        PurchaseLines.Type::Item:
                            begin
                                GLAccount.SetRange(GLAccount."No.", InventoryAccount);
                            end;
                        PurchaseLines.Type::"G/L Account":
                            begin
                                GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
                            end;
                        PurchaseLines.Type::"Fixed Asset":
                            GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
                    end;
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    //Get budget amount avaliable
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PurchaseLines."Dimension Set ID");
                    DimMgt.GetShortcutDimensions(PurchaseLines."Dimension Set ID", ShortcutDimCode);
                    FetchDimValue(PurchaseLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount := GLAccount."Budgeted Amount";
                        Expenses := GLAccount."Net Change";
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        DisbursedAmount := GLAccount."Disbursed Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if PurchaseLines.Type = PurchaseLines.Type::Item then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
                    if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
                    if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
                    /*  CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                PurchHeader."Order Date"); */
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               GenLedSetup."Current Budget End Date");

                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    //Commit();
                    if LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then
                        Message('Line No %1 has been commited', PurchaseLines."Line No.")
                    else
                        if CommittedAmount + PurchaseLines."Amount Including VAT" > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                              , PurchaseLines."Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 2 Code",
                               Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount,
                               PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                              , DimValueName[1], DimValueName[2],
                               Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount,
                               PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
                            //Commit();
                        end;
                    Committments.User := UserId;
                    Committments."Document No" := PurchHeader."No.";
                    Committments.No := PurchaseLines."No.";
                    Committments."Line No." := PurchaseLines."Line No.";
                    Committments."Account Type" := Committments."Account Type"::Vendor;
                    Committments."Account No." := PurchaseLines."Buy-from Vendor No.";
                    if Vendor.Get(PurchaseLines."Buy-from Vendor No.") then
                        Committments."Account Name" := Vendor.Name;
                    Committments.Description := PurchaseLines.Description;
                    Committments."Dimension Set ID" := PurchaseLines."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        PurchaseLines.Committment := true;
                        PurchaseLines.Modify();
                        if not LineError then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Line Amount")));
                    end;
                end;
            until PurchaseLines.Next() = 0;
        end;
    end;

    procedure PurchInvoiceCommittment(var PurchHeader: Record "Purchase Header"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchaseLines: Record "Purchase Line";
        Vendor: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        AcquisitionAccount: Code[20];
        InventoryAccount: Code[20];
        ShortcutDimCode: array[8] of Code[20];
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        DisbursedAmount: Decimal;
        Expenses: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
        FA: Record "Fixed Asset";
    begin
        PurchaseLines.Reset();
        PurchaseLines.SetRange(PurchaseLines."Document No.", PurchHeader."No.");
        PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Invoice);
        if PurchaseLines.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(GetLPOAccountNo(PurchaseLines)) then begin
                    Committments.Init();
                    Committments."Commitment No" := PurchHeader."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Purchase Invoice";
                    PurchHeader.Validate("Order Date");
                    if PurchHeader."Order Date" = 0D then
                        Error('Please enter the order date');
                    Committments."Commitment Date" := PurchHeader."Order Date";
                    Committments."Global Dimension 1 Code" := PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := PurchaseLines."Shortcut Dimension 2 Code";
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchaseLines.Type of
                        PurchaseLines.Type::Item:
                            begin
                                Item.Reset();
                                if Item.Get(PurchaseLines."No.") then
                                    if Item."Inventory Posting Group" = '' then
                                        Error('Assign Posting Group to Item No %1', Item."No.");
                                InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
                                //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                Item.TestField("Item G/L Budget Account");
                                InventoryAccount := Item."Item G/L Budget Account";
                                Committments.Account := InventoryAccount;
                            end;
                        PurchaseLines.Type::"G/L Account":
                            begin
                                Committments.Account := PurchaseLines."No.";
                            end;
                        PurchaseLines.Type::"Fixed Asset":
                            begin
                                if FixedAssetPG.Get(PurchaseLines."Posting Group") then begin
                                    FixedAssetPG.TestField("Acquisition Cost Account");
                                    AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                    Committments.Account := AcquisitionAccount;
                                end;
                            end;


                    end;
                    Committments."Committed Amount" := PurchaseLines."Amount Including VAT";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    case PurchaseLines.Type of
                        PurchaseLines.Type::Item:
                            begin
                                GLAccount.SetRange(GLAccount."No.", InventoryAccount);
                            end;
                        PurchaseLines.Type::"G/L Account":
                            begin
                                GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
                            end;
                        PurchaseLines.Type::"Fixed Asset":
                            GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
                    end;
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    //Get budget amount avaliable
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PurchaseLines."Dimension Set ID");
                    DimMgt.GetShortcutDimensions(PurchaseLines."Dimension Set ID", ShortcutDimCode);
                    FetchDimValue(PurchaseLines."Dimension Set ID", ShortcutDimCode, DimValueName);
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount := GLAccount."Budgeted Amount";
                        Expenses := GLAccount."Net Change";
                        BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                        DisbursedAmount := GLAccount."Disbursed Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if PurchaseLines.Type = PurchaseLines.Type::Item then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
                    if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
                    if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               PurchHeader."Order Date");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    //Commit();
                    if LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then
                        Message('Line No %1 has been commited', PurchaseLines."Line No.")
                    else
                        if CommittedAmount + PurchaseLines."Amount Including VAT" > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                              , PurchaseLines."Shortcut Dimension 1 Code", PurchaseLines."Shortcut Dimension 2 Code",
                               Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount,
                               PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                              , DimValueName[1], DimValueName[2],
                               Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Amount Including VAT")), BudgetAvailable - CommittedAmount,
                               PurchaseLines.FieldCaption("Shortcut Dimension 1 Code"), PurchaseLines.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
                            //Commit();
                        end;
                    Committments.User := UserId;
                    Committments."Document No" := PurchHeader."No.";
                    Committments.No := PurchaseLines."No.";
                    Committments."Line No." := PurchaseLines."Line No.";
                    Committments."Account Type" := Committments."Account Type"::Vendor;
                    Committments."Account No." := PurchaseLines."Buy-from Vendor No.";
                    if Vendor.Get(PurchaseLines."Buy-from Vendor No.") then
                        Committments."Account Name" := Vendor.Name;
                    Committments.Description := PurchaseLines.Description;
                    Committments."Dimension Set ID" := PurchaseLines."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(PurchHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        PurchaseLines.Committment := true;
                        PurchaseLines.Modify();
                        if not LineError then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + PurchaseLines."Line Amount")));
                    end;
                end;
            until PurchaseLines.Next() = 0;
        end;
    end;

    procedure PurchQuoteCommittment(var IR: Record "Procurement Evaluation Header"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Procurement Evaluation Line";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if IR.Status<>IR.Status::Released then
            Error('The imprest is not fully approved');*/
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        IRLine.SetRange(IRLine.Awarded, true);
        if IRLine.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                Committments.Init();
                Committments."Commitment No" := IR."No.";
                Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                //IR.TESTFIELD("Posting Date");
                Committments."Commitment Date" := Today;
                Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                Committments.Account := IRLine."Document No.";
                Committments."Committed Amount" := IRLine.Amount;
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.Get();
                GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                GLAccount.SetRange(GLAccount."No.", IRLine."No.");
                if GenLedSetup."Use Dimensions For Budget" then
                    GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                //Get Dimensions
                DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                /*if ShortcutDimCode[1]<>'' then
                GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                if ShortcutDimCode[2]<>'' then
                GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                if ShortcutDimCode[3]<>'' then
                GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                if ShortcutDimCode[4]<>'' then
                GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                if ShortcutDimCode[5]<>'' then
                GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                if ShortcutDimCode[6]<>'' then
                GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                //Get budget amount avaliable
                GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", Today);
                if GLAccount.Find('-') then begin
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                    BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                end;
                //Get committed Amount
                CommittedAmount := 0;
                CommitmentEntries.Reset();
                CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.");
                if GenLedSetup."Use Dimensions For Budget" then
                    CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                //     IF IR."Posting Date"=0D THEN
                //        ERROR('Please insert the imprest date');
                CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                           Today);
                CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                CommittedAmount := CommitmentEntries."Committed Amount";
                LineError := false;
                if LineCommitted(IR."No.", IRLine."No.", IRLine."Line No") then
                    Message('Line No %1 has been commited', IRLine."Line No")
                else
                    if CommittedAmount + IRLine.Amount > BudgetAvailable then begin
                        if ErrorMsg = '' then
                            ErrorMsg := StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                           , DimValueName[1], DimValueName[2],
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"),
                            IRLine.FieldCaption("Shortcut Dimension 2 Code"))
                        else
                            ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                           , DimValueName[1], DimValueName[2],
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"),
                            IRLine.FieldCaption("Shortcut Dimension 2 Code"));
                        LineError := true;
                    end;
                Committments.User := UserId;
                Committments."Document No" := IR."No.";
                Committments.No := IRLine."No.";
                Committments."Line No." := IRLine."Line No";
                Committments."Account Type" := Committments."Account Type"::Customer;
                Committments."Account No." := IRLine."No.";
                if Customer.Get(IRLine."No.") then
                    Committments."Account Name" := Customer.Name;
                Committments.Description := IRLine.Description;
                Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                GeneralLedgerSetup.Get();
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                //Check whether line is committed.
                if not LineCommitted(IR."No.", IRLine."No.", IRLine."Line No") then begin
                    EntryNo := EntryNo + 1;
                    Committments."Entry No" := EntryNo;
                    Committments.Insert();
                    IRLine.Committed := true;
                    IRLine.Modify();
                    if not LineError then
                        Message('Items Committed Successfully and the balance is %1',
                        Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)));
                end;
            until IRLine.Next() = 0;
        end;
        //CreatePV(IR);

    end;

    procedure PurchReqCommittment(var IR: Record "Internal Request Header"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Internal Request Line";
        Items: Record Item;
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        CommittmentAccount: Code[100];
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        Expenses: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        //IRLine.SetRange(IRLine.Type, IRLine.Type::"G/L Account");
        if IRLine.Find('-') then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                case IRLine.Type of
                    IRLine.Type::"G/L Account":
                        CommittmentAccount := IRLine."No.";
                    IRLine.Type::Item:
                        begin
                            Items.Get(IRLine."No.");
                            Items.TestField("Item G/L Budget Account");
                            CommittmentAccount := Items."Item G/L Budget Account";
                        end;
                    IRLine.Type::"Fixed Asset":
                        begin
                            CommittmentAccount := IRLine."Budget Line";
                        end;

                end;

                if IsAccountVotebookEntry(CommittmentAccount) then begin
                    Committments.Init();
                    Committments."Commitment No" := IR."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Purchase Requisition";
                    IR.TestField("Order Date");
                    Committments."Commitment Date" := IR."Order Date";
                    Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                    Committments.Account := CommittmentAccount;
                    Committments."Committed Amount" := IRLine.Amount;
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    GLAccount.SetRange(GLAccount."No.", CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                    /*if ShortcutDimCode[1]<>'' then
                    GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    if ShortcutDimCode[2]<>'' then
                    GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    if ShortcutDimCode[3]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    if ShortcutDimCode[4]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    if ShortcutDimCode[5]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    if ShortcutDimCode[6]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    //GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Order Date");
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAmount := GLAccount."Approved Budget";
                        Expenses := GLAccount."Net Change";
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    CommitmentEntries.SetRange(CommitmentEntries.Account, CommittmentAccount);
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    if IR."Order Date" = 0D then
                        Error('Please insert the imprest date');
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               IR."Order Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.") then
                        Message('Line No %1 has been commited', IRLine."Line No.")
                    else
                        if CommittedAmount + IRLine.Amount > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"),
                                IRLine.FieldCaption("Shortcut Dimension 2 Code"))
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for %5, %1 ,%6, %2, By %3 Budget Available %4'
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), BudgetAvailable - CommittedAmount, IRLine.FieldCaption("Shortcut Dimension 1 Code"),
                                IRLine.FieldCaption("Shortcut Dimension 2 Code"));
                            LineError := true;
                        end;
                    Committments.User := UserId;
                    Committments."Document No" := IR."No.";
                    Committments.No := IRLine."No.";
                    Committments."Line No." := IRLine."Line No.";
                    Committments."Account Type" := Committments."Account Type"::Customer;
                    Committments."Account No." := CommittmentAccount;
                    if Customer.Get(IRLine."No.") then
                        Committments."Account Name" := Customer.Name;
                    Committments.Description := IRLine.Description;
                    Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(IR."No.", CommittmentAccount, IRLine."Line No.") then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        IRLine.Committed := true;
                        IRLine.Modify();
                        if not LineError then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)));
                    end;
                end;
            until IRLine.Next() = 0;
        end;
        //CreatePV(IR);

    end;

    procedure ReverseLPOCommittment(var PurchHeader: Record "Purchase Header")
    var
        Committment: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        FixedAsset: Record "Fixed Asset";
        GenLedSetup: Record "General Ledger Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        AcquisitionAccount: Code[20];
        InventoryAccount: Code[20];
        EntryNo: Integer;
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Order no ' + PurchHeader."No." + '?', false) = true then begin
            Committment.Reset();
            Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
            if Committment.Find('-') then begin
                Committment.DeleteAll();
            end;
            PurchLine.Reset();
            PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
            if PurchLine.FindFirst() then begin
                repeat
                    //Insert Reversal entries in the committment entries table
                    if Committment.Find('+') then
                        EntryNo := Committment."Entry No";
                    EntryNo := EntryNo + 1;
                    GenLedSetup.Get();
                    if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.") then begin
                        Committment.Init();
                        Committment."Entry No" := EntryNo;
                        Committment."Commitment No" := PurchHeader."No.";
                        Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                        Committment."Document Type" := Committment."Document Type"::LPO;
                        Committment."Commitment Date" := PurchLine."Order Date";
                        //Dimensions
                        Committment."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                        Committment."Dimension Set ID" := PurchLine."Dimension Set ID";
                        //Dimensions
                        //Case of G/L Account,Item,Fixed Asset
                        case PurchLine.Type of
                            PurchLine.Type::Item:
                                begin
                                    Item.Reset();
                                    if Item.Get(PurchLine."No.") then
                                        if Item."Inventory Posting Group" = '' then
                                            Error('Assign Posting Group to Item No %1', Item."No.");
                                    InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                                    InventoryAccount := InventoryPostingSetup."Inventory Account";
                                    Committment.Account := InventoryAccount;
                                end;
                            PurchLine.Type::"G/L Account":
                                begin
                                    Committment.Account := PurchLine."No.";
                                end;
                            PurchLine.Type::"Fixed Asset":
                                begin
                                    FixedAsset.Reset();
                                    FixedAsset.Get(PurchLine."No.");
                                    FixedAssetPG.Get(FixedAsset."FA Posting Group");
                                    AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                    Committment.Account := AcquisitionAccount;
                                end;
                        end;
                        Committment."Committed Amount" := -PurchLine."Line Amount";
                        Committment.User := UserId;
                        Committment."Document No" := PurchHeader."No.";
                        Committment.No := PurchLine."No.";
                        Committment."Account Type" := Committment."Account Type"::Vendor;
                        Committment."Account No." := PurchLine."Buy-from Vendor No.";
                        if Vendor.Get(PurchLine."Buy-from Vendor No.") then
                            Committment."Account Name" := Vendor.Name;
                        Committment.Description := PurchLine.Description;
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committment."Budget Code" := GetCommittedBudget(PurchHeader."No.");
                        Committment.Insert();
                        //Mark entries as uncommited
                        PurchLine.Committment := false;
                        PurchLine.Modify();
                    end;
                until PurchLine.Next() = 0;
            end;
            Message('Committed entries for Order No %1 Have been reversed Successfully', PurchHeader."No.");
        end;
    end;

    procedure ReversePostedLPOEntries(PurchInvHeader: Record "Purch. Inv. Header")
    var
        Committment: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchInvLine: Record "Purch. Inv. Line";
        Vendor: Record Vendor;
        AcquisitionAccount: Code[50];
        InventoryAccount: Code[50];
        EntryNo: Integer;
        FA: Record "Fixed Asset";
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-') then begin
            if Committment.Find('+') then
                EntryNo := Committment."Entry No"
            else
                EntryNo := 0;

            repeat
                if LineCommitted(PurchInvHeader."Order No.", PurchInvLine."No.", PurchInvLine."Line No.") then begin
                    if PurchInvLine."Amount Including VAT" <> 0 then begin
                        Committment.Reset();
                        Committment.SetRange("Document Type", Committment."Document Type"::LPO);
                        Committment.SetRange("Document No", PurchInvHeader."Order No.");
                        if Committment.Find('-') then begin
                            EntryNo := EntryNo + 1;
                            Committment.Init();
                            Committment."Entry No" := EntryNo;
                            Committment."Commitment No" := PurchInvHeader."Order No.";
                            Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                            Committment."Document Type" := Committment."Document Type"::LPO;
                            Committment."Commitment Date" := PurchInvHeader."Posting Date";
                            //Dimensions
                            Committment."Global Dimension 1 Code" := PurchInvLine."Shortcut Dimension 1 Code";
                            Committment."Global Dimension 2 Code" := PurchInvLine."Shortcut Dimension 2 Code";
                            Committment."Dimension Set ID" := PurchInvHeader."Dimension Set ID";
                            //Dimensions
                            //Case of G/L Account,Item,Fixed Asset
                            case PurchInvLine.Type of
                                PurchInvLine.Type::Item:
                                    begin
                                        Item.Reset();
                                        if Item.Get(PurchInvLine."No.") then
                                            if Item."Inventory Posting Group" = '' then
                                                Error('Assign Posting Group to Item No %1', Item."No.");
                                        InventoryPostingSetup.Get(PurchInvLine."Location Code", Item."Inventory Posting Group");
                                        //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                        Item.TestField("Item G/L Budget Account");
                                        InventoryAccount := Item."Item G/L Budget Account";
                                        Committment.Account := InventoryAccount;
                                    end;
                                PurchInvLine.Type::"G/L Account":
                                    begin
                                        Committment.Account := PurchInvLine."No.";
                                    end;
                                PurchInvLine.Type::"Fixed Asset":
                                    begin
                                        if FixedAssetPG.Get(PurchInvLine."Posting Group") then begin
                                            FixedAssetPG.TestField("Acquisition Cost Account");
                                            AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                            Committment.Account := AcquisitionAccount;
                                        end;
                                    end;
                            end;
                            Committment."Committed Amount" := -PurchInvLine."Amount Including VAT";
                            Committment.User := UserId;
                            Committment."Document No" := Committment."Account No.";
                            Committment.No := Committment.No;
                            Committment."Account Type" := Committment."Account Type"::Vendor;
                            Committment."Account No." := PurchInvLine."Buy-from Vendor No.";
                            if Vendor.Get(PurchInvLine."Buy-from Vendor No.") then
                                Committment."Account Name" := Vendor.Name;
                            Committment.Description := PurchInvLine.Description;
                            Committment."Document No" := PurchInvHeader."No.";
                            Committment."Uncommittment Date" := Today;
                            GeneralLedgerSetup.Get();
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committment."Budget Code" := GetCommittedBudget(PurchInvHeader."Order No.");
                            Committment.Insert();
                        end;
                    end;
                end;
            until PurchInvLine.Next() = 0;
        end;
    end;

    procedure ReversePostedPurchInvEntries(PurchInvHeader: Record "Purch. Inv. Header")
    var
        Committment: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchInvLine: Record "Purch. Inv. Line";
        Vendor: Record Vendor;
        AcquisitionAccount: Code[50];
        InventoryAccount: Code[50];
        EntryNo: Integer;
        FA: Record "Fixed Asset";
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.Find('-') then begin
            if Committment.Find('+') then
                EntryNo := Committment."Entry No"
            else
                EntryNo := 0;

            repeat
                if LineCommitted(PurchInvHeader."No.", PurchInvLine."No.", PurchInvLine."Line No.") then begin
                    if PurchInvLine."Amount Including VAT" <> 0 then begin
                        Committment.Reset();
                        Committment.SetRange("Document Type", Committment."Document Type"::"Purchase Invoice");
                        Committment.SetRange("Document No", PurchInvHeader."No.");
                        if Committment.Find('-') then begin
                            EntryNo := EntryNo + 1;
                            Committment.Init();
                            Committment."Entry No" := EntryNo;
                            Committment."Commitment No" := PurchInvHeader."Order No.";
                            Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                            Committment."Document Type" := Committment."Document Type"::"Purchase Invoice";
                            Committment."Commitment Date" := PurchInvHeader."Posting Date";
                            //Dimensions
                            Committment."Global Dimension 1 Code" := PurchInvLine."Shortcut Dimension 1 Code";
                            Committment."Global Dimension 2 Code" := PurchInvLine."Shortcut Dimension 2 Code";
                            Committment."Dimension Set ID" := PurchInvHeader."Dimension Set ID";
                            //Dimensions
                            //Case of G/L Account,Item,Fixed Asset
                            case PurchInvLine.Type of
                                PurchInvLine.Type::Item:
                                    begin
                                        Item.Reset();
                                        if Item.Get(PurchInvLine."No.") then
                                            if Item."Inventory Posting Group" = '' then
                                                Error('Assign Posting Group to Item No %1', Item."No.");
                                        InventoryPostingSetup.Get(PurchInvLine."Location Code", Item."Inventory Posting Group");
                                        //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                        Item.TestField("Item G/L Budget Account");
                                        InventoryAccount := Item."Item G/L Budget Account";
                                        Committment.Account := InventoryAccount;
                                    end;
                                PurchInvLine.Type::"G/L Account":
                                    begin
                                        Committment.Account := PurchInvLine."No.";
                                    end;
                                PurchInvLine.Type::"Fixed Asset":
                                    begin
                                        if FixedAssetPG.Get(PurchInvLine."Posting Group") then begin
                                            FixedAssetPG.TestField("Acquisition Cost Account");
                                            AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                            Committment.Account := AcquisitionAccount;
                                        end;
                                    end;
                            end;
                            Committment."Committed Amount" := -PurchInvLine."Amount Including VAT";
                            Committment.User := UserId;
                            Committment."Document No" := Committment."Account No.";
                            Committment.No := Committment.No;
                            Committment."Account Type" := Committment."Account Type"::Vendor;
                            Committment."Account No." := PurchInvLine."Buy-from Vendor No.";
                            if Vendor.Get(PurchInvLine."Buy-from Vendor No.") then
                                Committment."Account Name" := Vendor.Name;
                            Committment.Description := PurchInvLine.Description;
                            Committment."Document No" := PurchInvHeader."No.";
                            Committment."Uncommittment Date" := Today;
                            GeneralLedgerSetup.Get();
                            GeneralLedgerSetup.TestField("Current Budget");
                            Committment."Budget Code" := GetCommittedBudget(PurchInvHeader."No.");
                            Committment.Insert();
                        end;
                    end;
                end;
            until PurchInvLine.Next() = 0;
        end;
    end;

    procedure ReversePurchReqCommittment(var PurchReq: Record "Internal Request Header")
    var
        Committment: Record "Commitment Entries";
        PurchReqLine: Record "Internal Request Line";
        EntryNo: Integer;
    begin
        //IF ConfirmMsg THEN
        if Confirm('Are you sure you want to reverse the committed entries for Purchase Requisition no ' + PurchReq."No." + '?', false) = true then
            //EXIT;
            Committment.Reset();
        Committment.SetRange(Committment."Commitment No", PurchReq."No.");
        if Committment.Find('-') then begin
            Committment.DeleteAll();
        end;
        PurchReqLine.Reset();
        PurchReqLine.SetRange("Document Type", PurchReq."Document Type");
        PurchReqLine.SetRange("Document No.", PurchReq."No.");
        if PurchReqLine.FindFirst() then begin
            if Committment.FindLast() then
                EntryNo := Committment."Entry No";
            repeat
                //Insert reversal entries into the committment table
                if LineCommitted(PurchReq."No.", PurchReqLine."No.", PurchReqLine."Line No.") then begin
                    Committment.Init();
                    Committment."Commitment No" := PurchReq."No.";
                    Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                    Committment."Commitment Date" := PurchReq."Posting Date";
                    Committment."Global Dimension 1 Code" := PurchReqLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2 Code" := PurchReqLine."Shortcut Dimension 2 Code";
                    Committment."Dimension Set ID" := PurchReqLine."Dimension Set ID";
                    Committment.Account := PurchReqLine."No.";
                    Committment."Committed Amount" := -PurchReqLine.Amount;
                    Committment.User := UserId;
                    Committment."Document No" := PurchReq."No.";
                    Committment.No := PurchReqLine."No.";
                    Committment."Line No." := PurchReqLine."Line No.";
                    EntryNo := EntryNo + 1;
                    Committment."Entry No" := EntryNo;
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committment."Budget Code" := GeneralLedgerSetup."Current Budget";
                    Committment.Insert();
                    //Mark imprest lines entries as uncommited
                    PurchReqLine.Committed := false;
                    PurchReqLine.Modify();
                end;
            until PurchReqLine.Next() = 0;
        end;
        PurchReq.Uncommitted := true;
        PurchReq.Modify();
        Message('Committed entries for Requisition No %1 Have been reversed Successfully', PurchReq."No.");
    end;

    procedure StoreReqCommittment(var IR: Record "Internal Request Header"; var ErrorMsg: Text)
    var
        CommitmentEntries: Record "Commitment Entries";
        Committments: Record "Commitment Entries";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        IRLine: Record "Internal Request Line";
        DimMgt: Codeunit DimensionManagement;
        LineError: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        EntryNo: Integer;
        DimValueName: array[8] of Text;
    begin
        ErrorMsg := '';
        /*
        if IR.Status<>IR.Status::Released then
            Error('The imprest is not fully approved');*/
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        if IRLine.FindFirst() then begin
            if Committments.FindLast() then
                EntryNo := Committments."Entry No";
            repeat
                if IsAccountVotebookEntry(IRLine."Item G/L Budget Account") then begin
                    Committments.Init();
                    Committments."Commitment No" := IR."No.";
                    Committments."Commitment Type" := Committments."Commitment Type"::Commitment;
                    Committments."Document Type" := Committments."Document Type"::"Store Requisition";
                    IR.TestField("Document Date");
                    Committments."Commitment Date" := Today;
                    Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                    if IRLine.Type <> IRLine.Type::Item then
                        Committments.Account := IRLine."No."
                    else
                        Committments.Account := IRLine."Item G/L Budget Account";
                    Committments."Committed Amount" := IRLine."Line Amount";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get();
                    GenLedSetup.TestField("Current Budget");
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    if IRLine.Type <> IRLine.Type::Item then
                        GLAccount.SetRange(GLAccount."No.", IRLine."No.")
                    else
                        GLAccount.SetRange(GLAccount."No.", IRLine."Item G/L Budget Account");
                    if GenLedSetup."Use Dimensions For Budget" then
                        GLAccount.SetRange(GLAccount."Dimension Set ID Filter", IRLine."Dimension Set ID");
                    //Get Dimensions
                    DimMgt.GetShortcutDimensions(IRLine."Dimension Set ID", ShortcutDimCode);
                    /*if ShortcutDimCode[1]<>'' then
                    GLAccount.SetRange("Global Dimension 1 Filter",ShortcutDimCode[1]);
                    if ShortcutDimCode[2]<>'' then
                    GLAccount.SetRange("Global Dimension 2 Filter",ShortcutDimCode[2]);
                    if ShortcutDimCode[3]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 3 Filter",ShortcutDimCode[3]);
                    if ShortcutDimCode[4]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 4 Filter",ShortcutDimCode[4]);
                    if ShortcutDimCode[5]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 5 Filter",ShortcutDimCode[5]);
                    if ShortcutDimCode[6]<>'' then
                    GLAccount.SetRange("Shortcut Dimension 6 Filter",ShortcutDimCode[6]);*/
                    FetchDimValue(IRLine."Dimension Set ID", ShortcutDimCode, DimValueName);
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", IR."Document Date");
                    if GLAccount.Find('-') then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                        BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
                        //MESSAGE('bud amt %1-expenses %2-avail %3',BudgetAmount,Expenses,BudgetAvailable);
                    end;
                    //Get committed Amount
                    CommittedAmount := 0;
                    CommitmentEntries.Reset();
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if IRLine.Type <> IRLine.Type::Item then
                        CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."No.")
                    else
                        CommitmentEntries.SetRange(CommitmentEntries.Account, IRLine."Item G/L Budget Account");
                    if GenLedSetup."Use Dimensions For Budget" then
                        CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", IRLine."Dimension Set ID");
                    CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
                    /*if IR."Posting Date"=0D then
                       Error('Please insert the imprest date');*/
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                               IR."Document Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount := CommitmentEntries."Committed Amount";
                    LineError := false;
                    if LineCommitted(IR."No.", IRLine."No.", IRLine."Line No.") then
                        Message('Line No %1 has been commited', IRLine."Line No.")
                    else
                        if CommittedAmount + IRLine."Line Amount" > BudgetAvailable then begin
                            if ErrorMsg = '' then
                                ErrorMsg := StrSubstNo('You have Exceeded Budget for Item No. %5 Amount %6 under %8, %1 ,%9, %2, on G/L Account %7 By %3 Budget Available %4'
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), (BudgetAvailable - CommittedAmount), IRLine."No.", IRLine."Line Amount", IRLine."Item G/L Budget Account",
                                IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"), IRLine.FieldCaption("Shortcut Dimension 4 Code"), IRLine."Shortcut Dimension 4 Code")
                            else
                                ErrorMsg := ErrorMsg + '\' + StrSubstNo('You have Exceeded Budget for Item No. %5 Amount %6 under %8, %1 ,%9, %2, on G/L Account %7 By %3 Budget Available %4'
                               , DimValueName[1], DimValueName[2],
                                Abs(BudgetAvailable - (CommittedAmount + IRLine.Amount)), (BudgetAvailable - CommittedAmount), IRLine."No.", IRLine."Line Amount", IRLine."Item G/L Budget Account",
                                IRLine.FieldCaption("Shortcut Dimension 1 Code"), IRLine.FieldCaption("Shortcut Dimension 2 Code"), IRLine.FieldCaption("Shortcut Dimension 4 Code"), IRLine."Shortcut Dimension 4 Code");
                            LineError := true;
                        end;
                    Committments.User := UserId;
                    Committments."Document No" := IR."No.";
                    Committments.No := IRLine."No.";
                    Committments."Line No." := IRLine."Line No.";

                    if IRLine.Type <> IRLine.Type::Item then begin
                        //Committments."Account Type" := Committments."Account Type"::"5";
                        Committments."Account No." := IRLine."No."
                    end else
                        Committments."Account Type" := Committments."Account Type"::"G/L Account";
                    Committments."Account No." := IRLine."Item G/L Budget Account";

                    if Customer.Get(IRLine."No.") then
                        Committments."Account Name" := Customer.Name;
                    Committments.Description := IRLine.Description;
                    Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committments."Budget Code" := GeneralLedgerSetup."Current Budget";
                    //Check whether line is committed.
                    if not LineCommitted(IR."No.", IRLine."No.", IRLine."Line No.") then begin
                        EntryNo := EntryNo + 1;
                        Committments."Entry No" := EntryNo;
                        Committments.Insert();
                        IRLine.Committed := true;
                        IRLine.Modify();
                        if not LineError then
                            Message('Items Committed Successfully and the balance is %1',
                            Abs(BudgetAvailable - (CommittedAmount + IRLine."Line Amount")));
                    end;
                end;
            until IRLine.Next() = 0;
        end;
        //CreatePV(IR);

    end;

    procedure UncommitLPO(var PurchHeader: Record "Purchase Header")
    var
        CommEntries: Record "Commitment Entries";
        Committment: Record "Commitment Entries";
        FixedAssetPG: Record "FA Posting Group";
        FixedAsset: Record "Fixed Asset";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        Item: Record Item;
        PurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        AcquisitionAccount: Code[20];
        InventoryAccount: Code[20];
        EntryNo: Integer;
    begin
        //Post Reversals to committment entries
        PurchLine.Reset();
        PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.Find('-') then begin
            Committment.Reset();
            Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
            Committment.SetRange(Committment."Commitment Type", Committment."Commitment Type"::Commitment);
            if Committment.Find('-') then
                UncommittmentDate := Committment."Commitment Date";
            repeat
                if CommEntries.Find('+') then
                    EntryNo := CommEntries."Entry No";

                if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.") then begin
                    Committment.Init();
                    Committment."Entry No" := EntryNo + 1;
                    Committment."Commitment No" := PurchHeader."No.";
                    Committment."Commitment Type" := Committment."Commitment Type"::"Commitment Reversal";
                    Committment."Document Type" := Committment."Document Type"::LPO;
                    //Insert the same
                    Committment."Commitment Date" := UncommittmentDate;
                    Committment."Uncommittment Date" := PurchLine."Order Date";
                    //Dimensions
                    Committment."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
                    //Dimensions
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchLine.Type of
                        PurchLine.Type::Item:
                            begin
                                Item.Reset();
                                if Item.Get(PurchLine."No.") then
                                    if Item."Inventory Posting Group" = '' then
                                        Error('Assign Posting Group to Item No %1', Item."No.");
                                InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                                //InventoryAccount:=InventoryPostingSetup."Inventory Account";
                                Item.TestField("Item G/L Budget Account");
                                InventoryAccount := Item."Item G/L Budget Account";
                                Committment.Account := InventoryAccount;
                            end;
                        PurchLine.Type::"G/L Account":
                            begin
                                Committment.Account := PurchLine."No.";
                            end;
                        PurchLine.Type::"Fixed Asset":
                            begin
                                FixedAsset.Reset();
                                FixedAsset.Get(PurchLine."No.");
                                FixedAssetPG.Get(FixedAsset."FA Posting Group");
                                AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
                                Committment.Account := AcquisitionAccount;
                            end;
                    end;
                    Committment."Committed Amount" := -PurchLine."Amount Including VAT";
                    Committment.User := UserId;
                    Committment."Document No" := PurchHeader."No.";
                    Committment.No := PurchLine."No.";
                    Committment."Line No." := PurchLine."Line No.";
                    Committment."Account Type" := Committment."Account Type"::Vendor;
                    Committment."Account No." := PurchLine."Buy-from Vendor No.";
                    if Vendor.Get(PurchLine."Buy-from Vendor No.") then
                        Committment."Account Name" := Vendor.Name;
                    Committment.Description := PurchLine.Description;
                    Committment."Dimension Set ID" := PurchLine."Dimension Set ID";
                    GeneralLedgerSetup.Get();
                    GeneralLedgerSetup.TestField("Current Budget");
                    Committment."Budget Code" := GetCommittedBudget(PurchHeader."No.");
                    Committment.Insert();
                end;
            until PurchLine.Next() = 0;
        end;
        //End Post Reversal to Committment entries
        //Note LPO Uncommittment.
    end;

    procedure UncommitPurchInvoice(var IR: Record "Purchase Header")
    var
        Committments: Record "Commitment Entries";
        IRLine: Record "Purchase Line";
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange("Document Type", IR."Document Type");
        if IRLine.FindFirst() then
            repeat
                Committments.Init();
                Committments."Commitment No" := IRLine."Document No.";
                Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                //Insert same Commitment Date
                Committments."Commitment Date" := UncommittmentDate;
                Committments."Uncommittment Date" := IR."Posting Date";
                Committments."Dimension Set ID" := IR."Dimension Set ID";
                Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                Committments."Dimension Set ID" := IR."Dimension Set ID";
                Committments.Account := IRLine."No.";
                Committments."Committed Amount" := -IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                Committments.User := UserId;
                Committments."Document No" := IR."No.";
                Committments.No := IRLine."No.";
                Committments."Line No." := IRLine."Line No.";
                Committments."Entry No" := EntryNo;
                GeneralLedgerSetup.Get();
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code" := GetCommittedBudget(IRLine."Document No.");
                Committments.Insert();
                EntryNo := EntryNo + 1;
            until IRLine.Next() = 0;
    end;

    procedure UncommitPurchReq(var IRLine: Record "Internal Request Line"; var IR: Record "Internal Request Header")
    var
        Committments: Record "Commitment Entries";
        EntryNo: Integer;
    begin
        //Update Dimension Set ID
        Committments.Reset();
        Committments.SetRange("Commitment No", IRLine."Document No.");
        Committments.SetRange(No, IRLine."No.");
        Committments.SetRange("Line No.", IRLine."Line No.");
        if Committments.Find('-') then begin
            Committments."Dimension Set ID" := IRLine."Dimension Set ID";
            Committments.Modify();
        end;
        Committments.Reset();
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        EntryNo := EntryNo + 1;
        Committments.Reset();
        Committments.SetRange("Commitment No", IR."No.");
        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
        if Committments.Find('-') then
            UncommittmentDate := Committments."Commitment Date";
        Committments.Init();
        Committments."Commitment No" := IRLine."Document No.";
        Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
        Committments."Document Type" := Committments."Document Type"::"Purchase Requisition";
        //Insert same Commitment Date
        Committments."Commitment Date" := UncommittmentDate;
        Committments."Uncommittment Date" := Today;
        Committments."Dimension Set ID" := IRLine."Dimension Set ID";
        Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
        Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
        Committments.Account := IRLine."No.";
        Committments."Committed Amount" := -LastCommittment(IRLine."Document No.", IRLine."No.", IRLine."Line No."); //-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
        Committments."Account No." := IRLine."No.";
        Committments.User := UserId;
        Committments."Document No" := IR."No.";
        Committments.No := IRLine."No.";
        Committments."Line No." := IRLine."Line No.";
        Committments."Entry No" := EntryNo;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Current Budget");
        Committments."Budget Code" := GetCommittedBudget(IRLine."Document No.");
        Committments.Insert();
    end;

    procedure UncommitPurchRequestOnCreateLPOAfterEvaluation(QuoteNo: Code[20]; ReqNo: Code[20])
    var
        Committments: Record "Commitment Entries";
        IR: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        ProcurementEvaluation: Record "Procurement Evaluation Header";
        EntryNo: Integer;
    begin
        if ProcurementEvaluation.Get(QuoteNo) then begin
            if IR.Get(ReqNo) and (not IR.Uncommitted) then begin
                IRLine.Reset();
                IRLine.SetRange("Document No.", IR."No.");
                IRLine.SetRange(Uncommitted, false);
                if IRLine.FindSet() then begin
                    repeat
                        Committments.Reset();
                        Committments.SetRange("Commitment No", IRLine."Document No.");
                        Committments.SetRange(No, IRLine."No.");
                        Committments.SetRange("Line No.", IRLine."Line No.");
                        if Committments.Find('-') then begin
                            Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                            Committments.Modify();
                        end;
                        Committments.Reset();
                        if Committments.FindLast() then
                            EntryNo := Committments."Entry No";
                        EntryNo := EntryNo + 1;
                        Committments.Reset();
                        Committments.SetRange("Commitment No", IR."No.");
                        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
                        if Committments.Find('-') then
                            UncommittmentDate := Committments."Commitment Date";
                        Committments.Init();
                        Committments."Commitment No" := IRLine."Document No.";
                        Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                        Committments."Document Type" := Committments."Document Type"::"Purchase Requisition";
                        //Insert same Commitment Date
                        Committments."Commitment Date" := UncommittmentDate;
                        Committments."Uncommittment Date" := IR."Posting Date";
                        Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                        Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                        Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                        Committments.Account := IRLine."No.";
                        Committments."Committed Amount" := -LastCommittment(IRLine."Document No.", IRLine."No.", IRLine."Line No."); //-IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                        Committments."Account No." := IRLine."No.";
                        Committments.User := UserId;
                        Committments."Document No" := IR."No.";
                        Committments.No := IRLine."No.";
                        Committments."Line No." := IRLine."Line No.";
                        Committments."Entry No" := EntryNo;
                        GeneralLedgerSetup.Get();
                        GeneralLedgerSetup.TestField("Current Budget");
                        Committments."Budget Code" := GetCommittedBudget(IRLine."Document No.");
                        Committments.Insert();

                        IRLine.Uncommitted := true;
                        IRLine.Modify();
                    until IRLine.Next() = 0;
                end;

                IR.Validate(Uncommitted, true);
                IR.Modify();
            end;
        end;
    end;

    procedure UncommitStoreReq(var IR: Record "Internal Request Header")
    var
        Committments: Record "Commitment Entries";
        IRLine: Record "Internal Request Line";
        EntryNo: Integer;
    begin
        //Update Dimension Set ID
        IRLine.Reset();
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        if IRLine.Find('-') then begin
            repeat
                Committments.Reset();
                Committments.SetRange("Commitment No", IRLine."Document No.");
                Committments.SetRange(No, IRLine."No.");
                Committments.SetRange("Line No.", IRLine."Line No.");
                if Committments.Find('-') then begin
                    Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                    Committments.Modify();
                end;
                Committments.Reset();
                if Committments.FindLast() then
                    EntryNo := Committments."Entry No";
                EntryNo := EntryNo + 1;
                Committments.Reset();
                Committments.SetRange("Commitment No", IR."No.");
                Committments.SetRange("Commitment Type", Committments."Commitment Type"::Commitment);
                if Committments.Find('-') then
                    UncommittmentDate := Committments."Commitment Date";
                Committments.Init();
                Committments."Commitment No" := IRLine."Document No.";
                Committments."Commitment Type" := Committments."Commitment Type"::"Commitment Reversal";
                Committments."Document Type" := Committments."Document Type"::"Store Requisition";
                //Insert same Commitment Date
                Committments."Commitment Date" := UncommittmentDate;
                Committments."Uncommittment Date" := IR."Document Date";
                Committments."Dimension Set ID" := IRLine."Dimension Set ID";
                Committments."Global Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                Committments."Global Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                if IRLine.Type <> IRLine.Type::Item then
                    Committments.Account := IRLine."No."
                else
                    Committments.Account := IRLine."Item G/L Budget Account";
                Committments."Committed Amount" := -IRLine."Qty. to Receive" * IRLine."Direct Unit Cost";
                if IRLine.Type <> IRLine.Type::Item then
                    Committments."Account No." := IRLine."No."
                else
                    Committments."Account No." := IRLine."Item G/L Budget Account";
                Committments.User := UserId;
                Committments."Document No" := IR."No.";
                Committments.No := IRLine."No.";
                Committments."Line No." := IRLine."Line No.";
                Committments."Entry No" := EntryNo;
                GeneralLedgerSetup.Get();
                GeneralLedgerSetup.TestField("Current Budget");
                Committments."Budget Code" := GetCommittedBudget(IRLine."Document No.");
                Committments.Insert();
            until IRLine.Next() = 0;
        end;
    end;

    procedure UnencumberPO(PurchHeader: Record "Purchase Header"; PurchLine: Record "Purchase Line")
    var
        Committments: Record "Commitment Entries";
        EncumberedAmt: Decimal;
        EntryNo: Integer;
    begin
        if Committments.FindLast() then
            EntryNo := Committments."Entry No";
        Committments.Reset();
        Committments.SetRange("Commitment No", PurchHeader."No.");
        Committments.SetRange("Commitment Type", Committments."Commitment Type"::Encumberance);
        Committments.SetRange(No, PurchLine."No.");
        Committments.SetRange("Line No.", PurchLine."Line No.");
        if Committments.Find('-') then begin
            UncommittmentDate := Committments."Commitment Date";
            EncumberedAmt := Committments."Committed Amount";
        end;
        if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.") then begin
            Committments.Init();
            Committments."Commitment No" := PurchHeader."No.";
            Committments."Commitment Type" := Committments."Commitment Type"::"Encumberance Reversal";
            //Insert same Commitment Date
            Committments."Commitment Date" := UncommittmentDate;
            Committments."Uncommittment Date" := PurchHeader."Posting Date";
            Committments."Dimension Set ID" := PurchLine."Dimension Set ID";
            Committments."Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
            Committments."Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
            Committments.Account := PurchLine."No.";
            Committments."Account No." := PurchLine."No.";
            Committments."Committed Amount" := -EncumberedAmt;
            Committments.User := UserId;
            Committments."Document No" := PurchHeader."No.";
            Committments.No := PurchLine."No.";
            Committments."Line No." := PurchLine."Line No.";
            EntryNo := EntryNo + 1;
            Committments."Entry No" := EntryNo;
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("Current Budget");
            Committments."Budget Code" := GetCommittedBudget(PurchHeader."No.");
            Committments.Insert();
        end;
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    local procedure GetLPOAccountNo(PurchaseLine: Record "Purchase Line"): Code[20]
    var
        FAPostingGroup: Record "FA Posting Group";
        Items: Record Item;
        FA: Record "Fixed Asset";
    begin
        case PurchaseLine.Type of
            PurchaseLine.Type::"G/L Account":
                exit(PurchaseLine."No.");
            PurchaseLine.Type::Item:
                begin
                    if Items.Get(PurchaseLine."No.") then begin
                        Items.TestField("Item G/L Budget Account");
                        exit(Items."Item G/L Budget Account");
                    end;
                end;
            PurchaseLine.Type::"Fixed Asset":
                begin
                    if FAPostingGroup.Get(PurchaseLine."Posting Group") then begin
                        FAPostingGroup.TestField("Acquisition Cost Account");
                        exit(FAPostingGroup."Acquisition Cost Account");
                    end;
                end;
        end;
    end;


    procedure GetRequisitionBudgetLineBalance(PurchLines: Record "Internal Request Line"; var CurrentBalance: Decimal; var BalanceAfter: Decimal)
    var
        CommitmentEntries: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        GenLedSetup: Record "General Ledger Setup";
        PurchHeader: Record "Internal Request Header";
        BudgetAmount: Decimal;
        BudgetAvailable: Decimal;
        CommittedAmount: Decimal;
        Expenses: Decimal;
    begin
        PurchLines.GetHeader(PurchHeader);
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Purchase then begin
            PurchLines.TestField("Budget Line");

            GenLedSetup.Get;
            GLAccount.SetRange(GLAccount."No.", PurchLines."Budget Line");
            GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
            GLAccount.SetRange(GLAccount."Dimension Set ID Filter", PurchLines."Dimension Set ID");
            //Get budget amount avaliable
            GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", PurchHeader."Order Date");
            if GLAccount.FindFirst() then begin
                GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change", "Approved Budget", "Disbursed Budget");
                BudgetAmount := GLAccount."Approved Budget";
                Expenses := GLAccount."Net Change";
                BudgetAvailable := GLAccount."Approved Budget" - GLAccount."Net Change";
            end;

            //Get committed Amount
            CommittedAmount := 0;
            CommitmentEntries.Reset;
            CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
            CommitmentEntries.SetRange(CommitmentEntries.Account, PurchLines."Budget Line");
            CommitmentEntries.SetRange(CommitmentEntries."Dimension Set ID", PurchLines."Dimension Set ID");
            CommitmentEntries.SetRange("Budget Code", GenLedSetup."Current Budget");
            if PurchHeader."Order Date" = 0D then
                Error('Please insert the header date');
            CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                      PurchHeader."Order Date");
            CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
            CommittedAmount := CommitmentEntries."Committed Amount";

            CurrentBalance := BudgetAvailable - CommittedAmount;
            BalanceAfter := Abs(BudgetAvailable - (CommittedAmount + PurchLines.Amount));
        end;
    end;
}





