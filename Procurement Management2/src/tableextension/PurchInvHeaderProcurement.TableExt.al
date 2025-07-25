tableextension 53010 PurchInvHeaderProcurement extends "Purch. Inv. Header"
{
    fields
    {
        field(53000; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition No.';
            Editable = false;
        }
        field(53001; "Tender/Quotation ref no"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender/RFQ No.';
            Editable = false;
        }
        field(53002; Minutes; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Minutes';
        }
        field(53003; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Caption = 'Employee No.';
        }
        field(53004; "LPO Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables,"Cost of Sales","Fixed Asset";
            Caption = 'LPO Type';
        }
        field(53005; "RFQ No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header"."No." where("Document Type" = filter(RFQ));
            Caption = 'Tender/RFQ No.';
            Editable = false;
        }
        field(53007; Reference; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference';
        }
        field(53008; "Cancel Comments"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel Comments';
        }
        field(53009; "Cancelled By"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled By';
        }
        field(53010; "LPO Closed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'LPO Closed';
        }
        field(53011; "Close Comments"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Close Comments';
        }
        field(53012; "Closed By"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Closed By';
        }
        field(53014; "Contract No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Contract";
        }
        field(53015; "Email Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53016; "Employee Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Name';
        }
    }
}











