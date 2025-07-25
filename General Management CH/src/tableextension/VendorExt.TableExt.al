tableextension 50006 "VendorExt" extends Vendor
{
    fields
    {
        field(50000; "Vendor Type"; Enum "Vendor Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Type';
        }
        field(50001; "KRA PIN"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'KRA PIN';
        }
        field(50002; "Sort Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sort Code';
        }
        field(50003; "PIN Certificate Expiry"; date)
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Certificate Expiry';
        }
    }
}





