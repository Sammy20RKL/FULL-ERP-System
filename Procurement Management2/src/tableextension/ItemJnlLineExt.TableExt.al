tableextension 53004 "ItemJnlLineExt" extends "Item Journal Line"
{
    fields
    {
        field(53000; Narration; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Narration';
        }
    }

    procedure Post()
    begin
        Codeunit.Run(Codeunit::"Item Jnl.-Post", Rec);
    end;
}





