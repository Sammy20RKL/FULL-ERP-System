table 53004 "Supplier Monitoring"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Purchase Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            Caption = 'Purchase Order No.';

            trigger OnValidate()
            begin
                if PO.Get(PO."Document Type"::Order, "Purchase Order No.") then begin
                    "Vendor Name" := PO."Pay-to Name";
                end;
            end;
        }
        field(2; "Brief Description of Work done"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Brief Description of Work done';
        }
        field(3; "Agreed Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Agreed Start Date';
        }
        field(4; "Actual Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Start Date';
        }
        field(5; "Agreed Completion date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Agreed Completion date';
        }
        field(6; "Actual Completion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Completion Date';
        }
        field(7; "Completed Within Schedule"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completed Within Schedule';
        }
        field(8; "Reasons for Late completion"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reasons for Late completion';
        }
        field(9; "Quality of Work"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Quality of Work';
        }
        field(10; "User ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(11; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(12; "Vendor Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
    }

    keys
    {
        key(Key1; "Purchase Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PO: Record "Purchase Header";
}





