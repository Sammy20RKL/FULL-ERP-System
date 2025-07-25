report 53038 "Tender Scores"
{
    Caption = 'Tender Scores';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderScores.rdl';
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
        DescBigTxt, ScoreDescBigTxt, SpecificationsBigTxt, ScoreDescBigTxtTechGoods, ScoreDescBigTxtTechServices, DescBigTxtTechServices, DescBigTxtTechGoods : BigText;
        Instrm, ScoreInstrm, SpecInstr : InStream;
        DescTxt, ScoreDescTxt, SpecificationsTxt, ScoreDescTxtTechGoods, ScoreDescTxtTechServices, DescTxtTechServices, DescTxtTechGoods : Text;
        LineScore: Decimal;

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.Get(SupplierCode) then
            exit(ProspectRec.Name);
    end;
}






