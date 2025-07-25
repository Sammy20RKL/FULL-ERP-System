table 53003 "Supplier Category"
{
    DataClassification = CustomerContent;
    //DrillDownPageId = "Supplier Category";
    fields
    {
        field(1; "Code"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

            trigger OnValidate()
            begin
                if "Code" <> xRec."Code" then begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Supplier Category Nos");
                    NoSeries.TestManual(PurchSetup."Supplier Category Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Vendor Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Posting Group";
            Caption = 'Vendor Posting Group';
        }
        field(4; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                /*if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                  if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
                    Validate("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");*/

            end;
        }
        field(5; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "VAT Business Posting Group";
        }
        field(6; "No. Prequalified"; Integer)
        {
            CalcFormula = count("Prospective Supplier Category" where("Supplier Category" = field("Code"))); //count("Prospective Suppliers" where(Category = field("Code")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. Prequalified Suppliers';
        }
        field(7; "Year Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Year Filter';
        }
        field(8; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Supplier,LPO;
            Caption = 'Type';
        }
        field(9; "No. Series"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(10; "Category Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category Code Setup".Code;
        }
        field(11; "Category Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category Code Setup".Description where(Code = field("Category Code")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /* if "Code" = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Supplier Category Nos");
            NoSeries.InitSeries(PurchSetup."Supplier Category Nos", xRec."No. Series", 0D, "Code", "No. Series");
        end; */
    end;

    trigger OnDelete()
    begin
        CategoryItems.SetRange("Category Code", "Code");
        CategoryItems.DeleteAll();
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        CategoryItems: Record "Supplier Category Item";
        NoSeries: Codeunit NoSeriesManagement;
}





