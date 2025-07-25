page 53122 "Vendor Evaluation List"
{
    CardPageID = "Vendor Evaluation Card";
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "Supplier Evaluation Header";
    SourceTableView = where(Type = const(Existing));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field';
                }
                field("Quote No"; Rec."Quote No")
                {
                    Caption = 'Tender No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
        }
    }
}





