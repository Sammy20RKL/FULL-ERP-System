report 53000 "Update Prospective Suppliers"
{
    Caption = 'Update Prospective Suppliers';
    UsageCategory = None;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Vendor Posting Group" = const('CREDITORS'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                ProspectiveSuppliers.SetRange("Vendor No", "No.");
                if ProspectiveSuppliers.FindFirst() then
                    CurrReport.Skip();

                ProspectiveSuppliers.Init();
                ProspectiveSuppliers."No." := '';
                ProspectiveSuppliers.Name := UpperCase(Vendor.Name);
                ProspectiveSuppliers."Physical Address" := Vendor."Address 2";
                ProspectiveSuppliers."Postal Address" := Vendor.Address;
                ProspectiveSuppliers.City := Vendor.City;
                ProspectiveSuppliers."E-mail" := Vendor."E-Mail";
                ProspectiveSuppliers."Telephone No" := Vendor."Phone No.";
                ProspectiveSuppliers."Mobile No" := CopyStr(Vendor."Mobile Phone No.", 1, 15);
                ProspectiveSuppliers."Pre Qualified" := false;
                ProspectiveSuppliers."Registration No" := Vendor."VAT Registration No.";
                ProspectiveSuppliers."Company PIN No." := Vendor."KRA PIN";
                ProspectiveSuppliers."Vendor No" := Vendor."No.";
                ProspectiveSuppliers."Country/Region Code" := Vendor."Country/Region Code";
                ProspectiveSuppliers."Fax No" := Vendor."Fax No.";
                ProspectiveSuppliers."Post Code" := Vendor."Post Code";
                ProspectiveSuppliers.County := Vendor.County;
                ProspectiveSuppliers."Contact E-Mail Address" := Vendor."E-Mail";
                ProspectiveSuppliers."Currency Code" := Vendor."Currency Code";
                ProspectiveSuppliers."Supplier Status" := ProspectiveSuppliers."Supplier Status"::Created;
                if ProspectiveSuppliers.Insert(true) then
                    Counter += 1;
            end;

            trigger OnPostDataItem()
            begin

            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('%1 Vendors updated successfully', Counter);
    end;

    var
        ProspectiveSuppliers: Record "Prospective Suppliers";
        Counter: Integer;
}
