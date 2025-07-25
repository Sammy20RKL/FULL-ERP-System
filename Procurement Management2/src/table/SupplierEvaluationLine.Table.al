table 53029 "Supplier Evaluation Line"
{
    Caption = 'Supplier Evaluation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            Caption = 'Tender No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Procurement Request";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Evaluation Type"; Text[70])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Evaluation SetUp" where(Type = const(Tender));
            Caption = 'Evaluation Type';

            trigger OnValidate()
            begin
                if EvalSetup.Get("Evaluation Type") then begin
                    "Evaluation Description" := EvalSetup."Evaluation Description";
                    "Max Score" := EvalSetup."Maximum Score";
                end;
            end;
        }
        field(4; "Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(5; "Pass"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pass';
        }
        field(6; "Comments"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(7; "Supplier"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
            Caption = 'Supplier';
        }
        field(8; "Supplier Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(9; "Evaluation Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Evaluation Description';
        }
        field(10; "Max Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max Score';
        }
        field(11; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender No.';
        }
        field(12; "Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score".Score where("Document No." = field("Quote No"), "Supplier Code" = field(Supplier)));
            Caption = 'Total Score';
        }
    }

    keys
    {
        key(PK; "Quote No", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        EvalSetup: Record "Supplier Evaluation SetUp";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}





