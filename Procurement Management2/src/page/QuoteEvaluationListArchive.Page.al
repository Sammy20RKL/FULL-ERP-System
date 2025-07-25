page 53091 "Quote Evaluation List-Archive"
{
    CardPageID = "Procurement Evaluation Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Evaluation Header";
    SourceTableView = where("LPO/Contract Generated" = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field';
                }
                field("Quote Generated"; Rec."LPO/Contract Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote Generated field';
                }
            }
        }
    }

    actions
    {
    }
}





