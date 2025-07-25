table 53037 "Prospective Supplier Tender"
{
    DataClassification = CustomerContent;

    fields
    {
        field(50000; "Prospect No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Prospect No.';
        }
        field(1; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request" where("Process Type" = const(Tender), Status = filter(<> Archived), "Tender Type" = const(Open));
            Caption = 'Tender No.';

            trigger OnValidate()
            begin
                if TenderRec.Get("Tender No.") then begin
                    Rec.TransferFields(TenderRec);

                    /* //Insert Lines
                    TenderLine.Reset();
                    TenderLine.SetRange(TenderLine."Requisition No", TenderRec."No.");
                    if TenderLine.FindFirst() then begin
                        repeat
                            ProspectiveTenderLine.Init();
                            ProspectiveTenderLine."Response No" := "Prospect No.";
                            ProspectiveTenderLine."Tender No." := TenderRec."No.";
                            ProspectiveTenderLine."Line No" := TenderLine."Line No";
                            ProspectiveTenderLine.Type := TenderLine.Type;
                            ProspectiveTenderLine.No := TenderLine."No";
                            ProspectiveTenderLine.Description := TenderLine.Description;
                            ProspectiveTenderLine.Quantity := TenderLine.Quantity;
                            ProspectiveTenderLine."Unit of Measure" := TenderLine."Unit of Measure";
                            ProspectiveTenderLine."Procurement Plan" := TenderLine."Procurement Plan";
                            ProspectiveTenderLine."Procurement Plan Item" := TenderLine."Procurement Plan Item";
                            ProspectiveTenderLine."Budget Line" := TenderLine."Budget Line";
                            ProspectiveTenderLine."Shortcut Dimension 1 Code" := TenderLine."Shortcut Dimension 1 Code";
                            ProspectiveTenderLine.Validate("Shortcut Dimension 1 Code");
                            ProspectiveTenderLine."Shortcut Dimension 2 Code" := TenderLine."Shortcut Dimension 2 Code";
                            ProspectiveTenderLine.Validate("Shortcut Dimension 2 Code");
                            ProspectiveTenderLine."Request Date" := TenderRec.TenderOpeningDate;
                            ProspectiveTenderLine."Expected Receipt Date" := DT2Date(TenderRec.TenderClosingDate);
                            ProspectiveTenderLine.Committed := TenderLine.Committed;
                            ProspectiveTenderLine.Specification2 := TenderLine.Specification2;
                            ProspectiveTenderLine."VAT Prod. Posting Group" := TenderLine."VAT Prod. Posting Group";
                            ProspectiveTenderLine."VAT %" := TenderLine."VAT %";
                            ProspectiveTenderLine."Amount Inclusive VAT" := TenderLine."Amount Inclusive VAT";
                            if not ProspectiveTenderLine.Get(ProspectiveTenderLine."Response No", ProspectiveTenderLine."Line No") then
                                ProspectiveTenderLine.Insert(true);
                        until TenderLine.Next() = 0;
                    end; */
                end;
            end;
        }
        field(2; Title; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(3; "Requisition No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header"."No." where("Document Type" = filter(Purchase),
                                                                   Status = filter(Released));
            Caption = 'Requisition No';
        }
        field(4; "Procurement Plan No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item";
            Caption = 'Procurement Plan No';
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(7; "Procurement type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement type';
        }
        field(9; "Process Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Direct,RFQ,RFP,Tender,EOI;
            Caption = 'Process Type';
        }
        field(10; "Procurement Plan Item"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item"."Plan Item No" where("Plan Year" = field("Procurement Plan No"));
            Caption = 'Procurement Plan Item';
        }
        field(11; Category; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Category';
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(14; TenderOpeningDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'TenderOpeningDate';
        }
        field(15; "Tender Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Released,"Pending Approval",Approved,"Pending Prepayment",Rejected,Closed;
            Caption = 'Tender Status';
        }
        field(16; TenderClosingDate; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'TenderClosingDate';
        }
        field(21; "Quotation Deadline"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quotation Deadline';
        }
        field(22; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(23; "Expected Closing Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Closing Time';
        }
        field(30; "Submitted To Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Submitted To Portal';
        }
        field(31; "Ref No."; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref No.';
        }
        field(50001; "Sent for Evaluation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sent for Evaluation';
        }
        field(50002; "Pre-qualified"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Prospective Suppliers"."Pre Qualified" where("No." = field("Prospect No.")));
            Caption = 'Pre-qualified';
        }
    }

    keys
    {
        key(Key1; "Prospect No.", "Tender No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

    end;

    var
        TenderRec: Record "Procurement Request";
        TenderLine: Record "Procurement Request Lines";
        ProspectiveTenderLine: Record "Prospective Tender Line";
}





