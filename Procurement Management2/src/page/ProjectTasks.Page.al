page 53043 "Project Tasks"
{
    CardPageID = "Project Tasks Card";
    Editable = false;
    PageType = List;
    SourceTable = "Project Tasks";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Task No"; Rec."Task No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task No field';
                }
                field(Descriprion; Rec.Descriprion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descriprion field';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                }
                field(Importance; Rec.Importance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Importance field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Progress Level % field';
                }
                field("Task Budget"; Rec."Task Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task Budget field';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }
}





