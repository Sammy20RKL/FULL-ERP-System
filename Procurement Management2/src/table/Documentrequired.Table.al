table 53026 "Document required"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Quote/Tender No.';
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(3; "Document Name"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Name';
        }
        field(4; Mandatory; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory';
        }
        field(5; "Document Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Document Setup"."Code";
            Caption = 'Document Code';

            trigger OnValidate()
            var
                ProcDocs: Record "Procurement Document Setup";
            begin
                if ProcDocs.Get("Document Code") then
                    "Document Name" := ProcDocs.Description;
            end;
        }
        field(6; Checked; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Checked';
        }
    }

    keys
    {
        key(Key1; "Quote No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





