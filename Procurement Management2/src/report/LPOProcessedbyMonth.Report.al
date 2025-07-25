report 53032 "LPO Processed by Month"
{
    ApplicationArea = All;
    Caption = 'Purchase Documents Processed by Month';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/LPOProcessedbyMonth.rdl';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            RequestFilterFields = "Order Date", Status;
            DataItemTableView = where("Document Type" = const(Order));
            column(No; "No.")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(Status; Status)
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(RFQNo_PurchaseHeader; "RFQ No.")
            {
            }
            column(RequisitionNo_PurchaseHeader; "Requisition No.")
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
            column(CancelComments_PurchaseHeader; "Cancel Comments")
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }

            trigger OnPreDataItem()
            begin
                ReportFilters := GetFilters();
            end;
        }
        dataitem("Posted Purchase Header"; "Posted Purchase Header")
        {
            RequestFilterFields = "Order Date";
            column(No_Posted; "No.")
            {
            }
            column(NoSeries_Posted; "No. Series")
            {
            }
            column(BuyfromVendorName_Posted; "Buy-from Vendor Name")
            {
            }
            column(PostingDescription_Posted; "Posting Description")
            {
            }
            column(AmountIncludingVAT_Posted; "Amount Including VAT")
            {
            }
            column(OrderDate_Posted; "Order Date")
            {
            }
            column(RFQNo_Posted; "RFQ No.")
            {
            }
            column(RequisitionNo_Posted; "Requisition No.")
            {
            }
            column(PostedReportFilters; PostedReportFilters)
            {
            }

            trigger OnPreDataItem()
            begin
                PostedReportFilters := GetFilters();
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ReportFilters, PostedReportFilters : Text;
}






