report 53012 "Supplier Award Letter"
{
    DefaultLayout = RDLC;
    applicationArea = Basic, Suite;
    Caption = 'Supplier Award Letter';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './src/report_layout/SupplierAwardLetterUNSacco.rdl';

    dataset
    {
        dataitem("Tender Evaluation Line"; "Procurement Evaluation Line")
        {
            RequestFilterFields = "Document No.", "Vendor No";
            DataItemTableView = where(Awarded = const(true));

            column(QuoteNo; "Document No.")
            {
            }
            column(AwardingCommittee; TenderEvaluation."Awarding Committee")
            {
            }
            column(RequisitionNo; TenderEvaluation."Requisition No")
            {
            }
            column(Title; TenderEvaluation.Title)
            {
            }
            column(DateofAward; TenderEvaluation."Date of Award")
            {
            }
            column(Ref_No_; TenderEvaluation."Ref No.")
            {
            }
            column(ContactPersonName; TenderEvaluation."Contact Person Name")
            {
            }
            column(ContactJobPosition; TenderEvaluation."Contact Job Position")
            {
            }
            column(ContactJobPositionTitle; TenderEvaluation."Contact Job Position Title")
            {
            }
            column(ContractDate; TenderEvaluation."Contract Date")
            {
            }
            column(PaymentTerms; PaymentTermsDesc)
            {
            }
            column(CreationDate; TenderEvaluation."Creation Date")
            {
            }
            column(SignOffEmployee; TenderEvaluation."Sign-Off Employee")
            {
            }
            column(SignOffEmployeeName; TenderEvaluation."Sign-Off Employee Name")
            {
            }
            column(SignOffEmployeeTitle; TenderEvaluation."Sign-Off Employee Title")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(Vendor_No; "Vendor No")
            {
            }
            column(Vendor_Name; "Vendor Name")
            {
            }
            column(ContPersonTitle; Prospective.Title)
            {
            }
            column(Amount_TenderEvaluationLine; Amount)
            {
            }
            column(TenderAmtAmount; "Amount Inclusive VAT")
            {
            }
            column(TotalAmountREg; TotalAmountREg)
            { }
            column(TenderAmtDescription; "VAT Amount")
            {
            }
            column(NegotiatedUnitAmount_TenderEvaluationLine; "Negotiated Unit Amount")
            {
            }
            column(ContPersonName; Prospective."Contact Person Name")
            {
            }
            column(ContPersonJobTitle; Prospective."Job Title")
            {
            }
            column(ContPersonPhysicalAddress; Prospective."Physical Address")
            {
            }
            column(ContPersonAddress; Prospective."Postal Address")
            {
            }
            column(ContPersonCity; Prospective.City)
            {
            }
            column(ContPersonCountry; Prospective."Country/Region Code")
            {
            }
            column(ContPersonPhone; Prospective."Contact Phone No.")
            {
            }
            column(AmtInWords; NumberText[1])
            {
            }
            column(Awarded_TenderEvaluationLine; Awarded)
            {
            }
            dataitem("Tender Scope of Work"; "Tender Scope of Work")
            {
                DataItemLink = "Tender No." = field("Document No.");
                DataItemTableView = sorting("Line No.") order(ascending);
                column(TenderScopeType; "Scope Type")
                {
                }
                column(TenderScopeDescription; Description)
                {
                }
                column(TenderScopeIndentation; Indentation)
                {
                }
                column(TenderScopeTenderNo; "Tender No.")
                {
                }
                column(TenderScopeLineNo; "Line No.")
                {
                }
            }
            dataitem("Tender Amount"; "Tender Amount")
            {
                DataItemLink = "Tender No." = field("Document No.");
                DataItemTableView = sorting("Line No.") order(ascending);

                column(TenderAmtIndentation; Indentation)
                {
                }
                column(TenderAmtScopeType; "Scope Type")
                {
                }
                column(TenderAmtTenderNo; "Tender No.")
                {
                }
                column(TenderAmtLineNo; "Line No.")
                {
                }
            }
            //Procurement Ev Criteria Line (53090)
            dataitem("Procurement Ev Criteria Line"; "Procurement Ev Criteria Line")
            {
                DataItemLink = "Document No." = field("Document No.");
                // DataItemTableView = where ("Vendor No"= ve);

                column(Vendor_Nocriteria; "Vendor No")
                {

                }
                column(Total_Amount; "Total Amount") { }


            }
            trigger OnAfterGetRecord()
            begin
                TenderEvaluation.Get("Tender Evaluation Line"."Document No.");

                if Prospective.Get("Tender Evaluation Line"."Vendor No") then;

                PaymentMgt.InitTextVariable();
                PaymentMgt.FormatNoText(NumberText, "Amount Inclusive VAT", '');

                if PayTerms.Get(TenderEvaluation."Payment Terms") then
                    PaymentTermsDesc := PayTerms.Description;

                //**********************************************
                TotalAmountREg := 0;
                repeat
                    TotalAmountREg := TotalAmountREg + "Amount Inclusive VAT";
                Until "Tender Evaluation Line".Next = 0;
                // Message('totalamount is %1', TotalAmountREg);
            end;

        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        TotalAmountREg: Decimal;
        CompanyInfo: Record "Company Information";
        PayTerms: Record "Payment Terms";
        Prospective: Record "Prospective Suppliers";
        TenderEvaluation: Record "Procurement Evaluation Header";
        PaymentTermsDesc: Text;
        PaymentMgt: Codeunit "Payments Management";
        NumberText: array[2] of Text;
}





