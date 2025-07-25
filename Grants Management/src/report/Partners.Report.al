report 60006 Partners
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/Partners.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Vendor Type-Grants" = filter("Implementing Partner"));
            RequestFilterFields = "No.";
            column(Partner_Code; Vendor."No.")
            {
            }
            column(Partner_Name; Vendor.Name)
            {
            }
            column(Address; Vendor.Address)
            {
            }
            column(Telephone_No; Vendor."Phone No.")
            {
            }
            column(Email; Vendor."E-Mail")
            {
            }
            column(Contact_Person; Vendor.Contact)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

