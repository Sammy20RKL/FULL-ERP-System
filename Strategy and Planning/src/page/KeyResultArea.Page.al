page 65003 "Key Result Area"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Key Results Area";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Strategic Plan No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Strategic Plan No. field.';
                    Visible = false;
                }
                field("KRA Code"; Rec."KRA Code")
                {
                    ToolTip = 'Specifies the value of the KRA Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
            action("Strategic Objectives")
            {
                Image = PostedCreditMemo;
                RunObject = page Strategies;
                RunPageLink = Code = field("KRA Code"), "Header No." = field("Document No.");
                ToolTip = 'Executes the Strategic Objectives action.';

                trigger OnAction()
                begin
                    //hghghgh
                end;
            }
        }
    }
}

