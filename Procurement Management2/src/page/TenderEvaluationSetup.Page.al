page 53147 "Tender Evaluation Setup"
{
    Caption = 'Tender Evaluation Setup';
    PageType = ListPart;
    SourceTable = "Tender Evaluation Setup";
    SourceTableView = sorting("Evaluation Criteria");

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Evaluation Code"; Rec."Evaluation Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Evaluation Description"; Rec."Evaluation Heading")
                {
                    ToolTip = 'Specifies the value of the Evaluation Heading field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                    ToolTip = 'Specifies the value of the Evaluation Criteria field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Parameters)
            {
                Image = Calculate;
                ApplicationArea = All;
                RunObject = page "Tender Evaluation Setup Lines";
                RunPageLink = "Tender No." = field("Tender No."), Code = field("Evaluation Code");
            }
        }
    }
}





