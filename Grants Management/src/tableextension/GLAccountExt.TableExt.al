tableextension 60002 "GL Account Ext" extends "G/L Account"
{
    fields
    {
        field(60000; "Budget Line Item"; Code[20])
        {
            Caption = 'Budget Line Item';
            DataClassification = ToBeClassified;
            TableRelation = "Budget Line Items".Code where(Use = filter(true));
        }
        field(60001; "Donor defined Account"; Boolean)
        {

        }
    }
}
