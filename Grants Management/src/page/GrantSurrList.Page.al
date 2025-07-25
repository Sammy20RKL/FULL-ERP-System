page 60005 "Grant Surr List"
{
    ApplicationArea = All;
    CardPageId = "Grant Surrender";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Grant Surrender Header";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(No; Rec.No)
                {
                    Caption = 'No';
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    Caption = 'Surrender Date';
                    ToolTip = 'Specifies the value of the Surrender Date field.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Caption = 'Cheque No';
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
            }
        }
    }

    actions
    {
    }
}

