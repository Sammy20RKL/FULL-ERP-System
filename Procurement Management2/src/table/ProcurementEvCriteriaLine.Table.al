table 53090 "Procurement Ev Criteria Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Document No.';
        }
        field(2; "Vendor No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Prospective Suppliers"."No.";
            Caption = 'Vendor No';

            trigger OnValidate()
            begin
                if ProspectiveRec.Get("Vendor No") then
                    "Vendor Name" := ProspectiveRec.Name;


            end;
        }
        field(13; "Vendor Name"; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
        field(11; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
        }
        field(12; "Price level (H/M/L)"; Enum "Price level")
        {
            DataClassification = CustomerContent;

        }
        field(23; "Quality (H/M/L)"; Text[1000])
        {
            DataClassification = CustomerContent;
        }
        field(33; "Delivery lead time- Days"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Delivery terms"; Code[1000])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Payment terms"; Text[1000])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(38; "Quotation valid untill"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Supplier registration"; Option)
        {
            DataClassification = CustomerContent;

            OptionMembers = ,Yes,No;
        }
        field(42; "Supplier status"; Option)
        {
            DataClassification = CustomerContent;

            OptionMembers = ,potential,qualified,selected;
        }
        field(43; "Total Amount"; Decimal)
        {
            //  DataClassification ;
            FieldClass = FlowField;
            CalcFormula = sum("Procurement Evaluation Line".Amount where("Document No." = field("Document No."), "Vendor No" = field("Vendor No")));
            // Sum("Member Ledger Entry".Amount WHERE (Customer No.=FIELD(Client Code),Loan No=FIELD(Loan  No.),Transaction Type=FILTER(Interest Due|Interest Paid),Currency Code=FIELD(Currency Filter),Posting Date=FIELD(Date filter)))
        }
        field(9; Awarded; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Awarded';

            trigger OnValidate()
            var
            begin

            end;
        }

    }

    keys
    {
        key(Key1; "Document No.", "Vendor No", "Line No")
        {
            Clustered = true;
        }
        // key(SIFTKey; "Total Amount")
        // {
        //     SumIndexFields = Amount;
        // }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var

        ProspectiveRec: Record "Prospective Suppliers";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}