table 60001 "Grant PV Lines"
{

    fields
    {
        field(1; "PV No"; Code[20])
        {
            TableRelation = "Grant Payments";

            trigger OnValidate()
            begin
                /*
                PV.RESET;
                IF PV.GET("PV No") THEN
                 BEGIN
                  IF PV."Account Type"=PV."Account Type"::Vendor THEN
                   BEGIN
                    "Account Type":="Account Type"::Vendor;
                    "Account No":=PV."Account No.";
                    "Account Name":=PV."Account Name";
                   END ELSE
                  IF PV."Account Type"=PV."Account Type"::Customer THEN
                   BEGIN
                    "Account Type":="Account Type"::Customer;
                    "Account No":=PV."Account No.";
                    "Account Name":=PV."Account Name";
                   END ELSE
                   BEGIN
                    "Account Type":="Account Type"::"G/L Account";
                    "Account No":='';
                   END;
                 END;
                */

            end;
        }
        field(2; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(3; "Account No"; Code[100])
        {
            Caption = 'Account No.';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else if ("Account Type" = const(Customer)) Customer else if ("Account Type" = const(Vendor)) Vendor else if ("Account Type" = const("Bank Account")) "Bank Account" else if ("Account Type" = const("Fixed Asset")) "Fixed Asset" else if ("Account Type" = const("IC Partner")) "IC Partner";

            trigger OnValidate()
            begin



                if "Account Type" in ["Account Type"::"G/L Account", "Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner"]
                then
                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                GLAcc.Get("Account No");
                                "Account Name" := GLAcc.Name;
                                if not GLAcc."Direct Posting" then
                                    Error('You cannot select a control account');

                            end;
                        "Account Type"::Customer:
                            begin
                                Cust.Get("Account No");
                                "Account Name" := Cust.Name;
                                CustBank.Reset();
                                CustBank.SetRange("Customer No.", Cust."No.");
                                if CustBank.FindFirst() then begin
                                    "KBA Branch Code" := CustBank."Bank Branch No.";
                                    "Bank Account No" := CustBank."Bank Account No.";
                                end;
                                //For Staff
                                /* EmpMap.RESET;
                                EmpMap.SETRANGE("Customer A/c", "Account No");
                                EmpMap.SETFILTER("Employee No.", '<>%1', '');
                                EmpMap.SETRANGE("Loan Type", 'IMPREST');
                                IF EmpMap.FIND('-') THEN BEGIN
                                    IF Empl.GET(EmpMap."Employee No.") THEN BEGIN
                                        "KBA Branch Code" := Empl."Bank Code" + Empl."Bank Branch Code";
                                        "Bank Account No" := Empl."Bank Account No";
                                    END;
                                END; */
                            end;
                        "Account Type"::Vendor:
                            begin
                                Vend.Get("Account No");
                                "Account Name" := Vend.Name;
                                VendBank.Reset();
                                VendBank.SetRange("Vendor No.", Vend."No.");
                                if VendBank.FindFirst() then begin
                                    "KBA Branch Code" := VendBank."Bank Branch No.";
                                    "Bank Account No" := VendBank."Bank Account No.";
                                end;
                            end;
                        "Account Type"::"Bank Account":
                            begin
                                BankAcc.Get("Account No");
                                "Account Name" := BankAcc.Name;

                            end;
                        "Account Type"::"Fixed Asset":
                            begin
                                FA.Get("Account No");
                                "Account Name" := FA.Description;

                            end;
                    end;
            end;
        }
        field(4; "Account Name"; Text[150])
        {
        }
        field(5; Description; Text[130])
        {
        }
        field(6; Amount; Decimal)
        {

            trigger OnValidate()
            var
            //pvheader: Record "Request Header";
            begin
                /*{
                IF ("Applies to Doc. No"<>'') AND (xRec.Amount<>0) THEN
                  IF xRec.Amount < Rec.Amount THEN
                    BEGIN
                      ERROR('You can not pay more than the Invoice Amount');
                    END;
                }
                VALIDATE("Applies to Doc. No");
                CSetup.GET;
                CSetup.TESTFIELD("Rounding Precision");
                IF CSetup."Rounding Type"=CSetup."Rounding Type"::Up THEN
                   Direction:='>'
                 ELSE IF CSetup."Rounding Type"=CSetup."Rounding Type"::Nearest THEN
                   Direction:='='
                 ELSE IF CSetup."Rounding Type"=CSetup."Rounding Type"::Down THEN
                   Direction:='<';
                CASE "Account Type" OF
                "Account Type"::"G/L Account":
                 BEGIN
                 //Check for Retention
                 IF "Retention Code"<>'' THEN BEGIN
                  IF GLAccount.GET("Account No") THEN
                   IF VATSetup.GET(GLAccount."VAT Bus. Posting Group","Retention Code") THEN BEGIN
                     IF VATSetup."VAT %"<>0 THEN BEGIN
                         RetAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                         NetAmount:=Amount-RetAmount;
                         "Retention Amount":=RetAmount;
                     END;
                    END;
                   END;
                 //End of Retention
                  IF "VAT Code"<>'' THEN BEGIN
                    IF GLAccount.GET("Account No") THEN
                      IF VATSetup.GET(GLAccount."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           VATAmount:=ROUND(((Amount/(1+VATSetup."VAT %"/100))*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                           NetAmount:=Amount-VATAmount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                           "Net Amount":=Amount-VATAmount
                           ELSE
                            "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF GLAccount.GET("Account No") THEN
                            IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                                IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END ELSE BEGIN
                          "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF GLAccount.GET("Account No") THEN
                            IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF GLAccount.GET("Account No") THEN
                      IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                      END;
                    END;
                  END;
                END;
                 "Account Type"::Customer:
                 BEGIN
                 //Check for Retention
                 IF "Retention Code"<>'' THEN BEGIN
                  IF Customer.GET("Account No") THEN
                   IF VATSetup.GET(Customer."VAT Bus. Posting Group","Retention Code") THEN BEGIN
                     IF VATSetup."VAT %"<>0 THEN BEGIN
                         RetAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                         NetAmount:=Amount-RetAmount;
                         "Retention Amount":=RetAmount;
                     END;
                    END;
                   END;
                 //End of Retention
                  IF "VAT Code"<>'' THEN BEGIN
                    IF Customer.GET("Account No") THEN
                      IF VATSetup.GET(Customer."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                         VATAmount:=ROUND(((Amount/(1+VATSetup."VAT %"/100))*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           NetAmount:=Amount-VATAmount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                              "Net Amount":=Amount-VATAmount
                              ELSE
                              "Net Amount":=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Customer.GET("Account No") THEN
                            IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                             IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END ELSE BEGIN
                           "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Customer.GET("Account No") THEN
                            IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF Customer.GET("Account No") THEN
                      IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                      END;
                    END;
                  END;
                END;
                { "Account Type"::Vendor:
                 BEGIN
                 //Check for Retention
                 IF "Retention Code"<>'' THEN BEGIN
                  IF Vendor.GET("Account No") THEN
                   IF VATSetup.GET(Vendor."VAT Bus. Posting Group","Retention Code") THEN BEGIN
                     IF VATSetup."VAT %"<>0 THEN BEGIN
                         RetAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                         NetAmount:=Amount-RetAmount;
                         "Retention Amount":=RetAmount;
                
                     END;
                    END;
                   END;
                 //End of Retention
                  IF "VAT Code"<>'' THEN BEGIN
                    IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           VATAmount:=ROUND(((Amount/(1+VATSetup."VAT %"/100))*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                           NetAmount:=Amount-VATAmount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                           "Net Amount":=Amount-VATAmount
                           ELSE
                           "Net Amount":=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND((Amount-"VAT Amount")*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END ELSE BEGIN
                         "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(Amount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(Amount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                      END;
                    END;
                  END;
                 END;}
                
                "Account Type"::Vendor:
                 BEGIN
                 //Check for Retention
                 IF "Retention Code"<>'' THEN BEGIN
                  IF Vendor.GET("Account No") THEN
                   IF VATSetup.GET(Vendor."VAT Bus. Posting Group","Retention Code") THEN BEGIN
                     IF VATSetup."VAT %"<>0 THEN BEGIN
                         //*RetAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);  //25-Feb-2021
                         RetAmount:=ROUND((Amount*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                         NetAmount:=Amount-RetAmount;
                         "Net Amount":="Net Amount"-RetAmount;
                         "Retention Amount":=RetAmount;
                
                     END;
                    END;
                   END;
                 //End of Retention
                  IF "VAT Code"<>'' THEN BEGIN
                    IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                         VATAmount:=ROUND((Amount*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);//JAN1321
                        //   VATAmount:=ROUND(((Amount/(1+VATSetup."VAT %"/100))*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                //MESSAGE('Amount is %1,vat is %2,percentage is %3',Amount,VATAmount,VATSetup."VAT %");
                           NetAmount:=Amount-VATAmount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                           "Net Amount":=Amount-VATAmount
                           ELSE
                           "Net Amount":=Amount-"Retention Amount";//*25-Feb-2021
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND((Amount-"VAT Amount")*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount")-"Retention Amount";   //*25-Feb-2021
                             END;
                           END;
                         END ELSE BEGIN
                         "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(Amount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(Amount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-("W/TAmount"+"W/VAT Amount");
                      END;
                    END;
                  END;
                 END;
                "Account Type"::"Bank Account":
                 "Net Amount":=Amount;
                END;
                
                //IF "Account Type" IN ["Account Type"::"Bank Account"] THEN
                  //BEGIN
                    PV.GET(Rec."PV No");
                    IF PV."Exchange Rate"<>0 THEN
                      "Amount(LCY)":=Amount*PV."Exchange Rate"
                    ELSE
                      "Amount(LCY)":=Amount;
                  //END ELSE
                    //"Amount(LCY)":=NetAmount;
                
                    VALIDATE("Net Amount");
                    */

                /*
                IF ("Applies to Doc. No"<>'') AND (xRec.Amount<>0) THEN
                  IF xRec.Amount < Rec.Amount THEN
                    BEGIN
                      ERROR('You can not pay more than the Invoice Amount');
                    END;
                */
                Validate("Applies to Doc. No");
                CSetup.Get();
                CSetup.TestField("Rounding Precision");
                if CSetup."Rounding Type" = CSetup."Rounding Type"::Up then
                    Direction := '>'
                else if CSetup."Rounding Type" = CSetup."Rounding Type"::Nearest then
                    Direction := '='
                else if CSetup."Rounding Type" = CSetup."Rounding Type"::Down then
                    Direction := '<';
                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            //Check for Retention
                            if "Retention Code" <> '' then
                                if GLAccount.Get("Account No") then
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", "Retention Code") then
                                        if VATSetup."VAT %" <> 0 then begin
                                            RetAmount := Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - RetAmount;
                                            "Retention Amount" := RetAmount;
                                        end;
                            //End of Retention
                            if "VAT Code" <> '' then begin
                                if GLAccount.Get("Account No") then
                                    if VATSetup.Get(GLAccount."VAT Bus. Posting Group", "VAT Code") then
                                        if VATSetup."VAT %" <> 0 then begin
                                            VATAmount := Round(((Amount / (1 + VATSetup."VAT %" / 100)) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            else
                                                "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                            if "W/Tax Code" <> '' then
                                                if GLAccount.Get("Account No") then
                                                    if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        else
                                                            "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                                    end;
                                        end else begin
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            if "W/Tax Code" <> '' then
                                                if GLAccount.Get("Account No") then
                                                    if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                                    end;
                                        end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then
                                    if GLAccount.Get("Account No") then
                                        if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                        end;
                            end;
                        end;
                    "Account Type"::Customer:
                        begin
                            //Check for Retention
                            if "Retention Code" <> '' then
                                if Customer.Get("Account No") then
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "Retention Code") then
                                        if VATSetup."VAT %" <> 0 then begin
                                            RetAmount := Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - RetAmount;
                                            "Retention Amount" := RetAmount;
                                        end;
                            //End of Retention
                            if "VAT Code" <> '' then begin
                                if Customer.Get("Account No") then
                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "VAT Code") then begin
                                        VATAmount := Round(((Amount / (1 + VATSetup."VAT %" / 100)) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        if VATSetup."VAT %" <> 0 then begin
                                            NetAmount := Amount - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            else
                                                "Net Amount" := Amount;
                                            if "W/Tax Code" <> '' then
                                                if Customer.Get("Account No") then
                                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        else
                                                            "Net Amount" := Amount - "W/TAmount";
                                                    end;
                                        end else begin
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            if "W/Tax Code" <> '' then
                                                if Customer.Get("Account No") then
                                                    if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                                    end;
                                        end;
                                    end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then
                                    if Customer.Get("Account No") then
                                        if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                        end;
                            end;
                        end;
                    "Account Type"::Vendor:
                        begin
                            //Check for Retention
                            if "Retention Code" <> '' then
                                if Vendor.Get("Account No") then
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "Retention Code") then
                                        if VATSetup."VAT %" <> 0 then begin
                                            RetAmount := Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - RetAmount;
                                            "Retention Amount" := RetAmount;

                                        end;
                            //End of Retention
                            if "VAT Code" <> '' then begin
                                if Vendor.Get("Account No") then
                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "VAT Code") then
                                        if VATSetup."VAT %" <> 0 then begin
                                            VATAmount := Round(((Amount / (1 + VATSetup."VAT %" / 100)) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            else
                                                "Net Amount" := Amount;
                                            if "W/Tax Code" <> '' then
                                                if Vendor.Get("Account No") then
                                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round((Amount - "VAT Amount") * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        if CSetup."Post VAT" then//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        else
                                                            "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                                    end;
                                        end else begin
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            if "W/Tax Code" <> '' then
                                                if Vendor.Get("Account No") then
                                                    if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                                        "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                                    end;
                                        end;
                            end
                            else begin
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                if "W/Tax Code" <> '' then
                                    if Vendor.Get("Account No") then
                                        if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code") then begin
                                            "W/TAmount" := Round(Amount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - ("W/TAmount" + "W/VAT Amount");
                                        end;
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        "Net Amount" := Amount;
                end;

                /*//IF "Account Type" IN ["Account Type"::"Bank Account"] THEN
                  //BEGIN
                    PV.GET(Rec."PV No");
                    IF PV."Exchange Rate"<>0 THEN
                      "Amount(LCY)":=Amount*PV."Exchange Rate"
                    ELSE
                      "Amount(LCY)":=Amount;
                  //END ELSE
                    //"Amount(LCY)":=NetAmount;
                    */
                Validate("Net Amount");

            end;
        }
        field(7; Grouping; Code[10])
        {
        }
        field(8; "Shortcut Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            FieldClass = Normal;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; "Applies to Doc. No"; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup()
            begin

                "Applies to Doc. No" := '';
                Amt := 0;
                VATAmount := 0;
                "W/TAmount" := 0;


                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            CustLedger.Reset();
                            CustLedger.SetCurrentKey(CustLedger."Customer No.", Open, "Document No.");
                            CustLedger.SetRange(CustLedger."Customer No.", "Account No");
                            CustLedger.SetRange(Open, true);
                            CustLedger.SetRange(Positive, false);
                            CustLedger.CalcFields(CustLedger.Amount);
                            if Page.RunModal(0, CustLedger) = Action::LookupOK then
                                if CustLedger."Applies-to ID" <> '' then begin
                                    CustLedger1.Reset();
                                    CustLedger1.SetCurrentKey(CustLedger1."Customer No.", Open, "Applies-to ID");
                                    CustLedger1.SetRange(CustLedger1."Customer No.", "Account No");
                                    CustLedger1.SetRange(Open, true);
                                    CustLedger1.SetRange("Applies-to ID", CustLedger."Applies-to ID");
                                    CustLedger.SetRange(Positive, false);
                                    if CustLedger1.Find('-') then
                                        repeat
                                            CustLedger1.CalcFields(CustLedger1."Remaining Amount");
                                            Amt := Amt + Abs(CustLedger1."Remaining Amount");
                                        until CustLedger1.Next() = 0;

                                    if Amt <> Amt then
                                        //ERROR('Amount is not equal to the amount applied on the application form');
                                        if Amount = 0 then
                                            Amount := Amt;
                                    Validate(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";
                                    "Applies-to Doc. Type" := CustLedger."Document Type";
                                end else begin
                                    if Amount <> Abs(CustLedger.Amount) then
                                        CustLedger.CalcFields(CustLedger."Remaining Amount");
                                    if Amount = 0 then
                                        Amount := Abs(CustLedger."Remaining Amount");
                                    Validate(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";
                                    "Applies-to Doc. Type" := CustLedger."Document Type";
                                end;
                            Validate(Amount);
                        end;

                    "Account Type"::Vendor:
                        begin
                            VendLedger.Reset();
                            VendLedger.SetCurrentKey(VendLedger."Vendor No.", Open, "Document No.");
                            VendLedger.SetRange(VendLedger."Vendor No.", "Account No");
                            VendLedger.SetRange(Open, true);
                            VendLedger.SetRange(Positive, false);
                            VendLedger.CalcFields("Remaining Amount");
                            if Page.RunModal(0, VendLedger) = Action::LookupOK then
                                if VendLedger."Applies-to ID" <> '' then begin
                                    //MESSAGE(FORMAT(VendLedger.Description));
                                    VendLedger1.Reset();
                                    VendLedger1.SetCurrentKey(VendLedger1."Vendor No.", Open, "Applies-to ID");
                                    VendLedger1.SetRange(VendLedger1."Vendor No.", "Account No");
                                    VendLedger.SetRange(Positive, false);
                                    VendLedger1.SetRange(Open, true);
                                    VendLedger1.SetRange(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                                    if VendLedger1.Find('-') then
                                        repeat
                                            VendLedger1.CalcFields(VendLedger1."Remaining Amount");
                                            NetAmount := NetAmount + Abs(VendLedger1."Remaining Amount");

                                        until VendLedger1.Next() = 0;

                                    if NetAmount <> NetAmount then
                                        //ERROR('Amount is not equal to the amount applied on the application form');
                                        if Amount = 0 then
                                            Amount := NetAmount;

                                    Validate(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";
                                    "Applies-to Doc. Type" := VendLedger."Applies-to Doc. Type";
                                    //MESSAGE('ewewew');
                                    //Added to Autopopulate the Invoice Description
                                    Description := VendLedger.Description;
                                    VendLedgEntry.Reset();
                                    VendLedgEntry.SetRange("Document No.", "Applies to Doc. No");
                                    if VendLedgEntry.FindFirst() then;
                                    // MESSAGE('ewewew2 %1',"Applies to Doc. No");
                                    //Transactionref:='RBA-'+VendLedgEntry."External Document No.";
                                end else begin
                                    if Amount <> Abs(VendLedger."Remaining Amount") then
                                        VendLedger.CalcFields(VendLedger."Remaining Amount");
                                    if Amount = 0 then
                                        Amount := Abs(VendLedger."Remaining Amount");
                                    Validate(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";
                                    //ERROR(VendLedgEntry."External Document No.");

                                    //Added to Autopopulate the Invoice Description

                                    Description := VendLedger.Description;

                                    VendLedgEntry.Reset();
                                    VendLedgEntry.SetRange("Document No.", "Applies to Doc. No");
                                    if VendLedgEntry.FindFirst() then;
                                    // MESSAGE('ewewew2 %1',"Applies to Doc. No");
                                    // Transactionref:='ERC-'+VendLedgEntry."External Document No.";

                                end;
                            Amount := Abs(VendLedger."Remaining Amount");
                            PPInv.Reset();
                            if PPInv.Get("Applies to Doc. No") then begin
                                PPInv.CalcFields("Amount Including VAT", Amount); //MESSAGE('..');
                                "Gross Amount" := Round(PPInv."Amount Including VAT", 1, '>');
                                "VAT Amount" := "Gross Amount" - PPInv.Amount;
                                Validate("Gross Amount");
                            end;
                            Validate(Amount);
                        end;
                end;
            end;

            trigger OnValidate()
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
            begin
                RoundingDirection := '>';
                RoundingPrecision := 1;
                VATAmountToCalc := 0;
                //MESSAGE('Description');
                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            CustLedger.Reset();
                            CustLedger.SetRange("Customer No.", "Account No");
                            CustLedger.SetRange(Open, true);
                            CustLedger.SetRange("Document No.", "Applies to Doc. No");
                            if CustLedger.Find('-') then begin
                                "Applies-to Doc. Type" := CustLedger."Document Type";
                                //Added to Autopopulate the Invoice Description
                                Description := VendLedger.Description;
                            end;

                        end;

                    "Account Type"::Vendor:
                        begin
                            VendLedger.Reset();
                            VendLedger.SetRange("Vendor No.", "Account No");
                            VendLedger.SetRange(Open, true);
                            VendLedger.SetRange("Document No.", "Applies to Doc. No");
                            if VendLedger.Find('-') then begin
                                "Applies-to Doc. Type" := VendLedger."Document Type";
                                Description := VendLedger.Description;

                                VendLedgEntry.CalcFields("Remaining Amount");
                                PPInv.Reset();
                                if PPInv.Get("Applies to Doc. No") then begin
                                    PPInv.CalcFields("Amount Including VAT", Amount); //MESSAGE('..');
                                    "Gross Amount" := Round(PPInv."Amount Including VAT", 1, '>');

                                    "VAT Amount" := Round(VATAmountToCalc, 1, '>');
                                    Validate("Account No");

                                end;

                            end;

                        end;
                end;


                ObjectPostedInvoice.Reset();
                ObjectPostedInvoice.SetRange(ObjectPostedInvoice."Document No.", "Applies to Doc. No");
                if ObjectPostedInvoice.Find('-') then
                    "Dimension Set ID" := ObjectPostedInvoice."Dimension Set ID";
                /*
                 IF ObjectPostedInvoice.GET("Applies to Doc. No") THEN BEGIN
                   REPEAT
                     "Dimension Set ID":=ObjectPostedInvoice."Dimension Set ID";
                     UNTIL ObjectPostedInvoice.NEXT=0;
                     END;*/

            end;
        }
        field(12; "Claim No"; Code[20])
        {
        }
        field(13; "Benefit ID"; Code[20])
        {
        }
        field(14; "Claimant ID"; Integer)
        {
        }
        field(15; "Policy No"; Code[20])
        {
        }
        field(16; "Amt Premium Currency"; Decimal)
        {
        }
        field(17; "Amt Reporting Currency"; Decimal)
        {
        }
        field(18; Underwriter; Code[20])
        {
            TableRelation = Vendor where("Vendor Type-Grants" = const(Law));
        }
        field(19; "Policy Type"; Code[20])
        {
        }
        field(20; "Claim Line Line No"; Integer)
        {
        }
        field(21; "Patients Name"; Text[250])
        {
        }
        field(22; Insured; Text[30])
        {
        }
        field(23; "Client Type"; Text[30])
        {
        }
        field(24; "Plan Type"; Text[130])
        {
        }
        field(25; Provider; Text[130])
        {
        }
        field(26; Payee; Text[130])
        {
        }
        field(27; "Date of Service"; Date)
        {
        }
        field(28; Diagnosis; Text[250])
        {
        }
        field(29; "ICD10 Code"; Code[10])
        {
        }
        field(30; "Notification date"; Date)
        {
        }
        field(31; "Date settled"; Date)
        {
        }
        field(32; "External Reference"; Code[20])
        {
        }
        field(33; YOA; Code[10])
        {
        }
        field(34; ChequeNo; Code[20])
        {
        }
        field(35; "Pay member"; Decimal)
        {
        }
        field(36; "Pay Provider"; Decimal)
        {
        }
        field(37; "Denial Reason Code"; Code[10])
        {
        }
        field(38; "Denial Statement"; Text[150])
        {
            FieldClass = Normal;
        }
        field(39; "Payment Frequency"; Code[20])
        {
        }
        field(40; "Premium Due Date"; Date)
        {
        }
        field(41; Tax; Boolean)
        {
        }
        field(42; "Bal. Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(43; "Bal. Account No."; Code[30])
        {
        }
        field(44; "KBA Branch Code"; Code[20])
        {
            //TableRelation = "Staff  Bank Account".Code;
        }
        field(45; "Bank Account No"; Code[250])
        {
        }
        field(46; "W/VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                if "W/VAT Code" = '' then
                    if "W/VAT Amount" <> 0 then begin
                        "Net Amount" := "Net Amount" + "W/VAT Amount";
                        "W/VAT Amount" := 0;
                    end;
                Validate(Amount);
                "WVAT%" := 0;
                if "W/VAT Code" <> '' then
                    if "Account Type" = "Account Type"::Vendor then begin
                        Vendor.Get("Account No");
                        VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/VAT Code");
                        if VATSetup."VAT %" = 0 then
                            exit
                        else
                            "WVAT%" := VATSetup."VAT %";
                        // MESSAGE(FORMAT("WVAT%"));
                    end;

                if "Account Type" = "Account Type"::"G/L Account" then begin
                    GLAccount.Get("Account No");
                    VATSetup.Get(GLAccount."VAT Bus. Posting Group", "W/VAT Code");
                    if VATSetup."VAT %" = 0 then
                        exit else
                        "WVAT%" := VATSetup."VAT %";
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Get("Account No");
                    VATSetup.Get(Customer."VAT Bus. Posting Group", "W/VAT Code");
                    if VATSetup."VAT %" = 0 then
                        exit else
                        "WVAT%" := VATSetup."VAT %";
                end;

                "VATCode%" := 0;
                if "VAT Code" <> '' then begin
                    if "Account Type" = "Account Type"::"G/L Account" then begin
                        GLAccount.Get("Account No");
                        VATSetup.Get(GLAccount."VAT Bus. Posting Group", "VAT Code");

                        "VATCode%" := VATSetup."VAT %";
                    end;

                    if "Account Type" = "Account Type"::Vendor then begin
                        Vendor.Get("Account No");
                        VATSetup.Get(Vendor."VAT Bus. Posting Group", "VAT Code");

                        "VATCode%" := VATSetup."VAT %";

                        if "Account Type" = "Account Type"::Customer then begin
                            Customer.Get("Account No");
                            VATSetup.Get(Customer."VAT Bus. Posting Group", "VAT Code");
                            "VATCode%" := VATSetup."VAT %";
                        end;
                    end;
                end;
                if (("WVAT%" <> 0) and ("VATCode%" <> 0)) then
                    "W/VAT Amount" := Round("VAT Amount" * ("WVAT%" / 100) / ("VATCode%" / 100), 0.01, '<');
                "Net Amount" := (Amount - ("W/TAmount" + "W/VAT Amount"));
            end;
        }
        field(47; "VAT Amount"; Decimal)
        {
        }
        field(48; "W/VAT Amount"; Decimal)
        {
        }
        field(49; "Net Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                // IF "Currency Factor"<>0 THEN
                //  "Amount(LCY)":="Net Amount"/"Currency Factor"
                //  ELSE
                //   "Amount(LCY)":="Net Amount";

                if "Currency Factor" <> 0 then
                    "Amount(LCY)" := Amount / "Currency Factor"
                else
                    "Amount(LCY)" := Amount;
            end;
        }
        field(50; "Loan No"; Code[20])
        {
        }
        field(51; "Asset No"; Code[20])
        {
            TableRelation = "Fixed Asset";
        }
        field(52; "Amount(LCY)"; Decimal)
        {
        }
        field(53; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(54; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(55; "Retention Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(56; "Retention Amount"; Decimal)
        {
        }
        field(57; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(58; "Global Dimension 3 Code"; Code[50])
        {
            Caption = 'Sub Item Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(59; "Sub Department"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(0));
        }
        field(60; "PAYE Code"; Code[20])
        {
            //TableRelation = "PAYEE SETUPS";

            trigger OnValidate()
            begin

                /* IF PAY.GET("PAYE Code") THEN BEGIN
                    "PAYE %" := PAY.PAYEE;
                    VALIDATE(Amount);
                END; */
            end;
        }
        field(61; "PAYE Amount"; Decimal)
        {
        }
        field(62; "PAYE %"; Decimal)
        {
        }
        field(63; "W/Tax Amount"; Decimal)
        {
        }
        field(64; "W/Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                if "W/Tax Code" = '' then
                    if "W/Tax Amount" <> 0 then begin
                        "Net Amount" := "Net Amount" + "W/Tax Amount";
                        "W/Tax Amount" := 0;
                    end;
                Validate(Amount);
                "WVAT%" := 0;
                if "W/VAT Code" <> '' then
                    if "Account Type" = "Account Type"::Vendor then begin
                        Vendor.Get("Account No");
                        VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/VAT Code");
                        if VATSetup."VAT %" = 0 then
                            exit
                        else
                            "WVAT%" := VATSetup."VAT %";
                        Message(Format("WVAT%"));
                    end;

                if "Account Type" = "Account Type"::"G/L Account" then begin
                    GLAccount.Get("Account No");
                    VATSetup.Get(GLAccount."VAT Bus. Posting Group", "W/VAT Code");
                    if VATSetup."VAT %" = 0 then
                        exit else
                        "WVAT%" := VATSetup."VAT %";
                end;

                if "Account Type" = "Account Type"::Customer then begin
                    Customer.Get("Account No");
                    VATSetup.Get(Customer."VAT Bus. Posting Group", "W/VAT Code");
                    if VATSetup."VAT %" = 0 then
                        exit else
                        "WVAT%" := VATSetup."VAT %";
                end;

                "VATCode%" := 0;
                if "VAT Code" <> '' then begin
                    if "Account Type" = "Account Type"::"G/L Account" then begin
                        GLAccount.Get("Account No");
                        VATSetup.Get(GLAccount."VAT Bus. Posting Group", "VAT Code");

                        "VATCode%" := VATSetup."VAT %";
                    end;

                    if "Account Type" = "Account Type"::Vendor then begin
                        Vendor.Get("Account No");
                        VATSetup.Get(Vendor."VAT Bus. Posting Group", "VAT Code");

                        "VATCode%" := VATSetup."VAT %";

                        if "Account Type" = "Account Type"::Customer then begin
                            Customer.Get("Account No");
                            VATSetup.Get(Customer."VAT Bus. Posting Group", "VAT Code");
                            "VATCode%" := VATSetup."VAT %";
                        end;
                    end;
                end;
                if (("WVAT%" <> 0) and ("VATCode%" <> 0)) then
                    "W/VAT Amount" := Round("VAT Amount" * ("WVAT%" / 100) / ("VATCode%" / 100), 1, '>');
                "Net Amount" := (Amount - ("W/TAmount" + "W/VAT Amount"));
            end;
        }
        field(65; "Bank Account"; Code[20])
        {
        }
        field(66; Activity; Code[20])
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
        field(67; "Activity Type___"; Option)
        {
            OptionCaption = ',WorkPlan,P&E';
            OptionMembers = ,WorkPlan,"P&E";
        }
        field(100; "Activity Type"; Option)
        {
            OptionCaption = ',WorkPlan,Admin & PE,Proc Plan';
            OptionMembers = ,WorkPlan,"Admin & PE","Proc Plan";
        }
        field(101; "Current Budget"; Code[100])
        {
            TableRelation = "G/L Budget Name";
        }
        field(102; "Available Amount"; Decimal)
        {
        }
        field(103; "PE Allowed"; Boolean)
        {
        }
        field(104; Activity_; Code[20])
        {
        }
        field(105; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), "Dimension Value Type" = filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
                //"Dimension Set ID" := DimMgt.ValidateShortcutDimValues(1,"Global Dimension 1 Code","Dimension Set ID");
            end;
        }
        field(106; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), "Dimension Value Type" = filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50000; "Investment Asset No."; Code[20])
        {
            //TableRelation = Table51405306;
        }
        field(50001; "Investment Transaction Type"; Option)
        {
            OptionCaption = ' ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Other Income,Expenses,Principal';
            OptionMembers = " ",Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,"Share-split",Premium,Discounts,"Other Income",Expenses,Principal;
        }
        field(50004; "Insurance Trans Type"; Option)
        {
            OptionCaption = ' ,Premium,Commission,Tax,Wht,Excess,Claim Reserve,Claim Payment,Reinsurance Premium,Reinsurance Commission,Reinsurance Premium Taxes,Reinsurance Commission Taxes,Net Premium,Claim Recovery,Salvage,Reinsurance Claim Reserve,Reinsurance Recovery Payment ,Accrued Reinsurance Premium,Deposit Premium,XOL Adjustment Premium';
            OptionMembers = " ",Premium,Commission,Tax,Wht,Excess,"Claim Reserve","Claim Payment","Reinsurance Premium","Reinsurance Commission","Reinsurance Premium Taxes","Reinsurance Commission Taxes","Net Premium","Claim Recovery",Salvage,"Reinsurance Claim Reserve","Reinsurance Recovery Payment ","Accrued Reinsurance Premium","Deposit Premium","XOL Adjustment Premium";
        }
        field(50005; "Instalment Plan No."; Integer)
        {
        }
        field(50006; "Treaty Code"; Code[30])
        {
        }
        field(50007; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(50008; "Treaty Addendum"; Integer)
        {
        }
        field(50009; "XOL Layer"; Code[10])
        {
        }
        field(50010; "No. of Units"; Decimal)
        {
        }
        field(50011; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := "No. of Units" * "Unit Price";
                Validate(Amount);
            end;
        }
        field(50012; "Employee No"; Code[30])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No") then
                    "Account Name" := Empl.FullName();
            end;
        }
        field(50013; "Gross Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                Amount := "Gross Amount";
                Validate(Amount);
                //=========================added by Mike=========
                // IF "Net Amount"=0 THEN
                //  MESSAGE('yes');
                //"Net Amount":="Gross Amount"-"W/VAT Amount";

                //VALIDATE(Amount);
                Validate("Applies to Doc. No");
            end;
        }
        field(50014; "VAT 6"; Code[10])
        {
            //TableRelation = "Tarriff Codes";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(50015; "VAT6 Amount"; Decimal)
        {
        }
        field(50016; "VATABLE Amount"; Decimal)
        {
        }
        field(50517; "Branch Name"; Text[250])
        {
        }
        field(50518; "Bank Name"; Code[250])
        {
        }
        field(50519; "From Imprest"; Boolean)
        {
        }
        field(50520; Commitno; Code[50])
        {
        }
        field(50521; Transactionref; Code[60])
        {
        }
        field(50522; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                if "Currency Code" = xRec."Currency Code" then
                    UpdateCurrencyFactor();

                if "Currency Code" <> xRec."Currency Code" then
                    UpdateCurrencyFactor()
                else
                    if "Currency Code" <> '' then
                        UpdateCurrencyFactor();
            end;
        }
        field(50523; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50524; "Currency Reciprical"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50525; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 4 : 4;

            trigger OnValidate()
            begin
                if "Currency Factor" <> 0 then
                    "Amount(LCY)" := "Net Amount" / "Currency Factor"
                else
                    "Amount(LCY)" := Amount;
            end;
        }
        field(50526; "Grant No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50527; "Job-Planning Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job-Planning Line"."Line No." where("Grant No." = field("Grant No"));
        }
        field(50528; "Job No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Jobs."No.";

            trigger OnValidate()
            begin
                CheckWipAccount();
            end;
        }
        field(50529; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            DataClassification = ToBeClassified;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            begin
                /*
                IF "Job Task No." <> xRec."Job Task No." THEN
                  VALIDATE("Job Planning Line No.",0);
                IF "Job Task No." = '' THEN BEGIN
                  "Job Quantity" := 0;
                  "Job Currency Factor" := 0;
                  "Job Currency Code" := '';
                  "Job Unit Price" := 0;
                  "Job Total Price" := 0;
                  "Job Line Amount" := 0;
                  "Job Line Discount Amount" := 0;
                  "Job Unit Cost" := 0;
                  "Job Total Cost" := 0;
                  "Job Line Discount %" := 0;
                
                  "Job Unit Price (LCY)" := 0;
                  "Job Total Price (LCY)" := 0;
                  "Job Line Amount (LCY)" := 0;
                  "Job Line Disc. Amount (LCY)" := 0;
                  "Job Unit Cost (LCY)" := 0;
                  "Job Total Cost (LCY)" := 0;
                  EXIT;
                END;
                
                IF JobTaskIsSet THEN BEGIN
                  CreateTempJobJnlLine;
                  UpdatePricesFromJobJnlLine;
                END;
                */

            end;
        }
    }

    keys
    {
        key(Key1; "PV No", "Line No")
        {
            Clustered = true;
            SumIndexFields = Amount, "Net Amount";
        }
        key(Key2; Tax)
        {
            SumIndexFields = Amount, "Net Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Payments.Get("PV No") then
            if Payments.Posted then
                Error('You cannot delete the line at this stage');
        /*
        IF "Loan No" <>''
          THEN BEGIN
           IF  RequestHeader.GET("Loan No") THEN
             RequestHeader."Attached to PV No":='';
           RequestHeader.MODIFY;
            END;*/

        if Payments.Get("PV No") then
            if Payments.Status <> Payments.Status::Open then
                Error('You cannot delete the line at this stage');

    end;

    trigger OnInsert()
    begin

        CashMngt.Get();
        GLSetup.Get();
        "Current Budget" := CashMngt."Current Budget";

        /* IF ReqHeader."Employee No" <> '' THEN BEGIN
            //Allow some PE to Non-Finance Dept People
            CASE "Activity Type" OF
                "Activity Type"::"Admin & PE":
                    BEGIN
                        AdminPlan.RESET;
                        AdminPlan.SETRANGE(AdminPlan.Code, CashMngt."Current Budget");
                        //AdminPlan.SETRANGE(AdminPlan."Global Dimension 1 Code",ReqHeader."Global Dimension 1 Code");
                        //AdminPlan.SETRANGE(AdminPlan."Global Dimension 2 Code",ReqHeader."Global Dimension 2 Code");//CashMngt."Finance Code");
                        IF AdminPlan.FIND('-') THEN
                            "PE Allowed" := TRUE;
                        TempPEApp.RESET;
                        TempPEApp.SETRANGE(TempPEApp."Employee No", ReqHeader."Employee No");
                        TempPEApp.SETRANGE(TempPEApp."Doc Request No", ReqHeader."No.");
                        TempPEApp.SETRANGE(TempPEApp.Archived, FALSE);
                        TempPEApp.SETRANGE(TempPEApp.Approved, TRUE);
                        IF TempPEApp.FIND('-') THEN BEGIN
                            AdminPlan.RESET;
                            AdminPlan.SETRANGE(AdminPlan.Code, CashMngt."Current Budget");
                            AdminPlan.SETRANGE(AdminPlan."PE Activity Code", TempPEApp."PE Code");
                            IF AdminPlan.FIND('+') THEN BEGIN
                                "PE Allowed" := TRUE;
                                // "Global Dimension 1 Code":=AdminPlan."Global Dimension 1 Code";
                                //"Global Dimension 2 Code":=AdminPlan."Global Dimension 2 Code";
                            END;
                        END;
                    END;
            END;

        END; */

        if Payments.Get("PV No") then begin

            if Payments.Posted then
                Error('You cannot delete the line at this stage');


            if Payments.Status <> Payments.Status::Open then
                Error('You cannot Add Lines at this stage');
            if Payments."Vendor No" <> '' then begin
                "Account Type" := "Account Type"::Vendor;
                "Account No" := Payments."Vendor No";
            end;
        end;
        PHead.Reset();
        PHead.SetRange(PHead.No, "PV No");
        if PHead.FindFirst() then begin

            Validate("Shortcut Dimension 1 Code", PHead."Global Dimension 1 Code");
            Validate("Shortcut Dimension 2 Code", PHead."Global Dimension 2 Code");
            //VALIDATE("Shortcut Dimension 3 Code",PHead."Shortcut Dimension 3 Code");
            //VALIDATE("Shortcut Dimension 4 Code",PHead."Shortcut Dimension 4 Code");
            "Dimension Set ID" := PHead."Dimension Set ID";
            "Currency Code" := PHead.Currency;
            "Currency Factor" := PHead."Exchange Factor";
            "Bank Account No" := PHead."Bank Account No";
            "Bank Name" := PHead."Bank Name";

        end;
    end;

    trigger OnModify()
    begin
        if Payments.Get("PV No") then
            if Payments.Posted then
                Error('You cannot delete the line at this stage');
        if Payments.Status <> Payments.Status::Open then;
        //  ERROR('You cannot modify the line at this stage');

    end;

    trigger OnRename()
    begin
        if Payments.Get("PV No") then
            if Payments.Posted then
                Error('You cannot rename the lines at this stage');
        /*
        IF Payments.GET("PV No") THEN
        IF Payments.Status<>Payments.Status::Open THEN
        ERROR('You cannot rename the line at this stage');
        */

    end;

    var
        BankAcc: Record "Bank Account";
        CashMngt: Record "Cash Management Setup";
        CSetup: Record "Cash Management Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        Customer: Record Customer;
        CustBank: Record "Customer Bank Account";
        //AdminPlan: Record "Procurement Plan Header";
        //ReqHeader: Record "Request Header";
        //TempPEApp: Record "PE Temp Approval";
        //ProcurementPlan: Record Earnings;
        //ImpRates: Record "Imprest Rates";
        //PostRec: Record Counties;
        Empl: Record Employee;
        FA: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        //WorkPlan: Record "Work Plans";
        GLAccount: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        Payments: Record "Grant Payments";
        //EmpMap: Record "Employee Account Mapping";
        PHead: Record "Grant Payments";
        PPInv: Record "Purch. Inv. Header";
        ObjectPostedInvoice: Record "Purch. Inv. Line";
        VATSetup: Record "VAT Posting Setup";
        Vend: Record Vendor;
        Vendor: Record Vendor;
        VendBank: Record "Vendor Bank Account";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedger: Record "Vendor Ledger Entry";
        VendLedger1: Record "Vendor Ledger Entry";
        DimMgt: Codeunit DimensionManagement;
        //TariffCodes: Record "Tarriff Codes";
        Amt: Decimal;
        NetAmount: Decimal;
        RetAmount: Decimal;
        VATAmount: Decimal;
        VATAmountToCalc: Decimal;
        "VATCode%": Decimal;
        "W/TAmount": Decimal;
        "WVAT%": Decimal;
        RoundingPrecision: Integer;
        RoundingDirection: Text;
        Direction: Text[30];

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
        //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin

        /* "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "PV No", "Line No"),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code"); */
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure FnRoundAmountToTheNearestOne(var AmountToRound: Decimal; var RoundUp: Text; RoundingPrecision: Integer): Decimal
    var
        AmountReturned: Decimal;
    begin
        AmountReturned := 0;
        AmountToRound := 0;
        RoundingPrecision := 1;

        RoundUp := '>';
        AmountReturned := Round(AmountToRound, RoundingPrecision, RoundUp);
        exit(AmountReturned);
    end;

    procedure CheckWipAccount()
    begin
        /*FAWIPJob.GET("Job No.");
        FAWIPJobPostingGrp.GET(FAWIPJob."Job Posting Group");
        TESTFIELD("Account Type","Account Type"::"G/L Account");
        IF "Account No."<>FAWIPJobPostingGrp."WIP Costs Account" THEN
        ERROR('Insert the right WIP Account %1',FAWIPJobPostingGrp."WIP Costs Account");
        */

    end;

    local procedure UpdateCurrencyFactor()
    var
        CurrencyDate: Date;
    begin
        if "Currency Code" <> '' then begin
            CurrencyDate := PHead.Date;
            //"Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;
}

