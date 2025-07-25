table 65015 "Performance Resource"
{
    DrillDownPageId = "Performance Resource";
    LookupPageId = "Performance Resource";

    fields
    {
        field(1; "Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Contracting Dept.";
        }
        field(5; Resource; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Performance Contracting Users".Resource where("Document No." = field(Department));

            trigger OnValidate()
            begin
                Clear(Name);
                if EmpRecs.Get(Resource) then
                    Name := EmpRecs.FullName();
                EmpRecs.TESTFIELD("User ID");
                "User ID" := EmpRecs."User ID";
            end;
        }
        field(6; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Responsibility; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Member,Secretary,Chairman';
            OptionMembers = " ",Member,Secretary,Chairman;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.", Department, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpRecs: Record Employee;
}

