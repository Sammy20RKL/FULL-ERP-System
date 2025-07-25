report 65007 "Project Based Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/ProjectBasedReport.rdlc';

    dataset
    {
        dataitem("Project Header"; "Project Header")
        {
            column(Code_ProjectHeader; "Project Header".Code)
            {
            }
            column(Description_ProjectHeader; "Project Header".Description)
            {
            }
            column(StartDate_ProjectHeader; "Project Header"."Start Date")
            {
            }
            column(EndDate_ProjectHeader; "Project Header"."End Date")
            {
            }
            column(Cost_ProjectHeader; "Project Header".Cost)
            {
            }
            column(Status_ProjectHeader; PrAct.Status)
            {
            }
            column(Remarks_ProjectHeader; "Project Header".Remarks)
            {
            }
            column(Source_ProjectHeader; "Project Header".Source)
            {
            }
            column(WorkPlanCode_ProjectHeader; "Project Header"."WorkPlan Code")
            {
            }
            column(Progress_ProjectHeader; "Project Header".Progress)
            {
            }
            column(ShortcutDimension1Code_ProjectHeader; "Project Header"."Shortcut Dimension 1 Code")
            {
            }
            column(Logo_; Comp.Picture)
            {
            }
            column(Milestone_; PrAct.Milestone)
            {
            }
            column(Percentage_of_Implementation; PrAct.Percentage)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrAct.Reset();
                PrAct.SetRange(Code, "Project Header".Code);
                if PrAct.FindFirst() then;
            end;

            trigger OnPreDataItem()
            begin
                Comp.Get();
                Comp.CalcFields(Picture);
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
        Comp: Record "Company Information";
        PrAct: Record "Project Activities";
}

