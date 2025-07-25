page 60002 "Compliance main List"
{
    ApplicationArea = All;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Grants Compliance";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Grant No"; Rec."Grant No")
                {
                    Editable = false;
                    Caption = 'Grant No';
                    ToolTip = 'Specifies the value of the Grant No field.';
                }
                field("Compliance Code"; Rec."Compliance Code")
                {
                    Caption = 'Serial No.';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("Post Compliance Report")
            {
                Caption = 'Post Compliance Report';
                ToolTip = 'Executes the Post Compliance Report action.';
            }
        }
    }
}

