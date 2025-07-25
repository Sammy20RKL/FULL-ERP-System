page 65005 "Strategic Lines"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Strategies;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Objective Description"; Rec."Objective Description")
                {
                    Caption = 'Objective';
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Strategic Name"; Rec."Strategic Name")
                {
                    Caption = 'Strategy';
                    ToolTip = 'Specifies the value of the Strategy field.';
                }
                field(Activity; Rec.Activity)
                {
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(Output; Rec.Output)
                {
                    ToolTip = 'Specifies the value of the Output field.';
                }
                field("Performance Indicator"; Rec."Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator field.';
                }
                field("Year 1 Target"; Rec."Year 1 Target")
                {
                    Caption = 'Year 1';
                    ToolTip = 'Specifies the value of the Year 1 field.';
                }
                field("Year 2 Target"; Rec."Year 2 Target")
                {
                    Caption = 'Year 2';
                    ToolTip = 'Specifies the value of the Year 2 field.';
                }
                field("Year 3 Target"; Rec."Year 3 Target")
                {
                    Caption = 'Year 3';
                    ToolTip = 'Specifies the value of the Year 3 field.';
                }
                field("Year 4 Target"; Rec."Year 4 Target")
                {
                    Caption = 'Year 4';
                    ToolTip = 'Specifies the value of the Year 4 field.';
                }
                field("Year 5 Target"; Rec."Year 5 Target")
                {
                    Caption = 'Year 5';
                    ToolTip = 'Specifies the value of the Year 5 field.';
                }
                field("Total Target"; Rec."Total Target")
                {
                    ToolTip = 'Specifies the value of the Total Target field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable := false
    end;
}

