page 60000 "Grants Mgt Rolecenter"
{
    ApplicationArea = All;
    Caption = 'Grants Mgt Rolecenter';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = All;
                Caption = 'Headline RC Accountant';
                Visible = false;
            }
            part("Grants Management Cue"; "Grants Management Cue")
            {
                ApplicationArea = All;
                Caption = 'Grants Management Cue';
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                action("Concept Notes Report")
                {
                    ApplicationArea = All;
                    Caption = 'Concept Notes Report';
                    RunObject = report "Concept Notes";
                    ToolTip = 'Executes the Concept Notes Report action.';
                }
                action("Proposals Report")
                {
                    ApplicationArea = All;
                    Caption = 'Proposals Report';
                    RunObject = report Proposals;
                    ToolTip = 'Executes the Proposals Report action.';
                }
                action(Donor)
                {
                    ApplicationArea = All;
                    Caption = 'Donor';
                    RunObject = report Donor;
                    ToolTip = 'Executes the Donor action.';
                }
                action("Grant Analysis Report")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Analysis Report';
                    RunObject = report "Grant Analsysis 3";
                    ToolTip = 'Executes the Grant Analysis Report action.';
                }
                action("Grant Financial Report")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Financial Report';
                    RunObject = report "Grant Financial Report";
                    ToolTip = 'Executes the Grant Financial Report action.';
                }
                action("Grant Projects Report")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Projects Report';
                    RunObject = report "Grant Projects";
                    ToolTip = 'Executes the Grant Projects Report action.';
                }
                action("Partner Budgets")
                {
                    ApplicationArea = All;
                    Caption = 'Partner Budgets';
                    RunObject = report "Partner Budgets";
                    ToolTip = 'Executes the Partner Budgets action.';
                }
                action("Partner Disbursements")
                {
                    ApplicationArea = All;
                    Caption = 'Partner Disbursements';
                    RunObject = report "Partner Disbursements";
                    ToolTip = 'Executes the Partner Disbursements action.';
                }
                action("Partner Returns")
                {
                    ApplicationArea = All;
                    Caption = 'Partner Returns';
                    RunObject = report "Partner Returns";
                    ToolTip = 'Executes the Partner Returns action.';
                }
                action(Partners)
                {
                    ApplicationArea = All;
                    Caption = 'Partners';
                    RunObject = report Partners;
                    ToolTip = 'Executes the Partners action.';
                }
                action("Project Approved Budgets")
                {
                    ApplicationArea = All;
                    Caption = 'Project Approved Budgets';
                    RunObject = report "Project Approved Budget";
                    ToolTip = 'Executes the Project Approved Budgets action.';
                }
            }
        }
        area(Sections)
        {
            group("Donor Management")
            {
                Caption = 'Donor Management';
                action("Donor List")
                {
                    ApplicationArea = All;
                    Caption = 'Donor List';
                    RunObject = page "Donor List";
                    ToolTip = 'Executes the Donor List action.';
                }
                action("Partners List")
                {
                    ApplicationArea = All;
                    Caption = 'Partners List';
                    RunObject = page "Partners List";
                    ToolTip = 'Executes the Partners List action.';
                }
            }
            group("Concept Notes")
            {
                Caption = 'Concept Notes';
                action("Concept Note List")
                {
                    ApplicationArea = All;
                    Caption = 'Concept Note List';
                    RunObject = page "Concept Note List";
                    ToolTip = 'Executes the Concept Note List action.';
                }
                action("Approved Concepts List")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Concepts List';
                    RunObject = page "Approved Concepts List";
                    ToolTip = 'Executes the Approved Concepts List action.';
                }
            }
            group(Proposals)
            {
                Caption = 'Proposals';
                action("Proposal List")
                {
                    ApplicationArea = All;
                    RunObject = page "Proposal List";
                    Caption = 'Proposal Development List';
                    ToolTip = 'Executes the Proposal Development List action.';
                }
                action("Approved Proposal List")
                {
                    ApplicationArea = All;
                    RunObject = page "Approved Proposal List";
                    Caption = 'Approved Proposals';
                    ToolTip = 'Executes the Approved Proposals action.';
                }
            }
            group("Grant Agreement")
            {
                Caption = 'Grant Agreement';
                action("Grant Agreement List")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Agreement List';
                    RunObject = page "Contract List";
                    ToolTip = 'Executes the Grant Agreement List action.';
                }
                action("Approved Grant Agreement List")
                {
                    ApplicationArea = All;
                    RunObject = page "Approved Contract List";
                    Caption = 'Approved Grant Agreements';
                    ToolTip = 'Executes the Approved Grant Agreements action.';
                }
            }
            group("Project Management")
            {
                Caption = 'Project Management';
                action("Project Summary List")
                {
                    ApplicationArea = All;
                    Caption = 'Project Summary List';
                    RunObject = page "Grants Project List";
                    ToolTip = 'Executes the Project Summary List action.';
                }
                action("Approved Projects List")
                {
                    ApplicationArea = All;
                    RunObject = page "Approved Grants Project List";
                    Caption = 'Approved Projects';
                    ToolTip = 'Executes the Approved Projects action.';
                }
                action("Project Partners")
                {
                    ApplicationArea = All;
                    Caption = 'Project Partners';
                    RunObject = page "Project Partners";
                    ToolTip = 'Executes the Project Partners action.';
                }
                action("Budget Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Lines';
                    RunObject = page "Grant Task Lines";
                    ToolTip = 'Executes the Budget Lines action.';
                }
                action(Budget)
                {
                    ApplicationArea = All;
                    Caption = 'Budget';
                    RunObject = page Budget;
                    ToolTip = 'Executes the Budget action.';
                }
                action("Compliance Check List")
                {
                    ApplicationArea = All;
                    Caption = 'Compliance Check List';
                    RunObject = page "Compliance journal Lists";
                    ToolTip = 'Executes the Compliance Check List action.';
                }
            }
            group("Grant Close Out")
            {
                Caption = 'Grant Close Out';
                action("Grant Close Out List")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Close Out List';
                    RunObject = page "Close out List";
                    ToolTip = 'Executes the Grant Close Out List action.';
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
                action("Grant Phases")
                {
                    ApplicationArea = All;
                    Caption = 'Grant Phases';
                    RunObject = page "Grant Phases";
                    ToolTip = 'Executes the Grant Phases action.';
                }
                action("Jobs Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Jobs Setup';
                    RunObject = page "Jobs-Setup";
                    ToolTip = 'Executes the Jobs Setup action.';
                }
            }
        }
    }
}
