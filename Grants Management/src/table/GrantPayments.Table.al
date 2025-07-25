table 60000 "Grant Payments"
{

    fields
    {
        field(1; No; Code[20])
        {
            trigger OnValidate()
            begin

                // IF No <> xRec.No THEN BEGIN
                //  GenLedgerSetup.GET;
                //  IF "Payment Type"="Payment Type"::Normal THEN BEGIN
                //    //IF NOT "Board Payment"  THEN
                //      NoSeriesMgt.TestManual(GenLedgerSetup."Payments No");
                //      END;
                //      END;



            end;
        }
        field(2; Date; Date)
        {

            trigger OnValidate()
            begin
                // IF Status=Status::Released THEN BEGIN
                // ERROR('You cannot change the date at this stage');
                // EXIT;
                // change the property so that it cannot be change after the document is released;
                //END
            end;
        }
        field(3; Type; Code[20])
        {
            TableRelation = "Grant Receipt and Payment Type".Code where(Type = filter(Payment));

            trigger OnValidate()
            begin
                "Account No." := '';
                "Account Name" := '';
                Remarks := '';

                if RecPayTypes.Get(Type, RecPayTypes.Type::Payment) then begin
                    Grouping := RecPayTypes."Default Grouping";
                    "Account Type" := RecPayTypes."Account Type";
                    "Transaction Name" := RecPayTypes.Description;




                    if RecPayTypes."Account Type" = RecPayTypes."Account Type"::"G/L Account" then
                        if RecPayTypes."G/L Account" <> '' then begin
                            "Account No." := RecPayTypes."G/L Account";
                            Validate("Account No.");
                        end;


                end;

                //VALIDATE("Account No.");
            end;
        }
        field(4; "Pay Mode"; Code[30])
        {
            NotBlank = true;
            //TableRelation = "Pay Modes".Code;

            trigger OnValidate()
            begin
                if BankAcc.Get("Paying Bank Account") then begin
                    Currency := BankAcc."Currency Code";
                    "Bank Name" := BankAcc.Name;
                    Validate(Currency);
                    Validate(Amount);
                    if "Pay Mode" = 'CHEQUE' then
                        //"Cheque No":=BankAcc."Last Check No.";
                        Modify();
                end;
            end;
        }
        field(5; "Cheque No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Pay Mode" = 'CHEQUE' then begin
                    if "Cheque No" <> '' then
                        ValidateChequeNo("Cheque No");

                    PVRec.Reset();
                    PVRec.SetRange("Cheque No", "Cheque No");
                    PVRec.SetRange("Paying Bank Account", "Paying Bank Account");
                    PVRec.SetFilter(Status, '<>%1', PVRec.Status::Rejected);
                    if PVRec.Find('-') then
                        if Confirm('Are you sure you want to reuse this cheque number for another payment?', false) then begin
                            PVRec."Cheque No" := PVRec."Cheque No" + 'R';
                            PVRec.Modify();
                        end else
                            Error('Cheque No %1 has already been used in Payment %2! for bank account %3', PVRec."Cheque No", PVRec.No, PVRec."Paying Bank Account");
                end;
            end;
        }
        field(6; "Cheque Date"; Date)
        {
        }
        field(7; "Cheque Type"; Code[20])
        {
            //TableRelation = "Cheque Types";
        }
        field(8; "KBA Bank Code"; Code[20])
        {
            //TableRelation = "Staff  Bank Account".Code;
        }
        field(9; "Received From"; Text[100])
        {
        }
        field(10; "On Behalf Of"; Text[100])
        {
        }
        field(11; Cashier; Code[50])
        {
        }
        field(12; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(13; "Account No."; Code[20])
        {
            Caption = 'Account No.';

            trigger OnValidate()
            begin
                "Account Name" := '';
                RecPayTypes.Reset();
                RecPayTypes.SetRange(RecPayTypes.Code, Type);
                RecPayTypes.SetRange(RecPayTypes.Type, RecPayTypes.Type::Payment);

                if "Account Type" in ["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner", "Account Type"::"Bank Account"]
                then
                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                GLAcc.Get("Account No.");
                                "Account Name" := GLAcc.Name;
                                "VAT Code" := RecPayTypes."VAT Code";
                                "Withholding Tax Code" := RecPayTypes."Withholding Tax Code";
                                "Global Dimension 1 Code" := '';
                                Payee := "Account Name";
                            end;
                        "Account Type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                "Account Name" := Cust.Name;
                                //"VAT Code":=Cust."Default VAT Code";
                                //"Withholding Tax Code":=Cust."Default Withholding Tax Code";
                                //"Global Dimension 1 Code":=Cust."Global Dimension 1 Code";
                                Payee := "Account Name";
                            end;
                        "Account Type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                "Account Name" := Vend.Name;
                                //"VAT Code":=Vend."Default VAT Code";
                                //"Withholding Tax Code":=Vend."Default Withholding Tax Code";
                                //"Global Dimension 1 Code":=Vend."Global Dimension 1 Code";
                                Payee := "Account Name";

                            end;
                        "Account Type"::"Bank Account":
                            begin
                                BankAcc.Get("Account No.");
                                "Account Name" := BankAcc.Name;
                                Payee := "Account Name";
                                // "VAT Code":=RecPayTypes."VAT Code";
                                // "Withholding Tax Code":=RecPayTypes."Withholding Tax Code";
                                // "Global Dimension 1 Code":=BankAcc."Global Dimension 1 Code";

                            end;
                        "Account Type"::"Fixed Asset":
                            begin
                                FA.Get("Account No.");
                                "Account Name" := FA.Description;
                                Payee := "Account Name";
                                //"VAT Code":=FA."Default VAT Code";
                                //"Withholding Tax Code":=FA."Default Withholding Tax Code";
                                // "Global Dimension 1 Code":=FA."Global Dimension 1 Code";

                            end;
                    end;
                Payee := "Account Name";
                Validate(Payee);
            end;
        }
        field(14; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(15; "Account Name"; Text[150])
        {
        }
        field(16; Posted; Boolean)
        {
            Editable = true;
        }
        field(17; "Date Posted"; Date)
        {
        }
        field(18; "Time Posted"; Time)
        {
        }
        field(19; "Posted By"; Code[50])
        {
        }
        field(20; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                // "Amount (LCY)":=CurrExchRate.ExchangeAmtFCYToLCY(Date,Currency,Amount,"Exchange Factor");
                /* IF Tarriff.GET("Withholding Tax Code") THEN
                 BEGIN
                  "Withholding Tax Amount":=(Tarriff.Percentage/100)*Amount;
                  "Net Amount":=Amount-"Withholding Tax Amount";
                 END;*/

            end;
        }
        field(21; Remarks; Text[100])
        {
        }
        field(22; "Transaction Name"; Text[100])
        {
        }
        field(23; "VAT Code"; Code[20])
        {
            //TableRelation = "Tarriff Codes";
        }
        field(24; "Withholding Tax Code"; Code[20])
        {
            //TableRelation = "Tarriff Codes";

            trigger OnValidate()
            begin
                /*IF Tarriff.GET("Withholding Tax Code") THEN
                 BEGIN
                // MESSAGE('gETS HERE');
                  "Withholding Tax Amount":=(Tarriff.Percentage/100)*Amount;
                  "Net Amount":=Amount-"Withholding Tax Amount";
                 END;*/


            end;
        }
        field(25; "VAT Amount"; Decimal)
        {
        }
        field(26; "Withholding Tax Amount"; Decimal)
        {
        }
        field(27; "Net Amount"; Decimal)
        {
        }
        field(28; "Paying Bank Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bank Account"."No." where("Currency Code" = field(Currency));

            trigger OnValidate()
            begin
                if BankAcc.Get("Paying Bank Account") then begin

                    if No = '' then
                        if BankAcc."Payments No" <> '' then begin
                            if ("Payment Type" = "Payment Type"::Normal) and not ("Transaction Type" = "Transaction Type"::InterBank) then begin
                                BankAcc.TestField(BankAcc."Payments No");
                                NoSeriesMgt.InitSeries(BankAcc."Payments No", xRec."No. Series", 0D, No, "No. Series");
                            end
                        end
                        else begin
                            GenLedgerSetup.Get();
                            if ("Payment Type" = "Payment Type"::Normal) and not ("Transaction Type" = "Transaction Type"::InterBank) then
                                if not "Board Payment" then begin
                                    GenLedgerSetup.TestField(GenLedgerSetup."Payments No");
                                    NoSeriesMgt.InitSeries(GenLedgerSetup."Payments No", xRec."No. Series", 0D, No, "No. Series");
                                end else begin
                                    GenLedgerSetup.TestField(GenLedgerSetup."Board PV Nos");
                                    NoSeriesMgt.InitSeries(GenLedgerSetup."Board PV Nos", xRec."No. Series", 0D, No, "No. Series");
                                end

                            else begin
                                //GenLedgerSetup.TESTFIELD(GenLedgerSetup."Petty Cash Payments No");
                                //NoSeriesMgt.InitSeries(GenLedgerSetup."Petty Cash Payments No",xRec."No. Series",0D,No,"No. Series");
                                GenLedgerSetup.TestField(GenLedgerSetup."Petty Cash No");
                                NoSeriesMgt.InitSeries(GenLedgerSetup."Petty Cash No", xRec."No. Series", 0D, No, "No. Series");
                            end;
                        end;

                    /*GenLedgerSetup.TESTFIELD(GenLedgerSetup."Petty Cash No");
                    NoSeriesMgt.InitSeries(GenLedgerSetup."Petty Cash No",xRec."No. Series",0D,No,"No. Series");*/



                    Currency := BankAcc."Currency Code";
                    "Bank Name" := BankAcc.Name;
                    Validate(Currency);
                    Validate(Amount);
                    if "Pay Mode" = 'CHEQUE' then
                        if BankAcc."Last Check No." = '' then begin
                            PVRec.Reset();
                            PVRec.SetFilter(PVRec."Cheque No", '<>%1', '');
                            if PVRec.Find('+') then
                                BankAcc."Last Check No." := PVRec."Cheque No";
                            BankAcc.Modify();
                        end;
                    // MESSAGE('Last check no=%1',BankAcc."Last Check No.");
                    /*EVALUATE(VarInteger,BankAcc."Last Check No.");
                    "Cheque No":=FORMAT(VarInteger+1);
                    BankAcc."Last Check No.":="Cheque No";
                    BankAcc.MODIFY;*/
                    // MESSAGE('Last check no=%1',BankAcc."Last Check No.");
                end;

                if ("Transaction Type" = "Transaction Type"::InterBank) and ("Payment Type" = "Payment Type"::Normal) then
                    if No = '' then begin
                        GenLedgerSetup.TestField(GenLedgerSetup."InterBank Nos");
                        NoSeriesMgt.InitSeries(GenLedgerSetup."InterBank Nos", xRec."No. Series", 0D, No, "No. Series");

                    end;

            end;
        }
        field(29; Payee; Text[100])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Payee := UpperCase(Payee);
            end;
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(31; "Branch Code"; Code[20])
        {
        }
        field(32; "PO/INV No"; Code[20])
        {
        }
        field(33; "Bank Account No"; Code[20])
        {
        }
        field(34; "Cashier Bank Account"; Code[20])
        {
        }
        field(35; Status; Option)
        {
            Editable = true;
            Enabled = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;

            trigger OnValidate()
            begin
                if Status = Status::Released then begin

                    PaymentsRec.Reset();
                    PaymentsRec.SetRange(PaymentsRec.No, No);
                    if PaymentsRec.Find('-') then begin

                        UserSetup.Get(Cashier);
                        if UserSetup."E-Mail" <> '' then begin

                            Employee.Reset();
                            //Employee.SETRANGE(Employee."No.", UserSetup."Employee No.");
                            if Employee.Find('-') then
                                UserFirstName := Employee."First Name";

                            ObjApprovals.Reset();
                            ObjApprovals.SetRange(ObjApprovals."Document No.", PaymentsRec.No);
                            if ObjApprovals.FindSet() then
                                Approver := ObjApprovals."Last Modified By User ID";

                            VarEmailSubject := PaymentsRec.No + '  PV APPROVED';
                            VarEmailBody := 'Your PV ' + PaymentsRec.No + ' has been Approved by ' + Approver;

                            //FAWENotifications.FnSendStatementViaMail(UserFirstName, VarEmailSubject, VarEmailBody, UserSetup."E-Mail", '', '');

                            //MESSAGE('Leave applicant and reliever have been notified successfully');
                        end;
                    end;
                end;

                /*HRLeaveApp.SETRANGE(HRLeaveApp."Application No","Application No");
                IF HRLeaveApp.FIND('-')THEN
                BEGIN
                 // HRLeaveApp.CreateLeaveLedgerEntries;
                
                  HREmp.GET("Employee No");
                  HREmp.TESTFIELD("E-Mail");
                
                  ObjApprovals.RESET;
                  ObjApprovals.SETRANGE(ObjApprovals."Document No.",HRLeaveApp."Application No");
                  IF ObjApprovals.FINDSET THEN
                  BEGIN
                    Approver:=ObjApprovals."Last Modified By User ID";
                  END;
                
                  HRLeaveTypes.GET(HRLeaveApp."Leave Code");
                
                  IF HRLeaveApp."Days Applied" > 1 THEN
                    LeaveDaysText:=FORMAT(HRLeaveApp."Days Applied")+' days '
                  ELSE
                    LeaveDaysText:=FORMAT(HRLeaveApp."Days Applied")+' day ';
                
                  IF "Duties Taken Over By" <> '' THEN
                  BEGIN
                    HREmp2.GET("Duties Taken Over By");
                    ReleivedBy:=' relieved by ' + Name;
                    ReleiverEmail:=HREmp2."E-Mail";
                  END;
                
                  EmailCC:='MMuhwezi@fawe.org';
                  DED:='TOmondi@fawe.org';
                  FAD:='CMulogoli@fawe.org';
                  HRAO:='EMoraa@fawe.org';
                  IF ReleiverEmail <> '' THEN
                    EmailCC:=EmailCC+';'+ReleiverEmail+';'+DED+';'+FAD+';'+HRAO;
                
                  IF HRLeaveApp."Days Applied" > 1 THEN
                    LeavePeriod:='from '+FORMAT(HRLeaveApp."Start Date",0,'<Day,2> <Month Text,3> <Year4>')+' to '+
                                  FORMAT(HRLeaveApp."End Date",0,'<Day,2> <Month Text,3> <Year4>')
                  ELSE
                    LeavePeriod:='for '+FORMAT(HRLeaveApp."Start Date",0,'<Day,2> <Month Text,3> <Year4>');
                
                
                  VarEmailSubject:=HRLeaveApp."Leave Code" + ' LEAVE APPROVED - '+HRLeaveApp."Employee No";
                  VarEmailBody:='Your '+ LeaveDaysText + HRLeaveApp."Leave Code"+' Leave Application '+LeavePeriod + ReleivedBy +' has been Approved by '+ Approver +
                  '. You are expected to resume on '+FORMAT(HRLeaveApp."Resumption Date",0,'<Day,2> <Month Text,3> <Year4>')+'. '+'';//HRLeaveTypes."Signout Message";
                
                 FAWENotifications.FnSendStatementViaMail(HREmp."First Name",VarEmailSubject,VarEmailBody,HREmp."E-Mail",'',EmailCC);
                
                  MESSAGE('Leave applicant and reliever have been notified successfully');
                END*/

            end;
        }
        field(36; Select; Boolean)
        {
        }
        field(37; Grouping; Code[20])
        {
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group".Code else if ("Account Type" = const(Vendor)) "Vendor Posting Group".Code;
        }
        field(38; "Payment Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Purchase Requisition,Store Requisition,Imprest,Claim-Accounting,Appointment,Payment Voucher,Leave Application,Training Request,Transport Request,Recruitment Request,Telephone Request,Appraisal,Communication Requests,Legal Request,Visits to Utilities,Refund,Journal,Normal,Petty Cash';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",None,"Purchase Requisition","Store Requisition",Imprest,"Claim-Accounting",Appointment,"Payment Voucher","Leave Application","Training Request","Transport Request","Recruitment Request","Telephone Request",Appraisal,"Communication Requests","Legal Request","Visits to Utilities",Refund,Journal,Normal,"Petty Cash";

            trigger OnValidate()
            begin
                if BankAcc.Get("Paying Bank Account") then begin
                    Currency := BankAcc."Currency Code";
                    "Bank Name" := BankAcc.Name;
                    Validate(Currency);
                    Validate(Amount);
                    if "Pay Mode" = 'CHEQUE' then begin
                        "Cheque No" := BankAcc."Last Check No.";
                        Modify();
                    end;
                end;
            end;
        }
        field(39; "Bank Type"; Option)
        {
            OptionMembers = Normal,"Petty Cash";
        }
        field(40; "PV Type"; Option)
        {
            OptionMembers = Normal,Other;
        }
        field(41; "Apply to"; Code[20])
        {
        }
        field(42; "Apply to ID"; Code[20])
        {
        }
        field(43; "No of Units"; Decimal)
        {
        }
        field(44; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = const(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(45; Currency; Code[10])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                /* IF Currency<>'' THEN BEGIN
                   CurrExchRate.RESET;
                   CurrExchRate.SETRANGE(CurrExchRate."Currency Code",Currency);
                   CurrExchRate.SETRANGE(CurrExchRate."Starting Date",0D,TODAY);
                   IF CurrExchRate.FIND('+') THEN BEGIN
                    "Exchange Rate":=CurrExchRate."Relational Exch. Rate Amount";
                    IF CurrExchRate."Relational Exch. Rate Amount"<>0 THEN
                     "Exchange Factor":=CurrExchRate."Exchange Rate Amount"/CurrExchRate."Relational Exch. Rate Amount";

                   END;
                 END;*/

                /*IF PayLinesExist THEN BEGIN
                ERROR('You first need to delete the existing Payment lines before changing the Currency Code'
                );
                END ELSE BEGIN
                   "Paying Bank Account":='';
                   VALIDATE("Paying Bank Account");
                ENd*/
                if Currency = xRec.Currency then
                    UpdateCurrencyFactor();

                if Currency <> xRec.Currency then
                    UpdateCurrencyFactor()
                else
                    if Currency <> '' then
                        UpdateCurrencyFactor();

                //Update Payment Lines
                UpdateLines();

            end;
        }
        field(46; "Exchange Rate"; Decimal)
        {
        }
        field(47; "Amount (LCY)"; Decimal)
        {
            CalcFormula = sum("Grant PV Lines"."Amount(LCY)" where("PV No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Exchange Factor"; Decimal)
        {
        }
        field(49; "Cheque Printed"; Boolean)
        {
        }
        field(50; "Bank Name"; Text[250])
        {
            Editable = false;
        }
        field(51; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Grant PV Lines"."Net Amount" where("PV No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; "KBA Branch Code"; Code[20])
        {
            //TableRelation = "Staff  Bank Account"."Bank Branch No." WHERE(Code = FIELD("KBA Bank Code"));
        }
        field(53; "Base Amount"; Decimal)
        {
            CalcFormula = sum("Grant PV Lines".Amount where("PV No" = field(No), Tax = const(false)));
            FieldClass = FlowField;
        }
        field(54; "Transaction Type"; Option)
        {
            OptionCaption = 'Payments,Imprest,InterBank';
            OptionMembers = Payments,Imprest,InterBank;
        }
        field(55; "Imprest No"; Code[20])
        {
            //TableRelation = "Request Header";

            trigger OnValidate()
            begin
                /* IF ReaquestHeader.GET("Imprest No") THEN BEGIN

                END; */
            end;
        }
        field(56; Paid; Boolean)
        {
        }
        field(57; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vend.Get("Vendor No") then
                    Payee := Vend.Name;
            end;
        }
        field(59; Archived; Boolean)
        {
        }
        field(60; Institution; Text[30])
        {
        }
        field(61; "Investment No"; Code[20])
        {
        }
        field(62; "Investment Type"; Option)
        {
            OptionMembers = " ","Money Market",Property,Equity,Mortgage;
        }
        field(63; "Investment Transcation Type"; Option)
        {
            OptionMembers = " ",Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,"Share-split",Premium,Discounts,"Other Income",Expenses,Principal;
        }
        field(64; "Issue No."; Code[20])
        {
        }
        field(65; Rate; Decimal)
        {
        }
        field(66; "No. Printed"; Integer)
        {
        }
        field(67; Collected; Boolean)
        {
        }
        field(68; "Eft Generated"; Boolean)
        {
            Editable = true;
        }
        field(69; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,1,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(70; BoardMemberNo; Code[30])
        {
            TableRelation = Employee where("Employee Posting Group" = const('BOARD'));
        }
        field(71; "No of Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Table ID" = const(51511000), "Document No." = field(No)));
            FieldClass = FlowField;
        }
        field(72; CreditorInstitution; Code[30])
        {
            //TableRelation = Institution;
        }
        field(73; Source; Option)
        {
            OptionCaption = 'Payment Voucher,Imprest,Petty Cash Voucher,Claim';
            OptionMembers = "Payment Voucher",Imprest,"Petty Cash Voucher",Claim;
        }
        field(74; "Amount Paid"; Decimal)
        {
        }
        field(75; "Imprest Deadline"; Date)
        {
        }
        field(76; "Partial No."; Code[20])
        {
        }
        field(77; "Partial Line No."; Integer)
        {
        }
        field(78; "Petty Cash Total Amount"; Decimal)
        {
            //CalcFormula = Sum("Petty Cash Lines"."Net Amount" WHERE("PV No" = FIELD(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(80; "Board Payment"; Boolean)
        {
            Editable = false;
        }
        field(81; "Total Amount-Board"; Decimal)
        {
            CalcFormula = sum("Grant PV Lines".Amount where("PV No" = field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(82; "Bord PV No"; Code[30])
        {
        }
        field(83; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(84; "Claim No."; Code[50])
        {
        }
        field(85; Activity; Code[20])
        {

            trigger OnValidate()
            begin
                /*GLSetup.GET;
                
                CASE "Activity Type" OF
                 "Activity Type"::WorkPlan:
                  BEGIN
                  WorkPlan.RESET;
                  WorkPlan.SETRANGE(Code,Activity);
                  IF WorkPlan.FIND('-') THEN BEGIN
                    Activity:=WorkPlan.Code;
                    "Account Type":="Account Type"::"G/L Account";
                    "Account No":=WorkPlan."G/L Account";
                     VALIDATE("Account No");
                     Description:=WorkPlan.Name;
                    "Global Dimension 1 Code":=WorkPlan."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=WorkPlan."Global Dimension 2 Code";
                     "Available Amount":=WorkPlan.Amount;
                   END;
                  END;
                  "Activity Type"::"P&E":
                   BEGIN
                
                   AdminPlan.RESET;
                   AdminPlan.SETRANGE("PE Activity Code",Activity);
                   IF AdminPlan.FIND('-') THEN BEGIN
                    Activity:=AdminPlan."PE Activity Code";
                    "Account Type":="Account Type"::"G/L Account";
                    "Account No":=AdminPlan."G/L Account";
                     VALIDATE("Account No");
                     Description:=AdminPlan.Name;
                    "Global Dimension 1 Code":=AdminPlan."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=AdminPlan."Global Dimension 2 Code";
                    "Available Amount":=AdminPlan.Amount;
                   END;
                   END;
                 END;
                  */

            end;
        }
        field(86; "Activity Type"; Option)
        {
            OptionCaption = ',WorkPlan,P&E';
            OptionMembers = ,WorkPlan,"P&E";
        }
        field(50000; "Reason Code"; Code[10])
        {
            //TableRelation = reas
        }
        field(50001; Priority; Option)
        {
            OptionCaption = ' ,High,Medium,Low';
            OptionMembers = " ",High,Medium,Low;
        }
        field(50002; "No. Of Instalments"; Integer)
        {
        }
        field(50003; "Deal Number"; Code[20])
        {
        }
        field(50004; "Charge By"; Option)
        {
            OptionCaption = ' ,OUR,BEN,SHA';
            OptionMembers = " ",OUR,BEN,SHA;
        }
        field(50005; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50006; "Payee Bank account No."; Code[20])
        {
        }
        field(50007; "Bank Name and Branch"; Text[130])
        {
        }
        field(50008; "Cancellation Reason"; Text[130])
        {
        }
        field(50009; "No. Of signatories"; Integer)
        {
        }
        field(50010; "Bank Payment Type"; Option)
        {
            AccessByPermission = tabledata "Bank Account" = R;
            Caption = 'Bank Payment Type';
            Editable = false;
            OptionCaption = ' ,Computer Check,Manual Check,Electronic Payment,Electronic Payment-IAT';
            OptionMembers = " ","Computer Check","Manual Check","Electronic Payment","Electronic Payment-IAT";

            trigger OnValidate()
            begin
                /*
                IF ("Bank Payment Type" <> "Bank Payment Type"::" ") AND
                   ("Account Type" <> "Account Type"::"Bank Account") AND
                   ("Bal. Account Type" <> "Bal. Account Type"::"Bank Account")
                THEN
                  ERROR(
                    Text007,
                    FIELDCAPTION("Account Type"),FIELDCAPTION("Bal. Account Type"));
                IF ("Account Type" = "Account Type"::"Fixed Asset") AND
                   ("Bank Payment Type" <> "Bank Payment Type"::" ")
                THEN
                  FIELDERROR("Account Type");
                  */

            end;
        }
        field(50500; "PV Date"; Date)
        {
        }
        field(50501; Balance; Decimal)
        {
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Paying Bank Account")));
            FieldClass = FlowField;
        }
        field(50502; "Approval Status"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Table ID" = const(51511000)));
            FieldClass = FlowField;
        }
        field(50503; "Attachment Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50504; Vote; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No." where("Account Type" = const(Posting));
        }
        field(50505; "Voucher Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Voted Provision,Deposit and Suspense';
            OptionMembers = "Voted Provision","Deposit and Suspense";
        }
        field(50506; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');

        //IF Status<>Status::Open THEN

        Error('You cannot delete voucher');
    end;

    trigger OnInsert()
    begin
        "PV Date" := Today;
        GenLedgerSetup.Get();
        if "Payment Type" = "Payment Type"::Normal then
            if No = '' then begin
                if "Transaction Type" = "Transaction Type"::InterBank then begin


                    GenLedgerSetup.TestField(GenLedgerSetup."InterBank Nos");
                    NoSeriesMgt.InitSeries(GenLedgerSetup."InterBank Nos", xRec."No. Series", 0D, No, "No. Series");


                end else
                    GenLedgerSetup.TestField(GenLedgerSetup."Payments No");
                NoSeriesMgt.InitSeries(GenLedgerSetup."Payments No", xRec."No. Series", 0D, No, "No. Series");
            end;

        //Date:=TODAY;
        Cashier := UserId;
    end;

    trigger OnModify()
    begin
        // IF Posted=TRUE THEN
        // ERROR('The transaction has already been posted and therefore cannot be modified.');
        /*IF Status<>Status::Open THEN
        BEGIN
        ERROR('You cannot modify this voucher');
        END;
        */

    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('The transaction has already been posted and therefore cannot be modified.');
        /*
        IF Status<>Status::Open THEN
        ERROR('You cannot modify this voucher');
        */

    end;

    var
        //FAWENotifications: Codeunit "FAWE Notifications";
        ObjApprovals: Record "Approval Entry";
        BankAcc: Record "Bank Account";
        GenLedgerSetup: Record "Cash Management Setup";
        PurchSetup: Record "Cash Management Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        Employee: Record Employee;
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        PaymentsRec: Record "Grant Payments";
        PVRec: Record "Grant Payments";
        //Tarriff: Record "Tarriff Codes";
        PLine: Record "Grant PV Lines";
        PVLines: Record "Grant PV Lines";
        RecPayTypes: Record "Grant Receipt and Payment Type";
        UserSetup: Record "User Setup";
        Vend: Record Vendor;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SelectNoSeriesAllowed: Boolean;
        Approver: Code[50];
        LastLineNo: Integer;
        Text001: Label 'The Cheque Number length should be 5 or 6';
        UserFirstName: Text;
        VarEmailBody: Text;
        VarEmailSubject: Text;

    procedure CreateTaxes(var PV: Record "Grant Payments")
    var
        GenJnline: Record "Gen. Journal Line";
        PVlines: Record "Grant PV Lines";
    begin
        GenJnline.Reset();
        ;
        GenJnline.SetRange(GenJnline."Journal Template Name", 'GENERAL');
        GenJnline.SetRange(GenJnline."Journal Batch Name", 'ACCR-TAX');
        if GenJnline.Find('+') then
            LastLineNo := GenJnline."Line No.";


        PVlines.Reset();
        PVlines.SetRange(PVlines."PV No", PV.No);
        if PVlines.Find('-') then
            repeat
                LastLineNo := LastLineNo + 10000;
                GenJnline.Init();
                GenJnline."Journal Template Name" := 'GENERAL';
                GenJnline."Journal Batch Name" := 'ACCR-TAX';
                GenJnline."Line No." := LastLineNo;
                GenJnline."Account Type" := PVlines."Account Type";
                GenJnline."Account No." := PVlines."Account No";
                GenJnline."Posting Date" := PV.Date;
                GenJnline."Document No." := PVlines."PV No";
                GenJnline."External Document No." := PVlines."Applies to Doc. No";
                GenJnline.Description := 'VAT Withheld';
                GenJnline.Amount := PVlines."VAT Amount";
                GenJnline."Bal. Account Type" := GenJnline."Bal. Account Type"::"G/L Account";
                GenJnline."Bal. Account No." := '304000';
                if GenJnline.Amount <> 0 then
                    GenJnline.Insert();


                GenJnline.Init();
                LastLineNo := LastLineNo + 10000;
                GenJnline."Journal Template Name" := 'GENERAL';
                GenJnline."Journal Batch Name" := 'ACCR-TAX';
                GenJnline."Line No." := LastLineNo;
                GenJnline."Account Type" := PVlines."Account Type";
                GenJnline."Account No." := PVlines."Account No";
                GenJnline."Posting Date" := PV.Date;
                GenJnline."Document No." := PVlines."PV No";
                GenJnline."External Document No." := PVlines."Applies to Doc. No";
                GenJnline.Description := 'Tax Withheld';
                GenJnline.Amount := PVlines."W/VAT Amount";
                GenJnline."Bal. Account Type" := GenJnline."Bal. Account Type"::"G/L Account";
                GenJnline."Bal. Account No." := '307000';
                if GenJnline.Amount <> 0 then
                    GenJnline.Insert();



            until PVlines.Next() = 0;
    end;

    procedure ValidateChequeNo(ChequeNo: Code[10])
    var
        ChequeLength: Integer;
        FirstDigit: Text[1];
    begin
        FirstDigit := CopyStr(ChequeNo, 1, 1);
        /*
        IF FirstDigit='0' THEN
         ERROR(Text000);
        */

        //IF "Pay Mode"='CHEQUE' THEN BEGIN
        ChequeLength := StrLen(ChequeNo);
        if (ChequeLength < 5) or (ChequeLength > 6) then
            Error(Text001);
        //END;

    end;

    procedure ShowDimensions()
    begin
        /* "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1', No),
            "Global Dimension 1 Code", "Global Dimension 2 Code"); */
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ReqLinesExist(): Boolean
    begin
        PVLines.Reset();
        PVLines.SetRange("PV No", No);
        exit(PVLines.FindFirst());
    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if Currency <> '' then begin
            CurrencyDate := Date;
            //"Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
            "Exchange Factor" := CurrExchRate.ExchangeRate(CurrencyDate, Currency);
        end else
            "Exchange Factor" := 0;
    end;

    procedure UpdateLines()
    begin
        PLine.Reset();
        PLine.SetRange(PLine."PV No", No);
        if PLine.FindFirst() then
            repeat
                PLine."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";//"Shortcut Dimension 2 Code";
                                                                               //pLine."Shortcut Dimension 3 Code":="Shortcut Dimension 3 Code";
                PLine."Dimension Set ID" := "Dimension Set ID";
                // PLine."Currency Factor":="Currency Factor";
                PLine."Bank Account No" := "Paying Bank Account";
                // PayLine."Payment Type":="Payment Type";
                // PLine.VALIDATE("Currency Factor");
                PLine.Modify();
            until PLine.Next() = 0;
    end;

    procedure AssistEdit(OldPurchHeader: Record "Grant Payments"): Boolean
    begin
        PurchSetup.Get();
        TestNoSeries();
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldPurchHeader."No. Series", "No. Series") then begin
            PurchSetup.Get();
            TestNoSeries();
            NoSeriesMgt.SetSeries(No);
            exit(true);
        end;
        //51511018
    end;

    procedure TestNoSeries()
    begin
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
    begin

        NoSeriesCode := PurchSetup."Payments No";

        OnAfterGetNoSeriesCode(Rec, PurchSetup, NoSeriesCode);
        exit(NoSeriesMgt.GetNoSeriesWithCheck(NoSeriesCode, SelectNoSeriesAllowed, "No. Series"));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetNoSeriesCode(var PurchHeader: Record "Grant Payments"; PurchSetup: Record "Cash Management Setup"; var NoSeriesCode: Code[20])
    begin
    end;
}

