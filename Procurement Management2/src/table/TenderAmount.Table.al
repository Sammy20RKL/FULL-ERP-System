table 53036 "Tender Amount"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Scope Type"; Option)
        {
            Caption = 'Scope Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Scope Item,Main Heading,Main Heading End,Sub-Heading,Sub-Heading End';
            OptionMembers = "Scope Parameter","Objective Heading","Objective Heading End","Sub-Heading","Sub-Heading End";
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = CustomerContent;
        }
        field(6; Indent; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Indent';
        }
        field(7; Amount; code[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
    }

    keys
    {
        key(PK; "Tender No.", "Line No.")
        {
            Clustered = true;
        }
    }
}





