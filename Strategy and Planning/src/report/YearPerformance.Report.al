report 65002 "Year Performance"
{
    ApplicationArea = All;
    // strExtractedFrml := fnPureFormula(strEmpCode, intMonth, intYear, prTransactionCodes.Formula);
    //   curTransAmount := ROUND(fnFormulaResult(strExtractedFrml)); //Get the calculated amount
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/YearPerformance.rdlc';


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
                DataItemTableView = sorting("Document No.", "Line No.");
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
                column(Q1_PerformanceContractingLines; PerformanceContractingLines.Q1)
                {
                }
                column(Q2_PerformanceContractingLines; PerformanceContractingLines.Q2)
                {
                }
                column(Q3_PerformanceContractingLines; PerformanceContractingLines.Q3)
                {
                }
                column(Q4_PerformanceContractingLines; PerformanceContractingLines.Q4)
                {
                }
                column(SpecificIndicatorComponents_PerformanceContractingLines; PerformanceContractingLines."Specific Indicator Components")
                {
                }
                column(Evidence_PerformanceContractingLines; PerformanceContractingLines.Evidence)
                {
                }
                column(ResponsibleDept_PerformanceContractingLines; PerformanceContractingLines.Resource)
                {
                }
                column(Heading_PerformanceContractingLines; PerformanceContractingLines.Heading)
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
                column(Submitted_PerformanceContractingLines; PerformanceContractingLines.Submitted)
                {
                }
                column(Remarks_PerformanceContractingLines; RemarksTxt)
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
                    RemarksTxt := '';
                    if Source = Source::"Quarter 1" then
                        RemarksTxt := PerformanceContractingLines.Remarks;
                    if Source = Source::"Quarter 2" then
                        RemarksTxt := PerformanceContractingLines."Remarks Q2";
                    if Source = Source::"Quarter 3" then
                        RemarksTxt := PerformanceContractingLines."Remarks Q3";
                    if Source = Source::"Quarter 4" then
                        RemarksTxt := PerformanceContractingLines."Remarks Q4";

                    Clear(Amount[1]);
                    Clear(Amount[2]);
                    Clear(Amount[3]);
                    Clear(Amount[4]);
                    Clear(Amount[5]);
                    Clear(Amount[6]);
                    Clear(Amount[7]);
                    Clear(Amount[10]);

                    /*IF PerformanceContractingLines."Totaling Type" = PerformanceContractingLines."Totaling Type"::Formula THEN
                      BEGIN
                        CLEAR(Amount[10]);
                        Amount[10] := CalculateFormulaBased("Document No.", "Line No.", Totaling, 1);
                    
                        {CLEAR(strExtractedFrml);
                        strExtractedFrml := PureFormula(PerformanceContractingLines."Row Text");
                        Amount[10] := ROUND( EvaluateExpression( strExtractedFrml) ); }
                    END ;{ELSE
                    Amount[10] := PerformanceContractingLines."Annual Target";}
                    */


                    if PerformanceContractingLines."Totaling Type" = PerformanceContractingLines."Totaling Type"::Formula then begin

                        Amount[10] := SumAnnualTarget("Document No.", Totaling);

                        Amount[1] := SumQuarterTarget("Document No.", Totaling, Source);        //PerformanceContractingLines."Quarter 2 Target";
                        Amount[2] := SumQuarterActual("Document No.", Totaling, Source);        //PerformanceContractingLines."Quarter 1 Actual";
                        Amount[3] := CalculateVariance(Amount[1], Amount[2]);
                        /*IF PerformanceContractingLines."Row No." = 'A1' THEN
                        MESSAGE('Actual %1 Target :%2', Amount[2], Amount[1]);*/
                        if (Amount[1] > 0) and (Amount[2] > 0) then
                            Amount[4] := CalculateVariancePercent(Amount[1], Amount[2]);
                        Amount[5] := CummulativeQuarterTarget("Document No.", Totaling, Source); //PerformanceContractingLines."Quarter 2 Target";
                        Amount[6] := CummulativeQuarterActual("Document No.", Totaling, Source); //PerformanceContractingLines."Quarter 1 Actual";
                        Amount[7] := CalculateVariance(Amount[5], Amount[6]);
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
        RemarksTxt: Text;
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

    local procedure SumAnnualTarget(DocumentNo: Code[20]; Formulas: Text): Decimal
    var
        ContractLines: Record "Performance Contracting Lines";
        SumAmount: Decimal;
    begin

        ContractLines.Reset();
        ContractLines.SetRange("Document No.", DocumentNo);
        ContractLines.SetFilter("Row Text", DelChr(Formulas, '=', '[]'));
        if ContractLines.FindFirst() then
            repeat

                SumAmount += ContractLines."Annual Target"  //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
          until ContractLines.Next() = 0;
        exit(SumAmount);
    end;

    local procedure SumQuarterTarget(DocumentNo: Code[20]; Formulas: Text; Period: Option " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4"): Decimal
    var
        ContractLines: Record "Performance Contracting Lines";
        SumAmount: Decimal;
    begin

        ContractLines.Reset();
        ContractLines.SetRange("Document No.", DocumentNo);
        ContractLines.SetFilter("Row Text", DelChr(Formulas, '=', '[]'));
        if ContractLines.FindFirst() then
            repeat
                if Period = Period::"Quarter 1" then
                    SumAmount += ContractLines."Quarter 1 Target"  //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                else
                    if Period = Period::"Quarter 2" then
                        SumAmount += ContractLines."Quarter 2 Target" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                    else
                        if Period = Period::"Quarter 3" then
                            SumAmount += ContractLines."Quarter 3 Target" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                        else
                            if Period = Period::"Quarter 4" then
                                SumAmount += ContractLines."Quarter 4 Target" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
          until ContractLines.Next() = 0;
        exit(SumAmount);
    end;

    local procedure SumQuarterActual(DocumentNo: Code[20]; Formulas: Text; Period: Option " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4"): Decimal
    var
        ContractLines: Record "Performance Contracting Lines";
        SumAmount: Decimal;
    begin

        ContractLines.Reset();
        ContractLines.SetRange("Document No.", DocumentNo);
        ContractLines.SetFilter("Row Text", DelChr(Formulas, '=', '[]'));
        if ContractLines.FindFirst() then
            repeat
                if Period = Period::"Quarter 1" then
                    SumAmount += ContractLines."Quarter 1 Actual"  //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                else
                    if Period = Period::"Quarter 2" then
                        SumAmount += ContractLines."Quarter 2 Actual" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                    else
                        if Period = Period::"Quarter 3" then
                            SumAmount += ContractLines."Quarter 3 Actual" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                        else
                            if Period = Period::"Quarter 4" then
                                SumAmount += ContractLines."Quarter 4 Actual" //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
          until ContractLines.Next() = 0;
        exit(SumAmount);
    end;

    local procedure CummulativeQuarterTarget(DocumentNo: Code[20]; Formulas: Text; Period: Option " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4"): Decimal
    var
        ContractLines: Record "Performance Contracting Lines";
        SumAmount: Decimal;
    begin

        ContractLines.Reset();
        ContractLines.SetRange("Document No.", DocumentNo);
        ContractLines.SetFilter("Row Text", DelChr(Formulas, '=', '[]'));
        if ContractLines.FindFirst() then
            repeat
                if Period = Period::"Quarter 1" then
                    SumAmount += ContractLines."Quarter 1 Target"    //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                else
                    if Period = Period::"Quarter 2" then
                        SumAmount += (ContractLines."Quarter 1 Target" +
                                      ContractLines."Quarter 2 Target") //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                    else
                        if Period = Period::"Quarter 3" then
                            SumAmount += (ContractLines."Quarter 1 Target" +
                                          ContractLines."Quarter 2 Target" +
                                          ContractLines."Quarter 3 Target") //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                        else
                            if Period = Period::"Quarter 4" then
                                SumAmount += (ContractLines."Quarter 1 Target" +
                                              ContractLines."Quarter 2 Target" +
                                              ContractLines."Quarter 3 Target" +
                                              ContractLines."Quarter 4 Target"); //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );

            until ContractLines.Next() = 0;
        exit(SumAmount);
    end;

    local procedure CummulativeQuarterActual(DocumentNo: Code[20]; Formulas: Text; Period: Option " ","Quarter 1","Quarter 2","Quarter 3","Quarter 4"): Decimal
    var
        ContractLines: Record "Performance Contracting Lines";
        SumAmount: Decimal;
    begin

        ContractLines.Reset();
        ContractLines.SetRange("Document No.", DocumentNo);
        ContractLines.SetFilter("Row Text", DelChr(Formulas, '=', '[]'));
        if ContractLines.FindFirst() then
            repeat
                if Period = Period::"Quarter 1" then
                    SumAmount += ContractLines."Quarter 1 Actual"     //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                else
                    if Period = Period::"Quarter 2" then
                        SumAmount += (ContractLines."Quarter 1 Actual" +
                                      ContractLines."Quarter 2 Actual")   //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                    else
                        if Period = Period::"Quarter 3" then
                            SumAmount += (ContractLines."Quarter 1 Actual" +
                                          ContractLines."Quarter 2 Actual" +
                                          ContractLines."Quarter 3 Actual")   //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
                        else
                            if Period = Period::"Quarter 4" then
                                SumAmount += (ContractLines."Quarter 1 Actual" +
                                              ContractLines."Quarter 2 Actual" +
                                              ContractLines."Quarter 3 Actual" +
                                              ContractLines."Quarter 4 Actual");  //ROUND( EvaluateExpression( PureFormula(ContractLines.Totaling) ) );
            until ContractLines.Next() = 0;
        exit(SumAmount);
    end;

    local procedure CalculateVariance(Target: Decimal; Actual: Decimal): Decimal
    begin
        exit(Actual - Target)
    end;

    local procedure CalculateVariancePercent(Target: Decimal; Actual: Decimal): Decimal
    begin
        exit((Actual / Target) * 100);
    end;
}

