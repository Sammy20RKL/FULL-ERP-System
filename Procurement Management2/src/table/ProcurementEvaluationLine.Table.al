table 53025 "Procurement Evaluation Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Document No.';
        }
        field(2; "Vendor No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
            Caption = 'Vendor No';

            trigger OnValidate()
            begin
                if ProspectiveRec.Get("Vendor No") then
                    "Vendor Name" := ProspectiveRec.Name;

                /* if Vendor.Get("Vendor No") then
                    "Vendor Name" := Vendor.Name; */
            end;
        }
        field(3; Type; Enum "Purchase Line Type")
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
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource)) Resource;
            Caption = 'No.';
        }
        field(5; Description; Text[70])
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

            trigger OnValidate()
            begin
                if "Unit Amount" > 0 then begin
                    Amount := Quantity * "Unit Amount";
                    Validate(Amount);
                end else begin
                    Amount := 0;
                    "Amount Inclusive VAT" := 0;
                end;
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
                else begin
                    Amount := 0;
                    "Amount Inclusive VAT" := 0;
                end;
            end;
        }
        field(9; Awarded; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Awarded';

            trigger OnValidate()
            var
                SuggestEvaluationLine, AwardEvaluationLine : Record "Procurement Evaluation Line";
                SuggestCount, AwardCount : Integer;
            begin
                //Get Comment
                GetHeader();
                if Awarded then begin
                    SuggestEvaluationLine.Reset();
                    SuggestEvaluationLine.SetRange("Document No.", "Document No.");
                    SuggestEvaluationLine.SetRange(Suggested, true);
                    SuggestCount := SuggestEvaluationLine.Count();

                    AwardEvaluationLine.Reset();
                    AwardEvaluationLine.SetRange("Document No.", "Document No.");
                    AwardEvaluationLine.SetRange(Awarded, true);
                    AwardCount := AwardEvaluationLine.Count() + 1;

                    if AwardCount > SuggestCount then
                        Error('You cannot award more suppliers than suggested');

                    /* if not Suggested then begin
                        Message('You are required to insert a comment');

                        //Prompt and Insert Rejection Comment
                        AwardComment.SetTableView(QuoteHeader);
                        if AwardComment.RunModal() = Action::OK then begin
                            QuoteHeader.Modify();
                            Message('Comment Inserted Successfuly');
                        end;
                    end; */
                end;
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
        field(12; "Quote Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Generated';
        }
        field(13; "Vendor Name"; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
        field(14; Title; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
        }
        field(18; Committed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Committed';
        }
        field(19; "Quantity Received"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Received';
        }
        field(20; "Procurement Plan"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name";
            Caption = 'Procurement Plan';
        }
        field(21; "Procurement Plan Item"; Code[30])
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
                        "No." := ProcurementPlan."Source of Funds";
                    end;
                    "Budget Line" := ProcurementPlan."Source of Funds";
                    Description := ProcurementPlan."Item Description";
                end;
            end;
        }
        field(22; "Budget Line"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Budget Line';
        }
        field(23; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Date';
        }
        field(24; "Expected Receipt Date"; Date)
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
        field(25; Suggested; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested';
            Editable = false;
        }
        field(26; "Requisition No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition No';
        }
        field(27; "Committed Amount"; Decimal)
        {
            CalcFormula = sum("Commitment Entries"."Committed Amount" where("Commitment No" = field("Requisition No"),
                                                                             Account = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Committed Amount';
        }
        field(28; "Min Value"; Decimal)
        {
            CalcFormula = min("Procurement Evaluation Line".Amount where("Document No." = field("Document No."),
                                                               Type = field(Type),
                                                               "No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Min Value';
        }
        field(29; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Prod. Posting Group';
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
        field(33; "Withholding Tax Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
            Caption = 'Withholding Tax Code';
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
        field(39; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(40; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
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
        field(42; "Financial Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Score';
        }
        field(43; Specification; Blob)
        {
            Caption = 'Specification';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(44; "Total Amount Per Vendor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Amount Per Vendor';
            Editable = false;
        }
        field(45; "LPO/Contract Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'LPO/Contract Generated';
        }
        field(46; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;
            Caption = 'Location Code';
        }
        field(47; Comments; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(48; "Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Vendor No", "No.", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        TotalAmountLine: Decimal;
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLAcc: Record "G/L Account";
        ItemRec: Record Item;
        ProcurementPlan: Record "Procurement Plan Item";
        ProspectiveRec: Record "Prospective Suppliers";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        TenderHeader: Record "Procurement Evaluation Header";
        VATSetup: Record "VAT Posting Setup";
        DimMgt: Codeunit DimensionManagement;
        VATAmount: Decimal;
        Direction: Text[30];

    procedure CreateQuote(var QuoteEvaluation: Record "Procurement Evaluation Line")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        QuoteEvaluationHeader: Record "Procurement Evaluation Header";
    begin
        if QuoteEvaluation.Awarded then begin
            //Purchase Header
            PurchaseHeader.Init();
            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
            PurchaseHeader."No." := '';
            PurchaseHeader."Buy-from Vendor No." := QuoteEvaluation."Vendor No";
            PurchaseHeader.Validate(PurchaseHeader."Buy-from Vendor No.");
            PurchaseHeader."Quote No." := QuoteEvaluation."Document No.";
            PurchaseHeader."Tender/Quotation ref no" := QuoteEvaluation."Document No.";
            QuoteEvaluationHeader.Get(QuoteEvaluation."Document No.");
            PurchaseHeader.Minutes := QuoteEvaluationHeader.Minutes;
            PurchaseLine.Reset();
            PurchaseHeader.SetRange(PurchaseHeader."Quote No.", QuoteEvaluation."Document No.");
            PurchaseHeader.SetRange(PurchaseHeader."Buy-from Vendor No.", QuoteEvaluation."Vendor No");
            if not PurchaseHeader.FindFirst() then
                PurchaseHeader.Insert(true);
            //Purchase Lines
            PurchaseLine.Reset();
            PurchaseLine.SetRange(PurchaseLine."Document Type", PurchaseLine."Document Type"::Quote);
            PurchaseLine.SetRange(PurchaseLine."Document No.", PurchaseHeader."No.");
            PurchaseLine.SetRange(PurchaseLine."Line No.", QuoteEvaluation."Line No");
            PurchaseLine.SetRange(PurchaseLine."Buy-from Vendor No.", QuoteEvaluation."Vendor No");
            if not PurchaseLine.FindFirst() then begin
                PurchaseLine.Init();
                PurchaseLine."Document Type" := PurchaseLine."Document Type"::Quote;
                PurchaseLine."Document No." := PurchaseHeader."No.";
                PurchaseLine."Buy-from Vendor No." := QuoteEvaluation."Vendor No";
                PurchaseLine.Type := QuoteEvaluation.Type;
                PurchaseLine."No." := QuoteEvaluation."No.";
                PurchaseLine."Line No." := QuoteEvaluation."Line No";
                PurchaseLine.Validate(PurchaseLine."No.");
                PurchaseLine.Description := QuoteEvaluation.Description;
                PurchaseLine."Unit of Measure" := QuoteEvaluation."Unit of Measure";
                PurchaseLine.Quantity := QuoteEvaluation.Quantity;
                PurchaseLine."Direct Unit Cost" := QuoteEvaluation."Unit Amount";
                PurchaseLine.Validate(PurchaseLine."Direct Unit Cost");
                if not PurchaseLine.Get(PurchaseLine."Document Type"::Quote, PurchaseHeader."No.", QuoteEvaluation."Line No") then
                    PurchaseLine.Insert();
            end;
            Codeunit.Run(Codeunit::"Purch.-Quote to Order", PurchaseHeader);
        end;
    end;

    procedure GetHeader()
    begin
        if TenderHeader.Get("Document No.") then;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
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





