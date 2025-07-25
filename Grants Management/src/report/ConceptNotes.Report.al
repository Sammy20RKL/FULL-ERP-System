report 60007 "Concept Notes"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/ConceptNotes.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = const("Concept Formulation"));
            RequestFilterFields = "No.", Status;
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
            column(Jobs__Project_Investigator_; Jobs."Principal Investigator")
            {
            }
            column(Jobs__Global_Dimension_1_Code_; Jobs."Bill-to Partner No.")
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
            column(Jobs__Total_Cost_; "Total Cost")
            {
            }
            column(Jobs__Total_Cost_LCY__; "Total Cost(LCY)")
            {
            }
            column(JobCaption; JobCaptionLbl)
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
            column(Jobs__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
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
            column(Jobs__Total_Cost_Caption; FieldCaption("Total Cost"))
            {
            }
            column(Jobs__Total_Cost_LCY__Caption; FieldCaption("Total Cost(LCY)"))
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

    var
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        JobCaptionLbl: Label 'Job';
}

