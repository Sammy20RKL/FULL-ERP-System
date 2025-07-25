page 60029 "Donor I/C Account List"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Donor IC G/L Account";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    Caption = 'Income/Balance';
                    ToolTip = 'Specifies the value of the Income/Balance field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Map-to G/L Acc. No."; Rec."Map-to G/L Acc. No.")
                {
                    Caption = 'Map-to G/L Acc. No.';
                    ToolTip = 'Specifies the value of the Map-to G/L Acc. No. field.';
                }
                field(Indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                    ToolTip = 'Specifies the value of the Indentation field.';
                }
                field(Donor; Rec.Donor)
                {
                    Caption = 'Donor';
                    ToolTip = 'Specifies the value of the Donor field.';
                }
            }
        }
    }

    actions
    {
    }
}

