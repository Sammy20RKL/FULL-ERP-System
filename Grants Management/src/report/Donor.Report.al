report 60005 Donor
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/Donor.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Customer Posting Group" = filter('DONOR'));
            RequestFilterFields = "No.";
            column(Donor_Code; Customer."No.")
            {
            }
            column(Donor_Name; Customer.Name)
            {
            }
            column(Address; Customer.Address)
            {
            }
            column(Telephone_No; Customer."Phone No.")
            {
            }
            column(Email; Customer."E-Mail")
            {
            }
            column(Contact_Person; Customer.Contact)
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

