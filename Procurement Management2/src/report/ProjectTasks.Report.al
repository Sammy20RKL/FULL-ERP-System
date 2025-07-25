report 53015 "Project Tasks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProjectTasks.rdlc';

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
            dataitem("Project Tasks"; "Project Tasks")
            {
                DataItemLink = "Project No" = field("No.");
                RequestFilterFields = "Task No";

                column(TaskNo_ProjectTasks; "Project Tasks"."Task No")
                {
                }
                column(Descriprion_ProjectTasks; "Project Tasks".Descriprion)
                {
                }
                column(ResponsiblePerson_ProjectTasks; "Project Tasks"."Responsible Person")
                {
                }
                column(Category_ProjectTasks; "Project Tasks".Category)
                {
                }
                column(Importance_ProjectTasks; "Project Tasks".Importance)
                {
                }
                column(ProgressLevel_ProjectTasks; "Project Tasks"."Progress Level %")
                {
                }
                column(TaskBudget_ProjectTasks; "Project Tasks"."Task Budget")
                {
                }
                column(EstimatedStartDate_ProjectTasks; "Project Tasks"."Estimated Start Date")
                {
                }
                column(EstimatedEndDate_ProjectTasks; "Project Tasks"."Estimated End Date")
                {
                }
                column(ActualStartDate_ProjectTasks; "Project Tasks"."Actual Start Date")
                {
                }
                column(ActualEnddate_ProjectTasks; "Project Tasks"."Actual End date")
                {
                }
                column(FullName; FullName)
                {
                }
                dataitem("Project Task Components"; "Project Task Components")
                {
                    DataItemLink = "Project No" = field("Project No"), "Task No" = field("Task No");

                    column(Component_ProjectTaskComponents; "Project Task Components".Component)
                    {
                    }
                    column(ComponentBudget_ProjectTaskComponents; "Project Task Components"."Component Budget")
                    {
                    }
                    column(ProgressLevel_ProjectTaskComponents; "Project Task Components"."Progress Level")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ProjectTeam.Reset();
                    ProjectTeam.SetRange("Project No", "Project Tasks"."Project No");
                    if ProjectTeam.FindFirst() then
                        FullName := ProjectTeam."Full Name";
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);

                if StartDate <> 0D then
                    Project.SetFilter("Actual Start Date", '>=%1', StartDate);
                if EndDate <> 0D then
                    Project.SetFilter("Actual End Date", '<=%1', EndDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field';
                }
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
        ProjectTeam: Record "Project Team";
        EndDate: Date;
        StartDate: Date;
        FullName: Text[70];
}





