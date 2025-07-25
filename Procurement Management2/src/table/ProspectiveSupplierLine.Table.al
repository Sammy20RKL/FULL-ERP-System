table 53016 "Prospective Supplier Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Response No"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Response No';

            trigger OnValidate()
            begin
            end;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';

            trigger OnValidate()
            begin
            end;
        }
        field(3; Type; Enum "Purchase Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(4; No; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item;
            Caption = 'No';
        }
        field(5; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(7; "Unit of Measure"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure';
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin

                Amount := Quantity * "Unit Price";
            end;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
        field(10; "Procurement Plan"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
            Caption = 'Procurement Plan';
        }
        field(11; "Procurement Plan Item"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item"."Plan Item No" where("Plan Year" = field("Procurement Plan"),
                                                                     "Shortcut Dimension 1 Code" = field("Shortcut Dimension 1 Code"));
            Caption = 'Procurement Plan Item';

            trigger OnValidate()
            begin
                if ProcurementPlan.Get("Procurement Plan", "Shortcut Dimension 1 Code", "Procurement Plan Item") then begin
                    if ProcurementPlan."Procurement Type" = ProcurementPlan."Procurement Type"::Goods then begin
                        Type := Type::Item;
                    end;
                    if ProcurementPlan."Procurement Type" <> ProcurementPlan."Procurement Type"::Goods then begin
                        Type := Type::"G/L Account";
                        No := ProcurementPlan."Source of Funds";
                    end;
                    "Budget Line" := ProcurementPlan."Source of Funds";
                    Description := ProcurementPlan."Item Description";
                end;
            end;
        }
        field(12; "Budget Line"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Budget Line';
        }
        field(13; "Amount LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount LCY';
        }
        field(14; Select; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Select';
        }
        field(15; "Request Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Generated';
        }
        field(16; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(17; "Expected Receipt Date"; Date)
        {
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

            end;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(20; Committed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Committed';
        }
        field(21; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(22; Specifications; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Specifications';
        }
        field(23; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";
        }
        field(24; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Prod. Posting Group';
        }
        field(25; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(26; "Amount Inclusive VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Inclusive VAT';
        }
        field(27; Specification; Blob)
        {
            Caption = 'Specification';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Response No", "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Expected Receipt Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ProcurementPlan: Record "Procurement Plan Item";
        DimMgt: Codeunit DimensionManagement;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





