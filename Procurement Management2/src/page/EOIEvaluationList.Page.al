page 53085 "EOI Evaluation List"
{
    CardPageID = "Procurement Evaluation Card";
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Evaluation Header";
    SourceTableView = where("LPO/Contract Generated" = const(false), "Process Type" = const(EOI));

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
                field("EOI Generated"; Rec."LPO/Contract Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EOI Generated field';
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::EOI;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::EOI;
    end;
}





