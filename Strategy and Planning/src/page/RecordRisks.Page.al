page 65036 "Record Risks"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Records Risks";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                    Visible = false;
                }
                field(Risk; Rec.Risk)
                {
                    ToolTip = 'Specifies the value of the Risk field.';
                }
                field(Mitigation; Rec.Mitigation)
                {
                    ToolTip = 'Specifies the value of the Mitigation field.';
                }
            }
        }
    }

    actions
    {
    }
}

