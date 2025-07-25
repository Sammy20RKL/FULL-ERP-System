report 53017 "Projects"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/Projects.rdlc';

    dataset
    {
        dataitem(Project; "New Project Header")
        {
            RequestFilterFields = "User ID", Status, "Actual Start Date", "Actual End Date";

            column(No_Project; Project."No.")
            {
            }
            column(ProjectName_Project; Project."Project Name")
            {
            }
            column(ProjectDate_Project; Project."Project Date")
            {
            }
            column(EstimatedStartDate_Project; Project."Estimated Start Date")
            {
            }
            column(EstimatedEndDate_Project; Project."Estimated End Date")
            {
            }
            column(EstimatedDuration_Project; Project."Estimated Duration")
            {
            }
            column(ActualStartDate_Project; Project."Actual Start Date")
            {
            }
            column(ActualEndDate_Project; Project."Actual End Date")
            {
            }
            column(ActualDuration_Project; Project."Actual Duration")
            {
            }
            column(ProjectBudget_Project; Project."Project Budget")
            {
            }
            column(ContractNo_Project; Project."Contract No")
            {
            }
            column(ContractName_Project; Project."Contract Name")
            {
            }
            column(Status_Project; Project.Status)
            {
            }
            column(UserID_Project; Project."User ID")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }
    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
}





