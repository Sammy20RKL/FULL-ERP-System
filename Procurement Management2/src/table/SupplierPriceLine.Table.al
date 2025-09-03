table 53055 "Supplier Price Line"
{
    DataClassification = CustomerContent;
    Caption = 'Supplier Price Line';
    DrillDownPageId = "Supplier Price Line Drilldown";

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Quote No';
        }
        field(2; "Vendor No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No';
        }
        field(3; Type; Enum "Procurement Purchase Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
        }
        field(4; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset";
            /* else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource)) Resource;
            Caption = 'No.'; */
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

            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Amount";
            end;
        }
        field(7; "Unit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quoted Unit Amount';
            DecimalPlaces = 5;
<<<<<<< HEAD
=======

>>>>>>> caf513357bef7b7907c57a396e6ed21bb005adbb
            trigger OnValidate()
            begin
                if "Unit Amount" < 0 then
                    Error('Amount can not be less than 0');

                if "Unit Amount" > 0 then
                    Amount := Quantity * "Unit Amount";

                Validate(Amount);
            end;
        }
        field(8; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';

            trigger OnValidate()
            begin

                if Amount <> 0 then
                    CalcVATAmount()
                else
                    Amount := 0;
            end;
        }
        field(10; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
        }
        field(11; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(13; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers".Name where("No." = field("Vendor No")));
            Editable = false;
        }
        field(27; Specification; Blob)
        {
            Caption = 'Specification';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(30; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(31; "Amount Inclusive VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Inclusive VAT';
        }
        field(32; "VAT Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
            Caption = 'VAT Code';

            trigger OnValidate()
            begin
                CalcVATAmount();
            end;
        }
        field(34; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(35; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
            Caption = 'Currency Code';
        }
        field(36; "VAT Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount (LCY)';
        }
        field(37; "Amount To Post"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount To Post';
        }
        field(38; "Amount To Post (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount To Post (LCY)';
        }
        field(41; "Negotiated Unit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Negotiated Unit Amount';

            trigger OnValidate()
            begin
                if "Negotiated Unit Amount" <> 0 then begin
                    Amount := "Negotiated Unit Amount" * Quantity;
                    Validate(Amount);
                end;
            end;
        }
        field(42; Comments; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
    }

    keys
    {
        key(Key1; "Quote No", "Vendor No", Type, "No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLAcc: Record "G/L Account";
        ItemRec: Record Item;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        TenderHeader: Record "Procurement Evaluation Header";
        VATSetup: Record "VAT Posting Setup";
        VATAmount: Decimal;
        Direction: Text[30];

    procedure GetHeader()
    begin
        if TenderHeader.Get("Quote No") then;
    end;

    local procedure CalcVATAmount()
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Rounding Precision");
        case PurchasesPayablesSetup."Rounding Type" of
            PurchasesPayablesSetup."Rounding Type"::Up:
                Direction := '>';
            PurchasesPayablesSetup."Rounding Type"::Nearest:
                Direction := '=';
            PurchasesPayablesSetup."Rounding Type"::Down:
                Direction := '<';
        end;

        if "VAT Code" <> '' then begin
            case Type of
                Type::"G/L Account":
                    begin
                        if GLAcc.Get("No.") then begin
                            //GLAcc.TESTFIELD("VAT Bus. Posting Group");
                            if VATSetup.Get(GLAcc."VAT Bus. Posting Group", "VAT Code") then begin
                                "VAT %" := VATSetup."VAT %";
                                if PurchasesPayablesSetup."Proc Plan Inclusive VAT" then begin
                                    VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Amount To Post" := Amount - VATAmount;
                                end
                                else begin
                                    VATAmount := Round((((Amount) * (1 + VATSetup."VAT %" / 100)) - Amount), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Amount To Post" := Amount + VATAmount;
                                    "Amount Inclusive VAT" := Amount + VATAmount;
                                end;

                                "VAT Amount" := VATAmount;

                                //Currency
                                if "Currency Code" = '' then begin
                                    "VAT Amount (LCY)" := Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                                    "Amount To Post (LCY)" := Round("Amount To Post", CurrencyRec."Amount Rounding Precision");
                                end
                                else begin
                                    if CurrencyRec.Get("Currency Code") then begin
                                        "VAT Amount (LCY)" := Round(
                                            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                              Today, "Currency Code",
                                              VATAmount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                                              CurrencyRec."Amount Rounding Precision");

                                        "Amount To Post (LCY)" := Round(
                                            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                              Today, "Currency Code",
                                              "Amount To Post", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                                              CurrencyRec."Amount Rounding Precision");
                                    end;
                                end;
                            end;
                        end;
                    end;
                Type::Item:
                    begin
                        begin
                            //ItemRec.TESTFIELD("VAT Bus. Posting Gr. (Price)");
                            if VATSetup.Get(ItemRec."VAT Bus. Posting Gr. (Price)", "VAT Code") then begin
                                "VAT %" := VATSetup."VAT %";
                                if PurchasesPayablesSetup."Proc Plan Inclusive VAT" then begin
                                    VATAmount := Round(((Amount) / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Amount To Post" := Amount - VATAmount;
                                end
                                else begin
                                    VATAmount := Round((((Amount) * (1 + VATSetup."VAT %" / 100)) - Amount), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Amount To Post" := Amount + VATAmount;
                                end;

                                "VAT Amount" := VATAmount;

                                //Currency
                                if "Currency Code" = '' then begin
                                    "VAT Amount (LCY)" := Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                                    "Amount To Post (LCY)" := Round("Amount To Post", CurrencyRec."Amount Rounding Precision");
                                end
                                else begin
                                    if CurrencyRec.Get("Currency Code") then begin
                                        "VAT Amount (LCY)" := Round(
                                            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                              Today, "Currency Code",
                                              VATAmount, CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                                              CurrencyRec."Amount Rounding Precision");

                                        "Amount To Post (LCY)" := Round(
                                            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                                              Today, "Currency Code",
                                              "Amount To Post", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                                              CurrencyRec."Amount Rounding Precision");
                                    end;
                                end;
                            end;
                        end;
                    end;
            end;
        end else begin
            "Amount To Post" := Amount;
            "Amount To Post (LCY)" := Amount;
            "Amount Inclusive VAT" := Amount;
        end;
    end;
}





