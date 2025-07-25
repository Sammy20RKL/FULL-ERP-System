report 60003 "Project Approved Budget"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/ProjectApprovedBudget.rdlc';

    dataset
    {
        dataitem(jobs; Jobs)
        {
            DataItemTableView = where(Status = const(Project));
            RequestFilterFields = "No.";
            column(Jobs_No_; "No.")
            {
            }
            column(Project_Name; jobs.Description)
            {
            }
            dataitem("Job-Planning Line"; "Job-Planning Line")
            {
                DataItemLink = "Grant No." = field("No.");
                DataItemTableView = sorting("Budget Grouping Code", "Grant No.", "Budget Period", "Grant Contract Entry No.") order(ascending);
                RequestFilterFields = "Budget Grouping Code", "Grant No.", "Budget Period";
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(COMPANYNAME; CompanyName)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo())
                {
                }
                column(USERID; UserId)
                {
                }
                column(Job_Planning_Line__Grant_No__; "Grant No.")
                {
                }
                column(Job_Planning_Line__Job_Planning_Line___Donor_Expense_Code_; "Job-Planning Line"."Donor Expense Code")
                {
                }
                column(Job_Planning_Line_Description; Description)
                {
                }
                column(Job_Planning_Line__Total_Year_1_; "Total Year 1")
                {
                }
                column(Job_Planning_Line__Total_Year_2_; "Total Year 2")
                {
                }
                column(Job_Planning_Line__Total_Year_3_; "Total Year 3")
                {
                }
                column(Job_Planning_Line__ICIPE_Contribution_; "ICIPE Contribution")
                {
                }
                column(TotalFor________Budget_Grouping_Code_; TotalFor + ' ' + "Budget Grouping Code")
                {
                }
                column(Job_Planning_Line__Total_Year_1__Control1102755053; "Total Year 1")
                {
                }
                column(Job_Planning_Line__Total_Year_2__Control1102755054; "Total Year 2")
                {
                }
                column(Job_Planning_Line__Total_Year_3__Control1102755055; "Total Year 3")
                {
                }
                column(Job_Planning_Line__Total_Year_1__Control1102755010; "Total Year 1")
                {
                }
                column(Job_Planning_Line__Total_Year_2__Control1102755012; "Total Year 2")
                {
                }
                column(Job_Planning_Line__Total_Year_3__Control1102755013; "Total Year 3")
                {
                }
                column(Overhead_1_; Overhead[1])
                {
                }
                column(Overhead_2_; Overhead[2])
                {
                }
                column(Overhead_3_; Overhead[3])
                {
                }
                column(Job_Planning_Line__Total_Year_1__Control1102755037; "Total Year 1")
                {
                }
                column(Job_Planning_Line__Total_Year_2__Control1102755038; "Total Year 2")
                {
                }
                column(Job_Planning_Line__Total_Year_3__Control1102755041; "Total Year 3")
                {
                }
                column(Job_Planning_LineCaption; Job_Planning_LineCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(PROJECT_APPROVED_BUDGETCaption; PROJECT_APPROVED_BUDGETCaptionLbl)
                {
                }
                column(Grant_NoCaption; Grant_NoCaptionLbl)
                {
                }
                column(Budget_Grouping_CodeCaption; Budget_Grouping_CodeCaptionLbl)
                {
                }
                column(Total_Year_1Caption; Total_Year_1CaptionLbl)
                {
                }
                column(Total_Year_2Caption; Total_Year_2CaptionLbl)
                {
                }
                column(Total_Year_3Caption; Total_Year_3CaptionLbl)
                {
                }
                column(Job_Planning_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(AMPATH_Contribution_Caption; AMPATH_Contribution_CaptionLbl)
                {
                }
                column(Sub_TotalCaption; Sub_TotalCaptionLbl)
                {
                }
                column(Overhead_13_Caption; Overhead_13_CaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Job_Planning_Line_Grant_Task_No_; "Grant Task No.")
                {
                }
                column(Job_Planning_Line_Line_No_; "Line No.")
                {
                }
                column(Job_Planning_Line_Budget_Grouping_Code; "Budget Grouping Code")
                {
                }
                column(Job_Planning_Line_Budget_Period; "Budget Period")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    Overhead[1] := "Total Year 1" * 0.13;
                    Overhead[2] := "Total Year 2" * 0.13;
                    Overhead[3] := "Total Year 3" * 0.13;
                    Overhead[4] := Totals * 0.13;

                    "Total Year 1" := "Total Year 1" + Overhead[1];
                    "Total Year 2" := "Total Year 2" + Overhead[2];
                    "Total Year 3" := "Total Year 3" + Overhead[3];
                    Totals := Totals + Overhead[4];
                end;

                trigger OnPreDataItem()
                begin

                    LastFieldNo := FieldNo("Grant Contract Entry No.");

                    //************Code on Pre-section*********************

                    //CurrReport.SHOWOUTPUT :=
                    //CurrReport.TOTALSCAUSEDBY = "Job-Planning Line".FIELDNO("Budget Grouping Code");
                end;
            }
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
        Overhead: array[4] of Decimal;
        Totals: Decimal;
        LastFieldNo: Integer;
        AMPATH_Contribution_CaptionLbl: Label '<AMPATH Contribution>';
        Budget_Grouping_CodeCaptionLbl: Label 'Budget Grouping Code';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Grant_NoCaptionLbl: Label 'Grant No';
        Job_Planning_LineCaptionLbl: Label 'Job Planning Line';
        Overhead_13_CaptionLbl: Label 'Overhead 13%';
        PROJECT_APPROVED_BUDGETCaptionLbl: Label 'PROJECT APPROVED BUDGET';
        Sub_TotalCaptionLbl: Label 'Sub-Total';
        Total_Year_1CaptionLbl: Label 'Total Year 1';
        Total_Year_2CaptionLbl: Label 'Total Year 2';
        Total_Year_3CaptionLbl: Label 'Total Year 3';
        TotalCaptionLbl: Label 'Total';
        TotalFor: Label 'Sub Total';
}

