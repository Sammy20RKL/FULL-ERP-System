table 53056 "Prospective Supplier Category"
{
    Caption = 'Prospective Supplier Category';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Prospective Supplier Category";

    fields
    {
        field(1; "Supplier Code"; Code[50])
        {
            Caption = 'Supplier Code';
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
        }
        field(2; "Supplier Category"; Code[100])
        {
            Caption = 'Supplier Category';
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category"."Code";
        }
        field(3; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers".Name where("No." = field("Supplier Code")));
            Editable = false;
        }
        field(4; "Category Name"; Text[250])
        {
            Caption = 'Category Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field("Supplier Category")));
        }
    }
    keys
    {
        key(PK; "Supplier Code", "Supplier Category")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Supplier Code", "Supplier Name", "Supplier Category")
        {
        }
    }
}






