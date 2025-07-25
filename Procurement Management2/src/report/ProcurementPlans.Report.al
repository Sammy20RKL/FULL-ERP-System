report 53046 "Procurement Plans"
{
    ApplicationArea = All;
    Caption = 'Procurement Plans';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProcurementPlans.rdl';
    dataset
    {
        dataitem(ProcurementPlan; "Procurement Plan")
        {
            RequestFilterFields = Name, Status;
            column(Name; Name)
            {
            }
            column(Description; Description)
            {
            }
            column(PlanSubmissionCutoff; "Plan Submission Cut-off")
            {
            }
            column(CurrentBudget; "Current Budget")
            {
            }
            column(TotalBudgetAllocation; "Total Budget Allocation")
            {
            }
            column(Status; Status)
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
            dataitem("Procurement Plan Item"; "Procurement Plan Item")
            {
                DataItemLink = "Plan Year" = field(Name);
                DataItemTableView = sorting("Plan Year", "Plan Item No");

                column(Date_ProcurementPlanItem; "Date")
                {
                }
                column(MonthName_ProcurementPlanItem; "Month Name")
                {
                }
                column(SupplierCategoryCode_ProcurementPlanItem; "Supplier Category Code")
                {
                }
                column(SupplierCategoryName_ProcurementPlanItem; "Supplier Category Name")
                {
                }
                column(ShortcutDimension1Code_ProcurementPlanItem; "Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_ProcurementPlanItem; "Shortcut Dimension 2 Code")
                {
                }
                column(ExpenditureType_ProcurementPlanItem; "Expenditure Type")
                {
                }
                column(Quantity_ProcurementPlanItem; Quantity)
                {
                }
                column(UnitPrice_ProcurementPlanItem; "Unit Price")
                {
                }
                column(EstimatedCost_ProcurementPlanItem; "Estimated Cost")
                {
                }
                column(Justification_ProcurementPlanItem; Justification)
                {
                }
                column(UserID_ProcurementPlanItem; "User ID")
                {
                }
                column(TotalEstimatedCost_ProcurementPlanItem; "Total Estimated Cost")
                {
                }
                column(ItemDescription_ProcurementPlanItem; "Item Description")
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






