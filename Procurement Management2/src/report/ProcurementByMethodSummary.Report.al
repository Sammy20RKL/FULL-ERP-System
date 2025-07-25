report 53051 "Procurement By Method Summary"
{
    ApplicationArea = All;
    Caption = 'Procurement Requests By Method Summarized';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ProcurementByMethodSummary.rdl';

    dataset
    {
        dataitem(ProcurementEvaluationHeader; "Procurement Evaluation Header")
        {
            RequestFilterFields = "Process Type", Status, "LPO/Contract Generated";
            column(No; "No.")
            {
            }
            column(RefNo; "Ref No.")
            {
            }
            column(ProcessType; "Process Type")
            {
            }
            column(RequisitionNo; "Requisition No")
            {
            }
            column(Status; Status)
            {
            }
            column(Title; Title)
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(QuotationDeadline; ProcurementRequest."Quotation Deadline")
            {
            }
            column(TenderStatus; "Status")
            {
            }
            column(TenderType; ProcurementRequest."Tender Type")
            {
            }
            column(TenderClosingDate; ProcurementRequest.TenderClosingDate)
            {
            }
            column(TenderOpeningDate; ProcurementRequest.TenderOpeningDate)
            {
            }
            column(LPOContractGenerated; "LPO/Contract Generated")
            {
            }
            column(LPOContractNo; "LPO/Contract No.")
            {
            }
            column(UserID; ProcurementRequest."User ID")
            {
            }
            column(ResponsibilityCentre; "Responsibility Centre")
            {
            }
            column(ResponsibleUser; GetUserName(ResponsibilityCenter."Head User"))
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }
            column(Country; CompanyInfo."Country/Region Code")
            {
            }
            dataitem("Procurement Evaluation Line"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Vendor No", "No.", "Line No");

                column(VendorNo_ProcurementEvaluationLine; "Vendor No")
                {
                }
                column(VendorName_ProcurementEvaluationLine; "Vendor Name")
                {
                }
                column(UnitAmount_ProcurementEvaluationLine; "Unit Amount")
                {
                }
                column(AmountInclusiveVAT_ProcurementEvaluationLine; "Amount Inclusive VAT")
                {
                }
            }
            dataitem(AwardedLine; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Vendor No", "No.", "Line No") where(Awarded = const(true));
                column(VendorNo_AwardedLine; "Vendor No")
                {
                }
                column(VendorName_AwardedLine; "Vendor Name")
                {
                }
                column(UnitAmount_AwardedLine; "Unit Amount")
                {
                }
                column(AmountInclusiveVAT_AwardedLine; "Amount Inclusive VAT")
                {
                }
                column(Quantity_AwardedLine; Quantity)
                {
                }
                column(No_AwardedLine; "No.")
                {
                }
                column(Description_AwardedLine; Description)
                {
                }
                column(Specifications; SpecificationsTxt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(SpecificationsBigTxt);
                    SpecificationsTxt := '';

                    CalcFields(Specification);
                    Specification.CreateInStream(Inst);
                    SpecificationsBigTxt.Read(Inst);
                    SpecificationsTxt := Format(SpecificationsBigTxt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if ProcurementRequest.Get(ProcurementEvaluationHeader."No.") then;

                if ResponsibilityCenter.Get(ProcurementEvaluationHeader."Responsibility Centre") then;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ProcurementRequest: Record "Procurement Request";
        ResponsibilityCenter: Record "Responsibility Center";
        SpecificationsBigTxt, RemarksBigTxt : BigText;
        SpecificationsTxt, RemarksTxt : Text;
        Inst: InStream;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        Users.Reset();
        Users.setrange("User Name", UserCode);
        if Users.FindFirst() THEN
            exit(Users."Full Name")
        else
            exit(UserCode);
    end;
}






