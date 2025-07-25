tableextension 60001 "Resource Ext" extends Resource
{
    fields
    {
        field(60000; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(60001; "Resource G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(60002; Email; Text[30])
        {

        }
        field(60003; Institution; Option)
        {
            OptionMembers = " ",MTRH,MU,Others;
        }
    }
}
