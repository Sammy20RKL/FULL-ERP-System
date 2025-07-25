tableextension 65000 "G/L Budget Name Ext" extends "G/L Budget Name"
{
    fields
    {
        field(65000; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
        }
        field(65001; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
    }
}
