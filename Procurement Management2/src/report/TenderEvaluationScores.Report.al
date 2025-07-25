report 53011 "Tender Evaluation Scores"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderEvaluationScores.rdl';

    dataset
    {
        dataitem(TenderCommittees; "Tender Committees")
        {
            DataItemTableView = sorting("Appointment No");

            column(AppointmentNo; "Appointment No")
            {
            }
            column(CommitteeID; "Committee ID")
            {
            }
            column(CommitteeName; "Committee Name")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(TenderQuotationNo; "Tender/Quotation No")
            {
            }
            column(Title; Title)
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
            dataitem("Supplier Evaluation Header"; "Supplier Evaluation Header")
            {
                DataItemLink = "Committee No." = field("Appointment No");

                column(No_; "No.")
                {
                }
                column(Quote_No; "Quote No")
                {
                }
                column(Total_Score; "Total Score")
                {
                }
                column(User; User)
                {
                }
                dataitem("Supplier Evaluation Score"; "Supplier Evaluation Score")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Score Parameter");

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
                    dataitem("Supplier Evaluation Score Line"; "Supplier Evaluation Score Line")
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
                        column(Y_N; "Pass/Fail")
                        {
                        }
                        column(Maximum_Score; "Maximum Score")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ScoreSetupLines.Reset();
                            ScoreSetupLines.SetRange(Code, "Supplier Evaluation Score Line"."Score Parameter");
                            ScoreSetupLines.SetRange("Line No.", "Supplier Evaluation Score Line"."Line No.");
                            if ScoreSetupLines.FindFirst() then begin
                                ScoreSetupLines.CalcFields(Description);
                                ScoreSetupLines.Description.CreateInStream(ScoreInstrm);
                                ScoreDescBigTxt.Read(ScoreInstrm);
                                ScoreDescTxt := Format(ScoreDescBigTxt);
                            end;

                            case "Supplier Evaluation Score Line"."Score Criteria" of
                                "Supplier Evaluation Score Line"."Score Criteria"::"Pass/Fail":
                                    LineScore := "Supplier Evaluation Score Line"."Pass/Fail Score";
                                "Supplier Evaluation Score Line"."Score Criteria"::Score:
                                    LineScore := "Supplier Evaluation Score Line".Score;
                            end;


                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        SupScoreSetup.Reset();
                        SupScoreSetup.SetRange(Code, "Supplier Evaluation Score"."Score Parameter");
                        if SupScoreSetup.FindFirst() then begin
                            SupScoreSetup.CalcFields(Description);
                            SupScoreSetup.Description.CreateInStream(Instrm);
                            DescBigTxt.Read(Instrm);
                            DescTxt := Format(DescBigTxt);
                        end;

                        /*"Supplier Evaluation Score".CalcFields(Description);
                        "Supplier Evaluation Score".Description.CreateInStream(Instrm);
                        DescBigTxt.Read(Instrm);
                        DescTxt := Format(DescBigTxt);*/
                    end;
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
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
        DescBigTxt: BigText;
        ScoreDescBigTxt: BigText;
        Instrm: InStream;
        ScoreInstrm: InStream;
        DescTxt: Text;
        ScoreDescTxt: Text;
        LineScore: Decimal;

    local procedure GetSupplierName(SupplierCode: Code[50]): Text
    begin
        if ProspectRec.Get(SupplierCode) then
            exit(ProspectRec.Name);
    end;
}





