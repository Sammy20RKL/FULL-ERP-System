page 60032 "Close out List"
{
    ApplicationArea = All;
    CardPageId = "Close out Header";
    PageType = List;
    SourceTable = "Close Out Check List";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Grant No"; Rec."Grant No")
                {
                    Editable = false;
                    Caption = 'Grant No';
                    ToolTip = 'Specifies the value of the Grant No field.';
                }
                field("Closeout No."; Rec."Closeout No.")
                {
                    Caption = 'Closeout No.';
                    ToolTip = 'Specifies the value of the Closeout No. field.';
                }
                field("Compliance Code"; Rec."Compliance Code")
                {
                    Caption = 'Compliance Code';
                    ToolTip = 'Specifies the value of the Compliance Code field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Compliance; Rec.Compliance)
                {
                    Caption = 'Compliance';
                    ToolTip = 'Specifies the value of the Compliance field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Comments';
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }
}

