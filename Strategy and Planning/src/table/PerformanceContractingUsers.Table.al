table 65013 "Performance Contracting Users"
{
    LookupPageId = "Performance Contracting Users";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Resource; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where(Status = filter(Active));

            trigger OnValidate()
            begin
                Clear(Name);
                if EmpRecs.Get(Resource) then
                    Name := EmpRecs."First Name" + ' ' + EmpRecs."Middle Name" + ' ' + EmpRecs."Last Name";
            end;
        }
        field(4; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Responsibility; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Member,Secretary,Chairman';
            OptionMembers = " ",Member,Secretary,Chairman;
        }
    }

    keys
    {
        key(Key1; "Document No.", Resource)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Resource, Name, Responsibility)
        {
        }
    }

    var
        EmpRecs: Record Employee;
}

