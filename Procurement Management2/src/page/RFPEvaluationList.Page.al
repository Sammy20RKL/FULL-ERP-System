page 53099 "RFP Evaluation List"
{
    CardPageID = "Procurement Evaluation Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Evaluation Header";
    SourceTableView = where("LPO/Contract Generated" = const(false), "Process Type" = const(RFP));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
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
                field("RFP Generated"; Rec."LPO/Contract Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TFP Generated field';
                }
            }
        }
    }

    actions
    {
    }
}





