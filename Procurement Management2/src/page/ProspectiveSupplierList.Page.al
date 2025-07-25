page 53107 "Prospective Supplier List"
{
    CardPageID = "Prospective Supplier card";
    // DeleteAllowed = false;
    PageType = List;
    SourceTable = "Prospective Suppliers";
    SourceTableView = where("Pre Qualified" = const(false));
    Editable = false;

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-mail field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Name field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Modds)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    PRosp: Record "Prospective Suppliers";
                begin
                    if PRosp.FindSet() then
                        repeat
                            PRosp.Validate("Pre Qualified", true);
                            PRosp.Modify();
                        until PRosp.Next() = 0;
                end;
            }
        }
    }
}





