table 53030 "Supplier Evaluation SetUp"
{
    Caption = 'Supplier Evaluation Score Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Parameter';
        }
        field(2; "Evaluation Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Detailed Parameter';
        }
        field(3; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
        }
        field(4; "Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(5; Active; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Active';
        }
        field(6; "Minimum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Score';
        }
        field(7; Description; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'Description';
        }
        field(8; "Total Maximum Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Setup Line"."Maximum Score" where(Code = field(Code)));
            Caption = 'Total Maximum Score';
        }
        field(9; "Score Criteria"; Enum "Supplier Eval Score Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Score Criteria';
        }
        field(10; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Existing,Tender;
            OptionCaption = 'Existing,New';
            Caption = 'Type';
        }
        field(11; "Evaluation Criteria"; Enum "Tender Evaluation Criteria")
        {
            DataClassification = CustomerContent;
            Caption = 'Evaluation Criteria';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Evaluation Description", "Evaluation Criteria")
        {
        }
    }

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
}





