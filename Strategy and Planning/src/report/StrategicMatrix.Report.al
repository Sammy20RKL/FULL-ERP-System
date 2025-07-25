report 65006 "Strategic Matrix"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/StrategicMatrix.rdlc';

    dataset
    {
        dataitem("Strategic Plan"; "Strategic Plan")
        {
            RequestFilterFields = "Code";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            dataitem(Strategies; Strategies)
            {
                DataItemLink = "Header No." = field(Code);
                DataItemTableView = sorting(Code, "Objective Code", "Header No.", "Strategic Code", "Entry No.");
                RequestFilterFields = "Objective Code";
                column(Code_Strategies; Strategies.Code)
                {
                }
                column(StrategicName_Strategies; Strategies."Strategic Name")
                {
                }
                column(Purpose_Strategies; Strategies.Purpose)
                {
                }
                column(EntryNo_Strategies; Strategies."Entry No.")
                {
                }
                column(ObjectiveCode_Strategies; Strategies."Objective Code")
                {
                }
                column(ObjectiveDescription_Strategies; Strategies."Objective Description")
                {
                }
                column(StrategicCode_Strategies; Strategies."Strategic Code")
                {
                }
                column(HeaderNo_Strategies; Strategies."Header No.")
                {
                }
                column(StrategicDescription_Strategies; Strategies."Strategic Description")
                {
                }
                column(Description_Strategies; Strategies.Description)
                {
                }
                column(Activity_Strategies; Strategies.Activity)
                {
                }
                column(Output_Strategies; Strategies.Output)
                {
                }
                column(PerformanceIndicator_Strategies; Strategies."Performance Indicator")
                {
                }
                column(ResponsiblePerson_Strategies; Strategies."Name of Responsible")
                {
                }
                column(AllocationI_Strategies; Strategies."Year 1 Target")
                {
                }
                column(AllocationII_Strategies; Strategies."Year 2 Target")
                {
                }
                column(AllocationIII_Strategies; Strategies."Year 3 Target")
                {
                }
                column(Allocationiv_Strategies; Strategies."Year 4 Target")
                {
                }
                column(Allocationv_Strategies; Strategies."Year 5 Target")
                {
                }
                column(TotalCost_Strategies; Strategies."Total Target")
                {
                }
                column(Descript; Descript)
                {
                }
                column(Year1Actual_Strategies; Strategies."Year 1 Actual")
                {
                }
                column(Year2Actual_Strategies; Strategies."Year 2 Actual")
                {
                }
                column(Year3Actual_Strategies; Strategies."Year 3 Actual")
                {
                }
                column(Year4Actual_Strategies; Strategies."Year 4 Actual")
                {
                }
                column(Year5Actual_Strategies; Strategies."Year 5 Actual")
                {
                }
                column(TotalActual_Strategies; Strategies."Total Actual")
                {
                }
                column(Year1Average_Strategies; Average[1])
                {
                }
                column(Year2Average_Strategies; Average[2])
                {
                }
                column(Year3Average_Strategies; Average[3])
                {
                }
                column(Year4Average_Strategies; Average[4])
                {
                }
                column(Year5Average_Strategies; Average[5])
                {
                }
                column(TotalAverage_Strategies; Average[6])
                {
                }
                column(Year1Budget_Strategies; Strategies."Year 1 Budget")
                {
                }
                column(Year2Budget_Strategies; Strategies."Year 2 Budget")
                {
                }
                column(Year3Budget_Strategies; Strategies."Year 3 Budget")
                {
                }
                column(Year4Budget_Strategies; Strategies."Year 4 Budget")
                {
                }
                column(Year5Budget_Strategies; Strategies."Year 5 Budget")
                {
                }
                column(TotalBudget_Strategies; Strategies."Total Budget")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if KeyResults.Get(Strategies.Code) then
                        Descript := KeyResults.Description
                    else
                        Descript := '';

                    Clear(Average[1]);
                    Clear(Average[2]);
                    Clear(Average[3]);
                    Clear(Average[4]);
                    Clear(Average[5]);
                    Clear(Average[6]);

                    if (Strategies."Year 1 Actual" <> 0) and (Strategies."Year 1 Target" <> 0) then
                        Average[1] := Strategies."Year 1 Actual" / Strategies."Year 1 Target" * 100;
                    if (Strategies."Year 2 Actual" <> 0) and (Strategies."Year 2 Target" <> 0) then
                        Average[2] := Strategies."Year 2 Actual" / Strategies."Year 2 Target" * 100;
                    if (Strategies."Year 3 Actual" <> 0) and (Strategies."Year 3 Target" <> 0) then
                        Average[3] := Strategies."Year 3 Actual" / Strategies."Year 3 Target" * 100;
                    if (Strategies."Year 4 Actual" <> 0) and (Strategies."Year 4 Target" <> 0) then
                        Average[4] := Strategies."Year 4 Actual" / Strategies."Year 4 Target" * 100;
                    if (Strategies."Year 5 Actual" <> 0) and (Strategies."Year 5 Target" <> 0) then
                        Average[5] := Strategies."Year 5 Actual" / Strategies."Year 5 Target" * 100;
                    if (Strategies."Total Actual" <> 0) and (Strategies."Total Target" <> 0) then
                        Average[6] := Strategies."Total Actual" / Strategies."Total Target" * 100;
                end;
            }
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
        KeyResults: Record "KRA Codes";
        "Average": array[6] of Decimal;
        Descript: Text[150];
}

