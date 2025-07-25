report 60002 "Partner Returns"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/PartnerReturns.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = filter(Project));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
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
            column(Jobs__No__; "No.")
            {
            }
            column(Jobs_Description; Description)
            {
            }
            column(Jobs__Contract_No_; "Contract No")
            {
            }
            column(Jobs__Starting_Date_; "Starting Date")
            {
            }
            column(Jobs__Ending_Date_; "Ending Date")
            {
            }
            column(Jobs__Currency_Code_; "Currency Code")
            {
            }
            column(JobCaption; JobCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Jobs_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Jobs__No__Caption; FieldCaption("No."))
            {
            }
            column(Jobs__Contract_No_Caption; FieldCaption("Contract No"))
            {
            }
            column(Project_PeriodCaption; Project_PeriodCaptionLbl)
            {
            }
            column(Jobs__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(ToCaption; ToCaptionLbl)
            {
            }
            column(Financial_StatementCaption; Financial_StatementCaptionLbl)
            {
            }
            dataitem(ProjectPartners; "Project Partners")
            {
                DataItemLink = "Grant No" = field("No.");
                DataItemTableView = sorting(PartnerID, "Grant No") order(ascending);
                column(UPPERCASE__Partner_Name__; UpperCase("Partner Name"))
                {
                }
                column(ProjectPartners_PartnerID; PartnerID)
                {
                }
                column(Partner_NameCaption; Partner_NameCaptionLbl)
                {
                }
                column(Partner_CodeCaption; Partner_CodeCaptionLbl)
                {
                }
                column(ProjectPartners_Grant_No; "Grant No")
                {
                }
                dataitem("Job-Planning Line"; "Job-Planning Line")
                {
                    DataItemLink = Partner = field(PartnerID), "Grant No." = field("Grant No");
                    DataItemTableView = sorting("Grant No.", "Grant Task No.", "Line No.") order(ascending);
                    column(Job_Planning_Line__No__; "No.")
                    {
                    }
                    column(Job_Planning_Line_Description; Description)
                    {
                    }
                    column(Job_Planning_Line__Total_Year_1_; "Total Year 1")
                    {
                    }
                    column(Totals; Totals)
                    {
                    }
                    column(Job_Planning_Line__Disbursed_Amount_; "Disbursed Amount")
                    {
                    }
                    column(Job_Planning_Line__Job_Planning_Line___Accounted_Amount_; "Job-Planning Line"."Accounted Amount")
                    {
                    }
                    column(Job_Planning_Line__Total_Year_1__Control1102755039; "Total Year 1")
                    {
                    }
                    column(Totals_Control1102755045; Totals)
                    {
                    }
                    column(Job_Planning_Line__Disbursed_Amount__Control1102755047; "Disbursed Amount")
                    {
                    }
                    column(Job_Planning_Line__Job_Planning_Line___Accounted_Amount__Control1102755053; "Job-Planning Line"."Accounted Amount")
                    {
                    }
                    column(Job_Planning_Line__No__Caption; FieldCaption("No."))
                    {
                    }
                    column(Budget_DescriptionCaption; Budget_DescriptionCaptionLbl)
                    {
                    }
                    column(Job_Planning_Line__Total_Year_1_Caption; FieldCaption("Total Year 1"))
                    {
                    }
                    column(Total_Budget_____Year_1___Year_3Caption; Total_Budget_____Year_1___Year_3CaptionLbl)
                    {
                    }
                    column(Job_Planning_Line__Disbursed_Amount_Caption; FieldCaption("Disbursed Amount"))
                    {
                    }
                    column(Current_ActualCaption; Current_ActualCaptionLbl)
                    {
                    }
                    column(TotalsCaption; TotalsCaptionLbl)
                    {
                    }
                    column(Job_Planning_Line_Grant_No_; "Grant No.")
                    {
                    }
                    column(Job_Planning_Line_Grant_Task_No_; "Grant Task No.")
                    {
                    }
                    column(Job_Planning_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Job_Planning_Line_Partner; Partner)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        "Job-Planning Line".CalcFields("Job-Planning Line"."Total Year 1");
                        "Job-Planning Line".CalcFields("Job-Planning Line"."Total Year 2");
                        "Job-Planning Line".CalcFields("Job-Planning Line"."Total Year 3");
                        "Job-Planning Line".CalcFields("Job-Planning Line"."Accounted Amount");
                        "Job-Planning Line".CalcFields("Job-Planning Line"."Disbursed Amount");

                        Totals := "Total Year 1" + "Total Year 2" + "Total Year 3";

                        "Unaccounted Amount" := "Disbursed Amount" - "Accounted Amount";
                    end;

                    trigger OnPreDataItem()
                    begin

                        CurrReport.CreateTotals("Total Year 1", "Total Year 2", "Total Year 3", Totals);
                    end;
                }
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
        Totals: Decimal;
        Budget_DescriptionCaptionLbl: Label 'Budget Description';
        Current_ActualCaptionLbl: Label 'Current Actual';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Financial_StatementCaptionLbl: Label 'Financial Statement';
        JobCaptionLbl: Label 'Job';
        Partner_CodeCaptionLbl: Label 'Partner Code';
        Partner_NameCaptionLbl: Label 'Partner Name';
        Project_PeriodCaptionLbl: Label 'Project Period';
        ToCaptionLbl: Label 'To';
        Total_Budget_____Year_1___Year_3CaptionLbl: Label 'Total Budget     Year 1 - Year 3';
        TotalsCaptionLbl: Label 'Totals';
}

