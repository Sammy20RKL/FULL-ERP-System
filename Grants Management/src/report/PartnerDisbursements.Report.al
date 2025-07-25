report 60001 "Partner Disbursements"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/PartnerDisbursements.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = const(Project));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(USERID; UserId)
            {
            }
            column(Jobs__No__; "No.")
            {
            }
            column(UPPERCASE_Description_; UpperCase(Description))
            {
            }
            column(JobCaption; JobCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PARTER_DISBURSEMENTSCaption; PARTER_DISBURSEMENTSCaptionLbl)
            {
            }
            column(Project_NameCaption; Project_NameCaptionLbl)
            {
            }
            column(Project_CodeCaption; Project_CodeCaptionLbl)
            {
            }
            dataitem(ProjectPartners; "Project Partners")
            {
                DataItemTableView = sorting(PartnerID, "Grant No");
                column(UPPERCASE__Partner_Name__; UpperCase("Partner Name"))
                {
                }
                column(ProjectPartners_PartnerID; PartnerID)
                {
                }
                column(Partner_NameCaption; Partner_NameCaptionLbl)
                {
                }
                column(Partner_CodeCaption; Partner_CodeCaptionLbl)
                {
                }
                column(ProjectPartners_Grant_No; "Grant No")
                {
                }
                dataitem(Payment_line; "Grant PV Lines")
                {
                    DataItemLink = "Account No" = field(PartnerID);
                    DataItemTableView = sorting("PV No", "Line No");
                    column(Payment_Line_No; Payment_line."PV No")
                    {
                    }
                    column(Payment_Line__NetAmount_LCY_; Payment_line."Gross Amount")
                    {
                    }
                    column(Payment_Line_Amount; Amount)
                    {
                    }
                    column(Payment_Line__VAT_Amount_; "VAT Amount")
                    {
                    }
                    column(DisbursedAmount; DisbursedAmount)
                    {
                    }
                    column(TotalOutstanding; TotalOutstanding)
                    {
                    }
                    column(Voucher_NumberCaption; Voucher_NumberCaptionLbl)
                    {
                    }
                    column(Net_Amount__LCY_Caption; Net_Amount__LCY_CaptionLbl)
                    {
                    }
                    column(Transaction_DateCaption; Transaction_DateCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(VAT_Amount__LCY_Caption; VAT_Amount__LCY_CaptionLbl)
                    {
                    }
                    column(Total_DisbursementsCaption; Total_DisbursementsCaptionLbl)
                    {
                    }
                    column(BalanceCaption; BalanceCaptionLbl)
                    {
                    }
                    column(Payment_Line_Account_No_; "Account No")
                    {
                    }
                    column(Payment_Line_Grant_No; "Grant No")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /*
                        //==================================================Compute outstanding amount===========================================
                        TotalOutstanding:=0;
                        DisbursedAmount:=0;
                        
                        //+++++++++++++++++++++++Get sum of all posted receipts from this donor++++++++++++++++++++++++++++++++++++++
                        PaymentLine.SETFILTER(PaymentLine."Grant No",'<>%1','');
                        PaymentLine.SETRANGE(PaymentLine.Status,PaymentLine.Status::Posted);
                        PaymentLine.SETRANGE(PaymentLine."Grant No","Payment Line"."Grant No");
                        PaymentLine.SETRANGE(PaymentLine."Account No.","Payment Line"."Account No.");
                        IF PaymentLine.FIND('-') THEN
                        REPEAT
                        DisbursedAmount:=DisbursedAmount +PaymentLine."NetAmount LCY";
                        UNTIL PaymentLine.NEXT=0;
                        //+++++++++++++++++++++++Get sum of all posted payments to this partner for this project++++++++++++++++++++++++++++++++++++++
                        //ERROR(FORMAT(DisbursedAmount));
                        //+++++++++++++++++++++++Get expected disbursement to this partner for this project++++++++++++++++++++++++++++++++++++++
                        Projpartners.RESET;
                        Projpartners.SETRANGE(Projpartners."Grant No","Payment Line"."Grant No");
                        Projpartners.SETRANGE(Projpartners.PartnerID,"Payment Line"."Account No.");
                        //++++++++++++++++++++++++End Get expected disbursement to this partner for this project++++++++++++++++++++++++++++++++++++++
                        IF Projpartners.FIND('-') THEN
                        Projpartners.CALCFIELDS(Projpartners."Partner Budget");
                        
                        //++++++++++++++++++++++++Compute Outstanding Amount++++++++++++++++++++++++++++++
                        TotalOutstanding:=Projpartners."Partner Budget" - DisbursedAmount;
                        //++++++++++++++++++++++++Compute Outstanding Amount++++++++++++++++++++++++++++++
                        
                        
                        //==================================================Compute outstanding amount===========================================
                         */

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    /*
                    ProjectPartners.CALCFIELDS(ProjectPartners."Partner Budget");
                    ProjectPartners.CALCFIELDS(ProjectPartners."Disbursed Amount (LCY)");

                    ProjectPartners.Balance:=ProjectPartners."Partner Budget"-ProjectPartners."Disbursed Amount (LCY)";
                    */

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DisbursedAmount: Decimal;
        TotalOutstanding: Decimal;
        AmountCaptionLbl: Label 'Amount';
        BalanceCaptionLbl: Label 'Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        JobCaptionLbl: Label 'Job';
        Net_Amount__LCY_CaptionLbl: Label 'Net Amount (LCY)';
        PARTER_DISBURSEMENTSCaptionLbl: Label 'PARTER DISBURSEMENTS';
        Partner_CodeCaptionLbl: Label 'Partner Code';
        Partner_NameCaptionLbl: Label 'Partner Name';
        Project_CodeCaptionLbl: Label 'Project Code';
        Project_NameCaptionLbl: Label 'Project Name';
        Total_DisbursementsCaptionLbl: Label 'Total Disbursements';
        Transaction_DateCaptionLbl: Label 'Transaction Date';
        VAT_Amount__LCY_CaptionLbl: Label 'VAT Amount (LCY)';
        Voucher_NumberCaptionLbl: Label 'Voucher Number';
}

