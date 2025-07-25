page 60050 "Grant Statistics"
{
    ApplicationArea = All;
    Caption = 'Grant Statistics';
    Editable = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = Jobs;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                label(Control11)
                {
                    CaptionClass = Text19080001;
                    ShowCaption = false;
                }
                label(Control55)
                {
                    CaptionClass = Text19012801;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                label(Control15)
                {
                    CaptionClass = Text19011378;
                    ShowCaption = false;
                }
                field(Text000; Text000)
                {
                    Caption = 'Price LCY';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Price LCY field.';
                }
                field(Control5; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("PL[1]"; PL[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,1,TRUE);
                    end;
                }
                field("PL[2]"; PL[2])
                {
                    Caption = 'Schedule Price LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,2,TRUE);
                    end;
                }
                field("PL[5]"; PL[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,1,TRUE);
                    end;
                }
                label(Control30)
                {
                    CaptionClass = Text19068736;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("PL[6]"; PL[6])
                {
                    Caption = 'Usage Price LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,2,TRUE);
                    end;
                }
                field("PL[9]"; PL[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,1,FALSE);
                    end;
                }
                field("PL[10]"; PL[10])
                {
                    Caption = 'Contract Price LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,2,FALSE);
                    end;
                }
                field("PL[13]"; PL[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,1,FALSE);
                    end;
                }
                field("PL[14]"; PL[14])
                {
                    Caption = 'Invoiced Price LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,2,FALSE);
                    end;
                }
                field("Cost LCY"; Text000)
                {
                    Caption = 'Cost LCY';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cost LCY field.';
                }
                field(Control129; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("CL[1]"; CL[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(1,1,TRUE);
                    end;
                }
                field("CL[2]"; CL[2])
                {
                    Caption = 'Schedule Cost LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(1,2,TRUE);
                    end;
                }
                field("CL[5]"; CL[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(1,1,TRUE);
                    end;
                }
                field("CL[6]"; CL[6])
                {
                    Caption = 'Usage Cost LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(1,2,TRUE);
                    end;
                }
                field("CL[9]"; CL[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(1,1,FALSE);
                    end;
                }
                label(Control72)
                {
                    CaptionClass = Text19073853;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("CL[10]"; CL[10])
                {
                    Caption = 'Contract Cost LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(1,2,FALSE);
                    end;
                }
                field("CL[13]"; CL[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(1,1,FALSE);
                    end;
                }
                field("CL[14]"; CL[14])
                {
                    Caption = 'Invoiced Cost LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(1,2,FALSE);
                    end;
                }
                field("Profit LCY"; Text000)
                {
                    Caption = 'Profit LCY';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Profit LCY field.';
                }
                field(Control148; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("PL[1] - CL[1]"; PL[1] - CL[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,1,TRUE);
                    end;
                }
                field("PL[2] - CL[2]"; PL[2] - CL[2])
                {
                    Caption = 'Schedule Profit LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,2,TRUE);
                    end;
                }
                field("PL[5] - CL[5]"; PL[5] - CL[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,1,TRUE);
                    end;
                }
                label(Control20)
                {
                    CaptionClass = Text19055809;
                    ShowCaption = false;
                }
                field(Control6; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("PL[6] - CL[6]"; PL[6] - CL[6])
                {
                    Caption = 'Usage Profit LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,2,TRUE);
                    end;
                }
                field("PL[9] - CL[9]"; PL[9] - CL[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,1,FALSE);
                    end;
                }
                field("PL[10] - CL[10]"; PL[10] - CL[10])
                {
                    Caption = 'Contract Profit LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowPlanningLine(3,2,FALSE);
                    end;
                }
                field("PL[13] - CL[13]"; PL[13] - CL[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,1,FALSE);
                    end;
                }
                field("PL[14] - CL[14]"; PL[14] - CL[14])
                {
                    Caption = 'Invoiced Profit LCY (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit LCY (Item) field.';

                    trigger OnDrillDown()
                    begin
                        ////JobCalcStatistics.ShowLedgEntry(3,2,FALSE);
                    end;
                }
                label(Control25)
                {
                    CaptionClass = Text19028226;
                    ShowCaption = false;
                }
                field(Control88; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("PL[3]"; PL[3])
                {
                    Caption = 'Schedule Price LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,3,TRUE);
                    end;
                }
                field("PL[4]"; PL[4])
                {
                    Caption = 'Schedule Price LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,0,TRUE);
                    end;
                }
                field("PL[7]"; PL[7])
                {
                    Caption = 'Usage Price LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,TRUE);
                    end;
                }
                field("PL[8]"; PL[8])
                {
                    Caption = 'Usage Price LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,TRUE);
                    end;
                }
                field("PL[11]"; PL[11])
                {
                    Caption = 'Contract Price LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,3,FALSE);
                    end;
                }
                field("PL[12]"; PL[12])
                {
                    Caption = 'Contract Price LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,0,FALSE);
                    end;
                }
                field("PL[15]"; PL[15])
                {
                    Caption = 'Invoiced Price LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,FALSE);
                    end;
                }
                field("PL[16]"; PL[16])
                {
                    Caption = 'Invoiced Price LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,FALSE);
                    end;
                }
                field(Control145; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field(Control146; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("CL[3]"; CL[3])
                {
                    Caption = 'Schedule Cost LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(1,3,TRUE);
                    end;
                }
                field("CL[4]"; CL[4])
                {
                    Caption = 'Schedule Cost LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(1,0,TRUE);
                    end;
                }
                field("CL[7]"; CL[7])
                {
                    Caption = 'Usage Cost LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(1,3,TRUE);
                    end;
                }
                field("CL[8]"; CL[8])
                {
                    Caption = 'Usage Cost LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(1,0,TRUE);
                    end;
                }
                field("CL[11]"; CL[11])
                {
                    Caption = 'Contract Cost LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(1,3,FALSE);
                    end;
                }
                field("CL[12]"; CL[12])
                {
                    Caption = 'Contract Cost LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(1,0,FALSE);
                    end;
                }
                field("CL[15]"; CL[15])
                {
                    Caption = 'Invoiced Cost LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(1,3,FALSE);
                    end;
                }
                field("CL[16]"; CL[16])
                {
                    Caption = 'Invoiced Cost LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(1,0,FALSE);
                    end;
                }
                field(Control149; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field(Control150; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("PL[3] - CL[3]"; PL[3] - CL[3])
                {
                    Caption = 'Schedule Profit LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,3,TRUE);
                    end;
                }
                field("PL[4] - CL[4]"; PL[4] - CL[4])
                {
                    Caption = 'Schedule Profit LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,0,TRUE);
                    end;
                }
                field("PL[7] - CL[7]"; PL[7] - CL[7])
                {
                    Caption = 'Usage Profit LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,TRUE);
                    end;
                }
                field("PL[8] - CL[8]"; PL[8] - CL[8])
                {
                    Caption = 'Usage Profit LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,TRUE);
                    end;
                }
                field("PL[11] - CL[11]"; PL[11] - CL[11])
                {
                    Caption = 'Contract Profit LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,3,FALSE);
                    end;
                }
                field("PL[12] - CL[12]"; PL[12] - CL[12])
                {
                    Caption = 'Contract Profit LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(3,0,FALSE);
                    end;
                }
                field("PL[15] - CL[15]"; PL[15] - CL[15])
                {
                    Caption = 'Invoiced Profit LCY (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit LCY (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,FALSE);
                    end;
                }
                field("PL[16] - CL[16]"; PL[16] - CL[16])
                {
                    Caption = 'Invoiced Profit LCY (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit LCY (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,FALSE);
                    end;
                }
            }
            group(Currency)
            {
                Caption = 'Currency';
                label(Control103)
                {
                    CaptionClass = Text19057252;
                    ShowCaption = false;
                }
                label(Control75)
                {
                    CaptionClass = Text19059736;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                label(Control117)
                {
                    CaptionClass = Text19080002;
                    ShowCaption = false;
                }
                field(Price; Text000)
                {
                    Caption = 'Price';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field(Control152; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("P[1]"; P[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,1,TRUE);
                    end;
                }
                field("P[2]"; P[2])
                {
                    Caption = 'Schedule Price (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,2,TRUE);
                    end;
                }
                field("P[5]"; P[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,1,TRUE);
                    end;
                }
                label(Control80)
                {
                    CaptionClass = Text19077570;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("P[6]"; P[6])
                {
                    Caption = 'Usage Price (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,2,TRUE);
                    end;
                }
                field("P[9]"; P[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,1,FALSE);
                    end;
                }
                field("P[10]"; P[10])
                {
                    Caption = 'Contract Price (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,2,FALSE);
                    end;
                }
                field("P[13]"; P[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,1,FALSE);
                    end;
                }
                field("P[14]"; P[14])
                {
                    Caption = 'Invoiced Price (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,2,FALSE);
                    end;
                }
                field(Cost; Text000)
                {
                    Caption = 'Cost';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cost field.';
                }
                field(Control156; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("C[1]"; C[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,1,TRUE);
                    end;
                }
                field("C[2]"; C[2])
                {
                    Caption = 'Schedule Cost (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,2,TRUE);
                    end;
                }
                field("C[5]"; C[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,1,TRUE);
                    end;
                }
                field("C[6]"; C[6])
                {
                    Caption = 'Usage Cost (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,2,TRUE);
                    end;
                }
                field("C[9]"; C[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,1,FALSE);
                    end;
                }
                label(Control85)
                {
                    CaptionClass = Text19075586;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("C[10]"; C[10])
                {
                    Caption = 'Contract Cost (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,2,FALSE);
                    end;
                }
                field("C[13]"; C[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,1,FALSE);
                    end;
                }
                field("C[14]"; C[14])
                {
                    Caption = 'Invoiced Cost (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,2,FALSE);
                    end;
                }
                field(Profit; Text000)
                {
                    Caption = 'Profit';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Profit field.';
                }
                field(Control160; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("P[1] - C[1]"; P[1] - C[1])
                {
                    Caption = 'Schedule';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,1,TRUE);
                    end;
                }
                field("P[2] - C[2]"; P[2] - C[2])
                {
                    Caption = 'Schedule Profit (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,2,TRUE);
                    end;
                }
                field("P[5] - C[5]"; P[5] - C[5])
                {
                    Caption = 'Usage';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,1,TRUE);
                    end;
                }
                label(Control131)
                {
                    CaptionClass = Text19080003;
                    ShowCaption = false;
                }
                field(Control153; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("P[6] - C[6]"; P[6] - C[6])
                {
                    Caption = 'Usage Profit (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,2,TRUE);
                    end;
                }
                field("P[9] - C[9]"; P[9] - C[9])
                {
                    Caption = 'Contract';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,1,FALSE);
                    end;
                }
                field("P[10] - C[10]"; P[10] - C[10])
                {
                    Caption = 'Contract Profit (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,2,FALSE);
                    end;
                }
                field("P[13] - C[13]"; P[13] - C[13])
                {
                    Caption = 'Invoiced';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,1,FALSE);
                    end;
                }
                field("P[14] - C[14]"; P[14] - C[14])
                {
                    Caption = 'Invoiced Profit (Item)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit (Item) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,2,FALSE);
                    end;
                }
                label(Control144)
                {
                    CaptionClass = Text19080004;
                    ShowCaption = false;
                }
                field(Control154; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("P[3]"; P[3])
                {
                    Caption = 'Schedule Price (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,3,TRUE);
                    end;
                }
                field("P[4]"; P[4])
                {
                    Caption = 'Schedule Price (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Price (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,0,TRUE);
                    end;
                }
                field("P[7]"; P[7])
                {
                    Caption = 'Usage Price (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,3,TRUE);
                    end;
                }
                field("P[8]"; P[8])
                {
                    Caption = 'Usage Price (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Price (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,0,TRUE);
                    end;
                }
                field("P[11]"; P[11])
                {
                    Caption = 'Contract Price (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,3,FALSE);
                    end;
                }
                field("P[12]"; P[12])
                {
                    Caption = 'Contract Price (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Price (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,0,FALSE);
                    end;
                }
                field("P[15]"; P[15])
                {
                    Caption = 'Invoiced Price (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,3,FALSE);
                    end;
                }
                field("P[16]"; P[16])
                {
                    Caption = 'Invoiced Price (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Price (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(4,0,FALSE);
                    end;
                }
                field(Control157; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field(Control158; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("C[3]"; C[3])
                {
                    Caption = 'Schedule Cost (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,3,TRUE);
                    end;
                }
                field("C[4]"; C[4])
                {
                    Caption = 'Schedule Cost (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Cost (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,0,TRUE);
                    end;
                }
                field("C[7]"; C[7])
                {
                    Caption = 'Usage Cost (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,3,TRUE);
                    end;
                }
                field("C[8]"; C[8])
                {
                    Caption = 'Usage Cost (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Cost (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,0,TRUE);
                    end;
                }
                field("C[11]"; C[11])
                {
                    Caption = 'Contract Cost (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,3,FALSE);
                    end;
                }
                field("C[12]"; C[12])
                {
                    Caption = 'Contract Cost (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Cost (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(2,0,FALSE);
                    end;
                }
                field("C[15]"; C[15])
                {
                    Caption = 'Invoiced Cost (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,3,FALSE);
                    end;
                }
                field("C[16]"; C[16])
                {
                    Caption = 'Invoiced Cost (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Cost (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(2,0,FALSE);
                    end;
                }
                field(Control161; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field(Control162; Text000)
                {
                    Visible = false;
                    Caption = 'Text000';
                    ToolTip = 'Specifies the value of the Text000 field.';
                }
                field("P[3] - C[3]"; P[3] - C[3])
                {
                    Caption = 'Schedule Profit (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,3,TRUE);
                    end;
                }
                field("P[4] - C[4]"; P[4] - C[4])
                {
                    Caption = 'Schedule Profit (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Schedule Profit (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,0,TRUE);
                    end;
                }
                field("P[7] - C[7]"; P[7] - C[7])
                {
                    Caption = 'Usage Profit (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,TRUE);
                    end;
                }
                field("P[8] - C[8]"; P[8] - C[8])
                {
                    Caption = 'Usage Profit (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Usage Profit (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,TRUE);
                    end;
                }
                field("P[11] - C[11]"; P[11] - C[11])
                {
                    Caption = 'Contract Profit (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,3,FALSE);
                    end;
                }
                field("P[12] - C[12]"; P[12] - C[12])
                {
                    Caption = 'Contract Profit (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Contract Profit (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowPlanningLine(4,0,FALSE);
                    end;
                }
                field("P[15] - C[15]"; P[15] - C[15])
                {
                    Caption = 'Invoiced Profit (G/L Acc.)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit (G/L Acc.) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,3,FALSE);
                    end;
                }
                field("P[16] - C[16]"; P[16] - C[16])
                {
                    Caption = 'Invoiced Profit (Total)';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Invoiced Profit (Total) field.';

                    trigger OnDrillDown()
                    begin
                        //JobCalcStatistics.ShowLedgEntry(3,0,FALSE);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        C: array[16] of Decimal;
        CL: array[16] of Decimal;
        P: array[16] of Decimal;
        PL: array[16] of Decimal;
        Text000: Label 'Placeholder';
        Text19011378: Label 'Item';
        Text19012801: Label 'Price LCY';
        Text19028226: Label 'Total';
        Text19055809: Label 'G/L Account';
        Text19057252: Label 'Resource';
        Text19059736: Label 'Price';
        Text19068736: Label 'Cost LCY';
        Text19073853: Label 'Profit LCY';
        Text19075586: Label 'Profit';
        Text19077570: Label 'Cost';
        Text19080001: Label 'Resource';
        Text19080002: Label 'Item';
        Text19080003: Label 'G/L Account';
        Text19080004: Label 'Total';

    local procedure OnAfterGetCurrRecord()
    begin
        // /
    end;
}

