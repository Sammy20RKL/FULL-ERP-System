tableextension 53000 "PurchasesPayablesExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(53000; "Effective Procurement Plan"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan".Name;
            Caption = 'Effective Procurement Plan';
        }
        field(53001; "RFQ Path"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'RFQ Path';
        }
        field(53002; "RFQ Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'RFQ Nos.';
        }
        field(53003; "RFP Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'RFP Nos.';
        }
        field(53004; "Tender Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Tender Nos.';
        }
        field(53005; "Store Req. Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Store Req. Nos.';
        }
        field(53006; "Purchase Req. Nos"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Purchase Req. Nos';
        }
        field(53007; "Committe Nos"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Committe Nos';
        }
        field(53008; "Update Cost From Item Card"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Update Cost From Item Card';
        }
        field(53009; "Store Return Order Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Store Return Order Nos.';
        }
        field(53010; "EOI Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'EOI Nos';
        }
        field(53011; "Supplier Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Supplier Nos';
        }
        field(53012; "Supplier Evaluation Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Supplier Evaluation Nos';
        }
        field(53013; "Vendor Evaluation Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Vendor Evaluation Nos';
        }
        field(53014; "Quotation Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Quotation Nos';
        }
        field(53015; "Max Open Documents"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Max Open Documents';
        }
        field(53016; "Store Transfer Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Store Transfer Nos';
        }
        field(53017; "Item Transfer Journal Template"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template".Name;
            Caption = 'Item Transfer Journal Template';
        }
        field(53018; "Item Transfer Journal Batch"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Item Transfer Journal Template"));
            Caption = 'Item Transfer Journal Batch';
        }
        field(53019; "Rounding Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up,Nearest,Down;
            Caption = 'Rounding Type';
        }
        field(53020; "Rounding Precision"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rounding Precision';
        }
        field(53021; "Proc Plan Inclusive VAT"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Proc Plan Inclusive VAT';
        }
        field(53022; "Prospective Suppliers Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Prospective Suppliers Nos';
        }
        field(53023; "Supplier Category Nos"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'Supplier Category Nos';
        }
        field(53024; "Procurement Documents Path"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement Documents Path';
        }
        field(53025; "Default Vendor Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Posting Group";
            Caption = 'Default Vendor Posting Group';
        }
        field(53026; "Def Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(53027; "Def VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }
        field(53028; "Procurement Plan Item Nos"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Procurement Plan Item Nos';
        }
        field(53029; "FA Disposal Quote Nos"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'FA Disposal Quote Nos';
        }
        field(53030; "Project Mgt Nos"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Project Mgt Nos';
        }
        field(53031; "Event Nos"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Event Nos';
        }
        field(53032; "Procurement E-Mail"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement E-Mail';
        }
        field(53033; "Procurement Contract Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(53034; "Use Dimensions in Requisitions"; Boolean)
        {
            Caption = 'Use Dimensions in Requisitions';
            DataClassification = SystemMetadata;
        }
    }
}





