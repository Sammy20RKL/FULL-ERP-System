tableextension 50010 "GenLedgerSetupExt" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
            DataClassification = CustomerContent;
        }
        field(50001; "Current Budget Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Current Budget End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Use Dimensions For Budget"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Budget Approval Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            ;
        }
        field(50005; "Proposed Budget Approval Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Serial No. Information";
            ;
        }
        field(50006; "Check For Commitments"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}





