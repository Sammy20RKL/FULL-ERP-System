page 65037 "Strategy & Planning Role"
{
    ApplicationArea = All;
    Caption = 'Strategy & Planning Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(ApprovalActivities; "Approvals Activities")
            {
                Caption = 'Approval Activities';
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(StrategicPlan)
            {
                Caption = 'Strategic Plan';
                action("Strategic Plan")
                {
                    Caption = 'Strategic Plan';
                    RunObject = page "Strategic Plan List";
                    ToolTip = 'Executes the Strategic Plan action.';
                }
            }
            group(PerformanceContracting)
            {
                Caption = 'Performance Contracting';
                action("Performance Contracting")
                {
                    Caption = 'Performance Contracting';
                    RunObject = page "Performance Contracting List";
                    ToolTip = 'Executes the Performance Contracting action.';
                }
                action("Performance Contracting Per Responsible Person")
                {
                    Caption = 'Performance Contracting Per Responsible Person';
                    RunObject = page "Performance Contracting Line";
                    ToolTip = 'Executes the Performance Contracting Per Responsible Person action.';
                }
                group(PerfomanceContractingTasks)
                {
                    Caption = 'Tasks';
                    action("Performance Contracting Dept.")
                    {
                        Caption = 'Performance Contracting Dept.';
                        RunObject = page "Performance Contracting Dept.";
                        ToolTip = 'Executes the Performance Contracting Dept. action.';
                    }
                    action("Generate-Perfm. Contract")
                    {
                        Caption = 'Generate - Perfm. Contract';
                        RunObject = report "Generate - Perfm. Contrac";
                        ToolTip = 'Executes the Generate - Perfm. Contract action.';
                    }
                    action("Reminder-Perfm. Contract")
                    {
                        Caption = 'Reminder - Perfm. Contract';
                        RunObject = report "Reminder - Perfm. Contrac";
                        ToolTip = 'Executes the Reminder - Perfm. Contract action.';
                    }
                }
                group(PerfomanceContractingReports)
                {
                    Caption = 'Reports';
                    action("Year Performance")
                    {
                        Caption = 'Year Performance';
                        RunObject = report "Year Performance";
                        ToolTip = 'Executes the Year Performance action.';
                    }
                    action("Year Performance SubIndicators")
                    {
                        Caption = 'Year Performance SubIndicators';
                        RunObject = report "Year Performance_SubIndicator";
                        ToolTip = 'Executes the Year Performance SubIndicators action.';
                    }
                }
            }
            group(WorkPlans)
            {
                Caption = 'WorkPlans';
                action("Work Plan List")
                {
                    Caption = 'Work Plan List';
                    RunObject = page "Work Plan List";
                    ToolTip = 'Executes the Work Plan List action.';
                }
                group(WorkplanReports)
                {
                    Caption = 'Reports';
                    action("Consolidated Work Plan")
                    {
                        Caption = 'Consolidated Work Plan';
                        RunObject = report "Technical Work Plan";
                        ToolTip = 'Executes the Consolidated Work Plan action.';
                    }
                }
                group(WorkplanSetups)
                {
                    Caption = 'Setups';
                    action(Objectives)
                    {
                        Caption = 'Objectives';
                        RunObject = page "Workplan Objectives";
                        ToolTip = 'Executes the Objectives action.';
                    }
                    action(Activities)
                    {
                        Caption = 'Activities';
                        RunObject = page "Workplan Activities";
                        ToolTip = 'Executes the Activities action.';
                    }
                    action("Sub-Activities")
                    {
                        Caption = 'Sub-Activities';
                        RunObject = page "Workplan Sub-Activities";
                        ToolTip = 'Executes the Sub-Activities action.';
                    }
                }
            }
            group(MonitoringEvaluation)
            {
                Caption = 'Monitoring & Evaluation';
                action("Monitoring & Evaluation")
                {
                    Caption = 'Monitoring & Evaluation';
                    RunObject = page "Monitoring & Evalu. List";
                    ToolTip = 'Executes the Monitoring & Evaluation action.';
                }
                group(MonitoringReports)
                {
                    Caption = 'Reports';
                    action("Monitoring & Evaluation Report")
                    {
                        Caption = 'Monitoring & Evaluation Report';
                        RunObject = report "Monitoring & Evalution";
                        ToolTip = 'Executes the Monitoring & Evaluation Report action.';
                    }
                }
            }
            group(StrategyPlanningReports)
            {
                Caption = 'Reports';
                action("Strategic Matrix")
                {
                    Caption = 'Strategic Matrix';
                    RunObject = report "Strategic Matrix";
                    ToolTip = 'Executes the Strategic Matrix action.';
                }
            }
            group("Project Management")
            {
                Caption = 'Project Management';
                action(Project)
                {
                    Caption = 'Project';
                    RunObject = page "Project List";
                    ToolTip = 'Executes the Project action.';
                }
                group(ProjectReports)
                {
                    Caption = 'Reports';
                    action("Project Based Report")
                    {
                        Caption = 'Project Based Report';
                        RunObject = report "Project Based Report";
                        ToolTip = 'Executes the Project Based Report action.';
                    }
                }
            }
            group("Strategy & Planning Setup")
            {
                Caption = 'Strategy & Planning Setup';
                action("Strategic Objective")
                {
                    Caption = 'Strategic Objective';
                    RunObject = page "KRA Codes";
                    ToolTip = 'Executes the Strategic Objective action.';
                }
                action("Strategic Issue")
                {
                    Caption = 'Strategic Issue';
                    RunObject = page "Objective Codes";
                    ToolTip = 'Executes the Strategic Issue action.';
                }
                action(Strategy)
                {
                    Caption = 'Strategy';
                    RunObject = page "Strategic Codes";
                    ToolTip = 'Executes the Strategy action.';
                }
                action(StrategicSetup)
                {
                    Caption = 'Strategic Setup';
                    RunObject = page "Strategic Setup";
                    ToolTip = 'Executes the Strategic Setup action.';
                }
            }
        }
    }
}
