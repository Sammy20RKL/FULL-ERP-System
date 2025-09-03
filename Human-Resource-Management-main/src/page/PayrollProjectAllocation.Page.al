Page 52313 "Payroll Project Allocation"
{
    PageType = List;
    SourceTable = "Payroll Project Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ToolTip = 'The Tooltip property for PageField Period must be filled';
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ToolTip = 'The Tooltip property for PageField "Employee No" must be filled';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'The Tooltip property for PageField "Employee Name" must be filled.';
                    ApplicationArea = All;
                }
                field("Project Code"; Rec."Project Code")
                {
                    ToolTip = 'The Tooltip property for PageField "Project Code" must be filled.';
                    ApplicationArea = All;
                }
                field("Budget Line Code"; Rec."Budget Line Code")
                {
                    ToolTip = 'The Tooltip property for PageField "Budget Line Code" must be filled.';
                    ApplicationArea = All;
                }
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                //     Caption = 'Shortcut Dimension 1 Code';
                //     // Editable = not CanEdit and not IsStatusPending;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                //     // Visible = DimVisible1;
                //     ApplicationArea = All;
                // }
                // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                // {
                //     Caption = 'Shortcut Dimension 2 Code';
                //     // Editable = not CanEdit and not IsStatusPending;
                //     ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                //     // Visible = DimVisible2;
                //     ApplicationArea = All;
                // }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                {
                    ApplicationArea = All;
                }
                // field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                // {
                //     ApplicationArea = All;
                // }


                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'The Tooltip property for PageField Allocation must be filled.';
                    ApplicationArea = All;
                    DecimalPlaces = 3 : 3;
                }
                field(Close; Rec.Close)
                {
                    ToolTip = 'The Tooltip property for PageField Closed must be filled.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadAllocations)
            {
                ApplicationArea = All;
                Caption = 'Load Allocations';
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'The Tooltip property for PageAction LoadAllocations must be filled.';
                trigger OnAction()
                begin
                    PayrollCalender_AU.Reset();
                    PayrollCalender_AU.SetRange(Closed, true);
                    if PayrollCalender_AU.FindLast() then begin
                        PayrollProjectAllocation.Reset();
                        PayrollProjectAllocation.SetRange(Period, PayrollCalender_AU."Pay Date");
                        if PayrollProjectAllocation.FindSet() then begin
                            repeat
                                PayrollCalender_AU2.Reset();
                                if PayrollCalender_AU2.FindLast() then begin
                                    PayrollProjectAllocation2.Init;
                                    PayrollProjectAllocation2.Period := PayrollCalender_AU2."Pay Date";
                                    PayrollProjectAllocation2."Project Code" := PayrollProjectAllocation."Project Code";
                                    PayrollProjectAllocation2."Budget Line Code" := PayrollProjectAllocation."Budget Line Code";
                                    PayrollProjectAllocation2."Employee No" := PayrollProjectAllocation."Employee No";
                                    PayrollProjectAllocation2."Employee Name" := PayrollProjectAllocation."Employee Name";
                                    PayrollProjectAllocation2.Allocation := PayrollProjectAllocation.Allocation;
                                    // PayrollProjectAllocation2."Shortcut Dimension 1 Code" := PayrollProjectAllocation."Shortcut Dimension 1 Code";
                                    // PayrollProjectAllocation2."Shortcut Dimension 2 Code" := PayrollProjectAllocation."Shortcut Dimension 2 Code";
                                    PayrollProjectAllocation2."Dimension Set ID" := PayrollProjectAllocation."Dimension Set ID";
                                    // "ShortcutDimCode[3]" := "ShortcutDimCode[3]";
                                    PayrollProjectAllocation2.Insert;
                                end;
                            until PayrollProjectAllocation.Next = 0;
                        end;
                        Message('Completed');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Employee Name" = '' then begin
            if HREmployees.Get(Rec."Employee No") then begin
                Rec."Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
                Rec.Modify;
            end;
        end;
    end;

    var
        HREmployees: Record Employee;
        PayrollProjectAllocation: Record "Payroll Project Allocation";
        PayrollCalender_AU: Record "Payroll Period";
        PayrollCalender_AU2: Record "Payroll Period";
        PayrollProjectAllocation2: Record "Payroll Project Allocation";
        // ShortcutDimCode: array[8] of Code[20];
}

