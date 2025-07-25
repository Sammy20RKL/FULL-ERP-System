tableextension 53005 "Return Shipment Header Ext" extends "Return Shipment Header"
{
    fields
    {
        field(53000; "Cancel Comments"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Comments';
        }
    }
}






