report 53001 "Overdue Vendor Invoices"
{
    ApplicationArea = All;
    Caption = 'Overdue Vendor Invoices';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/OverdueVendorInvoices.rdl';
    dataset
    {
        dataitem(CustLedgerEntry; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Vendor No.", "Posting Date";
            CalcFields = "Amount (LCY)", "Remaining Amt. (LCY)";
            DataItemTableView = where("Remaining Amt. (LCY)" = filter(> 0), "Vendor Posting Group" = const('CREDITORS'));
            column(CustomerNo; "Vendor No.")
            {
            }
            column(CustomerName; Vendor.Name)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(RemainingAmtLCY; "Remaining Amt. (LCY)")
            {
            }
            column(PayTerms; PayTerms)
            {
            }
            column(Description; Description)
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(DaysOverdue; DaysOverdue)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vendor.Get("Vendor No.");
                if PaymentTerms.Get(Vendor."Payment Terms Code") then
                    PayTerms := PaymentTerms.Description;

                if "Due Date" >= Today() then
                    CurrReport.Skip();

                DaysOverdue := Today() - "Due Date";
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);

        ReportFilters := Vendor.GetFilters();
    end;

    var
        Vendor: Record Vendor;
        PayTerms: Text[100];
        PaymentTerms: Record "Payment Terms";
        DaysOverdue: Integer;
        CompanyInfo: Record "Company Information";
        ReportFilters: Text;
}






