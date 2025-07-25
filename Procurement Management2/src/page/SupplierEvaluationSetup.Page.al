page 53109 "Supplier Evaluation Setup"
{
    PageType = List;
    Editable = false;
    SourceTable = "Supplier Evaluation SetUp";
    CardPageId = "Supplier Evaluation Setup Card";
    SourceTableView = where(Type = const(Tender));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Evalueation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Heading field';
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                    ToolTip = 'Specifies the value of the Evaluation Criteria field.';
                    ApplicationArea = All;
                }
                field("Score Criteria"; Rec."Score Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score Criteria field';
                }
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Maximum Score field';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field';
                }
            }
        }
    }

    actions
    {
    }
}





