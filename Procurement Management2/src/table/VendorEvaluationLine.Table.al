table 53038 "Vendor Evaluation Line"
{
    Caption = 'Vendor Evaluation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Evaluation Type"; Text[70])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Evaluation SetUp";
            Caption = 'Evaluation Type';
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
            TableRelation = Vendor;
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
            CalcFormula = sum("Vendor Evaluation Line".Score);
            Caption = 'Total Score';
        }
        field(13; "Evaluation Line"; Text[70])
        {
            Caption = 'Evaluation Category';
            DataClassification = CustomerContent;
            TableRelation = "Vendor Evaluation Setup Line".Code where(HeaderCode = field("Evaluation Type"));

            trigger OnValidate()
            begin
                if EvalSetupLines.Get("Evaluation Line") then begin
                    "Line Description" := EvalSetupLines.Description;
                    "Eval Lines Maximum score" := EvalSetupLines."Maximum Score";
                end;
            end;
        }
        field(14; "Line Description"; Blob)
        {
            Caption = 'Evaluation category Description';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(15; "Eval Lines Maximum score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Eval Lines Maximum score';
        }
    }

    keys
    {
        key(PK; No, Supplier, "Evaluation Type", "Evaluation Line", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        EvalSetupLines: Record "Vendor Evaluation Setup Line";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}





