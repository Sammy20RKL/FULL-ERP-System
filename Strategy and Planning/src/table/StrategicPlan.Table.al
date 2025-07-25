table 65004 "Strategic Plan"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; "No Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Mission; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Vision; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Strategic Plan';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Strategic Plan";
        }
        field(10; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Closed BY"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Date Closed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Time Closed"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Sent E-Mail to HOD"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Time Approved"; Time)
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
    }

    trigger OnDelete()
    begin
        TestField(Closed, false);
    end;

    trigger OnInsert()
    begin
        if Code = '' then begin
            StrategicSetup.Get();
            StrategicSetup.TestField("Strategic Plan Nos.");
            NoSeriesMgt.InitSeries(StrategicSetup."Strategic Plan Nos.", xRec."No Series", Today, Code, "No Series");
        end;

        SetControlMandatoryFields();
    end;

    trigger OnModify()
    begin
        //TESTFIELD(Closed,FALSE);
    end;

    var
        StrategicSetup: Record "Strategic Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure SetControlMandatoryFields()
    var
        StrategicPlan: Record "Strategic Plan";
    begin
        /*StrategicPlan.RESET;
        StrategicPlan.SETRANGE(Closed,FALSE);
        IF StrategicPlan.FINDFIRST THEN
          ERROR('You must first close existing strategic plan to proceed.');*/

    end;
}

