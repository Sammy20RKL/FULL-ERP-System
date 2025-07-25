page 50025 "General Activities Role Center"
{
    Caption = 'General Activities Role Center';
    PageType = RoleCenter;

    /* layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = All;
                Caption = 'Headline RC Accountant';
            }
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = All;
                Caption = 'General Management Cues';
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
        area(sections)
        {
            group("Self Service")
            {
                Caption = 'Self Service';
                action("Change Password")
                {
                    Caption = 'Change My Password';
                    RunObject = report "Change Password";
                    ApplicationArea = All;
                    ToolTip = 'Change Password';
                }
                action(Imprests)
                {
                    RunObject = Page "Imprests-General";
                    ApplicationArea = All;
                    Caption = 'Imprests';
                }
                action("Imprest Surrenders ")
                {
                    RunObject = Page "Imprest Surrenders-General";
                    ApplicationArea = All;
                    Caption = 'Imprest Surrenders ';
                }
                action("Staff Claim List ")
                {
                    RunObject = Page "Staff Claim List-General";
                    ApplicationArea = All;
                    Caption = 'Staff Claim List ';
                }
                action("Purchase Request List ")
                {
                    Caption = 'Procurement Requisition Form';
                    RunObject = Page "Purchase Request List-General";
                    ApplicationArea = All;
                }
                action("Store Request List ")
                {
                    RunObject = Page "Store Request List-General";
                    ApplicationArea = All;
                    Caption = 'Store Request List ';
                }
                action("Petty Cash")
                {
                    RunObject = page "Petty Cash List-General";
                    ApplicationArea = All;
                    Caption = 'Petty Cash';
                }
                action("Petty Cash Surrenders")
                {
                    RunObject = page "Petty Cash Surrenders-Gen";
                    ApplicationArea = All;
                    Caption = 'Petty Cash Surrenders';
                }
                action("Leave Applications List")
                {
                    RunObject = Page "Leave Application List-General";
                    ApplicationArea = All;
                    Caption = 'Leave Applications List';
                }
                action("Transport Request")
                {
                    RunObject = Page "Transport requests -General";
                    ApplicationArea = All;
                    Caption = 'Transport Request';
                }
                action("Training Requests List ")
                {
                    RunObject = Page "Training Request List-General";
                    ApplicationArea = All;
                    Caption = 'Training Requests List ';
                }
                action("Budget Approval List")
                {
                    RunObject = Page "Budget Approval List";
                    ApplicationArea = All;
                    Caption = 'Budget Approval List';
                }
                action("Payroll Requests ")
                {
                    Image = Reuse;
                    RunObject = page "Payroll Requests-Self Service";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Payroll Requests action';
                    Caption = 'Payroll Requests';
                }
                action(Payslip)
                {
                    Caption = 'My Payslip';
                    RunObject = report "New Payslipx-Self Service";
                    ApplicationArea = All;
                }
                action(P9)
                {
                    Caption = 'My P9';
                    RunObject = report "P9A Report-Self Service";
                    ApplicationArea = All;
                }
                group(Incident)
                {
                    Caption = 'Incidents Management';
                    action(Incidentss)
                    {
                        Caption = 'Service Desk';
                        RunObject = page "Incident Reports";
                        ApplicationArea = All;
                    }
                    action(MyIncidentss)
                    {
                        Caption = 'Solve A Request';
                        RunObject = page "Incident Reports - Pending";
                        ApplicationArea = All;
                    }
                }
                action(CustomerStatement)
                {
                    Caption = 'My Customer Statement';
                    RunObject = report "Customer Statement";
                    ApplicationArea = All;
                    Visible = false;
                }
                group("Procurement Tasks")
                {
                    Caption = 'Tender Evaluation';

                    group("Tenders ")
                    {
                        Caption = 'Tender Management';
                        group("OpeningSelf")
                        {
                            Caption = 'Tender Opening';

                            action(TenderOpeningSelf)
                            {
                                Caption = 'Tender Opening';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(false), "Document Type" = const(Tender);
                                ApplicationArea = All;
                            }
                            action(TenderOpeningArchiveSelf)
                            {
                                Caption = 'Tenders Opened';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(true), "Document Type" = const(Tender);
                                ApplicationArea = All;
                            }
                        }
                        group("PreliminarySelf")
                        {
                            Caption = 'Preliminary Evaluation';

                            action("Supplier Evaluation-PreliminarySelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Preliminary Evaluation");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Supplier Evaluation-Preliminary';
                            }
                            action("Supplier Evaluation-Failed PreliminarySelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Failed Preliminary");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Failed Preliminary Evaluation';
                            }
                        }
                        group("Technical EvaluationSelf")
                        {
                            Caption = 'Technical Evaluation';
                            action("Supplier Evaluation-TechnicalSelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Technical Evaluation");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Supplier Evaluation-Technical';
                            }
                            action("Supplier Evaluation-Failed TechnicalSelf")
                            {
                                Image = List;
                                RunObject = page "Supplier Evaluation List";
                                RunPageLink = "Evaluation Stage" = const("Failed Technical");
                                ApplicationArea = All;
                                ToolTip = 'Executes the Supplier Evaluation action';
                                Caption = 'Failed Technical Evaluation';
                            }
                        }
                        group(FinanicalEvaluation)
                        {
                            Caption = 'Financial Evaluation';

                            action("Tender evaluation listSelf")
                            {
                                Image = List;
                                RunObject = page "Tender Evaluation List";
                                RunPageLink = Status = const(New);
                                ApplicationArea = All;
                                ToolTip = 'Executes the Financial evaluation list action';
                                Caption = 'Financial Evaluation List';
                            }
                        }
                        group("PrequalificationOpeningSelf")
                        {
                            Caption = 'Prequalification Tender Opening';

                            action(PrequalificationTenderOpeningSelf)
                            {
                                Caption = 'Tender Opening';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(false), "Document Type" = const("Supplier Prequalification");
                                ApplicationArea = All;
                            }
                            action(PrequalificationTenderOpeningArchiveSelf)
                            {
                                Caption = 'Tenders Opened';
                                RunObject = page "Tender Opening List";
                                RunPageLink = "Tender Opened" = const(true), "Document Type" = const("Supplier Prequalification");
                                ApplicationArea = All;
                            }
                        }
                    }
                }
            }
        }
        area(reporting)
        {

        }
    } */
}






