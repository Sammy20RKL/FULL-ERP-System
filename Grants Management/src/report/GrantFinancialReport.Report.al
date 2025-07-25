report 60011 "Grant Financial Report"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/GrantFinancialReport.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            column(No_Jobs; Jobs."No.")
            {
            }
            column(periodstart; PeriodStart)
            {
            }
            column(periodend; PeriodEnd)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CreationDate_Jobs; Jobs."Creation Date")
            {
            }
            column(StartingDate_Jobs; Jobs."Starting Date")
            {
            }
            column(EndingDate_Jobs; Jobs."Ending Date")
            {
            }
            column(ReceivedAmount_Jobs; Jobs."Received Amount")
            {
            }
            column(Description_Jobs; Jobs.Description)
            {
            }
            column(GenSetupLCYCode; GenSetup."LCY Code")
            {
            }
            column(GenSetupAdditionalReportingCurrency; GenSetup."Additional Reporting Currency")
            {
            }
            column(Roe; ROE)
            {
            }
            dataitem("Budget Line Items"; "Budget Line Items")
            {
                column(Code_BudgetLineItems; "Budget Line Items".Code)
                {
                }
                column(Name_BudgetLineItems; "Budget Line Items".Name)
                {
                }
                column(SNo; SNo)
                {
                }
                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemLink = "Budget Line Item" = field(Code);
                    DataItemTableView = sorting("No.") where("Donor defined Account" = const(true));
                    column(No_GLAccount; "G/L Account"."No.")
                    {
                    }
                    column(AdditionalCurrencyNetChange_GLAccount; "G/L Account"."Additional-Currency Net Change")
                    {
                    }
                    column(NetChange_GLAccount; "G/L Account"."Net Change")
                    {
                    }
                    column(BudgetedAmount_GLAccount; "G/L Account"."Budgeted Amount")
                    {
                    }
                    column(Name_GLAccount; "G/L Account".Name)
                    {
                    }
                    column(AddCurrencyBalanceatDate_GLAccount; "G/L Account"."Add.-Currency Balance at Date")
                    {
                    }
                    column(BalanceatDate_GLAccount; "G/L Account"."Balance at Date")
                    {
                    }
                    column(Balance_GLAccount; "G/L Account".Balance)
                    {
                    }
                    dataitem("Job-Planning Line"; "Job-Planning Line")
                    {
                        DataItemLink = "G/l Account" = field("No.");
                        column(No_JobPlanningLine; "Job-Planning Line"."No.")
                        {
                        }
                        column(Description_JobPlanningLine; "Job-Planning Line".Description)
                        {
                        }
                        column(Quantity_JobPlanningLine; "Job-Planning Line".Quantity)
                        {
                        }
                        column(UnitCostLCY_JobPlanningLine; "Job-Planning Line"."Unit Cost (LCY)")
                        {
                        }
                        column(TotalCostLCY_JobPlanningLine; "Job-Planning Line"."Total Cost (LCY)")
                        {
                        }
                        column(UnitCost_JobPlanningLine; "Job-Planning Line"."Unit Cost")
                        {
                        }
                        column(TotalCost_JobPlanningLine; "Job-Planning Line"."Total Cost")
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            SetRange("Planning Date", PeriodStart, PeriodEnd);
                            SetFilter("Grant No.", Jobs."No.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("Net Change", "Additional-Currency Net Change", "Budgeted Amount", "Add.-Currency Balance at Date");
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Date Filter", PeriodStart, PeriodEnd);
                        SetFilter("Global Dimension 2 Filter", Jobs."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(PeriodStart; PeriodStart)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(PeriodEnd; PeriodEnd)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(ROE; ROE)
                {
                    ApplicationArea = All;
                    Caption = 'ROE';
                    ToolTip = 'Specifies the value of the ROE field.';
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

    trigger OnPreReport()
    begin
        if PeriodStart = 0D then Error('Specify the start date of the period');
        if PeriodEnd = 0D then Error('Specify the end date of the period');
        //IF ROE = 0 THEN ERROR('Specify the ROE');
        PeriodStart := CalcDate('-CM', PeriodStart);
        PeriodEnd := CalcDate('CM', PeriodEnd);
        CompanyInfo.Get();
        GenSetup.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        GenSetup: Record "General Ledger Setup";
        PeriodEnd: Date;
        PeriodStart: Date;
        ROE: Decimal;
        SNo: Integer;
}

