table 53031 "Procurement Plan Item"
{
    Caption = 'Procurement Plan Item';
    DataClassification = CustomerContent;
    LookupPageId = "Procurement Plan Item Lookup";

    fields
    {
        field(1; "Plan Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Plan Year';
        }
        field(2; "Plan Item No"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Plan Item No';
        }
        field(3; "Procurement Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Service,Goods,Works,"Fixed Asset","Event";
            Caption = 'Procurement Type';

            trigger OnValidate()
            begin
                if "Procurement Type" = "Procurement Type"::Service then
                    Type := Type::"G/L Account";

                if "Procurement Type" = "Procurement Type"::Goods then
                    Type := Type::Item;

                if "Procurement Type" = "Procurement Type"::Works then
                    Type := Type::"G/L Account";

                if "Procurement Type" = "Procurement Type"::"Fixed Asset" then
                    Type := Type::"Fixed Asset";

                /* if "Procurement Type" = "Procurement Type"::"Event" then
                    Type := Type::"Event"; */

            end;
        }
        field(4; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
            Caption = 'Unit of Measure';
        }
        field(5; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                "Estimated Cost" := Quantity * "Unit Price";
                Validate("Estimated Cost");
            end;
        }
        field(6; "Procurement Method"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Method";
            Caption = 'Procurement Method';
        }
        field(7; "Source of Funds"; Code[15])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            Caption = 'Source of Funds';
        }
        field(8; "Estimated Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Cost';

            trigger OnValidate()
            begin
                GLSetup.Get();
                GLSetup.TestField("Current Budget");
                GLSetup.TestField("Current Budget Start Date");
                GLSetup.TestField("Current Budget End Date");

                GLBudget.SetCurrentKey("Budget Name", "G/L Account No.", Date, "Global Dimension 1 Code");
                GLBudget.SetRange(GLBudget."Budget Name", "Plan Year");
                GLBudget.SetRange(GLBudget."G/L Account No.", "Source of Funds");
                if GLSetup."Use Dimensions For Budget" then
                    GLBudget.SetRange(GLBudget."Dimension Set ID", "Dimension Set ID");
                GLBudget.SetRange(GLBudget.Date, GLSetup."Current Budget Start Date", GLSetup."Current Budget End Date");
                GLBudget.CalcSums(Amount);
                BudgetAmount := GLBudget.Amount;
                "Approved Budget" := BudgetAmount;

                //ProcPlan.SetCurrentKey("Plan Year", "Department Code", "Source of Funds");
                ProcPlan.SetRange(ProcPlan."Plan Year", "Plan Year");
                //ProcPlan.SetRange(ProcPlan."Department Code", "Department Code");
                ProcPlan.SetRange(ProcPlan."Source of Funds", "Source of Funds");
                ProcPlan.CalcSums("Estimated Cost");
                ProcPlanAmount := ProcPlan."Estimated Cost";

                CalcVATAmount();

                /*if "Estimated Cost" > (BudgetAmount - ProcPlanAmount) then
                    Error('Overall budget amount for A/C no %1 has been exceeded by %2. Total Budgeted amount = %3', "Source of Funds",
                    ("Estimated Cost" - (BudgetAmount - ProcPlanAmount)), BudgetAmount);*/
            end;
        }
        field(9; "Item Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(12; "Process Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Direct,RFQ,RFP,Tender;
            Caption = 'Process Type';
        }
        field(13; "Approved Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved Budget';
            Editable = false;
        }
        field(14; "Plan Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Open,Approved,Rejected;
            Caption = 'Plan Status';
        }
        field(15; Type; Enum "Purchase Line Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Item Type';
        }
        field(16; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';

            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting))
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge";
            /* else
            if (type = const("Event")) "Events.Table"; */

            trigger OnValidate()
            begin
                if GLAcc.Get("No.") then begin
                    "Source of Funds" := "No.";
                    "Item Description" := GLAcc.Name;
                end;

                if ItemRec.Get("No.") then begin
                    "Item Description" := ItemRec.Description;
                    "Unit of Measure" := ItemRec."Base Unit of Measure";
                    "Unit Price" := ItemRec."Last Direct Cost";
                    //InventorySetup.GET('',ItemRec."Inventory Posting Group");
                    ItemRec.TestField("Item G/L Budget Account");
                    "Source of Funds" := ItemRec."Item G/L Budget Account";
                end;

                if FixedAsset.Get("No.") then begin
                    "Item Description" := FixedAsset.Description;
                    FixedAsset.TestField("FA Posting Group");
                    FAPostingGrp.Get(FixedAsset."FA Posting Group");
                    "Source of Funds" := FAPostingGrp."Acquisition Cost Account";
                end;
            end;
        }
        field(17; Actuals; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("Source of Funds"),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Actuals';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Commitments; Decimal)
        {
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(No = field("Source of Funds"),
                                                                             "Commitment Date" = field("Date Filter"),
                                                                             "Dimension Set ID" = field("Dimension Set ID")));
            Caption = 'Commitments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';

            trigger OnValidate()
            begin
                "Month Name" := Format(Date, 0, MonthText);
                Quarter := DateMgt.GetQuarter(Date);

                case Quarter of
                    1:
                        "Quarter Value" := "Quarter Value"::First;
                    2:
                        "Quarter Value" := "Quarter Value"::Second;
                    3:
                        "Quarter Value" := "Quarter Value"::Third;
                    4:
                        "Quarter Value" := "Quarter Value"::Fourth;
                end;
            end;
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';

            trigger OnValidate()
            begin

                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(23; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(24; "VAT Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
            Caption = 'VAT Code';

            trigger OnValidate()
            begin
                CalcVATAmount();
            end;
        }
        field(25; "Withholding Tax Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "VAT Product Posting Group";
            Caption = 'Withholding Tax Code';
        }
        field(26; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(27; "VAT Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount (LCY)';
        }
        field(28; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
            Caption = 'Currency Code';
        }
        field(29; "Total Estimated Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Estimated Cost (inc. VAT)';
        }
        field(30; "Amount To Post (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount To Post (LCY)';
        }
        field(31; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %';
        }
        field(32; "No. Series"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(33; Quarter; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Quarter';
        }
        field(34; "Quarter Value"; Enum "Quarter Value")
        {
            DataClassification = CustomerContent;
            Caption = 'Quarter Item is Needed';
        }
        field(35; "Month Name"; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
        }
        field(36; "Ordered Quantity"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Internal Request Line".Quantity
                          where("Procurement Plan Item" = field("Plan Item No"),
                          "Header Status" = filter(Fulfilled | Released)));
            Caption = 'Ordered Quantity';
        }
        field(37; Justification; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Justification';
        }
        field(38; "Remaining Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Budget';
            Editable = false;
        }
        field(39; "Delivery Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Period';
        }
        field(40; "Expenditure Type"; Option)
        {
            OptionMembers = " ","CAPEX","OPEX";
            OptionCaption = ' ,CAPEX,OPEX';
            DataClassification = CustomerContent;
            Caption = 'Expenditure Type';
        }
        field(41; "Supplier Category Code"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category"."Code";
            Caption = 'Supplier Category Code';
        }
        field(42; "Supplier Category Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field("Supplier Category Code")));
            Editable = false;
            Caption = 'Supplier Category Name';
        }
        field(43; "User ID"; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(44; "Ordered Amount"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Internal Request Line"."Amount Including VAT"
                          where("Procurement Plan Item" = field("Plan Item No"),
                          "Header Status" = filter(Fulfilled | Released)));
            Caption = 'Ordered Amount';
        }
        field(45; "User Department"; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Employee."Responsibility Center" where("User ID" = field("User ID")));
        }
    }

    keys
    {
        key(Key1; "Plan Year", "Plan Item No")
        {
            Clustered = true;
            SumIndexFields = "Estimated Cost";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Plan Item No", "Procurement Type", "Item Description")
        {
        }
    }

    trigger OnInsert()
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Procurement Plan Item Nos");
        if "Plan Item No" = '' then begin
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Procurement Plan Item Nos", xRec."No. Series", 0D, "Plan Item No", "No. Series");
        end;
    end;

    var
        CurrencyRec: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        FAPostingGrp: Record "FA Posting Group";
        FixedAsset: Record "Fixed Asset";
        GLAcc: Record "G/L Account";
        GLBudget: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        ItemRec: Record Item;
        ProcPlan: Record "Procurement Plan Item";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VATSetup: Record "VAT Posting Setup";
        DateMgt: Codeunit "Dates Management";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BudgetAmount: Decimal;
        ProcPlanAmount: Decimal;
        VATAmount: Decimal;
        MonthText: Label '<Month Text>', Locked = true;
        Direction: Text[30];

        Events: Record "Events.Table";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    local procedure CalcVATAmount()
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup.TestField("Rounding Precision");
        if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Up then
            Direction := '>'
        else
            if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Nearest then
                Direction := '='
            else
                if PurchasesPayablesSetup."Rounding Type" = PurchasesPayablesSetup."Rounding Type"::Down then
                    Direction := '<';

        if "VAT Code" <> '' then begin
            case Type of
                Type::"G/L Account":
                    begin
                        if GLAcc.Get("No.") then begin
                            //GLAcc.TESTFIELD("VAT Bus. Posting Group");
                            if VATSetup.Get(GLAcc."VAT Bus. Posting Group", "VAT Code") then begin
                                "VAT %" := VATSetup."VAT %";
                                if PurchasesPayablesSetup."Proc Plan Inclusive VAT" then begin
                                    VATAmount := Round((("Estimated Cost") / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Total Estimated Cost" := "Estimated Cost" - VATAmount;
                                end
                                else begin
                                    VATAmount := Round(((("Estimated Cost") * (1 + VATSetup."VAT %" / 100)) - "Estimated Cost"), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Total Estimated Cost" := "Estimated Cost" + VATAmount;
                                end;

                                "VAT Amount" := VATAmount;

                                //Currency
                                if "Currency Code" = '' then begin
                                    "VAT Amount (LCY)" := Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                                    "Amount To Post (LCY)" := Round("Total Estimated Cost", CurrencyRec."Amount Rounding Precision");
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
                                              "Total Estimated Cost", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
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
                                    VATAmount := Round((("Estimated Cost") / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Total Estimated Cost" := "Estimated Cost" - VATAmount;
                                end
                                else begin
                                    VATAmount := Round(((("Estimated Cost") * (1 + VATSetup."VAT %" / 100)) - "Estimated Cost"), PurchasesPayablesSetup."Rounding Precision", Direction);
                                    "Total Estimated Cost" := "Estimated Cost" + VATAmount;
                                end;

                                "VAT Amount" := VATAmount;

                                //Currency
                                if "Currency Code" = '' then begin
                                    "VAT Amount (LCY)" := Round(VATAmount, CurrencyRec."Amount Rounding Precision");
                                    "Amount To Post (LCY)" := Round("Total Estimated Cost", CurrencyRec."Amount Rounding Precision");
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
                                              "Total Estimated Cost", CurrencyExchangeRate.ExchangeRate(Today, "Currency Code")),
                                              CurrencyRec."Amount Rounding Precision");
                                    end;
                                end;
                            end;
                        end;
                    end;
            end;
        end else begin
            "VAT Amount" := 0;
            "Total Estimated Cost" := "Estimated Cost";
            "Amount To Post (LCY)" := "Estimated Cost";
        end;

        CalcFields(Actuals, Commitments);
        "Remaining Budget" := "Approved Budget" - Commitments - Actuals - "Total Estimated Cost";
    end;
}





