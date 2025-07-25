page 65002 "Strategic Objectives"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Strategic Objectives";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    Visible = false;
                }
                field("KRA Code"; Rec."KRA Code")
                {
                    ToolTip = 'Specifies the value of the KRA Code field.';
                }
                field("KRA Description"; Rec."KRA Description")
                {
                    ToolTip = 'Specifies the value of the KRA Description field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    ToolTip = 'Specifies the value of the Objective Code field.';
                }
                field("Objective description"; Rec."Objective description")
                {
                    ToolTip = 'Specifies the value of the Objective description field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Activities)
            {
                Image = PostedCreditMemo;
                RunObject = page Activities;
                RunPageLink = Code = field("Document No."), "Line No" = field("Line No.");
                ToolTip = 'Executes the Activities action.';
                Visible = false;
            }
        }
    }
}

