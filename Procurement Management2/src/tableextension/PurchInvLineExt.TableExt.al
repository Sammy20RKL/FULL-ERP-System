tableextension 53008 "PurchInvLineExt" extends "Purch. Inv. Line"
{
    fields
    {
        field(53000; Supplier; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            Caption = 'Supplier';

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get(Supplier) then
                    "Supplier Name" := Vend.Name;
            end;
        }
        field(53001; "Supplier Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(53002; Encumbered; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Encumbered';
        }
        field(53003; Committment; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Committment';
        }
        field(53005; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition No.';
        }
        field(53006; "Procurement Plan"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
            Caption = 'Procurement Plan';
        }
        field(53007; "Procurement Plan Item"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item"."Plan Item No" where("Plan Year" = field("Procurement Plan"),
                                                                     "Shortcut Dimension 1 Code" = field("Shortcut Dimension 1 Code"),
                                                                     "Shortcut Dimension 2 Code" = field("Shortcut Dimension 2 Code"));
            Caption = 'Procurement Plan Item';
        }
        field(53004; Specification; Blob)
        {
            Caption = 'Specifications';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
    }
}





