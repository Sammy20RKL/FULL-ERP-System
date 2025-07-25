table 65031 "Sent EmailLog"
{

    fields
    {
        field(1; "No."; Code[20])
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
        field(4; "Created BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Process Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Project,Action Step,Performance Contracting';
            OptionMembers = " ",Project,"Action Step","Performance Contracting";
        }
        field(7; "Sent From"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sent To"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Subject; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Salutation; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Body; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Body2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Body3; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Body4; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Body5; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Copy To"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Send From"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; Sent; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if not Sent then begin
                    Clear("Date Sent");
                    Clear("Time Sent");
                    Clear("Sent BY");
                end else begin
                    "Date Sent" := Today;
                    "Time Sent" := Time;
                    "Sent BY" := UserId;
                end;
            end;
        }
        field(23; "Date Sent"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Time Sent"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Sent BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Attempt; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Document Date", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

