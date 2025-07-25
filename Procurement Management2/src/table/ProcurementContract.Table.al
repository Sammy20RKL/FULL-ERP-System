table 53052 "Procurement Contract"
{
    Caption = 'Procurement Contract';
    DataClassification = CustomerContent;
    LookupPageId = "Procurement Contract";

    fields
    {
        field(1; "Contract No."; Code[50])
        {
            Caption = 'Contract No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Contract No." <> xRec."Contract No." then begin
                    PurchasesPayablesSetup.Get();
                    NoSeries.TestManual(PurchasesPayablesSetup."Procurement Contract Nos.");
                end;

                "No. Series" := ''
            end;
        }
        field(2; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Editable = false;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Duration"; DateFormula)
        {
            Caption = 'Duration';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Expiry Date" := CalcDate(Duration, "Start Date");
            end;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Expiry Date" := CalcDate(Duration, "Start Date");
            end;
        }
        field(6; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Total Contract Amount"; Decimal)
        {
            Caption = 'Total Contract Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Procurement Evaluation Line"."Amount Inclusive VAT" where("Document No." = field("Tender/Quote No."), Awarded = const(true), "Vendor No" = field("Prospective Supplier No.")));
            Editable = false;
        }
        field(8; "LPO No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'LPO No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
        }
        field(9; "Vendor No."; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Contract Details"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(12; "Contract Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = New,Active,Terminated;
            Editable = false;
        }
        field(13; "Contract Ref No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Tender/Quote No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Prospective Supplier No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
            Editable = false;
        }
        field(17; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Service Required?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Proposed Action"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(21; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(22; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
    }

    keys
    {
        key(PK; "Contract No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract No.", "Vendor Name", "Total Contract Amount")
        {

        }
    }
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if "Contract No." = '' then begin
            PurchasesPayablesSetup.Get();
            NoSeries.InitSeries(PurchasesPayablesSetup."Procurement Contract Nos.", xRec."No. Series", 0D, "Contract No.", "No. Series");
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}






