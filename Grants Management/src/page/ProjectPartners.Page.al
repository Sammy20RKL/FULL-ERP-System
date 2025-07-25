page 60045 "Project Partners"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Project Partners";

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(PartnerID; Rec.PartnerID)
                {
                    Caption = 'PartnerID';
                    ToolTip = 'Specifies the value of the PartnerID field.';
                }
                field("Partner Name"; Rec."Partner Name")
                {
                    Caption = 'Partner Name';
                    ToolTip = 'Specifies the value of the Partner Name field.';
                }
                field("Grant No"; Rec."Grant No")
                {
                    Caption = 'Grant No';
                    ToolTip = 'Specifies the value of the Grant No field.';
                }
                field("Contractor Type"; Rec."Contractor Type")
                {
                    Caption = 'Contractor Type';
                    ToolTip = 'Specifies the value of the Contractor Type field.';
                }
                field("Partner Budget"; Rec."Partner Budget")
                {
                    Editable = false;
                    Caption = 'Partner Budget';
                    ToolTip = 'Specifies the value of the Partner Budget field.';
                }
                field("Disbursed Amount (LCY)"; Rec."Disbursed Amount (LCY)")
                {
                    Caption = 'Disbursed Amount (LCY)';
                    ToolTip = 'Specifies the value of the Disbursed Amount (LCY) field.';
                }
                field(Balance; Rec.Balance)
                {
                    Caption = 'Balance';
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Accounted Amount"; Rec."Accounted Amount")
                {
                    Caption = 'Accounted Amount';
                    ToolTip = 'Specifies the value of the Accounted Amount field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.Balance := Rec."Partner Budget" - Rec."Disbursed Amount (LCY)";
    end;
}

