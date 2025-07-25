report 60004 "Partner Budgets"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/PartnerBudgets.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
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
            column(UPPERCASE_Description_; UpperCase(Description))
            {
            }
            column(JobCaption; JobCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PARTNER_BUDGETSCaption; PARTNER_BUDGETSCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Jobs__No__Caption; FieldCaption("No."))
            {
            }
            column(Name; Jobs.Description)
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
                    column(Job_Planning_Line__Total_Year_2_; "Total Year 2")
                    {
                    }
                    column(Job_Planning_Line__Total_Year_1_; "Total Year 1")
                    {
                    }
                    column(Job_Planning_Line__Total_Year_3_; "Total Year 3")
                    {
                    }
                    column(Totals; Totals)
                    {
                    }
                    column(Overhead_4_; Overhead[4])
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
                    column(Job_Planning_Line__Total_Year_1__Control1102755039; "Total Year 1")
                    {
                    }
                    column(Job_Planning_Line__Total_Year_2__Control1102755040; "Total Year 2")
                    {
                    }
                    column(Job_Planning_Line__Total_Year_3__Control1102755042; "Total Year 3")
                    {
                    }
                    column(Totals_Control1102755045; Totals)
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
                    column(Job_Planning_Line__Total_Year_2_Caption; FieldCaption("Total Year 2"))
                    {
                    }
                    column(Job_Planning_Line__Total_Year_3_Caption; FieldCaption("Total Year 3"))
                    {
                    }
                    column(TotalCaption; TotalCaptionLbl)
                    {
                    }
                    column(Overheads_7_5_Caption; Overheads_7_5_CaptionLbl)
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
                        Totals := "Total Year 1" + "Total Year 2" + "Total Year 3";
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
        Overhead: array[4] of Decimal;
        Totals: Decimal;
        Budget_DescriptionCaptionLbl: Label 'Budget Description';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DescriptionCaptionLbl: Label 'Description';
        JobCaptionLbl: Label 'Job';
        Overheads_7_5_CaptionLbl: Label 'Overheads 7.5%';
        PARTNER_BUDGETSCaptionLbl: Label 'PARTNER BUDGETS';
        Partner_CodeCaptionLbl: Label 'Partner Code';
        Partner_NameCaptionLbl: Label 'Partner Name';
        TotalCaptionLbl: Label 'Total';
        TotalsCaptionLbl: Label 'Totals';
}

