table 53017 "Procurement Management Cue"
{
    Caption = 'Procurement Management Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; Vendors; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Vendor);
            Caption = 'Vendors';
        }
        field(3; "Purchase Orders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order)));
            Caption = 'Purchase Orders';
        }
        field(4; "Purchase Quotes"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const(Quote)));
            Caption = 'Purchase Quotes';
        }
        field(5; "Blanket Purchase order"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const("Blanket Order")));
            Caption = 'Blanket Purchase order';
        }
        field(6; "Purchase Invoice"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const(Invoice)));
            Caption = 'Purchase Invoice';
        }
        field(7; "Purchase return order"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const("Return Order")));
            Caption = 'Purchase return order';
        }
        field(8; "Purchase Credit Memo"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = const("Credit Memo")));
            Caption = 'Purchase Credit Memo';
        }
        field(13; "Procurement Plans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("G/L Budget Name" where(Blocked = filter(false)));
            Caption = 'Procurement Plans';
        }
        field(14; "Purchase request list"; Integer)
        {
            Caption = 'Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type" = const(Purchase),
                            "Fully Ordered" = const(false),
                            Status = filter(Open | "Pending Approval")));
        }
        field(15; "Purchase request list Approved"; Integer)
        {
            Caption = 'Approved Purchase requests';
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type" = const(Purchase),
                            "Fully Ordered" = const(false),
                            Status = filter(Released)));
        }
        field(16; "Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type" = const(Stock),
                            Status = filter("Pending Approval"),
                            Posted = const(false)));
            Caption = 'Store Requests';
        }
        field(17; "Approved Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type" = const(Stock),
                            Status = filter(Released),
                            Posted = const(false)));
            Caption = 'Approved Store Requests';
        }
        field(18; "Open Store Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Internal Request Header" where("Document Type" = const(Stock),
                            Status = filter(Open),
                            Posted = const(false)));
            Caption = 'Open Store Requests';
        }
        field(19; "Request for Quote & Order"; Integer)
        {
            Caption = 'Request for Quotes';
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type" = const(RFQ)));
        }
        field(20; "Open Tenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type" = const(Tender),
                            Status = const(New),
                            "Tender Type" = const(Open)));
            Caption = 'Open Tenders';
        }
        field(21; "Restricted Tenders"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type" = const(Tender),
                            Status = const(New),
                            "Tender Type" = const(Restricted)));
            Caption = 'Restricted Tenders';
        }
        field(22; "Prospective Suppliers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prospective Suppliers" where("Pre Qualified" = const(false)));
            Caption = 'Prospective Suppliers';
        }
        field(23; "Prequalified Suppliers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prospective Suppliers" where("Pre Qualified" = const(true)));
            Caption = 'Prequalified Suppliers';
        }
        field(24; "Request For Proposal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type" = const(RFP),
                            Status = const(New)));
            Caption = 'Request For Proposal';
        }
        field(25; "RFP Evaluation List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Evaluation Header" where("LPO/Contract Generated" = const(false)));
            Caption = 'RFP Evaluation List';
        }
        field(26; "EOI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request" where("Process Type" = const(EOI),
                            Status = const(New)));
            Caption = 'EOI';
        }
        field(27; "EOI under Evaluation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Evaluation Header" where("LPO/Contract Generated" = const(false)));
            Caption = 'EOI under Evaluation';
        }
        field(28; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(29; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
        field(30; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(31; "RFQ Evaluation List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Evaluation Header" where("LPO/Contract Generated" = const(false),
                                                                      "Process Type" = const(RFQ)));
            Caption = 'RFQ Evaluations';
        }
        field(37; "Travel Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status = filter(<> Released)));
            Caption = 'Travel Requests';
        }
        field(32; "Travel Requests Approved"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where(Status = filter(Released)));
            Caption = 'Travel Requests Approved';
        }
        field(33; "Ongoing Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status" = filter("On Trip")));
            Caption = 'Ongoing Trips';
        }
        field(34; "Completed Trips"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Travel Requests" where("Transport Status" = filter(Completed)));
            Caption = 'Completed Trips';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}





