report 65003 "Year Performance_SubIndicator"
{
    ApplicationArea = All;
    // strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
    //   curTransAmount := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/YearPerformanceSubIndicator.rdlc';


    dataset
    {
        dataitem(PerformanceContracting; "Performance Contracting")
        {
            RequestFilterFields = "Code";
            column(Code_PerformanceContracting; PerformanceContracting.Code)
            {
            }
            column(Decription_PerformanceContracting; PerformanceContracting.Decription)
            {
            }
            column(DueDate_PerformanceContracting; PerformanceContracting."Due Date")
            {
            }
            column(Closed_PerformanceContracting; PerformanceContracting.Closed)
            {
            }
            column(Header_PerformanceContracting; Header)
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(Picture_CompanyInformation; CompanyInformation.Picture)
            {
            }
            dataitem(PerformanceContractingLines; "Performance Contracting Lines")
            {
                DataItemLink = "Document No." = field(Code);
                DataItemTableView = sorting("Document No.", "Line No.") where("SubGroup Order" = filter(<> ''));
                column(DocumentNo_PerformanceContractingLines; PerformanceContractingLines."Document No.")
                {
                }
                column(LineNo_PerformanceContractingLines; PerformanceContractingLines."Line No.")
                {
                }
                column(RowNo_PerformanceContractingLines; PerformanceContractingLines."Row No.")
                {
                }
                column(ItemActivity_PerformanceContractingLines; PerformanceContractingLines."Item/Activity")
                {
                }
                column(Weight_PerformanceContractingLines; PerformanceContractingLines.Weight)
                {
                }
                column(Measure_PerformanceContractingLines; PerformanceContractingLines.Measure)
                {
                }
                column(AnnualTarget_PerformanceContractingLines; Amount[10])
                {
                }
                column(AnnualTarget_PerformanceContractingLines_; PerformanceContractingLines."Annual Target")
                {
                }
                column(Q1_PerformanceContractingLines; PerformanceContractingLines."Specific Indicator Components")
                {
                }
                column(Q2_PerformanceContractingLines; PerformanceContractingLines.Evidence)
                {
                }
                column(Q3_PerformanceContractingLines; PerformanceContractingLines.Department)
                {
                }
                column(Q4_PerformanceContractingLines; PerformanceContractingLines.Resource)
                {
                }
                column(SpecificIndicatorComponents_PerformanceContractingLines; PerformanceContractingLines."Specific Indicator Components")
                {
                }
                column(Evidence_PerformanceContractingLines; PerformanceContractingLines.Evidence)
                {
                }
                column(ResponsibleDept_PerformanceContractingLines; PerformanceContractingLines."Row Text")
                {
                }
                column(Heading_PerformanceContractingLines; PerformanceContractingLines.Heading)
                {
                }
                column(RowText_PerformanceContractingLines; PerformanceContractingLines."Row Text")
                {
                }
                column(Class_PerformanceContractingLines; PerformanceContractingLines.Class)
                {
                }
                column(Detailed_PerformanceContractingLines; PerformanceContractingLines.Detailed)
                {
                }
                column(TotalingType_PerformanceContractingLines; PerformanceContractingLines."Totaling Type")
                {
                }
                column(Submitted_PerformanceContractingLines; PerformanceContractingLines.Totaling)
                {
                }
                column(Remarks_PerformanceContractingLines; Remarkq)
                {
                }
                column(ResponsiblePersons_PerformanceContractingLines; PerformanceContractingLines.Show)
                {
                }
                column(SubHeading_PerformanceContractingLines; PerformanceContractingLines.Bold)
                {
                }
                column(QuarterTarget_PerformanceContractingLines; Amount[1])
                {
                }
                column(QuarterActual_PerformanceContractingLines; Amount[2])
                {
                }
                column(Variance_; Amount[3])
                {
                }
                column(Variance_Perc_; Amount[4])
                {
                }
                column(TotalQuarterTarget_PerformanceContractingLines; Amount[5])
                {
                }
                column(TotalQuarterActual_PerformanceContractingLines; Amount[6])
                {
                }
                column(TotalQuarterVariance_PerformanceContractingLines; Amount[7])
                {
                }
                column(Amount_Formula; Amount[10])
                {
                }
                column(RowText1_PerformanceContractingLines; PerformanceContractingLines."Group Order")
                {
                }
                column(RowText2_PerformanceContractingLines; PerformanceContractingLines."SubGroup Order")
                {
                }
                column(Indicator_PerformanceContractingLines; PerformanceContractingLines.Indicator)
                {
                }
                column(SubIndicator_PerformanceContractingLines; PerformanceContractingLines.SubIndicator)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(Remarkq);
                    Clear(Amount[1]);
                    Clear(Amount[2]);
                    Clear(Amount[3]);
                    Clear(Amount[4]);
                    Clear(Amount[5]);
                    Clear(Amount[6]);
                    Clear(Amount[7]);

                    if PerformanceContractingLines."Totaling Type" = PerformanceContractingLines."Totaling Type"::Formula then begin
                        Clear(Amount[10]);
                        Clear(strExtractedFrml);
                        strExtractedFrml := PureFormula(PerformanceContractingLines."Row Text");
                        Amount[10] := Round(EvaluateExpression(strExtractedFrml));
                    end;/*ELSE
                    Amount[10] := PerformanceContractingLines."Annual Target";*/

                    case Source of
                        Source::"Quarter 1":
                            begin
                                Amount[1] := PerformanceContractingLines."Quarter 2 Target";
                                Amount[2] := PerformanceContractingLines."Quarter 1 Actual";
                                Amount[3] := Amount[1] - Amount[2];
                                if (Amount[1] > 0) and (Amount[2] > 0) then
                                    Amount[4] := (Amount[2] / Amount[1]) * 100;
                                Amount[5] := PerformanceContractingLines."Quarter 2 Target";
                                Amount[6] := PerformanceContractingLines."Quarter 1 Actual";
                                Amount[7] := Amount[5] - Amount[6];
                                Remarkq := PerformanceContractingLines.Remarks;
                            end;
                        Source::"Quarter 2":
                            begin
                                Amount[1] := PerformanceContractingLines."Quarter 2 Target";
                                Amount[2] := PerformanceContractingLines."Quarter 1 Actual";
                                Amount[3] := Amount[1] - Amount[2];
                                if (Amount[1] > 0) and (Amount[2] > 0) then
                                    Amount[4] := (Amount[2] / Amount[1]) * 100;
                                Amount[5] := PerformanceContractingLines."Quarter 2 Target" +
                                             PerformanceContractingLines."Quarter 3 Target";
                                Amount[6] := PerformanceContractingLines."Quarter 1 Actual" +
                                             PerformanceContractingLines."Quarter 2 Actual";
                                Amount[7] := Amount[5] - Amount[6];
                                Remarkq := PerformanceContractingLines."Remarks Q2";
                            end;
                        Source::"Quarter 3":
                            begin
                                Amount[1] := PerformanceContractingLines."Quarter 2 Target";
                                Amount[2] := PerformanceContractingLines."Quarter 1 Actual";
                                Amount[3] := Amount[1] - Amount[2];
                                if (Amount[1] > 0) and (Amount[2] > 0) then
                                    Amount[4] := (Amount[2] / Amount[1]) * 100;
                                Amount[5] := PerformanceContractingLines."Quarter 2 Target" +
                                             PerformanceContractingLines."Quarter 3 Target" +
                                             PerformanceContractingLines."Quarter 4 Target";
                                Amount[6] := PerformanceContractingLines."Quarter 1 Actual" +
                                             PerformanceContractingLines."Quarter 2 Actual" +
                                             PerformanceContractingLines."Quarter 3 Actual";
                                Amount[7] := Amount[5] - Amount[6];
                                Remarkq := PerformanceContractingLines."Remarks Q3";
                            end;
                        Source::"Quarter 4":
                            begin
                                Amount[1] := PerformanceContractingLines."Quarter 4 Target";
                                Amount[2] := PerformanceContractingLines."Quarter 4 Actual";
                                Amount[3] := Amount[1] - Amount[2];
                                if (Amount[1] > 0) and (Amount[2] > 0) then
                                    Amount[4] := (Amount[2] / Amount[1]) * 100;
                                Amount[5] := PerformanceContractingLines."Quarter 2 Target" +
                                             PerformanceContractingLines."Quarter 3 Target" +
                                             PerformanceContractingLines."Quarter 4 Target" +
                                             PerformanceContractingLines."Quarter 4 Target";
                                Amount[6] := PerformanceContractingLines."Quarter 1 Actual" +
                                             PerformanceContractingLines."Quarter 2 Actual" +
                                             PerformanceContractingLines."Quarter 3 Actual" +
                                             PerformanceContractingLines."Quarter 4 Actual";
                                Amount[7] := Amount[5] - Amount[6];
                                Remarkq := PerformanceContractingLines."Remarks Q4";
                            end;
                    end;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(Header);
                Header := UpperCase(Format(Source) + ' PERFORMANCE REPORT FOR THE YEAR ' + PerformanceContracting.Code);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(Source; Source)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Source field.';
                    }
                }
            }
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
        Source := Source::"Quarter 4";
    end;

    trigger OnPreReport()
    begin
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Amount: array[10] of Decimal;
        Source: Option " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4";
        Header: Text;
        Remarkq: Text;
        strExtractedFrml: Text;

    procedure PureFormula(strFormula: Text[250]) Formula: Text[250]
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        AccSchedMgt: Codeunit AccSchedManagement;
        CalcAddCurr: Boolean;
        StartCopy: Boolean;
        TransCode: Code[20];
        TransCodeAmount: Decimal;
        FirstBracket: Integer;
        i: Integer;
        Char: Text[1];
        Where: Text[30];
        Which: Text[30];
        FinalFormula: Text[250];
    begin
        TransCode := '';
        for i := 1 to StrLen(strFormula) do begin
            Char := CopyStr(strFormula, i, 1);

            if Char = '[' then
                StartCopy := true;

            if StartCopy then
                TransCode := TransCode + Char;

            if not StartCopy then                                                               //Copy Characters as long as is not within []
                FinalFormula := FinalFormula + Char;

            if Char = ']' then begin
                StartCopy := false;
                Where := '=';                                                                    //Get Transcode
                Which := '[]';
                TransCode := DelChr(TransCode, Where, Which);
                //TransCodeAmount := 1; //fnGetTransAmount(strEmpCode, TransCode, intMonth, intYear);   //Get TransCodeAmount
                TransCode := '';                                                                  //Reset Transcode
                FinalFormula := FinalFormula + Format(TransCodeAmount);                              //Get Final Formula
            end;                                                                                 //End Get Transcode
        end;
        Formula := FinalFormula;
    end;

    procedure EvaluateExpression(strFormula: Text[250]) Results: Decimal
    var
        AccSchedLine: Record "Acc. Schedule Line";
        ColumnLayout: Record "Column Layout";
        AccSchedMgt: Codeunit AccSchedManagement;
        CalcAddCurr: Boolean;
    begin
        Results := AccSchedMgt.EvaluateExpression(true, strFormula, AccSchedLine, ColumnLayout, CalcAddCurr);
    end;
}

