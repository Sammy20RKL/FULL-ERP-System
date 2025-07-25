report 60008 "Grant Projects"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/GrantProjects.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = const(Project));
            RequestFilterFields = "No.", Status, "Job Posting Group", "Grant Level", "Ending Date";
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo__Phone_No__; CompInfo."Phone No.")
            {
            }
            column(CompInfo__Fax_No__; CompInfo."Fax No.")
            {
            }
            column(CompInfo__E_Mail_; CompInfo."E-Mail")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Jobs__No__; "No.")
            {
            }
            column(Jobs_Description; Description)
            {
            }
            column(Jobs__Project_Investigator_; "Principal Investigator")
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
            column(Jobs_Partners; Partners)
            {
            }
            column(Jobs__Contract_No_; "Contract No")
            {
            }
            column(Jobs__Job_Posting_Group_; "Job Posting Group")
            {
            }
            column(Jobs__Project_Location_; "Project Location")
            {
            }
            column(Jobs__Income_Account_; "Income Account")
            {
            }
            column(Jobs__Reporting_dates_generated_; "Reporting dates generated")
            {
            }
            column(Jobs__Total_Cost_; "Total Cost")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Jobs__No__Caption; FieldCaption("No."))
            {
            }
            column(Jobs_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Jobs__Project_Investigator_Caption; FieldCaption("Principal Investigator"))
            {
            }
            column(Jobs__Starting_Date_Caption; FieldCaption("Starting Date"))
            {
            }
            column(Jobs__Ending_Date_Caption; FieldCaption("Ending Date"))
            {
            }
            column(Jobs__Currency_Code_Caption; FieldCaption("Currency Code"))
            {
            }
            column(Jobs_PartnersCaption; FieldCaption(Partners))
            {
            }
            column(Jobs__Contract_No_Caption; FieldCaption("Contract No"))
            {
            }
            column(Cluster_NameCaption; Cluster_NameCaptionLbl)
            {
            }
            column(Jobs__Project_Location_Caption; FieldCaption("Project Location"))
            {
            }
            column(Jobs__Income_Account_Caption; FieldCaption("Income Account"))
            {
            }
            column(Jobs__Reporting_dates_generated_Caption; FieldCaption("Reporting dates generated"))
            {
            }
            column(Budgeted_CostCaption; Budgeted_CostCaptionLbl)
            {
            }
            column(PI_Name; Jobs."Principal Investigator name")
            {
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

    trigger OnInitReport()
    begin
        CompInfo.Get();
    end;

    trigger OnPreReport()
    begin
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Budgeted_CostCaptionLbl: Label 'Budgeted Cost';
        Cluster_NameCaptionLbl: Label 'Cluster Name';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

