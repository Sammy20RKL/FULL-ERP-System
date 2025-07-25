table 53010 "Inspection Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Inspection No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection No';
        }
        field(2; "Order No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order),
                                                           Status = const(Released));
            Caption = 'Order No';

            trigger OnValidate()
            begin
                PurchLines.Reset();
                PurchLines.SetRange(PurchLines."Document Type", PurchLines."Document Type"::Order);
                PurchLines.SetRange(PurchLines."Document No.", "Order No");
                if PurchLines.Find('-') then begin
                    repeat
                        InspectLines.Init();
                        InspectLines."Inspection No" := "Inspection No";
                        InspectLines."Line No" := PurchLines."Line No.";
                        InspectLines.Description := PurchLines."Description 2";
                        InspectLines."Unit of Measure" := PurchLines."Unit of Measure";
                        InspectLines."Quantity Ordered" := PurchLines.Quantity;
                        InspectLines."Item No" := PurchLines."No.";
                        if not InspectLines.Get(InspectLines."Inspection No", InspectLines."Line No") then
                            InspectLines.Insert() else
                            InspectLines.Modify();
                    until PurchLines.Next() = 0;
                end;

                if PO.Get(PO."Document Type"::Order, "Order No") then
                    "Supplier Name" := PO."Buy-from Vendor Name";
            end;
        }
        field(3; "Commitee Appointment No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Committees" where(Permanent = const(true));
            Caption = 'Commitee Appointment No';
        }
        field(4; "Inspection Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Inspection Date';
        }
        field(5; "Supplier Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Name';
        }
        field(6; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(7; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Payment Processing';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,"Payment Processing";
            Caption = 'Status';
        }
        field(8; Amount; Decimal)
        {
            CalcFormula = sum("Purchase Line".Amount where("Document Type" = const(Order),
                                                            "Document No." = field("Order No")));
            Editable = true;
            FieldClass = FlowField;
            Caption = 'Amount';
        }
        field(9; "Amount Invoiced"; Decimal)
        {
            CalcFormula = sum("Purch. Inv. Line".Amount where("Document No." = field("Order No")));
            FieldClass = FlowField;
            Caption = 'Amount Invoiced';
        }
        field(10; "Temp Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Temp Amount';
        }
    }

    keys
    {
        key(Key1; "Inspection No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        InspectLines: Record "Inspection Lines";
        PO: Record "Purchase Header";
        PurchLines: Record "Purchase Line";
}





