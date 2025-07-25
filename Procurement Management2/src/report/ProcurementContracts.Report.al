report 53045 "Procurement Contracts"
{
    ApplicationArea = All;
    Caption = 'Procurement Contracts';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProcurementContracts.rdl';

    dataset
    {
        dataitem(ProcurementContract; "Procurement Contract")
        {
            RequestFilterFields = "Contract No.", "Contract Status";
            column(ContractNo; "Contract No.")
            {
            }
            column(ContractRefNo; "Contract Ref No.")
            {
            }
            column(Description; Description)
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(Duration; "Duration")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(ContractStatus; "Contract Status")
            {
            }
            column(TotalContractAmount; "Total Contract Amount")
            {
            }
            column(ProposedAction; "Proposed Action")
            {
            }
            column(ServiceRequired; "Service Required?")
            {
            }
            column(Comments; Comments)
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






