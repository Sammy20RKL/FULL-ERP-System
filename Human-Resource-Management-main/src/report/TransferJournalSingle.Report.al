report 52980 "Transfer Journal Single"
{
    ApplicationArea = All;
    Caption = 'Transfer to Journal-Single';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Employee Posting GroupX"; "Employee HR Posting Group")
        {
            DataItemTableView = where("Employee Type" = filter(<> Trustee));
            RequestFilterFields = "Pay Period Filter", "Code";

            column(Employee_Posting_GroupX_Code; Code)
            {
            }
            column(Employee_Posting_GroupX_Pay_Period_Filter; "Pay Period Filter")
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemLink = "Posting Group" = field(Code), "Pay Period Filter" = field("Pay Period Filter");
                DataItemTableView = where("Employee Type" = filter(<> "Board Member"));
                RequestFilterFields = "No.";
                column(No_; "No.") { }
                trigger OnAfterGetRecord()
                begin

                    //Datefilter := "Pay Period Filter";

                    Noseries := FORMAT(DATE2DMY(DateSpecified, 2)) + '-' + FORMAT(DATE2DMY(DateSpecified, 3));

                    PostingGroup.RESET();
                    IF PostingGroup.FIND('-') THEN
                        PayablesAcc := PostingGroup."Net Salary Payable";
                    FringeAcc := PostingGroup."Net Salary Payable";
                    GLSetup.GET();

                    PayrollPeriod.RESET();
                    PayrollPeriod.SETRANGE("Starting Date", DateSpecified);
                    IF PayrollPeriod.FIND('-') THEN
                        //PayrollPeriod.TESTFIELD("Pay Date");
                        Payday := PayrollPeriod."Pay Date";

                    TotalDebits := 0;
                    TotalCredits := 0;




                    BasicAmount := 0;
                    HREmp.RESET();
                    HREmp.SetRange(HREmp."No.", "No.");
                    HREmp.SETRANGE(Status, HREmp.Status::Active);
                    HREmp.SETRANGE("Pay Period Filter", DateSpecified);
                    IF HREmp.Find('-') THEN
                        REPEAT
                            //  Message('Processing Employee %1', HREmp."No.");
                            payrollproject.Reset();
                            payrollproject.SETRANGE(payrollproject."Employee No", HREmp."No.");
                            payrollproject.SETRANGE(payrollproject.Period, DateSpecified);
                            IF payrollproject.FIND('-') THEN
                                repeat
                                    //  Message('Processing Employee %1', payrollproject."Employee No");
                                    Earn.Reset();
                                    Earn.SETFILTER(Earn."Account No.", '<>%1', '');
                                    Earn.SETRANGE(Earn."Paye Allocation", true);
                                    Earn.SETRANGE(Earn."Non-Cash Benefit", FALSE);
                                    Earn.SETRANGE(Earn."Paye Allocation", TRUE);
                                    IF Earn.FIND('-') THEN
                                        REPEAT
                                            AssignMatrix.RESET();
                                            AssignMatrix.SETRANGE(Code, Earn.Code);
                                            AssignMatrix.SETRANGE("Employee No", payrollproject."Employee No"); //Added
                                            AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                            // AssignMatrix.SetRange(PA);
                                            IF AssignMatrix.FIND('-') THEN BEGIN

                                                AssignMatrix.CALCSUMS(Amount);


                                                // AssignMatrix.CALCSUMS("Employer Amount", payrollproject.Amount);
                                                BasicAmount := AssignMatrix.Amount * (payrollproject.Allocation / 100);
                                                // Message('Basic Amount %1', BasicAmount);
                                                GenJnline.INIT();
                                                LineNumber := LineNumber + 10;
                                                GenJnline."Journal Template Name" := 'GENERAL';
                                                GenJnline."Journal Batch Name" := 'NETPAY';
                                                GenJnline."Line No." := GenJnline."Line No." + 10;
                                                GenJnline."Account No." := Earn."Account No.";
                                                GenJnline.VALIDATE("Account No.");
                                                GenJnline."Posting Date" := Payday;
                                                GenJnline.Description := Earn.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                                                GenJnline."Document No." := Noseries;
                                                GenJnline."Shortcut Dimension 1 Code" := payrollproject."Project Code";
                                                // GenJnline.validate("Shortcut Dimension 1 Code");
                                                GenJnline."Shortcut Dimension 2 Code" := payrollproject."Budget Line Code";
                                                // GenJnline.validate("Shortcut Dimension 2 Code");
                                                GenJnline."Dimension Set ID" := payrollproject."Dimension Set ID";
                                                // GenJnline."Currency Code" := 'KES';
                                                GenJnline.Amount := BasicAmount;
                                                GenJnline.VALIDATE(Amount);
                                                GenJnline."Employee Code" := AssignMatrix."Employee No";

                                                IF GenJnline.Amount <> 0 THEN
                                                    GenJnline.INSERT();
                                                TotalCredits := TotalCredits + BasicAmount;

                                            END;
                                        UNTIL Earn.NEXT() = 0;
                                UNTIL payrollproject.NEXT() = 0;
                            //UNTIL HREmp.NEXT() = 0;
                            // END;


                            // // //============================================FRINGE BENEFITS

                            // HREmp.RESET();

                            // HREmp.SetRange(HREmp."No.", "No.");
                            // HREmp.SETRANGE(Status, HREmp.Status::Active);
                            // IF HREmp.FINDSET(FALSE, FALSE) THEN BEGIN
                            //     //REPEAT
                            Earn.RESET();
                            Earn.SETRANGE(Earn."Basic Salary Code", TRUE);
                            IF Earn.FIND('-') THEN
                                REPEAT
                                    AssignMatrix.RESET();
                                    AssignMatrix.SETRANGE(Code, Earn.Code);
                                    AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                    AssignMatrix.SETRANGE("Employee No", HREmp."No."); //Added
                                    IF AssignMatrix.FIND('-') THEN BEGIN
                                        AssignMatrix.CALCSUMS("Employer Amount");

                                        GenJnline.INIT();
                                        LineNumber := LineNumber + 10;
                                        GenJnline."Journal Template Name" := 'GENERAL';
                                        GenJnline."Journal Batch Name" := 'NETPAY';
                                        GenJnline."Line No." := GenJnline."Line No." + 10;
                                        GenJnline."Account No." := Earn."Account No.";
                                        GenJnline.VALIDATE("Account No.");
                                        GenJnline."Posting Date" := Payday;
                                        GenJnline.Description := Earn.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                                        GenJnline."Document No." := Noseries;
                                        // GenJnline."Currency Code" := 'KES';
                                        GenJnline.Amount := AssignMatrix."Employer Amount";
                                        GenJnline.VALIDATE(Amount);
                                        IF GenJnline.Amount <> 0 THEN
                                            GenJnline.INSERT();
                                    END;
                                UNTIL Earn.NEXT() = 0;
                            //     // UNTIL HREmp.NEXT() = 0;
                            // END;

                            //================================================END FRINGE BENEFITS

                            //=========================================================EMPLOYER AMOUNT
                            // HREmp.RESET();
                            // HREmp.SetRange(HREmp."No.", "No.");
                            // HREmp.SETRANGE(Status, HREmp.Status::Active);
                            // // IF StaffFilter <> '' THEN
                            // //REmp.SETRANGE("No.", "No.");
                            // IF HREmp.FINDSET(FALSE, FALSE) THEN BEGIN
                            //     REPEAT
                            Deduction.RESET();
                            Deduction.SETFILTER(Deduction."Account No.", '<>%1', '');
                            IF Deduction.FIND('-') THEN
                                REPEAT
                                    // Message('here1');
                                    AssignMatrix.RESET();
                                    AssignMatrix.SETRANGE(Code, Deduction.Code);
                                    AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                    AssignMatrix.SETRANGE("Employee No", HREmp."No."); //Added
                                    IF AssignMatrix.FIND('-') THEN BEGIN
                                        //  Message('here2');
                                        AssignMatrix.CALCSUMS(Amount, AssignMatrix."Employer Amount");
                                        IF (AssignMatrix."Employer Amount" <> 0) AND (Deduction."Account No. Employer" <> '') THEN BEGIN
                                            // Message('here3');
                                            // Message('amount is employer is %1', AssignMatrix."Employer Amount");
                                            GenJnline.INIT();
                                            LineNumber := LineNumber + 10;
                                            GenJnline."Journal Template Name" := 'GENERAL';
                                            GenJnline."Journal Batch Name" := 'NETPAY';
                                            GenJnline."Line No." := GenJnline."Line No." + 10;
                                            GenJnline."Account No." := Deduction."Account No. Employer";
                                            GenJnline."Posting Date" := Payday;
                                            GenJnline.Description := Deduction.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                                            GenJnline."Document No." := Noseries;
                                            AssignMatrix.SetRange("Employee No", payrollproject."Employee No");
                                            if AssignMatrix.Find('-') then begin
                                                GenJnline."Shortcut Dimension 1 Code" := payrollproject."Project Code";
                                                // GenJnline.validate("Shortcut Dimension 1 Code");
                                                GenJnline."Shortcut Dimension 2 Code" := payrollproject."Budget Line Code";
                                                // GenJnline.validate("Shortcut Dimension 2 Code");
                                                GenJnline."Dimension Set ID" := payrollproject."Dimension Set ID";
                                                // GenJnline."Currency Code" := 'KES';
                                            end;
                                            GenJnline.Amount := AssignMatrix."Employer Amount";

                                            //  GenJnline.Amount := -AssignMatrix.Amount;

                                            GenJnline.VALIDATE(Amount);
                                            IF GenJnline.Amount <> 0 THEN
                                                TotalDebits := TotalDebits + AssignMatrix."Employer Amount";
                                            GenJnline.INSERT();
                                        END;
                                    END;
                                UNTIL Deduction.NEXT() = 0;
                            //UNTIL HREmp.NEXT() = 0;
                            //END;
                            //============================================================END EMPLYER AMOUNT
                            //============================================================END EMPLYER AMOUNT

                            // HREmp.RESET();
                            // HREmp.SETRANGE(Status, HREmp.Status::Active);
                            // //IF  <> '' THEN HREmp.SETRANGE("No.", "No.");
                            // IF HREmp.FINDSET(FALSE, FALSE) THEN BEGIN
                            //     REPEAT
                            Deduction.RESET();
                            Deduction.SETFILTER(Deduction."Account No.", '<>%1', '');
                            IF Deduction.FIND('-') THEN
                                REPEAT


                                    ///*((((((((((((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))))))))
                                    AssignMatrix.RESET();
                                    AssignMatrix.SETRANGE(Code, Deduction.Code);
                                    AssignMatrix.SETRANGE("Employee No", HREmp."No."); //Added
                                    AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                    IF AssignMatrix.FIND('-') THEN BEGIN
                                        AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                                        // Message('amount is employer is %1', AssignMatrix."Employer Amount");
                                        GenJnline.INIT();
                                        LineNumber := LineNumber + 10;
                                        GenJnline."Journal Template Name" := 'GENERAL';
                                        GenJnline."Journal Batch Name" := 'NETPAY';
                                        GenJnline."Line No." := GenJnline."Line No." + 10;
                                        GenJnline."Account No." := Deduction."Account No.";

                                        GenJnline."Posting Date" := Payday;
                                        // GenJnline."Currency Code" := 'KES';
                                        GenJnline.Description := Deduction.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                                        GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//"Pay Period Filter"Mgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT("Pay Period Filter");
                                        IF (AssignMatrix."Employer Amount" <> 0) AND (Deduction."Account No. Employer" <> '') THEN BEGIN
                                            GenJnline.Amount := AssignMatrix.Amount; //- AssignMatrix."Employer Amount";
                                                                                     // GenJnline.Amount := -AssignMatrix."Employer Amount";
                                            ;
                                            GenJnline.Validate(Amount);
                                            // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");

                                        END ELSE
                                            // GenJnline.Amount := AssignMatrix.Amount;
                                            // GenJnline.Amount := -AssignMatrix."Employer Amount";
                                            // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");

                                            GenJnline.VALIDATE(Amount);
                                        //GenJnline."Employee Code":=AssignMatrix."Employee No";
                                        IF AssignMatrix.Amount <= 0 THEN
                                            TotalDebits := TotalDebits + GenJnline.Amount;
                                        ;
                                        IF GenJnline.Amount <> 0 THEN
                                            GenJnline.INSERT();
                                    END;



                                //DimMgt.ValidateShortcutDimValues(3,Dim3Value.Code,GenJnline."Dimension Set ID");

                                UNTIL Deduction.NEXT() = 0;

                            ////***************************************888mkj
                            Deduction.RESET();
                            Deduction.SETFILTER(Deduction."Account No.", '<>%1', '');
                            IF Deduction.FIND('-') THEN
                                REPEAT


                                    ///*((((((((((((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))))))))
                                    AssignMatrix.RESET();
                                    AssignMatrix.SETRANGE(Code, Deduction.Code);
                                    AssignMatrix.SETRANGE("Employee No", HREmp."No."); //Added
                                    AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                    IF AssignMatrix.FIND('-') THEN BEGIN
                                        AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                                        //   Message('amount is employer is %1', AssignMatrix."Employer Amount");
                                        GenJnline.INIT();
                                        LineNumber := LineNumber + 10;
                                        GenJnline."Journal Template Name" := 'GENERAL';
                                        GenJnline."Journal Batch Name" := 'NETPAY';
                                        GenJnline."Line No." := GenJnline."Line No." + 10;
                                        GenJnline."Account No." := Deduction."Account No.";
                                        // GenJnline."Currency Code" := 'KES';

                                        GenJnline."Posting Date" := Payday;
                                        GenJnline.Description := Deduction.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                                        GenJnline."Document No." := Noseries;
                                        GenJnline.Amount := AssignMatrix.Amount;

                                        //GenJnlBatch."Posting No. Series";//"Pay Period Filter"Mgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT("Pay Period Filter");
                                        IF (AssignMatrix."Employer Amount" <> 0) AND (Deduction."Account No. Employer" <> '') THEN
                                            //GenJnline.Amount := AssignMatrix.Amount - AssignMatrix."Employer Amount";
                                            GenJnline.Amount := -AssignMatrix."Employer Amount"
                                        // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");

                                        ELSE
                                            GenJnline.Amount := AssignMatrix.Amount;
                                        //GenJnline.Amount := -AssignMatrix."Employer Amount";

                                        // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");

                                        GenJnline.VALIDATE(Amount);
                                        //GenJnline."Employee Code":=AssignMatrix."Employee No";
                                        IF AssignMatrix.Amount <= 0 THEN
                                            TotalDebits := TotalDebits + GenJnline.Amount;
                                        ;
                                        IF GenJnline.Amount <> 0 THEN
                                            GenJnline.INSERT();
                                    END;
                                UNTIL Deduction.NEXT() = 0;


                            //=========================================================================END DEDUCTIONS

                            Earn.RESET();
                            Earn.SETRANGE("Non-Cash Benefit", TRUE);
                            Earn.SETRANGE(Earn."Basic Salary Code", TRUE);
                            IF Earn.FIND('-') THEN
                                REPEAT
                                    AssignMatrix.RESET();
                                    AssignMatrix.SETRANGE(Code, Earn.Code);
                                    AssignMatrix.SETRANGE("Employee No", HREmp."No."); //Added
                                    AssignMatrix.SETRANGE("Payroll Period", DateSpecified);
                                    AssignMatrix.CALCSUMS("Employer Amount");

                                    GenJnline.INIT();
                                    LineNumber := LineNumber + 10;
                                    GenJnline."Journal Template Name" := 'GENERAL';
                                    GenJnline."Journal Batch Name" := 'NETPAY';
                                    GenJnline."Line No." := GenJnline."Line No." + 10;
                                    GenJnline."Account No." := FringeAcc;
                                    GenJnline.VALIDATE("Account No.");
                                    GenJnline."Posting Date" := Payday;
                                    GenJnline.Description := Earn.Description + ': ' + HREmp."No." + ': ' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                                    GenJnline."Document No." := Noseries;
                                    //GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                                    GenJnline.Amount := -AssignMatrix."Employer Amount";
                                    // GenJnline."Currency Code" := 'KES';
                                    GenJnline.VALIDATE(Amount);
                                    //GenJnline."Employee Code":=AssignMatrix."Employee No";
                                    //TotalDebits:=TotalDebits+AssignMatrix.Amount;
                                    IF GenJnline.Amount <> 0 THEN
                                        GenJnline.INSERT();
                                UNTIL Earn.NEXT() = 0;
                            //     UNTIL HREmp.NEXT() = 0;
                            // END;

                            //================================================END FRINGE BENEFITS
                            //====================NET PAYABLE
                            NetPay := 0;

                            HREmp.CALCFIELDS(HREmp."Net pay");
                            NetPay := HREmp."Net Pay";
                            // MESSAGE('NetPay %1 ', NetPay);

                            GenJnline.INIT();
                            LineNumber := LineNumber + 10;
                            GenJnline."Journal Template Name" := 'GENERAL';
                            GenJnline."Journal Batch Name" := 'NETPAY';
                            GenJnline."Line No." := GenJnline."Line No." + 10;
                            GenJnline."Account No." := PayablesAcc;
                            GenJnline."Posting Date" := Payday;
                            // GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                            // GenJnline."Currency Code" := 'KES';
                            GenJnline.Description := 'Salaries Payable:' + FORMAT(DateSpecified, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                            GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//"Pay Period Filter"Mgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT("Pay Period Filter");
                            GenJnline.Amount := -NetPay;
                            GenJnline.VALIDATE(Amount);
                            //nJnline."Employee Code":=EmpRec."No.";
                            IF GenJnline.Amount <> 0 THEN
                                GenJnline.INSERT();
                        UNTIL HREmp.NEXT() = 0;
                    // MESSAGE('Transfer complete');



                end;

            }
        }

    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Datefilter; Datefilter)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Payroll Period';
                    //     ToolTip = 'this is date of period';
                    //     trigger OnLookup(var Text: Text): Boolean
                    //     begin
                    //         PayrollPeriod.Reset();
                    //         IF PAGE.RUNMODAL(52118, PayrollPeriod) = ACTION::LookupOK THEN
                    //             Datefilter := PayrollPeriod."Starting Date";
                    //     end;


                    // }
                    //     field(StaffFilter; StaffFilter)
                    //     {
                    //         ApplicationArea = all;
                    //         Caption = 'Staff No.';
                    //         TableRelation = Employee."No.";
                    //         ToolTip = 'this is date of period';
                    //     }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    trigger OnInitReport()
    begin

    end;


    trigger OnPreReport()
    begin
        PostingPeriod := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        Payperiodtext := Format(PostingPeriod, 0, '<Month Text,3> <Year4>');
        GetPeriodFilter := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");
        DateSpecified := "Employee Posting GroupX".GetRangeMin("Employee Posting GroupX"."Pay Period Filter");

        //if not PayrollMgt.CheckIfPayrollApproved(DateSpecified) then
        //   Error('%1 Payroll period needs to be approved first before transfering to journal', DateSpecified);
        //  PayrollMgt.CheckIfPayrollApproved(DateSpecified);

        if PayrollPeriod.Get(DateSpecified) then
            Payday := PayrollPeriod."Pay Date";

        if Payday = 0D then
            Error(Text002, DateSpecified);

        LineNumber := 0;
        TotalCount := 0;
        Counter := 0;

        GetCurrentPeriod();

        if PeriodStartDate <> PayrollPeriod."Starting Date" then
            if not Confirm(Text001, false) then
                CurrReport.Quit();

        AdjustPostingGr();

        Window.Open('Generating Entries: #1###############' +
                    'Progress : @2@@@@@@@@@@@@@@@');

        Window.Update(1, Payperiodtext);

        HRSetup.Get();
        HRSetup.TestField("Payroll Journal Template");
        HRSetup.TestField("Payroll Journal Batch");

        BatchTemplate := HRSetup."Payroll Journal Template";
        BatchName := HRSetup."Payroll Journal Batch";



        //Delete Journal Entries
        Batch.Init();
        Batch."Journal Template Name" := BatchTemplate;
        Batch.Name := BatchName;
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
            Batch.Insert();

        GenJnline.Reset();
        GenJnline.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnline.SETRANGE("Journal Batch Name", 'NETPAY');
        GenJnline.DELETEALL();



    end;


    trigger OnPostReport()
    var
        ConfirmOpenJournal: Label 'The Payroll Journal for %1 has been Generated to Template %3 - Batch %2. Do you want to Open the Journal? ';

    begin


        //Window.Close();

        if Confirm(ConfirmOpenJournal, false, Payperiodtext, 'GENERAL', 'NETPAY') then
            if Batch.Get('GENERAL', 'NETPAY') then
                GenJnlManagement.TemplateSelectionFromBatch(Batch);
    end;

    var
        BasicAmount: Decimal;
        payrollproject: Record "Payroll Project Allocation";
        Text001: Label 'You are about to transfer the payroll summary for the wrong period, you want to continue?';
        Text002: Label 'The pay date must be specified for the period %1';

        PayrollMgt: Codeunit Payroll;
        Counter: Integer;
        LastFieldNo: Integer;

        TotalCount: Integer;
        PostingPeriod: Date;
        Window: Dialog;
        GenJnlManagement: Codeunit GenJnlManagement;
        BatchTemplate: Code[20];
        StaffFilter: Code[20];
        HREmp: Record Employee;
        Company: Record "Company Information";

        NetPay: Decimal;
        RightBracket: Boolean;
        Companyz: Code[10];
        "Posting Date": Date;
        BatchName: Text[30];
        DocumentNo: Code[10];
        Description: Text[30];
        Amount: Decimal;
        "G/LAccount": Code[10];
        TotalncomeTax: Decimal;
        GrossPay: Decimal;
        Totalgross: Decimal;
        TotalNetPay: Decimal;
        TotalBasic: Decimal;


        TaxAccount: Code[10];
        SalariesAcc: Code[10];
        PayablesAcc: Code[10];
        FringeAcc: Code[10];
        First: Code[10];
        Last: Code[10];
        EmployeeTemp: Record Employee;
        Found: Boolean;
        TotalSSF: Decimal;
        DateSpecified: Date;
        Payperiodtext: Text[30];
        TransferLoans: Boolean;
        BasicSalary: Decimal;
        PAYE: Decimal;
        CompRec: Record 5218;
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        GetPeriodFilter: Date;
        ActivityRec: Record 349;
        EarningsCopy: Record Earnings;
        LoanApp: Record Loaner;
        // EmpAccMap : Record empl
        // EmpAccMap : Record 5;
        // PGMapping : Record 51511043;
        Deduction: Record Deductions;
        GLSetup: Record "General Ledger Setup";
        Dim2Value: Record "Dimension Value";
        Dim3Value: Record "Dimension Value";
        // DimMgt : Codeunit 408;
        DimSetEntry: Record 480;
        DimSetEntry2: Record 480;
        //Imprestheader : Record 51511003;
        saladno: Integer;
        vendrec: Record 23;
        employers: Decimal;
        LoanProductType1: Record "Loan Product Type-Payroll";
        Emp: Record 5200;
        AssignMatrix: Record "Assignment Matrix";
        Ded: Record Deductions;
        Ded2: Record Deductions;
        Earn: Record Earnings;
        EmpRec: Record Employee;
        PostingGroup: Record "Employee HR Posting Group";
        Batch: Record "Gen. Journal Batch";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnline: Record "Gen. Journal Line";
        HRSetup: Record "Human Resources Setup";
        LoanProductType: Record "Loan Product Type-Payroll";
        PayrollPeriod: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpGroup: Code[10];
        TaxCode: Code[10];
        Noseries: Code[50];
        Datefilter: Date;
        Payday: Date;
        PeriodStartDate: Date;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        TotalCredits: Decimal;
        TotalDebits: Decimal;
        TotalInterest: Decimal;
        LineNumber: Integer;
        JName: Text[10];
        MonDate: Text[10];

    procedure AdjustPostingGr()
    begin
        if AssignMatrix.Find('-') then
            repeat
                if EmpRec.Get(AssignMatrix."Employee No") then
                    AssignMatrix."Posting Group Filter" := EmpRec."Posting Group";
                AssignMatrix.Modify();
            until AssignMatrix.Next() = 0;
    end;

    procedure GetCurrentPeriod()
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.SetRange(PayPeriodRec.Closed, false);
        if PayPeriodRec.Find('-') then
            PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure GetPayPeriod(var PayPeriods: Record "Payroll Period")
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Brackets";
        Employee: Record Employee;
        EndTax: Boolean;
        Tax: Decimal;
        TotalTax: Decimal;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;

        TaxTable.SetRange("Table Code", TaxCode);

        if TaxTable.Find('-') then
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next() = 0) or EndTax = true;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax?" then
            IncomeTax := 0;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "Human Resources Setup";
    begin

        HRsetup.Get();
        if HRsetup."Payroll Rounding Precision" = 0 then
            Error('You must specify the rounding precision under HR setup');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    // procedure GetTaxBracket(VAR TaxableAmount : Decimal)
    // begin

    // end;
}