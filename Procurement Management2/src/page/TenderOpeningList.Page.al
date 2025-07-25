page 53051 "Tender Opening List"
{
    Caption = 'Tender Opening List';
    PageType = List;
    SourceTable = "Tender Opening Register";
    SourceTableView = sorting("Tender No.", "User ID");
    CardPageId = "Tender Opening Card";
    UsageCategory = None;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier No. field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Tender Opened"; Rec."Tender Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Opened field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."Show All" then begin
                Rec.FilterGroup(2);
                Rec.SetRange("User ID", UserId);
            end;
        end else
            Error('%1 does not exist in the Users Setup', UserId);
    end;
}






