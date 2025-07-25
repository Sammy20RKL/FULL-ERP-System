tableextension 50005 "CustomerExt" extends Customer
{
    fields
    {
        field(50000; "Customer Type"; Enum "Customer Type")
        {
            Caption = 'Customer Type';
            DataClassification = CustomerContent;
        }
        field(50001; "KRA PIN"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'KRA PIN';
        }
        field(50002; "PIN Certificate Expiry"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Certificate Expiry';
        }
    }
}





