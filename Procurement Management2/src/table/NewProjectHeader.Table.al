table 50014 "New Project Header"
{
   DrillDownPageID = "Projects List";
    LookupPageID = "Projects List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Project Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Project Name';
        }
        field(3; "Project Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Project Date';
        }
        field(4; "Estimated Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Start Date';

            trigger OnValidate()
            begin
                if "Estimated End Date" > 0D then
                    "Estimated Duration" := "Estimated End Date" - "Estimated Start Date";
            end;
        }
        field(5; "Estimated End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated End Date';

            trigger OnValidate()
            begin
                TestField("Estimated Start Date");
                if "Estimated End Date" < "Estimated Start Date" then
                    Error(DateError);
                "Estimated Duration" := CreateDateTime("Estimated End Date", 0T) - CreateDateTime("Estimated Start Date", 0T);
            end;
        }
        field(6; "Estimated Duration"; Duration)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Duration';
        }
        field(7; "Actual Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Start Date';

            trigger OnValidate()
            begin
                if "Actual End Date" > 0D then
                    "Actual Duration" := CreateDateTime("Actual End Date", 0T) - CreateDateTime("Actual Start Date", 0T);
            end;
        }
        field(8; "Actual End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual End Date';

            trigger OnValidate()
            begin
                TestField("Actual Start Date");
                if "Actual End Date" < "Actual Start Date" then
                    Error(DateError);
                "Actual Duration" := CreateDateTime("Actual End Date", 0T) - CreateDateTime("Actual Start Date", 0T);
                Modify();
            end;
        }
        field(9; "Actual Duration"; Duration)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Duration';
        }
        field(10; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Approved,Finished,Suspended,Rejected,Verified,"Pending Verification";
            Caption = 'Status';
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
        field(12; "Project Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Project Budget';
        }
        field(13; "Contract No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No';
        }
        field(14; "Contract Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Name';
        }
        field(15; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(16; "User ID"; Code[25])
        {
            DataClassification = CustomerContent;
            TableRelation = User;
            Caption = 'User ID';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GeneralSetUp.Get();
            GeneralSetUp.TestField("Project Mgt Nos");
            NoSeriesManagement.InitSeries(GeneralSetUp."Project Mgt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Project Date" := Today;
        "User ID" := UserId;
    end;

    var
        GeneralSetUp: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DateError: Label 'End Date cannot come before Start Date';
}






