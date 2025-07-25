page 60046 "Project Donors"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Project Donors";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Donor Name"; Rec."Donor Name")
                {
                    Caption = 'Donor Name';
                    ToolTip = 'Specifies the value of the Donor Name field.';
                }
                field(Percentage; Rec.Percentage)
                {
                    Caption = 'Percentage';
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field("Allowed Indirect Cost"; Rec."Allowed Indirect Cost")
                {
                    Caption = 'Allowed Indirect Cost';
                    ToolTip = 'Specifies the value of the Allowed Indirect Cost field.';
                }
                field("Indirect Cost"; Rec."Indirect Cost")
                {
                    Caption = 'Allow Indirect Cost';
                    ToolTip = 'Specifies the value of the Allow Indirect Cost field.';
                }
                field("Expected Donation"; Rec."Expected Donation")
                {
                    Caption = 'Expected Donation';
                    ToolTip = 'Specifies the value of the Expected Donation field.';
                }
                field("Donated Amount"; Rec."Donated Amount")
                {
                    Caption = 'Donated Amount';
                    ToolTip = 'Specifies the value of the Donated Amount field.';
                }
                field(Balance; Rec.Balance)
                {
                    Caption = 'Balance';
                    ToolTip = 'Specifies the value of the Balance field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Balance := Rec."Expected Donation" - Rec."Donated Amount";
    end;
}

