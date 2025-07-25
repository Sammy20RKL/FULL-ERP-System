page 53139 "Procurement Plan Review List"
{
    CardPageID = "Procurement Plan Review Card";
    Editable = false;
    PageType = List;
    SourceTable = "Budget Approval Header";
    ApplicationArea = All;
    UsageCategory = History;
    SourceTableView = where("Budget Type" = const("Procurement Plan"), "Budget Option" = const("Procurement Plan Review"), Status = filter(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field';
                }
                field("Time Created"; Rec."Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Created field';
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Name field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                    ApplicationArea = All;
                }
                field(Approvals; Rec.Approvals)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approvals field';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control11; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Budget Type" := Rec."Budget Type"::"Procurement Plan";
        Rec."Budget Option" := Rec."Budget Option"::"Procurement Plan Review";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Budget Type" := Rec."Budget Type"::"Procurement Plan";
        Rec."Budget Option" := Rec."Budget Option"::"Procurement Plan Review";
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Show All" then begin
            Rec.FilterGroup(2);
            Rec.SetRange("User ID", UserId);
        end;
    end;

    var
        UserSetup: Record "User Setup";
}






