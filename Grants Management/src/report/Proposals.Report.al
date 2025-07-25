report 60000 Proposals
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/Proposals.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = const(Proposal));
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
            column(Jobs__Project_Investigator_; "Principal Investigator")
            {
            }
            column(Jobs__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Jobs__Job_Posting_Group_; "Job Posting Group")
            {
            }
            column(Jobs__Concept_Number_; "Concept Number")
            {
            }
            column(Jobs_Partners; Partners)
            {
            }
            column(ProposalsCaption; ProposalsCaptionLbl)
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
            column(ClusterCaption; ClusterCaptionLbl)
            {
            }
            column(Related_Concept_NoCaption; Related_Concept_NoCaptionLbl)
            {
            }
            column(Jobs_PartnersCaption; FieldCaption(Partners))
            {
            }
            column(PIName_Jobs; Jobs."Principal Investigator name")
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
        ClusterCaptionLbl: Label 'Cluster';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ProposalsCaptionLbl: Label 'Proposals';
        Related_Concept_NoCaptionLbl: Label 'Related Concept No';
}

