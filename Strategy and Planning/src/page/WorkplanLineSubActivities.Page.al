page 65024 "Workplan Line Sub-Activities"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "WorkPlan Line Sub-Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("KRA Code"; Rec."KRA Code")
                {
                    ToolTip = 'Specifies the value of the KRA Code field.';
                }
                field("KRA Description"; Rec."KRA Description")
                {
                    ToolTip = 'Specifies the value of the KRA Description field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic Issue';
                    ToolTip = 'Specifies the value of the Strategic Issue field.';
                }
                field("Objective Description"; Rec."Objective Description")
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Strategic Code"; Rec."Strategic Code")
                {
                    Caption = 'Strategy';
                    ToolTip = 'Specifies the value of the Strategy field.';
                }
                field("Strategic Name"; Rec."Strategic Name")
                {
                    Caption = 'Strategic Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Strategic Name field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field("Activities Code"; Rec."Activities Code")
                {
                    Caption = 'Projected Output Code';
                    ToolTip = 'Specifies the value of the Projected Output Code field.';
                    Visible = false;
                }
                field("Description [Activities]"; Rec."Description [Activities]")
                {
                    Caption = 'Description (Projected Output)';
                    ToolTip = 'Specifies the value of the Description (Projected Output) field.';
                }
                field("Sub Activity Code"; Rec."Sub Activity Code")
                {
                    Caption = 'Activities Code';
                    ToolTip = 'Specifies the value of the Activities Code field.';
                    Visible = false;
                }
                field("Description [Sub Activities]"; Rec."Description [Sub Activities]")
                {
                    Caption = 'Description (Activities)';
                    ToolTip = 'Specifies the value of the Description (Activities) field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
                field(Output; Rec.Output)
                {
                    ToolTip = 'Specifies the value of the Output field.';
                    Visible = false;
                }
                field("GOK Approved Budget"; Rec."GOK Approved Budget")
                {
                    ToolTip = 'Specifies the value of the GOK Approved Budget field.';
                }
                field("Donor in Kind"; Rec."Donor in Kind")
                {
                    ToolTip = 'Specifies the value of the Donor in Kind field.';
                }
                field("Donor Funds Approved Budget"; Rec."Donor Funds Approved Budget")
                {
                    ToolTip = 'Specifies the value of the Donor Funds Approved Budget field.';
                }
                field("Approved Total Budget"; Rec."Approved Total Budget")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Approved Total Budget field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field("Key Performance Indicator"; Rec."Key Performance Indicator")
                {
                    Caption = 'Means of Verification';
                    ToolTip = 'Specifies the value of the Means of Verification field.';
                }
                field(July; Rec.July)
                {
                    ToolTip = 'Specifies the value of the July field.';
                }
                field(August; Rec.August)
                {
                    ToolTip = 'Specifies the value of the August field.';
                }
                field(September; Rec.September)
                {
                    ToolTip = 'Specifies the value of the September field.';
                }
                field(October; Rec.October)
                {
                    ToolTip = 'Specifies the value of the October field.';
                }
                field(November; Rec.November)
                {
                    ToolTip = 'Specifies the value of the November field.';
                }
                field(December; Rec.December)
                {
                    ToolTip = 'Specifies the value of the December field.';
                }
                field(January; Rec.January)
                {
                    ToolTip = 'Specifies the value of the January field.';
                }
                field(February; Rec.February)
                {
                    ToolTip = 'Specifies the value of the February field.';
                }
                field(March; Rec.March)
                {
                    ToolTip = 'Specifies the value of the March field.';
                }
                field(April; Rec.April)
                {
                    ToolTip = 'Specifies the value of the April field.';
                }
                field(May; Rec.May)
                {
                    ToolTip = 'Specifies the value of the May field.';
                }
                field(June; Rec.June)
                {
                    ToolTip = 'Specifies the value of the June field.';
                }
                field("Quarter 1 Target"; Rec."Quarter 1 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 1 Target field.';

                    trigger OnValidate()
                    begin
                        if WPlan.Get(Rec.Code) then begin
                            if WPlan.Status = WPlan.Status::Approved then
                                Error('You are not allowed to modify approved targets');
                        end;
                    end;
                }
                field("Quarter 2 Target"; Rec."Quarter 2 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 2 Target field.';

                    trigger OnValidate()
                    begin
                        if WPlan.Get(Rec.Code) then begin
                            if WPlan.Status = WPlan.Status::Approved then
                                Error('You are not allowed to modify approved targets');
                        end;
                    end;
                }
                field("Quarter 3 Target"; Rec."Quarter 3 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 3 Target field.';

                    trigger OnValidate()
                    begin
                        if WPlan.Get(Rec.Code) then begin
                            if WPlan.Status = WPlan.Status::Approved then
                                Error('You are not allowed to modify approved targets');
                        end;
                    end;
                }
                field("Quarter 4 Target"; Rec."Quarter 4 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 4 Target field.';

                    trigger OnValidate()
                    begin
                        if WPlan.Get(Rec.Code) then begin
                            if WPlan.Status = WPlan.Status::Approved then
                                Error('You are not allowed to modify approved targets');
                        end;
                    end;
                }
                field("Total Quarter Target"; Rec."Total Quarter Target")
                {
                    ToolTip = 'Specifies the value of the Total Quarter Target field.';
                }
                field("Quarter 1 Actual"; Rec."Quarter 1 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 1 Actual field.';
                }
                field("Quarter 2 Actual"; Rec."Quarter 2 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 2 Actual field.';
                }
                field("Quarter 3 Actual"; Rec."Quarter 3 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 3 Actual field.';
                }
                field("Quarter 4 Actual"; Rec."Quarter 4 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 4 Actual field.';
                }
                field("Total Quarter Actual"; Rec."Total Quarter Actual")
                {
                    ToolTip = 'Specifies the value of the Total Quarter Actual field.';
                }
                field("Sub-Activities"; Rec."Sub-Activities")
                {
                    ToolTip = 'Specifies the value of the Sub-Activities field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Image = StepOut;
                ToolTip = 'Executes the Submit action.';
                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to submit actual achievements?', false) then begin
                        WkLines.Reset();
                        WkLines.SetRange(Code, Rec.Code);
                        WkLines.SetRange("KRA Code", Rec."KRA Code");
                        if WkLines.Find('-') then begin
                            repeat
                                if WPlan.Get(Rec.Code) then begin
                                    if Budget.Get(WPlan."Financial Year") then begin
                                        if CalcDate('<+4M>', Budget."Start Date") > Today then begin
                                            if ((WkLines."Quarter 1 Target" <> 0) and (WkLines."Quarter 1 Actual" = 0)) then
                                                Message('Kindly note that you are behind schedule in implementing targets set for the reporting period(Q1)');
                                        end;
                                        if CalcDate('<+7M>', Budget."Start Date") > Today then begin
                                            if ((WkLines."Quarter 2 Target" <> 0) and (WkLines."Quarter 2 Actual" = 0)) then
                                                Message('Kindly note that you are behind schedule in implementing targets set for the reporting period(Q2)');
                                        end;
                                        if CalcDate('<+10M>', Budget."Start Date") > Today then begin
                                            if ((WkLines."Quarter 3 Target" <> 0) and (WkLines."Quarter 3 Actual" = 0)) then
                                                Message('Kindly note that you are behind schedule in implementing targets set for the reporting period(Q3)');
                                        end;
                                        if CalcDate('<+13M>', Budget."Start Date") > Today then begin
                                            if ((WkLines."Quarter 4 Target" <> 0) and (WkLines."Quarter 4 Actual" = 0)) then
                                                Message('Kindly note that you are behind schedule in implementing targets set for the reporting period(Q4)');
                                        end;
                                    end;
                                end;
                            until WkLines.Next() = 0;
                        end;
                    end;

                end;
            }
        }
    }

    var
        Budget: Record "G/L Budget Name";
        WPlan: Record "Work Plan Header";
        WkLines: Record "WorkPlan Line Sub-Activities";
        Q1d: Date;
        StartDate: Date;
}

