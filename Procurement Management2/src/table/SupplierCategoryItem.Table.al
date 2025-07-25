table 53053 "Supplier Category Item"
{
    Caption = 'Supplier Category Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Category Code"; Code[50])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
        }
        field(2; "Item Type"; Enum "Procurement Purchase Line Type")
        {
            Caption = 'Item Type';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = if ("Item Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true),
                                                                "Account Type" = const(Posting),
                                                                Blocked = const(false))
            else
            if ("Item Type" = const(Item)) Item
            else
            if ("Item Type" = const("Fixed Asset")) "Fixed Asset";

            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
                GLAcc: Record "G/L Account";
                Item: Record Item;
                ItemCharge: Record "Item Charge";
                Resource: Record Resource;
            begin
                case "Item Type" of
                    "Item Type"::"G/L Account":
                        begin
                            GLAcc.Get("Item No.");
                            Description := GLAcc.Name;
                        end;
                    "Item Type"::Item:
                        begin
                            Item.Get("Item No.");
                            Description := Item.Description;
                            Item.TestField("Gen. Prod. Posting Group");
                            Item.TestField("Base Unit of Measure");
                            Item.TestField("Item G/L Budget Account");
                            "Item Category Code" := item."Item Category Code";
                        end;
                    "Item Type"::"Fixed Asset":
                        begin
                            FixedAsset.Get("Item No.");
                            FixedAsset.TestField("FA Posting Group");
                            Description := FixedAsset.Description;
                        end;
                end;
            end;
        }
        field(4; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Category Code", "Item Type", "Item No.")
        {
            Clustered = true;
        }
    }
}






