table 53018 "FA Disposal"
{
    Caption = 'FA Disposal';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    CashMgt.Get();
                    CashMgt.TestField("FA Disposal Nos");
                    NoSeriesMgt.TestManual(CashMgt."FA Disposal Nos");
                end;
            end;
        }
        field(2; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(3; "Date-Time Created"; DateTime)
        {
            Caption = 'Date-Time Created';
            DataClassification = CustomerContent;
        }
        field(4; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(5; Status; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(6; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(7; "Staff No."; Code[50])
        {
            Caption = 'Staff No.';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Staff No.") then
                    "Staff Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(8; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
        field(9; "Fullfilled"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fullfilled';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Comments)
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            CashMgt.Get();
            CashMgt.TestField("FA Disposal Nos");
            NoSeriesMgt.InitSeries(CashMgt."FA Disposal Nos", xRec."No. Series", 0D, "No.", "No. Series")
        end;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Employee No.");
            "Staff No." := UserSetup."Employee No.";
            if Emp.Get("Staff No.") then
                "Staff Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
        end else
            Error('Please set up user in User Setup');

        "Date-Time Created" := CurrentDateTime;
        "Created By" := UserId;
    end;

    var
        CashMgt: Record "Cash Management Setups";
        Emp: Record Employee;
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





