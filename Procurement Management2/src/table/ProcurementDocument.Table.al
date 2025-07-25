table 53015 "Procurement Document"
{
    Caption = 'Procurement Document-Per Method';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Direct,RFQ,RFP,Tender,EOI;
        }
        field(2; "Document Code"; Code[20])
        {
            Caption = 'Document Code';
            DataClassification = CustomerContent;
            TableRelation = "Procurement Document Setup".Code;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; Type, "Document Code")
        {
            Clustered = true;
        }
    }
}





