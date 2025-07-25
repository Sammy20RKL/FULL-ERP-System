tableextension 53001 "ItemExt" extends Item
{
    fields
    {
        field(53000; "Item G/L Budget Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Caption = 'Item G/L Budget Account';
        }
    }
}





