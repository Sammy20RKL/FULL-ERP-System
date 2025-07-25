table 60004 "Transaction Types"
{

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; "Transaction Name"; Text[70])
        {
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" else if ("Account Type" = const(Customer)) Customer else if ("Account Type" = const(Vendor)) Vendor else if ("Account Type" = const("Fixed Asset")) "Fixed Asset" else if ("Account Type" = const("Bank Account")) "Bank Account";
        }
        field(5; "Warm Clothing Allowance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Subsistence; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Other; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Restricted Days"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Default Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Per Diem"; Boolean)
        {
            DataClassification = ToBeClassified;
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
        fieldgroup(DropDown; "Code", "Transaction Name")
        {
        }
    }
}

