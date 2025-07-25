report 53039 "Tender Summary"
{
    Caption = 'Tender Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderSummaryReport.rdl';
    dataset
    {
        dataitem(Tender; "Procurement Request")
        {
            column(No_Tender; "No.")
            {
            }
            column(Title_Tender; Title)
            {
            }
            column(TenderItemType_Tender; "Tender Item Type")
            {
            }
            column(EvaluationCriteria_Tender; "Award Criteria")
            {
            }
            column(RequisitionNo_Tender; "Requisition No")
            {
            }
            column(CreationDate_Tender; "Creation Date")
            {
            }
            column(ShortcutDimension1Code_Tender; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_Tender; "Shortcut Dimension 2 Code")
            {
            }
            column(UserID_Tender; "User ID")
            {
            }
            column(QuotationDeadline_Tender; "Quotation Deadline")
            {
            }
            column(ExpectedClosingTime_Tender; "Expected Closing Time")
            {
            }
            column(TechnicalPassMark_Tender; "Technical Pass Mark")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPic; CompanyInfo.Picture)
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
            dataitem(TenderCommitte; "Tender Committees")
            {
                DataItemLink = "Tender/Quotation No" = field("No.");
                dataitem(CommitteeMembers; "Committee Member")
                {
                    DataItemLink = "Appointment No" = field("Appointment No");
                    column(AppointmentNo_CommitteeMembers; "Appointment No")
                    {
                    }
                    column(CommitteeMemberNo_CommitteeMembers; "Committee Member No")
                    {
                    }
                    column(CommitteeMemberType_CommitteeMembers; "Committee Member Type")
                    {
                    }
                    column(Name_CommitteeMembers; Name)
                    {
                    }
                    column(EMailAddress_CommitteeMembers; "E-Mail Address")
                    {
                    }
                    column(Role_CommitteeMembers; Role)
                    {
                    }
                    column(UserID_CommitteeMembers; "User ID")
                    {
                    }
                }
            }
            dataitem(PurchaseRequest; "Internal Request Header")
            {
                DataItemLink = "No." = field("Requisition No");
                column(No_PurchaseRequest; "No.")
                {
                }
                column(DocumentDate_PurchaseRequest; "Document Date")
                {
                }
                column(OrderDate_PurchaseRequest; "Order Date")
                {
                }
                column(EmployeeName_PurchaseRequest; "Employee Name")
                {
                }
                column(EmployeeNo_PurchaseRequest; "Employee No.")
                {
                }
                column(ReasonDescription_PurchaseRequest; "Item Description")
                {
                }
                column(RequestedBy_PurchaseRequest; "Requested By")
                {
                }
                column(CurrencyCode_PurchaseRequest; "Currency Code")
                {
                }
                dataitem(PurchReqLines; "Internal Request Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    column(ProcurementPlanItem_PurchReqLines; "Procurement Plan Item")
                    {
                    }
                    column(Type_PurchReqLines; "Type")
                    {
                    }
                    column(No_PurchReqLines; "No.")
                    {
                    }
                    column(SupplierCategoryCode_PurchReqLines; "Supplier Category Code")
                    {
                    }
                    column(SupplierCategoryName_PurchReqLines; "Supplier Category Name")
                    {
                    }
                    column(Description_PurchReqLines; Description)
                    {
                    }
                    column(Quantity_PurchReqLines; Quantity)
                    {
                    }
                    column(PlannedQuantity_PurchReqLines; "Planned Quantity")
                    {
                    }
                    column(UnitCost_PurchReqLines; "Unit Cost")
                    {
                    }
                    column(AmountIncludingVAT_PurchReqLines; "Amount Including VAT")
                    {
                    }
                    column(ApprovedBudgetAmount_PurchReqLines; "Approved Budget Amount")
                    {
                    }
                    column(BudgetBalanceAfter_PurchReqLines; "Budget Balance After")
                    {
                    }
                    column(CurrentBudgetBalance_PurchReqLines; "Current Budget Balance")
                    {
                    }
                    column(BudgetLine_PurchReqLines; "Budget Line")
                    {
                    }
                    column(UnitofMeasure_PurchReqLines; "Unit of Measure")
                    {
                    }
                    column(Specification_PurchReqLines; Specification)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CalcFields(Specification);
                        Specification.CreateInStream(SpecInstr);
                        SpecificationsBigTxt.Read(SpecInstr);
                        SpecificationsTxt := Format(SpecificationsBigTxt);
                    end;
                }
            }
            dataitem(TenderApplicants; "Tender Applicant")
            {
                DataItemLink = "Tender No." = field("No.");
                column(SupplierCategory_TenderApplicants; "Supplier Category")
                {
                }
                column(SupplierCode_TenderApplicants; "Supplier Code")
                {
                }
                column(SupplierName_TenderApplicants; "Supplier Name")
                {
                }
                column(SupplierEmail_TenderApplicants; "Supplier Email")
                {
                }
                column(TenderApplicantStage_TenderApplicants; "Tender Applicant Stage")
                {
                }
            }
            dataitem(BidderSelection; "Supplier Selection")
            {
                DataItemLink = "Reference No." = field("No.");
                column(SupplierCategory_BidderSelection; "Supplier Category")
                {
                }
                column(SupplierCode_BidderSelection; "Supplier Code")
                {
                }
                column(SupplierName_BidderSelection; "Supplier Name")
                {
                }
                column(SupplierEmail_BidderSelection; "Supplier Email")
                {
                }
            }
            dataitem(Evaluation; "Supplier Evaluation Header")
            {
                DataItemLink = "Quote No" = field("No.");
                column(EvaluationStage_Evaluation; "Evaluation Stage")
                {
                }
                column(No_Evaluation; "No.")
                {
                }
                column(Quote_No_Evaluation; "Quote No")
                {
                }
                column(Total_Score_Evaluation; "Total Score")
                {
                }
                column(User_Evaluation; User)
                {
                }
                column(AverageTechnicalScore_Evaluation; "Average Technical Score")
                {
                }

                dataitem(PreliminaryEvaluationScore; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Score Parameter") where("Evaluation Criteria" = const("Preliminary Evaluation"));

                    column(Score_Parameter; "Score Parameter")
                    {
                    }
                    column(Score_DescriptionHeader; "Score Description")
                    {
                    }
                    column(Supplier_Code; "Supplier Code")
                    {
                    }
                    column(Supplier_Name; GetSupplierName("Supplier Code"))
                    {
                    }
                    column(Total_ScoreHeader; "Total Parameter Score")
                    {
                    }
                    column(BlobDescription; DescTxt)
                    {
                    }
                    dataitem(EvaluationScores; "Supplier Evaluation Score Line")
                    {
                        DataItemLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");
                        DataItemTableView = sorting("Line No.");
                        column(Score_DescriptionLine; ScoreDescTxt)
                        {
                        }
                        column(Score; LineScore)
                        {
                        }
                        column(ScoreCriteria; "Score Criteria")
                        {
                        }
                        column(PassFail; Format("Pass/Fail"))
                        {
                        }
                        column(Maximum_Score; "Maximum Score")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ScoreSetupLines.Reset();
                            ScoreSetupLines.SetRange(Code, EvaluationScores."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", EvaluationScores."Line No.");
                            if ScoreSetupLines.FindFirst() then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxt.Read(ScoreInstrm);
                                ScoreDescTxt := Format(ScoreDescBigTxt);
                            end;

                            case EvaluationScores."Score Criteria" of
                                EvaluationScores."Score Criteria"::"Pass/Fail":
                                    LineScore := EvaluationScores."Pass/Fail Score";
                                EvaluationScores."Score Criteria"::Score:
                                    LineScore := EvaluationScores.Score;
                            end;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, PreliminaryEvaluationScore."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);
                        end;
                    end;
                }
                dataitem(TechnicalGoodsEvaluationScore; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Score Parameter") where("Evaluation Criteria" = const("Technical Evaluation"), "Tender Item Type" = const(Goods));

                    column(Score_ParameterTechGoods; "Score Parameter")
                    {
                    }
                    column(Score_DescriptionHeaderTechGoods; "Score Description")
                    {
                    }
                    column(Supplier_CodeTechGoods; "Supplier Code")
                    {
                    }
                    column(Supplier_NameTechGoods; GetSupplierName("Supplier Code"))
                    {
                    }
                    column(Total_ScoreHeaderTechGoods; "Total Parameter Score")
                    {
                    }
                    column(BlobDescriptionTechGoods; DescTxtTechGoods)
                    {
                    }
                    dataitem(EvaluationScoresTechGoods; "Supplier Evaluation Score Line")
                    {
                        DataItemLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");
                        DataItemTableView = sorting("Line No.");
                        column(Score_DescriptionLineTechGoods; ScoreDescTxtTechGoods)
                        {
                        }
                        column(ScoreTechGoods; "Score")
                        {
                        }
                        column(ScoreCriteriaTechGoods; "Score Criteria")
                        {
                        }
                        column(ConformTechGoods; Format("Conform/Not Conform"))
                        {
                        }
                        column(Maximum_ScoreTechGoods; "Maximum Score")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ScoreSetupLines.Reset();
                            ScoreSetupLines.SetRange(Code, EvaluationScoresTechGoods."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", EvaluationScoresTechGoods."Line No.");
                            if ScoreSetupLines.FindFirst() then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxtTechGoods.Read(ScoreInstrm);
                                ScoreDescTxtTechGoods := Format(ScoreDescBigTxtTechGoods);
                            end;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, TechnicalGoodsEvaluationScore."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxtTechGoods.Read(Instrm);
                            DescTxtTechGoods := Format(DescBigTxtTechGoods);
                        end;
                    end;
                }
                dataitem(TechnicalServicesEvaluationScore; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Score Parameter") where("Evaluation Criteria" = const("Technical Evaluation"), "Tender Item Type" = const(Services));

                    column(Score_ParameterTechServices; "Score Parameter")
                    {
                    }
                    column(Score_DescriptionHeaderTechServices; "Score Description")
                    {
                    }
                    column(Supplier_CodeTechServices; "Supplier Code")
                    {
                    }
                    column(Supplier_NameTechServices; GetSupplierName("Supplier Code"))
                    {
                    }
                    column(Total_ScoreHeaderTechServices; "Total Parameter Score")
                    {
                    }
                    column(BlobDescriptionTechServices; DescTxtTechServices)
                    {
                    }
                    dataitem(EvaluationScoresTechServices; "Supplier Evaluation Score Line")
                    {
                        DataItemLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");
                        DataItemTableView = sorting("Line No.");
                        column(Score_DescriptionLineTechServices; ScoreDescTxtTechServices)
                        {
                        }
                        column(ScoreTechServices; Score)
                        {
                        }
                        column(ScoreCriteriaTechServices; "Score Criteria")
                        {
                        }
                        column(PassFailTechServices; Format("Pass/Fail"))
                        {
                        }
                        column(Maximum_ScoreTechServices; "Maximum Score")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ScoreSetupLines.Reset();
                            ScoreSetupLines.SetRange(Code, EvaluationScoresTechServices."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", EvaluationScoresTechServices."Line No.");
                            if ScoreSetupLines.FindFirst() then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxtTechServices.Read(ScoreInstrm);
                                ScoreDescTxtTechServices := Format(ScoreDescBigTxtTechServices);
                            end;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, TechnicalServicesEvaluationScore."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxtTechServices.Read(Instrm);
                            DescTxtTechServices := Format(DescBigTxtTechServices);
                        end;
                    end;
                }
            }
            dataitem(FinancialEvaluation; "Procurement Evaluation Header")
            {
                DataItemLink = "No." = field("No.");
                column(QuoteNo_FinancialEvaluation; "No.")
                {
                }
                column(RefNo_FinancialEvaluation; "Ref No.")
                {
                }
                column(Title_FinancialEvaluation; Title)
                {
                }
                column(RequisitionNo_FinancialEvaluation; "Requisition No")
                {
                }
                column(CreationDate_FinancialEvaluation; "Creation Date")
                {
                }
                column(CalculationType_FinancialEvaluation; "Calculation Type")
                {
                }
                column(EvaluationCriteria_FinancialEvaluation; "Evaluation Criteria")
                {
                }
                column(ShortcutDimension1Code_FinancialEvaluation; "Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_FinancialEvaluation; "Shortcut Dimension 2 Code")
                {
                }
                column(PreparedBy_FinancialEvaluation; "Prepared By")
                {
                }
                column(RemarksTxt_FinancialEvaluation; RemarksTxt)
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
                    column(Specifications_TenderEvaluationLine; FinSpecificationsTxt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CalcFields(Specification);
                        Specification.CreateInStream(Inst);
                        FinSpecificationsBigTxt.Read(Inst);
                        FinSpecificationsTxt := Format(FinSpecificationsBigTxt);
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
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ProspectRec: Record "Prospective Suppliers";
        SupScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLines: Record "Supplier Evaluation Setup Line";
        DescBigTxt, ScoreDescBigTxt, SpecificationsBigTxt, ScoreDescBigTxtTechGoods, ScoreDescBigTxtTechServices, DescBigTxtTechServices, DescBigTxtTechGoods, RemarksBigTxt, FinSpecificationsBigTxt : BigText;
        Inst, Instrm, ScoreInstrm, SpecInstr : InStream;
        DescTxt, ScoreDescTxt, SpecificationsTxt, ScoreDescTxtTechGoods, ScoreDescTxtTechServices, DescTxtTechServices, DescTxtTechGoods, RemarksTxt, FinSpecificationsTxt : Text;
        LineScore: Decimal;

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.Get(SupplierCode) then
            exit(ProspectRec.Name);
    end;
}






