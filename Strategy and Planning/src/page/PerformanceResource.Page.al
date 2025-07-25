page 65017 "Performance Resource"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Performance Resource";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Resource; Rec.Resource)
                {
                    ToolTip = 'Specifies the value of the Resource field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ToolTip = 'Specifies the value of the Responsibility field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control6; Notes)
            {
            }
            systempart(Control7; MyNotes)
            {
            }
            systempart(Control8; Links)
            {
            }
        }
    }

    actions
    {
    }
}

