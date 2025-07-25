table 53006 "Procurement Request Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition No';

            trigger OnValidate()
            begin

                if ReqHeader.Get("Document No.") then begin
                    "Procurement Plan" := ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code" := ReqHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';

            trigger OnValidate()
            begin
                if ReqHeader.Get("Document No.") then begin
                    "Procurement Plan" := ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code" := ReqHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := ReqHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                end;
            end;
        }
        //
        field(3; Type; Enum "Procurement Purchase Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(4; No; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset";
            /*  else
             if (Type = const("Charge (Item)")) "Item Charge"
             else
             if (Type = const(Resource)) Resource; */
            Caption = 'No';

            trigger OnValidate()
            begin

            end;
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
            Caption = 'Estimated Unit Price';

            trigger OnValidate()
            begin

                Amount := Quantity * "Unit Price";
            end;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Estimated Amount';
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

                // CheckReservationDateConflict(FIELDNO("Expected Receipt Date"));
                //
                // IF "Expected Receipt Date" <> 0D THEN
                //  VALIDATE(
                //    "Planned Receipt Date",
                //    CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
                //      CalChange."Source Type"::Location,"Location Code",'',
                //      CalChange."Source Type"::Location,"Location Code",'',FALSE))
                // ELSE
                //  VALIDATE("Planned Receipt Date","Expected Receipt Date");
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
            Subtype = Memo;
        }
        field(28; "FA Disposal Doc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Disposal Doc No.';
        }
        field(29; "Bid Submitted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bid Submitted';
        }
        field(30; "Staff No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Staff No.';
        }
        field(31; "Staff Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Staff Name';
        }
        field(32; "Suggested"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested';
        }
        field(33; "Awarded"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Awarded';
        }
        field(34; "Sales Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Order Created';
        }
        field(35; "Comments"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(36; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;
            Caption = 'Location Code';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No")
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
        ReqHeader: Record "Internal Request Header";
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





