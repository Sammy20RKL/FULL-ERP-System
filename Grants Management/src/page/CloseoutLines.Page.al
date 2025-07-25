page 60034 "Close out Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Closeout Checklist Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Line No"; Rec."Line No")
                {
                    Caption = 'Line No';
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                field("Closeout Nos"; Rec."Closeout Nos")
                {
                    Caption = 'Closeout Nos';
                    ToolTip = 'Specifies the value of the Closeout Nos field.';
                }
                field(Sections; Rec.Sections)
                {
                    Caption = 'Sections';
                    ToolTip = 'Specifies the value of the Sections field.';
                }
                field(Options; Rec.Options)
                {
                    Caption = 'Options';
                    ToolTip = 'Specifies the value of the Options field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Reason; Rec.Reason)
                {
                    Caption = 'Comment';
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }

    actions
    {
    }
}

