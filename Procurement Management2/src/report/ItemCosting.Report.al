report 53009 "Item Costing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/ItemCosting.rdlc';
    Caption = 'Status';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") where("Entry Type" = const(Purchase));
            RequestFilterFields = "Item No.", "Source No.", "Document No.", "Posting Date";

            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemDescription; ItemDescription)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
            {
            }
            column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(SourceNo_ItemLedgerEntry; "Item Ledger Entry"."Source No.")
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
            {
            }
            column(LocationCode_ItemLedgerEntry; "Item Ledger Entry"."Location Code")
            {
            }
            column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
            {
            }
            column(GlobalDimension1Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_ItemLedgerEntry; "Item Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(DocumentDate_ItemLedgerEntry; "Item Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_ItemLedgerEntry; "Item Ledger Entry"."External Document No.")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompPic; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item.Reset();
                Item.SetRange("No.", "Item Ledger Entry"."Item No.");
                if Item.FindFirst() then
                    ItemDescription := Item.Description;
                Vendor.Reset();
                Vendor.SetRange("No.", "Item Ledger Entry"."Source No.");
                if Vendor.FindFirst() then
                    VendorName := Vendor.Name;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if statusdate = 0D then
                statusdate := WorkDate();
        end;
    }
    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        Vendor: Record Vendor;
        statusdate: Date;
        VendorName: Text;
        ItemDescription: Text[50];
}





