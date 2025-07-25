page 53070 "Committee"
{
    PageType = List;
    SourceTable = "Procurement Committees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Members; Rec.Members)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Members field';
                }
                field(Permanent; Rec.Permanent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Permanent field';
                }
            }
        }
    }

    actions
    {
    }
}





