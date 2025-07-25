page 65015 "Performance Contracting Users"
{
    ApplicationArea = All;
    AutoSplitKey = false;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Performance Contracting Users";

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
    }

    actions
    {
    }
}

