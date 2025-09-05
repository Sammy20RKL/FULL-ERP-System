
page 52312 "Employee Timesheet card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Work Time";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'GENERAL';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field';
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                    Editable = false;
                }
                field(Position; Rec.Position)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Work Date field';

                }
                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                }
                field("Job Position Title"; Rec."Job Position Title")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                }
                field("Total Working Days"; Rec."Total Working Days")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                }
                field("Employee Total Personal Cost1"; Rec."Employee Total Personal Cost1")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                    Caption = 'Employee Total Personal Cost';
                    Editable = false;

                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Work Date field';
                }




            }

            part(Control26; "Employee Timesheet line")
            {
                Caption = 'Timesheet line';
                SubPageLink = "No." = field("No.");
                UpdatePropagation = Both;
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(TimeSheet)
            {
                RunObject = report "Employee Time Sheet";

                trigger OnAction()
                begin

                end;
            }
            action(calculate)
            {
                trigger OnAction()
                begin
                    //                     FromDate:=StartDate;

                    // ToDate:=CALCDATE('-1D',CALCDATE('1M',StartDate));
                    // EVALUATE(FromDateS,FORMAT(FromDate));
                    // EVALUATE(ToDateS,FORMAT(ToDate));


                    FromDate := CalcDate('-CM', Rec."Payroll Period");
                    ToDate := CALCDATE('-1D', CALCDATE('1M', Rec."Payroll Period"));
                    Message('from is %1...#...ToDate is %2', FromDate, ToDate);
                    EVALUATE(FromDateS, FORMAT(startDate));
                    EVALUATE(ToDateS, FORMAT(EndDate));
                    DateFilter := FromDateS + '..' + ToDateS;

                    CustomizedCalendarChange.Reset();
                    CustomizedCalendarChange.SetFilter(Date, DateFilter);
                    if CustomizedCalendarChange.Find('-') then
                        TDays := Rec.count;//TDays + CustomizedCalendarChange."Entry No.";
                    Message('Tday is %1', TDays);

                end;
            }
        }
    }

    var
        ToDate: Date;
        FromDate: Date;
        TDays: Integer;
        DateFilter: Text;
        ToDateS: Text;
        FromDateS: Text;
        myInt: Integer;
        BaseCalendar: Record "Base Calendar";
        startDate: Date;
        EndDate: Date;
        StartInt: Integer;
        EndInt: Integer;
        Monthperiod: Date;
        DaysOfMonth: Integer;
        CustomizedCalendarChange: Record "Customized Calendar Change";
}



