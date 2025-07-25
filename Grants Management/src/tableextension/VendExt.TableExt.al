tableextension 60000 "Vend Ext" extends Vendor
{
    fields
    {
        field(60000; "Vendor Type-Grants"; Option)
        {
            Caption = 'Vendor Type-Grants';
            DataClassification = ToBeClassified;
            OptionMembers = " ",Medical,Law,"Professional Bodies","Board Member",Staff,Donor,Creditors,"Implementing Partner";
        }
    }
}
