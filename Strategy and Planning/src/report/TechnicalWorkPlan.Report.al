report 65004 "Technical Work Plan"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/TechnicalWorkPlan.rdlc';

    dataset
    {
        dataitem(wPlan; "Work Plan Header")
        {
            RequestFilterFields = "Financial Year";
            column(Code_wPlan; wPlan.Code)
            {
            }
            column(Description_wPlan; wPlan.Description)
            {
            }
            column(ShortcutDimension1Code_wPlan; wPlan."Shortcut Dimension 1 Code" + ' - ' + DimensionValue.Name)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            dataitem(LineObjective; "WorkPlan Line Objectives")
            {
                DataItemLink = Code = field(Code);
                DataItemTableView = sorting(Code, "Objective Code");
                column(Code_LineObjective; LineObjective.Code)
                {
                }
                column(ObjectiveCode_LineObjective; LineObjective."Objective Code")
                {
                }
                column(Description_LineObjective; LineObjective.Description)
                {
                }
                dataitem(LineObjectiveSubActivities; "WorkPlan Line Sub-Activities")
                {
                    DataItemLink = Code = field(Code), "Objective Code" = field("Objective Code");
                    DataItemTableView = sorting(Code, "Objective Code", "Activities Code", "Sub Activity Code");
                    RequestFilterFields = "Objective Code", "KRA Code";
                    column(StrategicName_LineObjectiveSubActivities; LineObjectiveSubActivities."Strategic Name")
                    {
                    }
                    column(DepartMent_; wPlan."Shortcut Dimension 1 Code")
                    {
                    }
                    column(ObjectiveDescription_LineObjectiveSubActivities; LineObjectiveSubActivities."Objective Description")
                    {
                    }
                    column(StrategicCode_LineObjectiveSubActivities; LineObjectiveSubActivities."Strategic Code")
                    {
                    }
                    column(StrategicDescription_LineObjectiveSubActivities; LineObjectiveSubActivities."Strategic Description")
                    {
                    }
                    column(KRACode_LineObjectiveSubActivities; LineObjectiveSubActivities."KRA Code")
                    {
                    }
                    column(KRADescription_LineObjectiveSubActivities; LineObjectiveSubActivities."KRA Description")
                    {
                    }
                    column(SubActivities_LineObjectiveSubActivities; LineObjectiveSubActivities."Sub-Activities")
                    {
                    }
                    column(Code_LineObjectiveSubActivities; LineObjectiveSubActivities.Code)
                    {
                    }
                    column(Description_LineObjectiveSubActivities; LineObjectiveSubActivities.Description)
                    {
                    }
                    column(ObjectiveCode_LineObjectiveSubActivities; LineObjectiveSubActivities."Objective Code")
                    {
                    }
                    column(ActivitiesCode_LineObjectiveSubActivities; LineObjectiveSubActivities."Activities Code")
                    {
                    }
                    column(ResponsiblePerson_LineObjectiveSubActivities; EmpRecords."First Name" + ' ' + EmpRecords."Middle Name" + ' ' + EmpRecords."Last Name")
                    {
                    }
                    column(Output_LineObjectiveSubActivities; LineObjectiveSubActivities.Output)
                    {
                    }
                    column(ApprovedTotalBudget_LineObjectiveSubActivities; LineObjectiveSubActivities."Approved Total Budget")
                    {
                    }
                    column(SubActivityCode_LineObjectiveSubActivities; LineObjectiveSubActivities."Sub Activity Code")
                    {
                    }
                    column(DescriptionActivities_LineObjectiveSubActivities; LineObjectiveSubActivities."Description [Activities]")
                    {
                    }
                    column(DescriptionSubActivities_LineObjectiveSubActivities; LineObjectiveSubActivities."Description [Sub Activities]")
                    {
                        IncludeCaption = true;
                    }
                    column(KeyPerformanceIndicator_LineObjectiveSubActivities; LineObjectiveSubActivities."Key Performance Indicator")
                    {
                    }
                    column(July_LineObjectiveSubActivities; MonthText[7])
                    {
                    }
                    column(August_LineObjectiveSubActivities; MonthText[8])
                    {
                    }
                    column(September_LineObjectiveSubActivities; MonthText[9])
                    {
                    }
                    column(October_LineObjectiveSubActivities; MonthText[10])
                    {
                    }
                    column(November_LineObjectiveSubActivities; MonthText[11])
                    {
                    }
                    column(December_LineObjectiveSubActivities; MonthText[12])
                    {
                    }
                    column(January_LineObjectiveSubActivities; MonthText[1])
                    {
                    }
                    column(February_LineObjectiveSubActivities; MonthText[2])
                    {
                    }
                    column(March_LineObjectiveSubActivities; MonthText[3])
                    {
                    }
                    column(April_LineObjectiveSubActivities; MonthText[4])
                    {
                    }
                    column(May_LineObjectiveSubActivities; MonthText[5])
                    {
                    }
                    column(June_LineObjectiveSubActivities; MonthText[6])
                    {
                    }
                    column(GOKApprovedBudget_LineObjectiveSubActivities; LineObjectiveSubActivities."GOK Approved Budget")
                    {
                    }
                    column(DonorFundsApprovedBudget_LineObjectiveSubActivities; LineObjectiveSubActivities."Donor Funds Approved Budget")
                    {
                    }
                    column(UnitofMeasure_LineObjectiveSubActivities; LineObjectiveSubActivities."Unit of Measure")
                    {
                    }
                    column(DonorinKind_LineObjectiveSubActivities; LineObjectiveSubActivities."Donor in Kind")
                    {
                    }
                    column(Quarter1Target_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 1 Target")
                    {
                    }
                    column(Quarter2Target_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 2 Target")
                    {
                    }
                    column(Quarter3Target_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 3 Target")
                    {
                    }
                    column(Quarter4Target_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 4 Target")
                    {
                    }
                    column(TotalQuarterTarget_LineObjectiveSubActivities; LineObjectiveSubActivities."Total Quarter Target")
                    {
                    }
                    column(Quarter1Actual_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 1 Actual")
                    {
                    }
                    column(Quarter2Actual_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 2 Actual")
                    {
                    }
                    column(Quarter3Actual_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 3 Actual")
                    {
                    }
                    column(Quarter4Actual_LineObjectiveSubActivities; LineObjectiveSubActivities."Quarter 4 Actual")
                    {
                    }
                    column(TotalQuarterActual_LineObjectiveSubActivities; LineObjectiveSubActivities."Total Quarter Actual")
                    {
                    }
                    column(Average_1; Averag[1])
                    {
                    }
                    column(Average_2; Averag[2])
                    {
                    }
                    column(Average_3; Averag[3])
                    {
                    }
                    column(Average_4; Averag[4])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if LineObjectiveSubActivities."Responsible Person" <> '' then
                            EmpRecords.Get(LineObjectiveSubActivities."Responsible Person");
                        if LineObjectiveSubActivities.Description = '' then begin
                            LineObjectiveSubActivities.Validate("Objective Code");
                            LineObjectiveSubActivities.Modify();
                        end;
                        Clear(MonthText[7]);
                        Clear(MonthText[8]);
                        Clear(MonthText[9]);
                        Clear(MonthText[10]);
                        Clear(MonthText[11]);
                        Clear(MonthText[12]);
                        Clear(MonthText[1]);
                        Clear(MonthText[2]);
                        Clear(MonthText[3]);
                        Clear(MonthText[4]);
                        Clear(MonthText[5]);
                        Clear(MonthText[6]);

                        if not LineObjectiveSubActivities.July then
                            MonthText[7] := ''
                        else
                            MonthText[7] := Format(LineObjectiveSubActivities.July);

                        if not LineObjectiveSubActivities.August then
                            MonthText[8] := ''
                        else
                            MonthText[8] := Format(LineObjectiveSubActivities.August);

                        if not LineObjectiveSubActivities.September then
                            MonthText[9] := ''
                        else
                            MonthText[9] := Format(LineObjectiveSubActivities.September);

                        if not LineObjectiveSubActivities.October then
                            MonthText[10] := ''
                        else
                            MonthText[10] := Format(LineObjectiveSubActivities.October);

                        if not LineObjectiveSubActivities.November then
                            MonthText[10] := ''
                        else
                            MonthText[11] := Format(LineObjectiveSubActivities.November);

                        if not LineObjectiveSubActivities.December then
                            MonthText[12] := ''
                        else
                            MonthText[12] := Format(LineObjectiveSubActivities.December);

                        if not LineObjectiveSubActivities.January then
                            MonthText[1] := ''
                        else
                            MonthText[1] := Format(LineObjectiveSubActivities.January);

                        if not LineObjectiveSubActivities.February then
                            MonthText[2] := ''
                        else
                            MonthText[2] := Format(LineObjectiveSubActivities.February);

                        if not LineObjectiveSubActivities.March then
                            MonthText[3] := ''
                        else
                            MonthText[3] := Format(LineObjectiveSubActivities.March);

                        if not LineObjectiveSubActivities.April then
                            MonthText[4] := ''
                        else
                            MonthText[4] := Format(LineObjectiveSubActivities.April);

                        if not LineObjectiveSubActivities.May then
                            MonthText[5] := ''
                        else
                            MonthText[5] := Format(LineObjectiveSubActivities.May);

                        if not LineObjectiveSubActivities.June then
                            MonthText[6] := ''
                        else
                            MonthText[6] := Format(LineObjectiveSubActivities.June);

                        Clear(Averag[1]);
                        Clear(Averag[2]);
                        Clear(Averag[3]);
                        Clear(Averag[4]);

                        if (LineObjectiveSubActivities."Quarter 1 Target" > 0) and (LineObjectiveSubActivities."Quarter 1 Actual" > 0) then
                            Averag[1] := (LineObjectiveSubActivities."Quarter 1 Actual" / LineObjectiveSubActivities."Quarter 1 Target") * 100;
                        if (LineObjectiveSubActivities."Quarter 2 Target" > 0) and (LineObjectiveSubActivities."Quarter 2 Actual" > 0) then
                            Averag[2] := (LineObjectiveSubActivities."Quarter 2 Actual" / LineObjectiveSubActivities."Quarter 2 Target") * 100;
                        if (LineObjectiveSubActivities."Quarter 3 Target" > 0) and (LineObjectiveSubActivities."Quarter 3 Actual" > 0) then
                            Averag[3] := (LineObjectiveSubActivities."Quarter 3 Actual" / LineObjectiveSubActivities."Quarter 3 Target") * 100;
                        if (LineObjectiveSubActivities."Quarter 4 Target" > 0) and (LineObjectiveSubActivities."Quarter 4 Actual" > 0) then
                            Averag[4] := (LineObjectiveSubActivities."Quarter 4 Actual" / LineObjectiveSubActivities."Quarter 4 Target") * 100;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                GeneralLedgerSetup.Get();
                if DimensionValue.Get(GeneralLedgerSetup."Global Dimension 1 Code", "Shortcut Dimension 1 Code") then;
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
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        EmpRecords: Record Employee;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Averag: array[5] of Decimal;
        MonthText: array[12] of Text;
}

