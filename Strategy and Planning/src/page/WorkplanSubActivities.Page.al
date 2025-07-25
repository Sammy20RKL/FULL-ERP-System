page 65021 "Workplan Sub-Activities"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "WorkPlan Sub-Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Activities Code"; Rec."Activities Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Activities Code field.';
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    ToolTip = 'Specifies the value of the Objective Code field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
                field(Output; Rec.Output)
                {
                    ToolTip = 'Specifies the value of the Output field.';
                }
                field("First Quarter"; Rec."First Quarter")
                {
                    ToolTip = 'Specifies the value of the First Quarter field.';
                }
                field("Second Quarter"; Rec."Second Quarter")
                {
                    ToolTip = 'Specifies the value of the Second Quarter field.';
                }
                field("Third Quarter"; Rec."Third Quarter")
                {
                    ToolTip = 'Specifies the value of the Third Quarter field.';
                }
                field("Fourth Quarter"; Rec."Fourth Quarter")
                {
                    ToolTip = 'Specifies the value of the Fourth Quarter field.';
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ToolTip = 'Specifies the value of the Approved Budget field.';
                }
            }
        }
    }

    actions
    {
    }
}

