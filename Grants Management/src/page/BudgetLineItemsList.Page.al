page 60021 "Budget Line Items List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Budget Line Items";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Use; Rec.Use)
                {
                    Caption = 'Use';
                    ToolTip = 'Specifies the value of the Use field.';
                }
                field(Position; Rec.Position)
                {
                    Caption = 'Position';
                    ToolTip = 'Specifies the value of the Position field.';
                }
            }
        }
    }

    actions
    {
    }
}

