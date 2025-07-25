table 53007 "Procurement Committees"
{
    LookupPageId = "Procurement Committees";
    DrillDownPageId = "Procurement Committees";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Members; Integer)
        {
            CalcFormula = count("Committee Member" where(Commitee = field(Code)));
            FieldClass = FlowField;
            Editable = false;
            Caption = 'Members';
        }
        field(4; Permanent; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Permanent';
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
}





