report 53016 "Project Team"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProjectTeam.rdlc';

    dataset
    {
        dataitem(Project; "New Project Header")
        {
            RequestFilterFields = "No.";

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
            dataitem("Project Team"; "Project Team")
            {
                DataItemLink = "Project No" = field("No.");

                column(FullName_ProjectTeam; "Project Team"."Full Name")
                {
                }
                column(IDNo_ProjectTeam; "Project Team"."ID No")
                {
                }
                column(Company_ProjectTeam; "Project Team".Company)
                {
                }
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





