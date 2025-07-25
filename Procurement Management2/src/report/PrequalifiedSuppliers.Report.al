report 53033 "Prequalified Suppliers"
{
    ApplicationArea = All;
    Caption = 'Prequalified Suppliers';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PrequalifiedSuppliers.rdl';
    dataset
    {
        dataitem("Prospective Supplier Category"; "Prospective Supplier Category")
        {
            RequestFilterFields = "Supplier Category";
            column(SupplierCode_ProspectiveSupplierCategory; "Supplier Code")
            {
            }
            column(SupplierName_ProspectiveSupplierCategory; "Supplier Name")
            {
            }
            column(CategoryName_ProspectiveSupplierCategory; "Category Name")
            {
            }
            column(SupplierCategory_ProspectiveSupplierCategory; "Supplier Category")
            {
            }

            dataitem(ProspectiveSuppliers; "Prospective Suppliers")
            {
                DataItemLink = "No." = field("Supplier Code");
                DataItemTableView = sorting("No.") where("Pre Qualified" = const(true));
                column(No; "No.")
                {
                }
                column(Name; Name)
                {
                }
                column(Email; "E-mail")
                {
                }
                column(CountryRegionCode; "Country/Region Code")
                {
                }
                column(PhysicalAddress; "Physical Address")
                {
                }
                column(PostalAddress; "Postal Address")
                {
                }
                column(PostCode; "Post Code")
                {
                }
                column(Category; Category)
                {
                }
                column(CategoryName; "Category Name")
                {
                }
                column(VendorNo; "Vendor No")
                {
                }
                column(City; City)
                {
                }
                column(Company_Name; CompanyInfo.Name)
                {
                }
                column(CompanyAddress; CompanyInfo.Address)
                {
                }
                column(CompanyCity; CompanyInfo.City)
                {
                }
                column(Phone_No; CompanyInfo."Phone No.")
                {
                }
                column(CompanyLogo; CompanyInfo.Picture)
                {
                }
                column(CompanyEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyWebsite; CompanyInfo."Home Page")
                {
                }
                column(CompanyCountry; CompanyInfo."Country/Region Code")
                {
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}






