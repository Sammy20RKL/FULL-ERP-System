pageextension 53001 "PurchasesAndPayablesExt" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Rounding Type"; Rec."Rounding Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rounding Type field';
            }
            field("Rounding Precision"; Rec."Rounding Precision")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rounding Precision field';
            }
            field("Effective Procurement Plan"; Rec."Effective Procurement Plan")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Effective Procurement Plan field';
            }
            field("Max Open Documents"; Rec."Max Open Documents")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Max Open Documents field';
            }
            field("Procurement Documents Path"; Rec."Procurement Documents Path")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Procurement Documents Path field';
            }
            field("Default Vendor Posting Group"; Rec."Default Vendor Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default Vendor Posting Group field';
            }
            field("Def Gen. Bus. Posting Group"; Rec."Def Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field';
            }
            field("Def VAT Bus. Posting Group"; Rec."Def VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
            }
            field("Proc Plan Inclusive VAT"; Rec."Proc Plan Inclusive VAT")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Proc Plan Inclusive VAT field';
            }
            field("Item Transfer Journal Template"; Rec."Item Transfer Journal Template")
            {
                ToolTip = 'Specifies the value of the Item Transfer Journal Template field.';
                ApplicationArea = All;
            }
            field("Item Transfer Journal Batch"; Rec."Item Transfer Journal Batch")
            {
                ToolTip = 'Specifies the value of the Item Transfer Journal Batch field.';
                ApplicationArea = All;
            }
            field("Procurement E-Mail"; Rec."Procurement E-Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Procurement E-Mail field.';
            }
            field("Use Dimensions in Requisitions"; Rec."Use Dimensions in Requisitions")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use Dimensions in Requisitions field.';
            }
        }
        addlast("Number Series")
        {
            field("Purchase Req. Nos"; Rec."Purchase Req. Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Req. Nos field';
            }
            field("Store Req. Nos."; Rec."Store Req. Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Store Req. Nos. field';
            }
            field("Store Transfer Nos"; Rec."Store Transfer Nos")
            {
                ToolTip = 'Specifies the value of the Store Transfer Nos field.';
                ApplicationArea = All;
            }
            field("Quotation Nos"; Rec."Quotation Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quotation Nos field';
            }
            field("RFQ Nos."; Rec."RFQ Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RFQ Nos. field';
            }
            field("RFP Nos."; Rec."RFP Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RFP Nos. field';
            }
            field("RFQ Path"; Rec."RFQ Path")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RFQ Path field';
            }
            field("EOI Nos"; Rec."EOI Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EOI Nos field';
            }
            field("Tender Nos."; Rec."Tender Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Tender Nos. field';
            }
            field("Supplier Nos"; Rec."Supplier Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Nos field';
            }
            field("Supplier Evaluation Nos"; Rec."Supplier Evaluation Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Evaluation Nos field';
            }
            field("Vendor Evaluation Nos"; Rec."Vendor Evaluation Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Evaluation Nos field';
            }
            field("Prospective Suppliers Nos"; Rec."Prospective Suppliers Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prospective Suppliers Nos field';
            }
            field("Committe Nos"; Rec."Committe Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Committe Nos field';
            }
            field("Supplier Category Nos"; Rec."Supplier Category Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Supplier Category Nos field';
            }
            field("Procurement Plan Item Nos"; Rec."Procurement Plan Item Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Procurement Plan Item Nos field';
            }
            field("FA Disposal Quote Nos"; Rec."FA Disposal Quote Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Disposal Quote Nos field';
            }
            field("Project Mgt Nos"; Rec."Project Mgt Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Mgt Nos field';
            }

            field("Event Nos"; Rec."Event Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Project Mgt Nos field';
            }
            field("Procurement Contract Nos."; Rec."Procurement Contract Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Procurement Contract Nos. field.';
            }
        }
    }
}





