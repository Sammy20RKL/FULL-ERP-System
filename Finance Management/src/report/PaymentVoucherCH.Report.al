report 51050 "Payment Voucher CH"
{
    ApplicationArea = All;
    Caption = 'Payment Voucher';
    // DefaultRenderingLayout = "PV-CH";
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PV-CHNew.rdl';

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where("Payment Type" = filter("Payment Voucher" | Imprest));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", Date, "Cheque No", Payee;


            column(Posted_Date; "Posted Date")
            { }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(ISOCert; CompanyInfo."Registration No.")
            {
            }
            column(No_; "No.")
            {

            }
            column(Bank_Name; "Bank Name") { }
            column(Payee; Payee) { }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }
            column(Payment_Release_Date; "Payment Release Date") { }
            column(Total_Amount; "Total Amount") { }
            column(Total_Amount__LCY_; "Total Amount (LCY)") { }
            column(Exchange_Rate; "Exchange Rate") { }
            column(Currency; Currency) { }

            column(Currency_Factor; "Currency Factor") { }
            column(PreparedBySignature; PreparedBySignature)
            { }

            column(Status_Payments; Payments.Status)
            {
            }
            column(PaymentType_Payments; Payments."Payment Type")
            {
            }





            column(Number_In_Words; NumberText[1])
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(Vendor_Bank_Code; VendorBank.Code)
            {
            }
            column(Venodor_Bank_Account; VendorBank."Bank Account No.")
            {
            }
            column(Vendor_Bank; VendorBank.Name)
            {
            }
            column(Bank_Branch; VendorBank."Bank Branch No.")
            {
            }

            column(Branch_Name; VendorBank."Bank Branch Name")
            {
            }
            column(SWIFT_Code; VendorBank."SWIFT Code")
            {
            }
            column(PayeeTxt; PayeeTxt)
            {
            }
            column(ShortcutDimension1Code_Payments; PaymentLine."Shortcut Dimension 1 Code")
            {
            }

            column(HeaderDimValueName_1; HeaderDimValueCode[1])
            {
            }
            column(HeaderDimValueName_2; HeaderDimValueCode[2])
            {
            }
            column(HeaderDimValueName_3; HeaderDimValueCode[3])
            {
            }
            column(HeaderDimValueName_4; HeaderDimValueCode[4])
            {
            }
            column(HeaderDimValueName_5; HeaderDimValueCode[5])
            {
            }
            column(HeaderDimValueName_6; HeaderDimValueCode[6])
            {
            }
            column(HeaderDimValueName_7; HeaderDimValueCode[7])
            {
            }
            column(HeaderDimValueName_8; HeaderDimValueCode[8])
            {
            }
            column(Counter; Counter)
            {
            }
            column(PinNo; PinNo)
            {
            }
            column(VendAcNo; VendAcNo)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankName; BankName)
            {
            }
            column(SwiftCode; SwiftCode)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(Branch; Branch)
            {
            }
            column(VendAddress; VendAddress)
            {
            }
            column(ChequePayment; ChequePayment)
            {
            }
            column(ACKNOWLEDGEMENT_OF_RECEIPTCaptionLbl; ACKNOWLEDGEMENT_OF_RECEIPTCaptionLbl)
            {
            }
            column(ChequeCashRecievedByLbl; ChequeCashRecievedByLbl)
            {
            }
            column(IDNoPassportNoLbl; IDNoPassportNoLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(VarExchangeRate; VarExchangeRate)
            {

            }




            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");

                column(No_PVLines; "Payment Lines".No)
                {
                }
                column(Account_Name; "Account Name") { }
                column(Description; Description) { }
                column(Amount; Amount) { }
                column(Amount__LCY_; "Amount (LCY)") { }
                column(sspAmount; SSPAmount) { }
                column(USDAmount; USDAmount) { }
                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;

                    case "Payment Lines"."Account Type" of
                        "Payment Lines"."Account Type"::Customer:
                            begin
                                CustLedgerEntry.Reset();
                                CustLedgerEntry.SetRange("Applies-to ID", "Payment Lines"."Applies-to ID");
                                if CustLedgerEntry.Find('-') then
                                    InvoiceNo := CustLedgerEntry."Document No.";
                            end;
                        "Payment Lines"."Account Type"::Vendor:
                            begin
                                VendLedgerEntry.Reset();
                                VendLedgerEntry.SetRange("Document No.", "Payment Lines"."Applies-to ID");
                                if VendLedgerEntry.Find('-') then begin
                                    VendLedgerEntry2.Reset();
                                    VendLedgerEntry2.SetRange("Closed by Entry No.", VendLedgerEntry."Entry No.");
                                    if VendLedgerEntry2.Find('-') then
                                        InvoiceNo := CopyStr(VendLedgerEntry2."External Document No.", 1, MaxStrLen(InvoiceNo));
                                end;
                            end;
                    end;
                    SSPAmount := 0;
                    USDAmount := 0;
                    Payments.Reset();
                    Payments.SetRange("No.", No);
                    if Payments.Find('-') then
                        if (Payments.Currency = 'SSP-BMZ') or (Payments.Currency = 'SSP-BOSS') then begin
                            SSPAmount := "Payment Lines".Amount;
                        end;
                    //else
                    //     USDAmount := "Payment Lines".Amount / Payments."Currency Factor";
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = field("No.");

                column(DocumentType; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }

                column(RemainingAmount; "Vendor Ledger Entry"."Remaining Amount")
                {
                }

                column(AmounttoApply; "Vendor Ledger Entry"."Amount to Apply")
                {
                }
                column(DocumentDate; "Vendor Ledger Entry"."Document Date")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin

                if ((Payments."Payment Type" = Payments."Payment Type"::Imprest) and (Payments.Status <> Payments.Status::Released)) then
                    CurrReport.Skip();
                if Payments."Payment Type" = Payments."Payment Type"::Imprest then begin
                    PayeeTxt := Payments."On behalf of";
                    Payments.CalcFields("Imprest Amount");
                    AmountPaid := Payments."Imprest Amount";
                end else begin
                    PayeeTxt := Payments.Payee;
                    Payments.CalcFields("Total Net Amount");
                    AmountPaid := Payments."Total Amount (LCY)";
                end;
                Payments.CalcFields("Imprest Amount");
                PaymentMgt.InitTextVariable();
                //  PaymentMgt.FormatNoText(NumberText, AmountPaid, CopyStr(Currency, 2, 10));
                PaymentMgt.FormatNoText(NumberText, AmountPaid, CopyStr(Currency, 4, 10));


                if PaymentMethod.Get(Payments."Pay Mode") then begin
                    BalAccType := PaymentMethod."Bal. Account Type";

                    if BalAccType = BalAccType::Cheque then
                        ChequePayment := true
                    else
                        ChequePayment := false;
                end;
                VarExchangeRate := Payments."Exchange Rate";

                //Get sender ID even before approval sent
                Approver[1] := Payments."Created By";
                ApproverDate[1] := CreateDateTime(Payments.Date, Payments."Time Inserted");
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::Payments);
                ApprovalEntries.SetRange("Document No.", Payments."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then
                                UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next() = 0;

                // if Posted then begin
                //     Approver[4] := "Posted By";
                //     ApproverDate[4] := CreateDateTime("Posted Date", "Time Posted");
                //     if UserSetup3.Get(Approver[4]) then
                //         UserSetup3.CalcFields(Signature);
                // end;

                PaymentLine.Reset();
                PaymentLine.SetRange(No, "No.");
                PaymentLine.SetRange("Account Type", PaymentLine."Account Type"::Vendor);
                if PaymentLine.FindFirst() then
                    PaymentMgt.GetVendorBankDetails(VendorBank, PaymentLine."Account No");

                //Get Header Dimensions
                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;

                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[2] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[2] := DimSetEntry."Dimension Value Name";
                end;
                //*******************************************************************8



            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            // area(Content)
            // {
            //     group(GroupName)
            //     {
            //         field(Name; SourceExpression)
            //         {

            //         }
            //     }
            // }
        }


    }



    var
        SSPAmount: Decimal;
        USDAmount: Decimal;
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentLine: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        VendorBank: Record "Vendor Bank Account";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgerEntry2: Record "Vendor Ledger Entry";
        PaymentMgt: Codeunit "Payments Management";
        ChequePayment: Boolean;
        BankCode: Code[20];
        HeaderDimValueCode: array[8] of Code[20];
        InvoiceNo: Code[20];
        PinNo: Code[20];
        SwiftCode: Code[20];
        VendAcNo: Code[20];
        Approver: array[10] of Code[50];
        BranchCode: Code[50];
        ApproverDate: array[10] of DateTime;
        AmountPaid: Decimal;
        BalAccType: Enum "Payment Balance Account Type";
        Counter: Integer;
        BankName: Text;
        Branch: Text;
        DimValueName: array[8] of Text;
        HeaderDimValueName: array[8] of Text;
        NumberText: array[2] of Text;
        PayeeTxt: Text;
        VendAddress: Text;
        SignatureLbl: Label 'Signature:...................................';
        PreparedBySignature: Text[1000];
        ACKNOWLEDGEMENT_OF_RECEIPTCaptionLbl: Label 'ACKNOWLEDGEMENT OF RECEIPT';
        ChequeCashRecievedByLbl: Label 'Cheque/Cash Received By:';
        IDNoPassportNoLbl: Label 'ID No./Passport No.';
        VarExchangeRate: Decimal;

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        GLSetup.Get();
        Counter := 0;
        ChequePayment := false;
        //   UserSetup.Get();
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  //EXIT(Users."Full Name");
        //  EXIT(Users."User Name");
        exit(UserCode);
    end;

    local procedure GetBankDetails(PayingBankCode: Code[20]): Text
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(PayingBankCode) then
            exit(BankAccount.Name)
        else
            exit(PayingBankCode);
    end;
}