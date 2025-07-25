page 65014 "Performance Contracting Dept."
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Performance Contracting Dept.";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Resource)
            {
                Image = Resource;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Performance Contracting Users";
                RunPageLink = "Document No." = field(Code);
                ToolTip = 'Executes the Resource action.';
            }
        }
    }
}

