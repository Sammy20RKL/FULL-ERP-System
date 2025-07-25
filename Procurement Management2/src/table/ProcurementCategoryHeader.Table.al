table 53013 "Procurement Category Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Fiscal Year"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
            Caption = 'Fiscal Year';
        }
        field(2; Category; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Category';

            trigger OnValidate()
            begin
                if CategoryRec.Get(Category) then begin
                    "Category Name" := CategoryRec.Description;
                end;
            end;
        }
        field(3; "Category Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Name';
        }
    }

    keys
    {
        key(Key1; "Fiscal Year", Category)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CategoryRec: Record "Supplier Category";
}





