report 53031 "RFQ Analysis-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/RFQAnalysis2.rdl';

    dataset
    {
        dataitem("Quote Evaluation Header"; "Procurement Evaluation Header")
        {
            CalcFields = "Least Amount";
            RequestFilterFields = "No.";

            column(QuoteNo_QuoteEvaluationHeader; "Quote Evaluation Header"."No.")
            {
            }
            column(Title_QuoteEvaluationHeader; "Quote Evaluation Header".Title)
            {
            }
            column(RequisitionNo_QuoteEvaluationHeader; "Quote Evaluation Header"."Requisition No")
            {
            }
            column(QuoteGenerated_QuoteEvaluationHeader; "Quote Evaluation Header"."LPO/Contract Generated")
            {
            }
            column(Minutes_QuoteEvaluationHeader; "Quote Evaluation Header".Minutes)
            {
            }
            column(AwardingCommittee_QuoteEvaluationHeader; "Quote Evaluation Header"."Awarding Committee")
            {
            }
            column(DateofAward_QuoteEvaluationHeader; "Quote Evaluation Header"."Date of Award")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
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
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            dataitem("Quote Evaluation"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Unit Amount" = filter(> 0), Amount = filter(> 0));

                column(QuoteNo_QuoteEvaluation; "Quote Evaluation"."Document No.")
                {
                }
                column(VendorNo_QuoteEvaluation; "Quote Evaluation"."Vendor No")
                {
                }
                column(Type_QuoteEvaluation; "Quote Evaluation".Type)
                {
                }
                column(No_QuoteEvaluation; "Quote Evaluation"."No.")
                {
                }
                column(Description_QuoteEvaluation; "Quote Evaluation".Description)
                {
                }
                column(Quantity_QuoteEvaluation; "Quote Evaluation".Quantity)
                {
                }
                column(UnitAmount_QuoteEvaluation; "Quote Evaluation"."Unit Amount")
                {
                }
                column(Amount_QuoteEvaluation; "Quote Evaluation".Amount)
                {
                }
                column(Awarded_QuoteEvaluation; "Quote Evaluation".Awarded)
                {
                }
                column(UnitofMeasure_QuoteEvaluation; "Quote Evaluation"."Unit of Measure")
                {
                }
                column(LineNo_QuoteEvaluation; "Quote Evaluation"."Line No")
                {
                }
                column(QuoteGenerated_QuoteEvaluation; "Quote Evaluation"."Quote Generated")
                {
                }
                column(VendorName_QuoteEvaluation; "Quote Evaluation"."Vendor Name")
                {
                }
                column(Title_QuoteEvaluation; "Quote Evaluation".Title)
                {
                }
                column(ShortcutDimension1Code_QuoteEvaluation; "Quote Evaluation"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_QuoteEvaluation; "Quote Evaluation"."Shortcut Dimension 2 Code")
                {
                }
                column(DimensionSetID_QuoteEvaluation; "Quote Evaluation"."Dimension Set ID")
                {
                }
                column(Committed_QuoteEvaluation; "Quote Evaluation".Committed)
                {
                }
                column(QuantityReceived_QuoteEvaluation; "Quote Evaluation"."Quantity Received")
                {
                }
                column(ProcurementPlan_QuoteEvaluation; "Quote Evaluation"."Procurement Plan")
                {
                }
                column(ProcurementPlanItem_QuoteEvaluation; "Quote Evaluation"."Procurement Plan Item")
                {
                }
                column(BudgetLine_QuoteEvaluation; "Quote Evaluation"."Budget Line")
                {
                }
                column(RequestDate_QuoteEvaluation; "Quote Evaluation"."Request Date")
                {
                }
                column(ExpectedReceiptDate_QuoteEvaluation; "Quote Evaluation"."Expected Receipt Date")
                {
                }
                column(Suggested_QuoteEvaluation; "Quote Evaluation".Suggested)
                {
                }
                column(AmountInclusiveVAT_QuoteEvaluation; "Quote Evaluation"."Amount Inclusive VAT")
                {
                }
                column(LeastVendorName; LeastVendorName)
                {
                }
                column(LeastAmount; LeastAmount)
                {
                }
                column(SupplierCount; SupplierCount)
                {
                }
                column(TotalSuppliers; TotalSuppliers)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Quote Evaluation"."Unit Amount" = 0 then
                        CurrReport.Skip();


                    LeastAmount := "Quote Evaluation Header"."Least Amount";

                    QuoteLines.Reset();
                    QuoteLines.SetRange(QuoteLines."Document No.", "Quote Evaluation"."Document No.");
                    QuoteLines.SetFilter(QuoteLines.Amount, '>%1', 0);
                    QuoteLines.SetRange(Amount, LeastAmount);
                    if QuoteLines.FindFirst() then begin
                        LeastVendorName := QuoteLines."Vendor Name";
                        QuoteLines.Suggested := true;
                        QuoteLines.Modify();
                    end else begin
                        QuoteLines.Suggested := false;
                        QuoteLines.Modify();
                    end;

                    //LeastAmount:=0;

                    /*QuoteLines.Reset();
                    QuoteLines.SetRange(QuoteLines."Quote No","Quote Evaluation"."Quote No");
                    QuoteLines.SetRange(QuoteLines.Type,"Quote Evaluation".Type);
                    QuoteLines.SetRange(QuoteLines."No.","Quote Evaluation"."No.");
                    QuoteLines.SetFilter(QuoteLines.Amount,'>%1',0);
                    QuoteLines.SetFilter(QuoteLines."Unit Amount",'>%1',0);
                    if QuoteLines.FindSet() then
                      begin
                        //LeastAmount:=QuoteLines.GETRANGEMIN(Amount);
                    
                        repeat
                          LeastAmount:=QuoteLines.GetRangeMin(Amount);
                          //LeastAmount:=QuoteLines.Amount;
                    
                          QuoteLines2.Reset();
                          QuoteLines2.SetRange("Quote No",QuoteLines."Quote No");
                          QuoteLines2.SetRange(Type,QuoteLines.Type);
                          QuoteLines2.SetRange("No.",QuoteLines."No.");
                          //QuoteLines2.SETFILTER(Amount,'>%1',0);
                          //QuoteLines2.SETFILTER("Unit Amount",'>%1',0);
                          QuoteLines2.SetRange(Amount,LeastAmount);
                          if QuoteLines2.FindFirst() then
                            begin
                    
                              QuoteLines.Suggested:=true;
                              LeastVendorName:=QuoteLines2."Vendor Name";
                    
                              QuoteLines.Modify();
                            end;
                        until QuoteLines.Next()=0;
                      end;*/


                end;

                trigger OnPreDataItem()
                begin
                    SupplierCount := Count; //responded suppliers
                end;
            }

            trigger OnAfterGetRecord()
            begin
                QuoteEvalHeader.Copy("Quote Evaluation Header");
                QuoteLines.Reset();
                QuoteLines.SetRange("Document No.", QuoteEvalHeader."No.");
                TotalSuppliers := QuoteLines.Count;
            end;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        QuoteLines: Record "Procurement Evaluation Line";
        QuoteEvalHeader: Record "Procurement Evaluation Header";
        LeastAmount: Decimal;
        SupplierCount: Integer;
        TotalSuppliers: Integer;
        LeastVendorName: Text;
}





