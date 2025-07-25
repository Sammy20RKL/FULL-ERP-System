page 53074 "Quote Evaluation List"
{
    CardPageID = "Procurement Evaluation Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Evaluation Header";
    SourceTableView = where("LPO/Contract Generated" = const(false), "Process Type" = const(RFQ));
    InsertAllowed = false;
    Editable = true;

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





