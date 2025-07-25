table 53050 "Tender Evaluation Setup Line"
{
    Caption = 'Tender Evaluation Setup Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Description; Blob)
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(4; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
        }
        field(5; "Score Type"; Option)
        {
            OptionMembers = " ","Yes/No","Criteria";
            OptionCaption = ' ,Yes/No,Criteria';
            DataClassification = CustomerContent;
            Caption = 'Score Type';
        }
        field(6; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Tender No.", Code, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description, "Maximum Score")
        {
        }
    }
}





