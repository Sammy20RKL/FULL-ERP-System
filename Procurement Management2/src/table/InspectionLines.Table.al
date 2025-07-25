table 53011 "Inspection Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Inspection No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection No';
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure';
        }
        field(5; "Quantity Ordered"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Ordered';
        }
        field(6; "Quantity Received"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Received';
        }
        field(7; "Inspection Decision"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Accept,Reject;
            Caption = 'Inspection Decision';
        }
        field(8; "Reasons for Rejection"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reasons for Rejection';
        }
        field(9; "Return Reasons"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Return Reason";
            Caption = 'Return Reasons';
        }
        field(10; "Item No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No';
        }
    }

    keys
    {
        key(Key1; "Inspection No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





