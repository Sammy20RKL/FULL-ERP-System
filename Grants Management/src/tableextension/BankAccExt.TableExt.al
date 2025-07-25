tableextension 60003 "Bank Acc Ext" extends "Bank Account"
{
    fields
    {
        field(60000; "Payments No"; Code[30])
        {
            Caption = 'Payments No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
