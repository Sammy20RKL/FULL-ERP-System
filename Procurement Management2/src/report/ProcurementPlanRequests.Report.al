report 53035 "Procurement Plan Requests"
{
    ApplicationArea = All;
    Caption = 'Procurement Plan Requests';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProcurementPlanRequests.rdl';

    dataset
    {
        dataitem(BudgetApprovalHeader; "Budget Approval Header")
        {
            DataItemTableView = where("Budget Type" = const("Procurement Plan"));
            column(DocumentNo; "Document No.")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(Status; Status)
            {
            }
            column(UserID; "User ID")
            {
            }
            column(TimeCreated; "Time Created")
            {
            }
            column(Activity; "Global Dimension 1 Code")
            {
            }
            column(Branch; "Global Dimension 2 Code")
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






