table 53059 "Tender Committee Category"
{
    Caption = 'Tender Committee Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Appointment No."; Code[50])
        {
            Caption = 'Appointment No.';
            DataClassification = CustomerContent;
        }
        field(2; "Supplier Category"; Code[50])
        {
            Caption = 'Supplier Category';
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category".Code;

            trigger OnValidate()
            var
                SupplierCategoryExistsErr: Label 'Supplier Category %1 already exists in Committee Appointment No. %2';
            begin
                TenderCommittees.Get("Appointment No.");
                TenderCommittees.TestField("Tender/Quotation No");

                TenderCommitteeCategories.Reset();
                TenderCommitteeCategories.SetRange("Tender No.", "Tender No.");
                TenderCommitteeCategories.SetRange("Supplier Category", "Supplier Category");
                if TenderCommitteeCategories.FindFirst() then
                    Error(SupplierCategoryExistsErr, "Supplier Category", TenderCommitteeCategories."Appointment No.");
            end;
        }
        field(3; "Category Name"; Text[250])
        {
            Caption = 'Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field("Supplier Category")));
            Editable = false;
        }
        field(4; "Tender No."; Code[50])
        {
            Caption = 'Tender No.';
            FieldClass = Normal;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Appointment No.", "Tender No.", "Supplier Category")
        {
            Clustered = true;
        }
    }

    var
        TenderCommittees: Record "Tender Committees";
        TenderCommitteeCategories: Record "Tender Committee Category";
}






