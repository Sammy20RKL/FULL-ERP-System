page 53044 "Project Task Components"
{
    PageType = ListPart;
    SourceTable = "Project Task Components";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Component; Rec.Component)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Component field';
                }
                field("Component Budget"; Rec."Component Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Component Budget field';
                }
                field("Progress Level"; Rec."Progress Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Progress Level field';
                }
            }
        }
    }

    actions
    {
    }
}





