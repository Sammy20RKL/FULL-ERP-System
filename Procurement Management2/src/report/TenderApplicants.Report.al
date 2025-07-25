report 53036 "Tender Applicants"
{
    ApplicationArea = All;
    Caption = 'Tender Applicants';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderApplicants.rdl';
    dataset
    {
        dataitem(ProcurementRequest; "Procurement Request")
        {
            DataItemTableView = where("Process Type" = filter(Tender | "Supplier Prequalification"));
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Title; Title)
            {
            }
            column(ProcessType; "Process Type")
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
            dataitem(TenderApplicants; "Tender Applicant")
            {
                DataItemLink = "Tender No." = field("No.");
                column(SupplierCategory_TenderApplicants; "Supplier Category")
                {
                }
                column(SupplierCode_TenderApplicants; "Supplier Code")
                {
                }
                column(SupplierName_TenderApplicants; "Supplier Name")
                {
                }
                column(SupplierEmail_TenderApplicants; "Supplier Email")
                {
                }
                column(CountryRegionCode_TenderApplicants; "Country/Region Code")
                {
                }
                column(Address_TenderApplicants; Address)
                {
                }
                column(City_TenderApplicants; City)
                {
                }
                column(PhoneNo_TenderApplicants; "Phone No.")
                {
                }
                column(TenderApplicantStage_TenderApplicants; "Tender Applicant Stage")
                {
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






