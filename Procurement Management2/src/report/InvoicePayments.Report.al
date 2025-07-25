report 53043 "Invoice Payments"
{
    ApplicationArea = All;
    Caption = 'Invoice Payments';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/InvoicePayments.rdl';

    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            RequestFilterFields = "Buy-from Vendor No.", "Posting Date";
            column(No; "No.")
            {
            }
            column(VendorInvoiceNo; "Vendor Invoice No.")
            {
            }
            column(VendorInvoiceDate; Today())
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(RemainingAmount; "Remaining Amount")
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(OrderDate; "Order Date")
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

            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor Ledger Entry No." = field("Vendor Ledger Entry No.");
                DataItemTableView = where("Entry Type" = const(Application));
                column(PostingDate_DetailedVendorLedgEntry; "Posting Date")
                {
                }
                column(DocumentNo_DetailedVendorLedgEntry; "Document No.")
                {
                }
                column(DocumentType_DetailedVendorLedgEntry; "Document Type")
                {
                }
                column(AmountLCY_DetailedVendorLedgEntry; "Amount (LCY)")
                {
                }
                column(UserID_DetailedVendorLedgEntry; "User ID")
                {
                }

                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Entry No." = field("Applied Vend. Ledger Entry No.");
                    DataItemTableView = sorting("Entry No.");

                    column(Description_VendorLedgerEntry; Description)
                    {
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}






