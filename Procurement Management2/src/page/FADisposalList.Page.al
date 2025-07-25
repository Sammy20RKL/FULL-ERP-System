page 53027 "FA Disposal List"
{
    ApplicationArea = All;
    Caption = 'FA Disposal List';
    PageType = List;
    SourceTable = "FA Disposal";
    UsageCategory = Lists;
    CardPageId = "FA Disposal Card";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date-Time Created field';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }
}





