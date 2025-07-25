page 53125 "Vendor Evaluation Setup"
{
    PageType = List;
    SourceTable = "Supplier Evaluation SetUp";
    CardPageId = "Vendor Evaluation Setup Card";
    SourceTableView = where(Type = const(Existing));

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
                field("Evaluation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Heading field';
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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
        }
    }

    actions
    {
    }
}





