table 60035 "Grants Lookup Values"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Sub Contractor Close Out Checklist,,Close Out Checklist';
            OptionMembers = "Sub Contractor Close Out Checklist",,"Close Out Checklist";
        }
        field(2; "Code"; Code[70])
        {
        }
        field(3; Description; Text[80])
        {
        }
        field(4; Remarks; Text[250])
        {
        }
        field(6; Closed; Boolean)
        {
        }
        field(7; "Order"; Integer)
        {
        }
        field(8; "Grants no."; Code[50])
        {
            TableRelation = Jobs."No.";
        }
    }

    keys
    {
        key(Key1; "Order", Type, "Code", "Grants no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // IF Type=Type::"10" THEN BEGIN
        //   HrLookupValues.RESET;
        //   HrLookupValues.SETRANGE(HrLookupValues.Type,HrLookupValues.Type::"Appraisal Period");
        //   HrLookupValues.SETRANGE(HrLookupValues.Closed,FALSE);
        //   IF HrLookupValues.FINDFIRST THEN
        //     ERROR('Close the Appraisal Period %1',HrLookupValues.Code);
        // END
    end;
}

