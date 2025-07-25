report 50006 "Tender Advert"
{
    ApplicationArea = All;
    Caption = 'Tender Advert';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderAdvert.rdl';
    dataset
    {
        dataitem("Procurement Request"; "Procurement Request")
        {
            column(Quotation_Deadline; "Quotation Deadline")
            {

            }

            dataitem(ProcurementRequestLines; "Procurement Request Lines")
            {
                DataItemLink = "Document No." = field("No.");
                column(No; No)
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(CompanyInfo_Address; CompanyInfo.Address)
                {
                }
                column(CompanyInfo_Address2; CompanyInfo."Address 2")
                {
                }
                column(CompanyInfo_City; CompanyInfo.City)
                {
                }
                column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(TitleCaption; TitleCaption)
                {

                }
                column(QuotationTitle; QuotationTitle)
                { }
                column(TCsCaption; TCsCaption)
                {

                }
                column(Unit_of_Measure; "Unit of Measure")
                { }

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        Counter := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        Counter: Integer;
        TitleCaption: Label 'REQUEST FOR QUOTATIONS (RFQS)';
        QuotationTitle: Label 'Suppliers are requested to quote for the following items';
        TCsCaption: Label 'Suppliers are requested to quote for the following items';
}
