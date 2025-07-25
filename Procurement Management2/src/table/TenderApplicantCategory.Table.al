table 53058 "Tender Applicant Category"
{
    Caption = 'Tender Applicant Category';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[50])
        {
            Caption = 'Tender No.';
            DataClassification = CustomerContent;
        }
        field(2; "Supplier Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
            Caption = 'Supplier Code';
        }
        field(3; "Supplier Category"; Code[50])
        {
            Caption = 'Supplier Category';
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category".Code;
        }
        field(4; "Category Name"; Text[250])
        {
            Caption = 'Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field("Supplier Category")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Tender No.", "Supplier Code", "Supplier Category")
        {
            Clustered = true;
        }
    }
}






