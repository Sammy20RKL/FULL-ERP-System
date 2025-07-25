report 53040 "Supplier Payments Summary"
{
    ApplicationArea = All;
    Caption = 'Supplier Payments Summary';
    UsageCategory = Tasks;
    RDLCLayout = './src/report_layout/SupplierPaymentsSummary.rdl';

    dataset
    {
        dataitem(Payments; Payments)
        {
            column(No_; "No.")
            {

            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(PVType; "PV Type")
            {
            }
            column(Currency; Currency)
            {
            }
            column(PayMode; "Pay Mode")
            {
            }
            column(Payee; Payee)
            {
            }
            column(PaymentNarration; "Payment Narration")
            {
            }
            column(PaymentType; "Payment Type")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(TotalAmount; "Total Amount")
            {
            }
            column(Applies__To_Doc_No_; "Applies- To Doc No.")
            {

            }
            column(Cheque_No; "Cheque No")
            {

            }
            column(Cheque_Date; "Cheque Date")
            {

            }
            column(EFT_Reference; "EFT Reference")
            {

            }
            column(EFT_Date; "EFT Date")
            {

            }

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}






