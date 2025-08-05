tableextension 53002 "PurchHeaderExt" extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            //TableRelation = Vendor where("Vendor Type" = filter(Vendor));
            TableRelation = Vendor where("Vendor Posting Group" = filter('CREDITORS'));

        }
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

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
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

            trigger OnValidate()
            var
                IR: Record "Internal Request Header";
                IRLine: Record "Internal Request Line";
            begin
                if "RFQ No." <> '' then begin
                    if Confirm('Are you sure you want to use this RFQ Document', false) = true then begin
                        IR.Reset();
                        IR.SetRange("No.", "RFQ No.");
                        if IR.Find('-') then begin
                            IRLine.Reset();
                            IRLine.SetRange("Document No.", IR."No.");
                            //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
                            if IRLine.Find('-') then begin
                                PurchSetup.Get();
                                "Document Date" := Today;
                                "Requisition No." := IR."Requisition No.";
                                "Assigned User ID" := UserId;
                                Commit();
                                repeat
                                    //insert lines
                                    PurchLine.Init();
                                    PurchLine.TransferFields(IRLine);
                                    PurchLine."Document Type" := "Document Type";
                                    PurchLine."Document No." := "No.";
                                    PurchLine.Validate("No.");
                                    PurchLine."Buy-from Vendor No." := "Buy-from Vendor No.";
                                    PurchLine."Pay-to Vendor No." := "Buy-from Vendor No.";
                                    PurchLine.Validate("Buy-from Vendor No.", "Pay-to Vendor No.");
                                    PurchLine."Quantity Received" := 0;
                                    PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                                    //MESSAGE(IRLine."Requisition No.");
                                    PurchLine."Requisition No." := IRLine."Requisition No.";
                                    PurchLine."Unit of Measure" := IRLine."Unit of Measure";
                                    PurchLine."Unit of Measure Code" := IRLine."Unit of Measure";
                                    PurchLine.Description := IRLine.Description;
                                    PurchLine.Specification := IRLine.Specification;
                                    PurchLine.Insert();

                                    IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                                    IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                                //IRLine.MODIFY;
                                until IRLine.Next() = 0;
                            end;
                        end;
                    end else
                        exit;

                    /*END ELSE IF "Combine Order"=FALSE THEN
                      BEGIN
                        DocNo:=NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.",0D,TRUE);
                        PurchHeader.INIT;
                        PurchHeader.TRANSFERFIELDS(IR);
                        PurchHeader.VALIDATE("No.");
                        PurchHeader."No.":=DocNo;
                        PurchHeader."Document Type":=PurchHeader."Document Type"::Quote;
                        PurchHeader.Status:=PurchHeader.Status::Open;
                        //PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
                        //PurchHeader.VALIDATE("Buy-from Vendor No.");
                        PurchHeader."Document Date":=TODAY;
                        PurchHeader."Requisition No.":="No.";
                        PurchHeader.INSERT;
                      PurchSetup.GET;
                      //insert lines
                      PurchLine.INIT;
                      PurchLine.TRANSFERFIELDS(IRLine);
                      PurchLine.VALIDATE(Type);
                      PurchLine.VALIDATE("No.");
                      PurchLine."Document No.":=DocNo;
                      PurchLine."Document Type":=PurchLine."Document Type"::Quote;
                      PurchLine."Quantity Received":=0;
                      PurchLine.VALIDATE(Quantity,IRLine."Qty. to Receive");
                      PurchLine."Requisition No.":="No.";
                //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
                      PurchLine.INSERT;
                //      Committement.UncommitPurchReq(IRLine,IR);
                //      Committement.EncumberPO(PurchLine,PurchHeader);
                      IRLine."Quantity Received":=IRLine."Quantity Received"+IRLine."Qty. to Receive";
                      IRLine."Qty. to Receive":=IRLine.Quantity-IRLine."Quantity Received";
                      //IRLine.MODIFY;
                      MESSAGE('Quote No %1 has been created',DocNo);
                      END;
                    END;
                //    IF CheckifFullyordered(IR)=TRUE THEN
                //      IR."Fully Ordered":=TRUE;
                //      IR.MODIFY;*/
                end;

            end;
        }
        field(53006; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Invoice Date';
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


        field(53017; "Purchase Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header"."No." where("Document Type" = const(Purchase), Status = filter(Fulfilled | Released), Archived = const(false));
            Caption = 'Purchase Request No.';

            trigger OnValidate()
            var
                IR: Record "Internal Request Header";
                IRLine: Record "Internal Request Line";
                PurchSetup: Record "Purchases & Payables Setup";
                PurchLine: Record "Purchase Line";
            begin
                if "Purchase Request No." = '' then
                    exit;

                if not Confirm('Are you sure you want to use this Purchase request Document?', false) then begin
                    "Purchase Request No." := '';
                    exit;
                end;

                IR.Get(IR."Document Type"::Purchase, "Purchase Request No.");
                if (IR.Status <> IR.Status::Released) and (IR.Status <> IR.Status::Fulfilled) or IR.Archived then
                    Error('Purchase Request %1 must be in Released or Fulfilled status and not archived.', "Purchase Request No.");

                IRLine.Reset();
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.FindSet() then begin
                    PurchSetup.Get();
                    repeat
                        PurchLine.Init();
                        PurchLine."Document Type" := "Document Type";
                        PurchLine."Document No." := "No."; // Current document's number
                                                           //PurchLine."Line No." := GetNextLineNo();
                        PurchLine.Type := IRLine.Type;
                        PurchLine.Validate("No.", IRLine."No.");
                        PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                        PurchLine."Buy-from Vendor No." := "Buy-from Vendor No.";
                        PurchLine."Pay-to Vendor No." := "Buy-from Vendor No.";
                        PurchLine."Requisition No." := IRLine."Requisition No.";
                        PurchLine."Unit of Measure Code" := IRLine."Unit of Measure";
                        PurchLine.Description := IRLine.Description;
                        PurchLine.Specification := IRLine.Specification;
                        PurchLine.Insert();

                        // Update IR Line if needed
                        IRLine."Quantity Received" += IRLine."Qty. to Receive";
                        IRLine."Qty. to Receive" := 0;
                        IRLine.Modify();
                    until IRLine.Next() = 0;
                end;
            end;
        }
        field(53018; "Requisition No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header"."No." where("Document Type" = const(Purchase), Status = filter(Fulfilled | Released), Archived = const(false));
            Caption = 'Requisition No';

            trigger OnValidate()
            begin
                if "Requisition No" <> '' then begin
                    RequisitionHeader.Get("Requisition No");

                    //Delete Existing Lines
                    QuotationLines.SetRange("Document No.", "No.");
                    QuotationLines.DeleteAll();

                    //Delete Attachments
                    DocumentAttachment.SetRange("Table ID", Database::"Purchase Header");
                    DocumentAttachment.SetRange("No.", "No.");
                    DocumentAttachment.DeleteAll();

                    //Insert Header
                    "Shortcut Dimension 1 Code" := RequisitionHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := RequisitionHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Currency Code" := RequisitionHeader."Currency Code";

                    //Insert Lines
                    RequisitionLines.Reset();
                    RequisitionLines.SetRange(RequisitionLines."Document No.", RequisitionHeader."No.");
                    if RequisitionLines.FindSet() then begin
                        repeat
                            QuotationLines.Init();
                            QuotationLines."Document No." := "No.";
                            QuotationLines.Type := RequisitionLines.Type;
                            QuotationLines."No." := RequisitionLines."No.";
                            QuotationLines.Description := RequisitionLines.Description;
                            QuotationLines.Quantity := RequisitionLines.Quantity;
                            QuotationLines."Unit of Measure" := RequisitionLines."Unit of Measure";
                            QuotationLines."Procurement Plan" := RequisitionLines."Procurement Plan";
                            QuotationLines."Procurement Plan Item" := RequisitionLines."Procurement Plan Item";
                            QuotationLines."Shortcut Dimension 1 Code" := RequisitionLines."Shortcut Dimension 1 Code";
                            QuotationLines.Validate("Shortcut Dimension 1 Code");
                            QuotationLines."Shortcut Dimension 2 Code" := RequisitionLines."Shortcut Dimension 2 Code";
                            QuotationLines.Validate("Shortcut Dimension 2 Code");
                            QuotationLines."Expected Receipt Date" := RequisitionHeader."Expected Receipt Date";
                            RequisitionLines.CalcFields(Specification);
                            QuotationLines.Specification := RequisitionLines.Specification;
                            QuotationLines."VAT Prod. Posting Group" := RequisitionLines."VAT Prod. Posting Group";
                            QuotationLines."VAT %" := RequisitionLines."VAT %";
                            QuotationLines."Amt. Rcd. Not Invoiced (LCY)" := RequisitionLines."Amount Including VAT";
                            QuotationLines.Amount := RequisitionLines."Amount Including VAT";
                            QuotationLines."Location Code" := RequisitionLines."Location Code";
                            QuotationLines.Insert(true);
                        until RequisitionLines.Next() = 0;
                    end;

                end;
            end;
        }
        field(53019; "Delivery Address"; Text[100])
        {
            Caption = 'Delivery Address';
            DataClassification = CustomerContent;
        }
    }
    var
        DocAttachMgt: Codeunit "Document Attachment Custom";
        DocumentAttachment: Record "Document Attachment";
        Employee: Record Employee;
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        RequisitionHeader: Record "Internal Request Header";
        RequisitionLines: Record "Internal Request Line";
        QuotationLines: Record "Purchase Line";
}











