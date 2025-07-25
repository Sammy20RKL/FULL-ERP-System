report 53041 "RFQ Financial Evaluation"
{
    Caption = 'RFQ Financial Evaluation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/RFQFinancialEvaluation.rdl';
    dataset
    {
        dataitem(TenderEvaluationHeader; "Procurement Evaluation Header")
        {
            column(QuoteNo; "No.")
            {
            }
            column(RefNo; "Ref No.")
            {
            }
            column(Title; Title)
            {
            }
            column(RequisitionNo; "Requisition No")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(CalculationType; "Calculation Type")
            {
            }
            column(EvaluationCriteria; "Evaluation Criteria")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(PreparedBy; "Prepared By")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(RemarksTxt; RemarksTxt)
            {
            }

            dataitem(TenderEvaluationLine; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");

                column(VendorNo_TenderEvaluationLine; "Vendor No")
                {
                }
                column(VendorName_TenderEvaluationLine; "Vendor Name")
                {
                }
                column(Type_TenderEvaluationLine; "Type")
                {
                }
                column(No_TenderEvaluationLine; "No.")
                {
                }
                column(Description_TenderEvaluationLine; Description)
                {
                }
                column(LineNo_TenderEvaluationLine; "Line No")
                {
                }
                column(QuoteNo_TenderEvaluationLine; "Document No.")
                {
                }
                column(Quantity_TenderEvaluationLine; Quantity)
                {
                }
                column(UnitofMeasure_TenderEvaluationLine; "Unit of Measure")
                {
                }
                column(UnitAmount_TenderEvaluationLine; "Unit Amount")
                {
                }
                column(Amount_TenderEvaluationLine; Amount)
                {
                }
                column(AmountInclusiveVAT_TenderEvaluationLine; "Amount Inclusive VAT")
                {
                }
                column(NegotiatedUnitAmount_TenderEvaluationLine; "Negotiated Unit Amount")
                {
                }
                column(VATAmount_TenderEvaluationLine; "VAT Amount")
                {
                }
                column(VATAmountLCY_TenderEvaluationLine; "VAT Amount (LCY)")
                {
                }
                column(FinancialScore_TenderEvaluationLine; "Financial Score")
                {
                }
                column(Awarded_TenderEvaluationLine; Awarded)
                {
                }
                column(Suggested_TenderEvaluationLine; Suggested)
                {
                }
                column(Specifications; SpecificationsTxt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Specification);
                    Specification.CreateInStream(Inst);
                    SpecificationsBigTxt.Read(Inst);
                    SpecificationsTxt := Format(SpecificationsBigTxt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Remarks);
                Remarks.CreateInStream(Inst);
                RemarksBigTxt.Read(Inst);
                RemarksTxt := Format(RemarksBigTxt);
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
        SpecificationsBigTxt, RemarksBigTxt : BigText;
        SpecificationsTxt, RemarksTxt : Text;
        Inst: InStream;

}






