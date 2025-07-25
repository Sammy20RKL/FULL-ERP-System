tableextension 53011 "VendorProcurementExt" extends Vendor
{
    fields
    {
        field(53000; "Prospective No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Prospective No.';
        }
    }
}
