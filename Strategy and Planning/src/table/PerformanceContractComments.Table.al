table 65014 "Performance Contract Comments"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Created BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Documet Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Row No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Resource; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where(Status = const(Active));
        }
        field(10; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Resource, "Document Date", "Created BY", Resource, Remarks)
        {
        }
    }
}

