table 53009 "Tender Committees"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender/Quotation No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request" where("Process Type" = filter(Tender | "Supplier Prequalification" | RFP | RFQ));
            Caption = 'Tender/Quote No.';

            trigger OnValidate()
            begin
                if TenderRec.Get("Tender/Quotation No") then begin
                    Title := TenderRec.Title;
                    "Process Type" := TenderRec."Process Type";

                    if "Process Type" <> "Process Type"::"Supplier Prequalification" then begin
                        TenderCommittees.Reset();
                        TenderCommittees.SetRange(TenderCommittees."Tender/Quotation No", "Tender/Quotation No");
                        if TenderCommittees.FindFirst() then
                            Error(AnotherCommitteeExistsErr, TenderCommittees."Appointment No", "Tender/Quotation No");
                    end;
                end;
            end;
        }
        field(2; "Committee ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Committees";
            Caption = 'Committee ID';

            trigger OnValidate()
            begin
                if ProcurementComittee.Get("Committee ID") then begin
                    "Committee Name" := ProcurementComittee.Description;
                end;
            end;
        }
        field(3; "Committee Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Committee Name';
        }
        field(4; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(5; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(6; Title; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(7; "Appointment No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Appointment No';
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(9; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            Caption = 'Status';
        }
        field(10; "Process Type"; Enum "Procurement Process Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Process Type';
        }
    }

    keys
    {
        key(Key1; "Appointment No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Appointment No" = '' then begin
            PurchSetup.Get();
            PurchSetup.TestField("Committe Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Committe Nos", xrec."No. Series", 0D, "Appointment No", "No. Series");
        end;

        "User ID" := CopyStr(UserId, 1, 20);
        "Creation Date" := Today;
    end;

    var
        ProcurementComittee: Record "Procurement Committees";
        TenderRec: Record "Procurement Request";
        PurchSetup: Record "Purchases & Payables Setup";
        TenderCommittees: Record "Tender Committees";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AnotherCommitteeExistsErr: Label 'Another Tender Committee %1 already exists for Tender No. %2';
}





