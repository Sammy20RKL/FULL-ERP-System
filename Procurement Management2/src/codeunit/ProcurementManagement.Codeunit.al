codeunit 53000 "Procurement Management"
{

    trigger OnRun()
    begin
    end;

    procedure CancelApprovedLPO(LPONo: Code[70])
    var
        ApprovalEntry: Record "Approval Entry";
        CommitmentEntries: Record "Commitment Entries";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        RejectionComments: Page "Rejection Comments";
        RejectComment: Text;
    begin
        if Confirm('Are you sure you want to cancel LPO No.%1', false, LPONo) = true then begin
            PurchaseHeader.Reset();
            PurchaseHeader.SetRange("No.", LPONo);
            if PurchaseHeader.Find('-') then begin
                //Uncheck commitments
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                if PurchaseLine.Find('-') then begin
                    repeat
                        PurchaseLine.Committment := false;
                        PurchaseLine.Modify();
                    until PurchaseLine.Next() = 0;
                end;

                //Clear commitments
                CommitmentEntries.Reset();
                CommitmentEntries.SetRange("Document No", LPONo);
                CommitmentEntries.DeleteAll();

                //Clear Approvals
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Document No.", LPONo);
                ApprovalEntry.DeleteAll();

                //Prompt and Insert Rejection Comment
                if RejectionComments.RunModal() = Action::OK then begin
                    RejectComment := RejectionComments.GetRejectComment();
                    if RejectComment = '' then
                        Error('Please input rejection comment');
                    PurchaseHeader."Cancel Comments" := RejectComment;
                    PurchaseHeader.Status := PurchaseHeader.Status::Open;
                    PurchaseHeader."Cancelled By" := UserId;
                    PurchaseHeader.Modify();
                end;
            end;
            Message('LPO %1 cancelled successfully', LPONo);
        end else
            exit;
    end;


    procedure CloseAndUncommitLPO(PurchaseHeader: Record "Purchase Header")
    var
        Committment: Codeunit "Commitments Mgt Procurement";
        ClosingComments: Page "Rejection Comments";
        CloseComment: Text;
    begin
        //Uncommit Entries
        if PurchaseHeader."LPO Type" <> PurchaseHeader."LPO Type"::"Cost of Sales" then begin
            Message('Kinldy note that LPO %1 has committment entries which will be reveresed!', PurchaseHeader."No.");
            Committment.UncommitLPO(PurchaseHeader);
        end;

        Commit();

        //Prompt and Insert Closing Comment
        if ClosingComments.RunModal() = Action::OK then begin
            CloseComment := ClosingComments.GetRejectComment();
            if CloseComment = '' then
                Error('Please input Closing comment');
            PurchaseHeader."Close Comments" := CloseComment;
            PurchaseHeader."Closed By" := UserId;
            PurchaseHeader."LPO Closed" := true;
            PurchaseHeader.Modify();
        end;

        Commit();
        Message('LPO %1 has been closed successfully', PurchaseHeader."No.");
    end;

    procedure CreateProcurementEvaluation(var SupplierSelection: Record "Supplier Selection")
    var
        ProcurementRequest: Record "Procurement Request";
        ProcurementRequestLine: Record "Procurement Request Lines";
        PreQualifiedList: Record "Prospective Suppliers";
        PPSetup: Record "Purchases & Payables Setup";
        QuoteEvaluationHeader: Record "Procurement Evaluation Header";
        QuoteEvaluation: Record "Procurement Evaluation Line";
        BidPrices: Record "Supplier Price Line";
        DocumentAttachment: Codeunit "Document Attachment Custom";
    begin
        PPSetup.Get();
        //Create a supplier from the list of Pre-Qualified Suppliers
        if SupplierSelection.Invited then begin
            if PreQualifiedList.Get(SupplierSelection."Supplier Code") then begin
                //Insert Header
                if ProcurementRequest.Get(SupplierSelection."Reference No.") then begin
                    QuoteEvaluationHeader.Init();
                    QuoteEvaluationHeader."No." := ProcurementRequest."No.";
                    QuoteEvaluationHeader.Title := ProcurementRequest.Title;
                    QuoteEvaluationHeader."Process Type" := ProcurementRequest."Process Type";
                    QuoteEvaluationHeader."Requisition No" := ProcurementRequest."Requisition No";
                    QuoteEvaluationHeader."Creation Date" := Today();
                    QuoteEvaluationHeader."Prepared By" := UserId();
                    QuoteEvaluationHeader."Shortcut Dimension 1 Code" := ProcurementRequest."Shortcut Dimension 1 Code";
                    QuoteEvaluationHeader."Shortcut Dimension 2 Code" := ProcurementRequest."Shortcut Dimension 2 Code";
                    QuoteEvaluationHeader."Responsibility Centre" := ProcurementRequest."Responsibility Centre";
                    QuoteEvaluationHeader."Dimension Set ID" := ProcurementRequest."Dimension Set ID";
                    QuoteEvaluationHeader."Ref No." := ProcurementRequest."Ref No.";
                    QuoteEvaluationHeader."Currency Code" := ProcurementRequest."Currency Code";
                    if not QuoteEvaluationHeader.Get(ProcurementRequest."No.") then
                        QuoteEvaluationHeader.Insert();


                    //Copy Attachments From Quotation
                    DocumentAttachment.CopyAttachmentsFromRec(QuoteEvaluationHeader.RecordId,
                                                              Database::"Procurement Request",
                                                              ProcurementRequest."No.",
                                                              QuoteEvaluationHeader."No.",
                                                              Enum::"Attachment Document Type"::"Procurement Evaluation");
                end;

                //Insert Lines
                ProcurementRequestLine.Reset();
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Document No.", SupplierSelection."Reference No.");
                if ProcurementRequestLine.FindSet() then begin
                    repeat
                        QuoteEvaluation.Init();
                        QuoteEvaluation."Document No." := SupplierSelection."Reference No.";
                        //QuoteEvaluation."Vendor No" := PreQualifiedList."Vendor No";
                        QuoteEvaluation."Vendor No" := PreQualifiedList."No.";
                        QuoteEvaluation.Validate(QuoteEvaluation."Vendor No");
                        case ProcurementRequestLine.Type of
                            ProcurementRequestLine.Type::" ":
                                QuoteEvaluation.Type := QuoteEvaluation.Type::" ";
                            ProcurementRequestLine.Type::"G/L Account":
                                QuoteEvaluation.Type := QuoteEvaluation.Type::"G/L Account";
                            ProcurementRequestLine.Type::"Fixed Asset":
                                QuoteEvaluation.Type := QuoteEvaluation.Type::"Fixed Asset";
                            ProcurementRequestLine.Type::Item:
                                QuoteEvaluation.Type := QuoteEvaluation.Type::Item;
                        end;
                        QuoteEvaluation."No." := ProcurementRequestLine.No;
                        QuoteEvaluation.Description := ProcurementRequestLine.Description;
                        QuoteEvaluation."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                        QuoteEvaluation.Quantity := ProcurementRequestLine.Quantity;
                        if BidPrices.Get(ProcurementRequest."No.", PreQualifiedList."No.", ProcurementRequestLine.Type, ProcurementRequestLine.No, ProcurementRequestLine."Line No") then
                            QuoteEvaluation.Validate("Unit Amount", BidPrices."Unit Amount")
                        else begin
                            QuoteEvaluation."Unit Amount" := 0;//ProcurementRequestLine."Unit Price";
                            QuoteEvaluation.Amount := 0;//ProcurementRequestLine.Amount;
                            QuoteEvaluation."Amount Inclusive VAT" := 0;// ProcurementRequestLine."Amount Inclusive VAT";
                        end;
                        QuoteEvaluation."Line No" := ProcurementRequestLine."Line No";
                        QuoteEvaluation."Shortcut Dimension 1 Code" := ProcurementRequestLine."Shortcut Dimension 1 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 1 Code");
                        QuoteEvaluation."Shortcut Dimension 2 Code" := ProcurementRequestLine."Shortcut Dimension 2 Code";
                        QuoteEvaluation.Validate("Shortcut Dimension 2 Code");
                        QuoteEvaluation.Committed := ProcurementRequestLine.Committed;
                        QuoteEvaluation."Procurement Plan" := ProcurementRequestLine."Procurement Plan";
                        QuoteEvaluation."Procurement Plan Item" := ProcurementRequestLine."Procurement Plan Item";
                        QuoteEvaluation."Budget Line" := ProcurementRequestLine."Budget Line";
                        QuoteEvaluation."Request Date" := ProcurementRequestLine."Request Date";
                        QuoteEvaluation."Expected Receipt Date" := ProcurementRequestLine."Expected Receipt Date";
                        QuoteEvaluation."Requisition No" := ProcurementRequest."Requisition No";
                        QuoteEvaluation."VAT Prod. Posting Group" := ProcurementRequestLine."VAT Prod. Posting Group";
                        QuoteEvaluation."VAT %" := ProcurementRequestLine."VAT %";
                        ProcurementRequestLine.CalcFields(Specification);
                        QuoteEvaluation.Specification := ProcurementRequestLine.Specification;
                        QuoteEvaluation."Location Code" := ProcurementRequestLine."Location Code";
                        if ProcurementRequest.Get(SupplierSelection."Reference No.") then
                            QuoteEvaluation.Title := ProcurementRequest.Title;
                        if not QuoteEvaluation.Get(SupplierSelection."Reference No.", PreQualifiedList."Vendor No", ProcurementRequestLine.No, ProcurementRequestLine."Line No") then
                            QuoteEvaluation.Insert();
                    until ProcurementRequestLine.Next() = 0;
                end;
                //Message('Tender Evaluation generated successfully');
            end;
            //Archive the quotation
            if ProcurementRequest.Get(SupplierSelection."Reference No.") then begin
                ProcurementRequest.Status := ProcurementRequest.Status::Archived;
                ProcurementRequest.Modify();
            end;
        end;
    end;

    procedure CreateQuote(var SupplierSelection: Record "Supplier Selection")
    var
        ProcurementRequestLine: Record "Procurement Request Lines";
        PreQualifiedList: Record "Prospective Suppliers";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //Create a supplier from the list of Pre-Qualified Suppliers
        if SupplierSelection.Invited then begin
            PreQualifiedList.Reset();
            PreQualifiedList.SetRange(PreQualifiedList.Name, SupplierSelection."Supplier Name");
            //PreQualifiedList.Setrange(PreQualifiedList.Category,SupplierSelection."Supplier Category");
            if PreQualifiedList.Find('-') then begin
                if PreQualifiedList."Vendor No" = '' then
                    if Confirm('The system will create Vendor %1 Do you want to continue?', true, SupplierSelection."Supplier Name") then begin
                        PreQualifiedList.CreateVend(PreQualifiedList);
                    end;
                PurchaseHeader.Init();
                PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                PurchaseHeader."No." := '';
                PurchaseHeader."Buy-from Vendor No." := PreQualifiedList."Vendor No";
                PurchaseHeader.Validate(PurchaseHeader."Buy-from Vendor No.");
                PurchaseHeader.Insert(true);
                ProcurementRequestLine.Reset();
                ProcurementRequestLine.SetRange(ProcurementRequestLine."Document No.", SupplierSelection."Reference No.");
                if ProcurementRequestLine.Find('-') then
                    repeat
                        PurchaseLine.Init();
                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := ProcurementRequestLine."Line No";
                        PurchaseLine."Buy-from Vendor No." := PreQualifiedList."Vendor No";
                        PurchaseLine.Type := ProcurementRequestLine.Type;
                        PurchaseLine."No." := ProcurementRequestLine.No;
                        PurchaseLine.Validate(PurchaseLine."No.");
                        PurchaseLine.Description := ProcurementRequestLine.Description;
                        PurchaseLine."Unit of Measure" := ProcurementRequestLine."Unit of Measure";
                        PurchaseLine.Quantity := ProcurementRequestLine.Quantity;
                        PurchaseLine.Insert();
                    until ProcurementRequestLine.Next() = 0;
            end;
        end;
    end;

    procedure CreateRFQ(var IR: Record "Internal Request Header")
    var
        IRHeader: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetFilter("Qty. to Receive", '>%1', 0);
        if IRLine.Find('-') then begin
            PurchSetup.Get();
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."RFQ Nos.", 0D, true);
            IRHeader.Init();
            IRHeader.TransferFields(IR);
            IRHeader."No." := DocNo;
            IRHeader."Document Type" := IR."Document Type"::RFQ;
            IRHeader."Requisition No." := IR."No.";
            IRHeader.Insert();

            repeat
                //insert lines
                IRLine2.Init();
                IRLine2.TransferFields(IRLine);
                IRLine2."Document No." := DocNo;
                IRLine2."Document Type" := IRLine."Document Type"::RFQ;
                IRLine2.Validate(Quantity, IRLine."Qty. to Receive");
                IRLine2."Requisition No." := IR."No.";
                IRLine2.Insert();
            until IRLine.Next() = 0;
            IR."Fully Ordered" := true;
            IR.Modify();
            Message('RFQ %1 has been successfully created', DocNo);
        end;
    end;

    procedure CreateRFQFromSelected()
    var
        IRHeader: Record "Internal Request Header";
        IRHeader2: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        ReqLine: Record "Internal Request Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        LineNo: Integer;
    begin
        IRLine.Reset();
        IRLine.SetRange("Document Type", IRLine."Document Type"::Purchase);
        IRLine.SetRange("Header Status", IRLine."Header Status"::Released);
        IRLine.SetRange(Selected, true);
        IRLine.SetRange("RFQ Created", false);
        IRLine.SetRange("Selected By", UserId);
        IRLine.SetRange(Reversed, false);
        if IRLine.Find('-') then begin
            LineNo := 0;
            PurchSetup.Get();
            PurchSetup.TestField("RFQ Nos.");
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."RFQ Nos.", 0D, true);
            IRHeader.Init();
            //IRHeader.TRANSFERFIELDS(IR);
            IRHeader."No." := DocNo;
            IRHeader."Document Type" := IRHeader."Document Type"::RFQ;
            IRHeader."Document Date" := Today;
            IRHeader."Order Date" := Today;
            IRHeader."Expected Receipt Date" := Today;
            IRHeader."Posting Description" := 'GPR' + ' ' + DocNo;
            IRHeader."Requested By" := UserId;
            //IRHeader."Requisition No.":="No.";
            IRHeader.Insert();

            repeat
                LineNo := LineNo + 10000;
                //insert lines
                IRLine2.Init();
                IRLine2.TransferFields(IRLine);
                IRLine2."Document No." := DocNo;
                IRLine2."Line No." := LineNo;
                IRLine2."Document Type" := IRLine."Document Type"::RFQ;
                //IRLine2.Validate(Quantity,IRLine."Qty. to Receive");
                IRLine2."Requisition No." := IRLine."Document No.";
                IRLine2.Insert();
                Commit();

                //Modify selected records as rfq created
                IRLine."RFQ Created" := true;
                IRLine."RFQ No" := DocNo;
                IRLine.Modify();

                //Check if all lines are selected so as to archive Requisition
                if IRHeader2.Get(IRLine."Document No.") then begin
                    IRHeader2.Archived := true;
                    IRHeader.Modify();

                    ReqLine.Reset();
                    ReqLine.SetRange("Document No.", IRHeader2."No.");
                    ReqLine.SetRange(Selected, false);
                    if not ReqLine.Find('-') then
                        IRHeader2."GPR Created For All Lines" := true
                    else
                        IRHeader2."GPR Created For All Lines" := false;
                    IRHeader2.Modify();
                end;

            until IRLine.Next() = 0;

            Message('GPR %1 has been successfully created', DocNo);
        end else
            Message('You have not selected any items');
    end;


    procedure GetFirstVendor(IR: Record "Internal Request Header") Vendor: Code[30]
    var
        IRLine: Record "Internal Request Line";
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetRange("Document Type", IR."Document Type");
        if IRLine.FindFirst() then begin
            Vendor := IRLine.Supplier;
        end;
    end;

    procedure GetOpenEvaluationPeriod(): Code[20]
    var
        EvalPeriod: Record "Vendor Evaluation Periods";
    begin
        EvalPeriod.Reset();
        EvalPeriod.SetRange(Active, true);
        if EvalPeriod.FindFirst() then
            exit(EvalPeriod.Code)
        else
            Error('Please define an active vendor evaluation period');
    end;

    procedure IndentTenderAmounts(DocNo: Code[20]; Type: Integer)
    var
        TenderAmountLines: Record "Tender Amount";
        i: Integer;
        EndTotalMissingBeginTotalErr: Label 'End-Total %1 is missing a matching Begin-Total.';
    begin
        //Window.OPEN(Text004);
        TenderAmountLines.SetRange("Tender No.", DocNo);
        if TenderAmountLines.Find('-') then
            repeat
                //Window.UPDATE(1,"Line No");

                case TenderAmountLines."Scope Type" of
                    TenderAmountLines."Scope Type"::"Objective Heading",
                  TenderAmountLines."Scope Type"::"Objective Heading End":
                        i := 0;
                    TenderAmountLines."Scope Type"::"Sub-Heading",
                  TenderAmountLines."Scope Type"::"Sub-Heading End":
                        i := 1;
                    TenderAmountLines."Scope Type"::"Scope Parameter":
                        i := 2;
                end;

                if TenderAmountLines."Scope Type" = TenderAmountLines."Scope Type"::"Sub-Heading End" then begin
                    if i < 1 then
                        Error(
                          EndTotalMissingBeginTotalErr,
                          TenderAmountLines."Line No.");
                    //i := i - 1;
                end;

                TenderAmountLines.Indentation := i;
                TenderAmountLines.Modify();

            /*IF "Scope Type" = "Scope Type"::"Sub-Heading" THEN BEGIN
              i := i + 1;
              AccNo[i] := FORMAT("Line No");
            END;*/
            until TenderAmountLines.Next() = 0;

        //Window.CLOSE;

    end;

    procedure IndentTenderScopeOfWork(DocNo: Code[20]; Type: Integer)
    var
        ScopeLines: Record "Tender Scope of Work";
        i: Integer;
        EndTotalMissingBeginTotalErr: Label 'End-Total %1 is missing a matching Begin-Total.';
    begin
        //Window.OPEN(Text004);
        ScopeLines.SetRange("Tender No.", DocNo);
        if ScopeLines.Find('-') then
            repeat
                //Window.UPDATE(1,"Line No");

                case ScopeLines."Scope Type" of
                    ScopeLines."Scope Type"::"Objective Heading",
                  ScopeLines."Scope Type"::"Objective Heading End":
                        i := 0;
                    ScopeLines."Scope Type"::"Sub-Heading",
                  ScopeLines."Scope Type"::"Sub-Heading End":
                        i := 1;
                    ScopeLines."Scope Type"::"Scope Parameter":
                        i := 2;
                end;

                if ScopeLines."Scope Type" = ScopeLines."Scope Type"::"Sub-Heading End" then begin
                    if i < 1 then
                        Error(
                          EndTotalMissingBeginTotalErr,
                          ScopeLines."Line No.");
                    //i := i - 1;
                end;

                ScopeLines.Indentation := i;
                ScopeLines.Modify();

            /*IF "Scope Type" = "Scope Type"::"Sub-Heading" THEN BEGIN
              i := i + 1;
              AccNo[i] := FORMAT("Line No");
            END;*/
            until ScopeLines.Next() = 0;

        //Window.CLOSE;

    end;


    procedure MakeOrder(var IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        IRLine2: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Committement: Codeunit "Commitments Mgt Procurement";
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
        LineNo: Integer;
    begin
        PurchSetup.Get();

        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        IRLine.SetFilter(Supplier, '<>%1', '');
        IRLine.SetFilter(Quantity, '>%1', 0);
        IRLine.SetRange("Document Created", IRLine."Document Created"::" ");
        IRLine.SetRange("LPO/Contract Generated", false);
        //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
        if IRLine.FindSet() then begin
            repeat
                IRLine2.Reset();
                IRLine2.SetRange("Document No.", IR."No.");
                IRLine2.SetRange(IRLine2.Supplier, IRLine.Supplier);
                if IRLine2.FindSet() then begin
                    //IF "Combine Order"=TRUE THEN BEGIN
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init();
                    //PurchHeader.TransferFields(IR);
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."LPO Type" := IR."LPO Type";
                    PurchHeader."Posting Description" := IR."Posting Description";
                    PurchHeader.Status := PurchHeader.Status::Open;
                    IRLine2.TestField(Supplier);
                    PurchHeader.InitRecord();
                    PurchHeader."Buy-from Vendor No." := IRLine2.Supplier;
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Pay-to Vendor No." := IRLine2.Supplier;
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."No.";
                    PurchHeader.Insert();

                    repeat
                        LineNo := LineNo + 10000;
                        //insert lines
                        PurchLine.Init();
                        PurchLine.TransferFields(IRLine2);
                        //PurchLine.Validate("No.");
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine."Document No." := DocNo;
                        PurchLine."Line No." := LineNo;

                        PurchLine.Validate("Buy-from Vendor No.", IRLine2.Supplier);
                        //PurchLine."Pay-to Vendor No." := IRLine2.Supplier;
                        //PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        PurchLine."Quantity Received" := 0;
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Unit Cost" := IRLine2."Unit Cost";
                        PurchLine.Validate("Unit Cost");
                        PurchLine.Amount := IRLine2.Amount;
                        PurchLine."VAT Prod. Posting Group" := IRLine2."VAT Prod. Posting Group";
                        PurchLine.Validate(Amount);
                        PurchLine."Requisition No." := IR."No.";
                        IRLine2.CalcFields(Specification);
                        PurchLine.Specification := IRLine2.Specification;
                        PurchLine.Validate("Shortcut Dimension 1 Code", IRLine2."Shortcut Dimension 1 Code");
                        PurchLine.Insert();

                        //Committement.UncommitPurchReq(IRLine2, IR);
                        //Committement.EncumberPO(PurchLine, PurchHeader);
                        // IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine2."Qty. to Receive";
                        // IRLine2."Qty. to Receive" := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2."Document Created" := IRLine2."Document Created"::LPO;
                        IRLine2."LPO/Contract Generated" := true;
                        IRLine2.Modify();

                    until IRLine2.Next() = 0;
                    Message('LPO No %1 has been created', DocNo);
                end;
            until IRLine.Next() = 0;

            IRLine.Reset();
            IRLine.SetRange("Document No.", IR."No.");
            IRLine.SetRange(LPO, true);
            IRLine.SetRange("Document Created", IRLine."Document Created"::" ");
            if IRLine.Count = 0 then begin
                IR."Fully Ordered" := true; //Mark fully ordered when all LPOs have been created
                IR.Modify();
            end;
        end else
            Message('All purchase request lines have been fulfilled');
        /*
        END ELSE IF "Combine Order"=FALSE THEN
          BEGIN
            DocNo:=NoseriesMgt.GetNextNo(PurchSetup."Order Nos.",0D,TRUE);
            PurchHeader.INIT;
            PurchHeader.TRANSFERFIELDS(IR);
            PurchHeader.VALIDATE("No.");
            PurchHeader."No.":=DocNo;
            PurchHeader."Document Type":=PurchHeader."Document Type"::Order;
            PurchHeader.Status:=PurchHeader.Status::Open;
            PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
            PurchHeader.VALIDATE("Buy-from Vendor No.");
            PurchHeader."Document Date":=TODAY;
            PurchHeader."Requisition No.":="No.";
            PurchHeader.INSERT;
          PurchSetup.GET;
          //insert lines
          PurchLine.INIT;
          PurchLine.TRANSFERFIELDS(IRLine);
          PurchLine."Document No.":=DocNo;
          PurchLine."Document Type":=PurchLine."Document Type"::Order;
          PurchLine."Quantity Received":=0;
          PurchLine.VALIDATE(Quantity,IRLine."Qty. to Receive");
          PurchLine."Requisition No.":="No.";
          PurchLine."Gen. Bus. Posting Group":='GENERAL';
          PurchLine."Gen. Prod. Posting Group":='GENERAL';
    //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
          PurchLine.INSERT;
          Committement.UncommitPurchReq(IRLine,IR);
          Committement.EncumberPO(PurchLine,PurchHeader);
          IRLine."Quantity Received":=IRLine."Quantity Received"+IRLine."Qty. to Receive";
          IRLine."Qty. to Receive":=IRLine.Quantity-IRLine."Quantity Received";
          IRLine.MODIFY;
          MESSAGE('Order No %1 has been created',DocNo);
          END;
        END;*/
        ////IF CheckifFullyordered(IR)=TRUE THEN
    end;

    procedure MakeOrderFromSelected(IRHeader: Record "Internal Request Header"; IRSelected: Boolean)
    var
        IRLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        Committement: Codeunit "Commitments Mgt Procurement";
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[30];
        LineNo: Integer;
    begin
        IRHeader.Reset();
        IRHeader.SetRange(Selected, IRSelected);
        if IRHeader.Find('-') then begin
            PurchSetup.Get();
            DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
            PurchHeader.Init();
            PurchHeader.TransferFields(IRHeader);
            PurchHeader.Validate("No.");
            PurchHeader."No." := DocNo;
            PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
            PurchHeader.Status := PurchHeader.Status::Open;
            PurchHeader."Buy-from Vendor No." := GetFirstVendor(IRHeader);
            PurchHeader.Validate("Buy-from Vendor No.");
            PurchHeader."Document Date" := Today;
            PurchHeader.Insert();
            repeat
                IRLine.Reset();
                IRLine.SetRange("Document No.", IRHeader."No.");
                IRLine.SetFilter("Qty. to Receive", '>%1', 0);
                if IRLine.Find('-') then begin
                    repeat
                        LineNo := LineNo + 10000;
                        PurchLine.Init();
                        PurchLine.TransferFields(IRLine);
                        PurchLine."Document No." := DocNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Quantity Received" := 0;
                        PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                        PurchLine."Gen. Bus. Posting Group" := 'GENERAL';
                        PurchLine."Gen. Prod. Posting Group" := 'GENERAL';
                        PurchLine."VAT Bus. Posting Group" := 'GENERAL';
                        PurchLine."Requisition No." := IRHeader."No.";
                        PurchLine.Insert();
                        Committement.UncommitPurchReq(IRLine, IRHeader);
                        Committement.EncumberPO(PurchLine, PurchHeader);
                        IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                        IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                        IRLine.Modify();
                    until IRLine.Next() = 0;
                end;
                if CheckifFullyordered(IRHeader) = true then begin
                    IRHeader."Fully Ordered" := true;
                    IRHeader.Selected := false;
                    IRHeader.Modify();
                end;
            until IRHeader.Next() = 0;
            Message('Order No %1 has been created', DocNo);
        end;
    end;

    procedure GenerateOrderFromProcurementEvaluation(var IR: Record "Procurement Evaluation Header")
    var
        ProspectiveSuppliers: Record "Prospective Suppliers";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        IRLine: Record "Procurement Evaluation Line";
        IRLine2: Record "Procurement Evaluation Line";
        TenderRec: Record "Procurement Request";
        DocAttachRec: Record "Document Attachment";
        Committement: Codeunit "Commitments Mgt Procurement";
        Item: Record Item;
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocumentAttachment: Codeunit "Document Attachment Custom";
        TempBlob: Codeunit "Temp Blob";
        QuoteFinancialEvaluation: Report "Quote Financial Evaluation";
        TenderFinancialEvaluation: Report "Tender Financial Evaluation";
        AwardAtLeastOneVendorErr: Label 'Please award at least one supplier';
        OrderCreatedSuccessMsg: Label 'Order No %1 has been created';
        DocNo, LPONo : Code[50];
        VendNo: Code[50];
        LineNo: Integer;
        AttachInstream: Instream;
        AttachOutstream: Outstream;
        PurchRecRef: RecordRef;
        FileName: Text;
        IRCopy: Record "Procurement Evaluation Header";
    begin
        IR.TestField("LPO/Contract Generated", false);

        IRLine.Reset();
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        IRLine.SetRange(IRLine.Awarded, true);
        IRLine.SetFilter(IRLine.Quantity, '>%1', 0);
        IRLine.SetRange("LPO/Contract Generated", false);
        if IRLine.FindSet() then begin
            repeat
                PurchSetup.Get();
                IRLine2.Reset();
                IRLine2.SetRange(IRLine2."Document No.", IRLine."Document No.");
                IRLine2.SetRange(IRLine2.Awarded, IRLine.Awarded);
                IRLine2.SetRange(IRLine2."Vendor No", IRLine."Vendor No");
                if IRLine2.FindSet() then begin
                    //Get Vendor No.
                    GetAwardedSupplierVendorNo(IRLine2, VendNo);

                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Order Nos.", 0D, true);
                    PurchHeader.Init();
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Order;
                    PurchHeader."No. Printed" := 0;
                    PurchHeader."Quote No." := IR."No.";
                    PurchHeader.Status := PurchHeader.Status::Open;
                    PurchHeader."Responsibility Center" := IR."Responsibility Centre";
                    PurchHeader.InitRecord();
                    PurchHeader."Buy-from Vendor No." := VendNo;
                    PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."Requisition No";
                    PurchHeader."Posting Date" := Today;
                    PurchHeader."Order Date" := GetQuoteDate(IRLine2."Document No.");
                    PurchHeader."Due Date" := GetQuoteDueDate(IRLine2."Document No.");
                    PurchHeader."Assigned User ID" := UserId;
                    PurchHeader."Document Date" := IR."Creation Date";
                    PurchHeader."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                    PurchHeader."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                    PurchHeader."Dimension Set ID" := IR."Dimension Set ID";
                    PurchHeader."RFQ No." := IR."No.";
                    PurchHeader."Posting Description" := IR.Title;
                    PurchHeader.Validate("Prices Including VAT", true);
                    PurchHeader.Validate("Currency Code", IR."Currency Code");
                    //**************************************************

                    //PurchHeader."Email Sent" := IRLine2
                    PurchHeader.Insert();

                    //Get Attachments from Evaluation
                    DocumentAttachment.CopyAttachmentsFromRec(PurchHeader.RecordId,
                                                              Database::"Procurement Evaluation Header",
                                                              IR."No.",
                                                              PurchHeader."No.",
                                                              Enum::"Attachment Document Type"::Order);

                    //Attach Financial Evaluation Report To LPO
                    case IR."Process Type" of
                        IR."Process Type"::Tender:
                            begin
                                Clear(TenderFinancialEvaluation);

                                IRCopy.SetRange("No.", IR."No.");
                                if IRCopy.FindFirst() then begin
                                    TenderFinancialEvaluation.SetTableView(IRCopy);
                                    TempBlob.CreateOutStream(AttachOutStream);

                                    if TenderFinancialEvaluation.SaveAs('', ReportFormat::Pdf, AttachOutStream) then begin
                                        FileName := StrSubstNo('Financial Evaluation for %1.pdf', IRCopy."No.");
                                        TempBlob.CreateInStream(AttachInstream);
                                        PurchRecRef.Get(PurchHeader.RecordId());
                                        DocAttachRec.SaveAttachmentFromStream(AttachInstream, PurchRecRef, FileName);
                                    end;
                                end;
                            end;
                        else begin
                            Clear(QuoteFinancialEvaluation);

                            IRCopy.SetRange("No.", IR."No.");
                            if IRCopy.FindFirst() then begin
                                QuoteFinancialEvaluation.SetTableView(IRCopy);
                                TempBlob.CreateOutStream(AttachOutStream);

                                if QuoteFinancialEvaluation.SaveAs('', ReportFormat::Pdf, AttachOutStream) then begin
                                    FileName := StrSubstNo('Financial Evaluation for %1.pdf', IRCopy."No.");
                                    TempBlob.CreateInStream(AttachInstream);
                                    PurchRecRef.Get(PurchHeader.RecordId());
                                    DocAttachRec.SaveAttachmentFromStream(AttachInstream, PurchRecRef, FileName);
                                end;
                            end;
                        end;
                    end;

                    repeat
                        //insert lines
                        LineNo := LineNo + 1000;
                        PurchLine.Init();
                        PurchLine."Document No." := DocNo;
                        PurchLine."Line No." := LineNo;
                        PurchLine."Document Type" := PurchLine."Document Type"::Order;
                        PurchLine.Type := IRLine2.Type;
                        PurchLine.Validate(Type);
                        if IRLine2.Type = IRLine2.Type::Item then
                            IRLine2.TestField("Location Code");
                        PurchLine."No." := IRLine2."No.";
                        PurchLine.Validate("No.");
                        PurchLine."Unit of Measure" := IRLine2."Unit of Measure";
                        IRLine2.CalcFields(Specification);
                        PurchLine.Specification := IRLine2.Specification;
                        PurchLine."Location Code" := IRLine2."Location Code";
                        PurchLine."Unit of Measure Code" := IRLine2."Unit of Measure";
                        PurchLine."Quantity Received" := 0;
                        PurchLine.Validate(Quantity, IRLine2.Quantity);
                        PurchLine."Direct Unit Cost" := IRLine2."Unit Amount";
                        PurchLine.Validate("Direct Unit Cost");
                        PurchLine.Validate("Line Amount");
                        PurchLine.Amount := IRLine2.Amount;


                        // Get VAT Prod. Posting Group from Item Card when Type = Item
                        if PurchLine.Type = PurchLine.Type::Item then begin
                            if Item.Get(PurchLine."No.") then
                                PurchLine."VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                        end else
                            PurchLine."VAT Prod. Posting Group" := IRLine2."VAT Code";
                        PurchLine."VAT %" := IRLine2."VAT %";
                        PurchLine.Validate(Amount);
                        PurchLine."Requisition No." := IR."Requisition No";
                        PurchLine."Expected Receipt Date" := IRLine2."Expected Receipt Date";
                        PurchLine."Shortcut Dimension 1 Code" := IR."Shortcut Dimension 1 Code";
                        PurchLine."Shortcut Dimension 2 Code" := IR."Shortcut Dimension 2 Code";
                        PurchLine."Dimension Set ID" := IR."Dimension Set ID";
                        PurchLine.Insert();

                        Committement.UncommitPurchRequestOnCreateLPOAfterEvaluation(IR."No.", IR."Requisition No");
                        //Committement.EncumberPO(PurchLine, PurchHeader);

                        IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                        //IRLine2.Quantity := IRLine2.Quantity - IRLine2."Quantity Received";
                        IRLine2."LPO/Contract Generated" := true;
                        IRLine2.Modify();
                    until IRLine2.Next() = 0;
                end;
                Message(OrderCreatedSuccessMsg, DocNo);
                LPONo := LPONo + ',' + DocNo;
            until IRLine.Next() = 0;

            IR.Validate("LPO/Contract No.", CopyStr(LPONo, 1, MaxStrLen(IR."LPO/Contract No.")));
            IR.Validate("LPO/Contract Generated", true);
            IR.Modify();
        end else
            Error(AwardAtLeastOneVendorErr);
    end;


    procedure MakeQuote(var IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        DocNo: Code[20];
    begin
        IRLine.Reset();
        IRLine.SetRange("Document No.", IR."No.");
        //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
        if IRLine.Find('-') then begin
            PurchSetup.Get();
            if IR."Combine Order" then begin
                DocNo := NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.", 0D, true);
                PurchHeader.Init();
                PurchHeader.TransferFields(IR);
                PurchHeader."Document Type" := PurchHeader."Document Type"::Quote;
                PurchHeader."No." := DocNo;
                PurchHeader.Status := PurchHeader.Status::Open;
                PurchHeader."Buy-from Vendor No." := IRLine.Supplier;
                PurchHeader.Validate("Buy-from Vendor No.");
                PurchHeader."Document Date" := Today;
                PurchHeader."Requisition No." := IR."No.";
                PurchHeader.Insert();
                repeat
                    PurchSetup.Get();
                    //insert lines
                    PurchLine.Init();
                    PurchLine.TransferFields(IRLine);
                    PurchLine."Document No." := DocNo;
                    PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                    PurchLine."Quantity Received" := 0;
                    PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                    PurchLine."Requisition No." := IR."No.";
                    //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                    //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                    //      PurchLine."VAT Bus. Posting Group":='GENERAL';
                    //PurchLine.Validate(Type);
                    //PurchLine.Validate("No.");
                    PurchLine.Insert();

                    //      Committement.UncommitPurchReq(IRLine,IR);
                    //      Committement.EncumberPO(PurchLine,PurchHeader);
                    IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                    IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                    //IRLine.Modify;
                    Message('Quote No %1 has been created', DocNo);
                until IRLine.Next() = 0;
            end else
                if IR."Combine Order" = false then begin
                    DocNo := NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.", 0D, true);
                    PurchHeader.Init();
                    PurchHeader.TransferFields(IR);
                    PurchHeader.Validate("No.");
                    PurchHeader."No." := DocNo;
                    PurchHeader."Document Type" := PurchHeader."Document Type"::Quote;
                    PurchHeader.Status := PurchHeader.Status::Open;
                    //PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
                    //PurchHeader.Validate("Buy-from Vendor No.");
                    PurchHeader."Document Date" := Today;
                    PurchHeader."Requisition No." := IR."No.";
                    PurchHeader.Insert();
                    PurchSetup.Get();
                    //insert lines
                    PurchLine.Init();
                    PurchLine.TransferFields(IRLine);
                    PurchLine.Validate(Type);
                    PurchLine.Validate("No.");
                    PurchLine."Document No." := DocNo;
                    PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                    PurchLine."Quantity Received" := 0;
                    PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                    PurchLine."Requisition No." := IR."No.";
                    //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                    //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                    //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
                    PurchLine.Insert();
                    //      Committement.UncommitPurchReq(IRLine,IR);
                    //      Committement.EncumberPO(PurchLine,PurchHeader);
                    IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                    IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                    //IRLine.Modify;
                    Message('Quote No %1 has been created', DocNo);
                end;
        end;
        //    IF CheckifFullyordered(IR)=TRUE THEN
        //      IR."Fully Ordered":=TRUE;
        //      IR.Modify;
    end;

    procedure MakeSalesOrderOnFADisposal(var FADisposal: Record "FA Disposal")
    var
        FADisposalBids, FADisposalBids2 : Record "Procurement Request Lines";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesOrder: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
    begin
        SalesSetup.Get();
        FADisposalBids.Reset();
        FADisposalBids.SetRange("FA Disposal Doc No.", FADisposal."No.");
        if FADisposalBids.Find('-') then begin
            FADisposalBids2.Reset();
            FADisposalBids2.SetRange("FA Disposal Doc No.", FADisposal."No.");
            FADisposalBids2.SetRange(Awarded, true);
            FADisposalBids2.SetRange("Staff No.", FADisposalBids."Staff No.");
            FADisposalBids2.SetRange("Sales Order Created", false);
            if FADisposalBids2.Find('-') then begin
                //Insert Sales Header
                SalesOrder.Init();
                SalesOrder."Document Type" := SalesOrder."Document Type"::Order;
                SalesOrder.Validate("Sell-to Customer No.", GetStaffCustNo(FADisposalBids2."Staff No."));
                SalesOrder.Validate("Document Date", Today);
                SalesOrder.Insert(true);

                //Insert Sales Line
                repeat
                    LineNo := LineNo + 10000;
                    SalesLine.Init();
                    SalesLine."Document Type" := SalesLine."Document Type"::Order;
                    SalesLine."Document No." := SalesOrder."No.";
                    SalesLine."Line No." := LineNo;
                    SalesLine.Type := FADisposalBids2.Type;
                    SalesLine.Validate("No.", FADisposalBids2.No);
                    SalesLine.Validate("Sell-to Customer No.", GetStaffCustNo(FADisposalBids2."Staff No."));
                    SalesLine.Quantity := FADisposalBids2.Quantity;
                    SalesLine.Validate("Unit Cost", FADisposalBids2."Unit Price");
                    SalesLine.Validate("Unit Price", FADisposalBids2."Unit Price");
                    SalesLine.Validate(Amount, FADisposalBids2.Amount);
                    SalesLine.Insert();

                    FADisposalBids2."Sales Order Created" := true;
                    FADisposalBids2.Modify();

                until FADisposalBids2.Next() = 0;

                Message('Sales Order %1 created successfully', SalesOrder."No.");

                FADisposal.Fullfilled := true;
                FADisposal.Modify();
            end else
                Message('All Orders Have been fullfilled');
        end;

    end;

    procedure NotifyRFQSuppliers(RFQNo: Code[20])
    var
        CompanyInformation: Record "Company Information";
        DocAttachment: Record "Document Attachment";
        ProqRequest: Record "Procurement Request";
        PurchSetup: Record "Purchases & Payables Setup";
        SupplierSelection: Record "Supplier Selection";
        SupplierSelection2: Record "Supplier Selection";
        RepFormat: ReportFormat;
        RFQ: Report RFQ;
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        TempBlobArray: array[10] of Codeunit "Temp Blob";
        EmailBodyBigText: BigText;
        AttachInstr, Instr : InStream;
        DocAttachInstream: array[10] of InStream;
        i: Integer;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached a Request For Quotation for <strong>%4<strong>.</p><p style="font-family:Verdana,Arial;font-size:9pt">RFQ reference number is <b>%2</b>.</p><p style="font-family:Verdana,Arial;font-size:9pt">You are required to log in to the E-Procurement Potal <a href="http://192.168.88.187:4050/">Link</a> to submit your application.</p><p style="font-family:Verdana,Arial;font-size:9pt">Kind Regards,<br>Procurement Office</p><p style="font-family:Verdana,Arial;font-size:9pt">%3</p>';
        Recipient: List of [Text];
        AttachOutstr: OutStream;
        DocAttachOutStream: array[10] of OutStream;
        Base64Txt: Text;
        DocAttachFileName, FullFileName : Text;
        EmailBodyText: Text;
        FileName: Text;
        HtmlBody: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
    begin
        CompanyInformation.Get();
        CompanyInformation.TestField(Name);
        CompanyInformation.TestField("E-Mail");

        PurchSetup.Get();
        PurchSetup.TestField("RFQ Path");

        SenderName := CompanyInformation.Name;
        SenderAddress := CompanyInformation."E-Mail";

        if ProqRequest.Get(RFQNo) then begin
            if ProqRequest."Specify Body" then begin
                ProqRequest.TestField("E-Mail Subject");

                ProqRequest.CalcFields("E-Mail Body Text");
                if not ProqRequest."E-Mail Body Text".HasValue then
                    Error('Please define an E-Mail body');

                Subject := ProqRequest."E-Mail Subject";
                ProqRequest."E-Mail Body Text".CreateInStream(Instr);
                EmailBodyBigText.Read(Instr);
                EmailBodyText := Format(EmailBodyBigText);
            end else
                Subject := StrSubstNo('Request For Quotation %1 - %2', ProqRequest."No.", ProqRequest.Title);

            SupplierSelection.Reset();
            SupplierSelection.SetRange("Reference No.", RFQNo);
            SupplierSelection.SetRange(Invited, true);
            SupplierSelection.SetRange(Notified, false);
            if SupplierSelection.Findset() then begin
                repeat
                    //Mail
                    FileName := SupplierSelection."Supplier Name" + '_' + RFQNo + '.pdf';
                    FullFileName := PurchSetup."RFQ Path" + RFQNo + '_' + SupplierSelection."Supplier Code" + '.pdf';

                    Clear(Recipient);
                    SupplierSelection.TestField("Supplier Email");
                    Recipient.Add(SupplierSelection."Supplier Email");

                    if ProqRequest."Specify Body" then
                        EmailMessage.Create(Recipient, Subject, EmailBodyText, false)
                    else begin
                        HtmlBody := StrSubstNo(NewBody, SupplierSelection."Supplier Name", RFQNo, CompanyInformation.Name, ProqRequest.Title);
                        EmailMessage.Create(Recipient, Subject, HtmlBody, true);
                    end;

                    //Attach RFQ
                    SupplierSelection2.Copy(SupplierSelection);
                    SupplierSelection2.SetRange(SupplierSelection2."Supplier Code", SupplierSelection."Supplier Code");
                    if SupplierSelection2.FindFirst() then begin
                        Clear(RFQ);
                        RFQ.SetTableView(SupplierSelection2);
                        TempBlob.CreateOutStream(AttachOutstr);
                        if RFQ.SaveAs('', RepFormat::Pdf, AttachOutstr) then begin
                            TempBlob.CreateInStream(AttachInstr);
                            Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                            EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
                        end;
                    end;

                    //Add other attachments
                    i := 1;

                    DocAttachment.Reset();
                    DocAttachment.SetRange("Table ID", Database::"Procurement Request");
                    DocAttachment.SetRange("No.", ProqRequest."No.");
                    if DocAttachment.FindSet() then begin
                        repeat
                            if DocAttachment."Document Reference ID".HasValue then begin
                                TempBlobArray[i].CreateOutStream(DocAttachOutStream[i]);
                                TempBlobArray[i].CreateInStream(DocAttachInstream[i]);

                                DocAttachFileName := DocAttachment."File Name" + '.' + DocAttachment."File Extension";
                                if DocAttachment."Document Reference ID".ExportStream(DocAttachOutStream[i]) then
                                    EmailMessage.AddAttachment(DocAttachFileName, 'application/pdf', DocAttachInstream[i]);
                                i += 1;
                            end;
                        until DocAttachment.Next() = 0;
                    end;

                    Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);

                    /*//Add other attachments on Record Link
                    RecordLink.Reset;
                    RecordLink.SetRange("Record ID", ProqRequest.RecordId);
                    if RecordLink.Find('-') then begin
                        i := 1;
                        repeat
                            AdditionalFilename[i] := RecordLink.URL1;
                            SMTP.AddAttachment(AdditionalFilename[i], AdditionalAttachments[i]);
                            i := i + 1;
                        until RecordLink.Next = 0;
                    end;*/

                    SupplierSelection.Notified := true;
                    SupplierSelection.Modify();
                until SupplierSelection.Next() = 0;
                Message('Selected suppliers have been successfully notified');
            end;

            ProqRequest.Validate(Status, ProqRequest.Status::Issued);
            ProqRequest.Modify();
        end;
    end;


    procedure PostInternalRequest(IR: Record "Internal Request Header")
    begin
        PostStockItem(IR);
    end;


    /* procedure PostJobItem(IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        JobJnlLine: Record "Job Journal Line";
        JobLedgerEntry: Record "Job Ledger Entry";
        UserPosting: Record "User Posting Template";
        QuantitynotIssued: Decimal;
        TotalQuantitynotIssued: Decimal;
        "Line No": Integer;
        Text002: Label 'Quantity to issue exceeds quantity requested for Item No %1';
        Text003: Label 'IR %1 Posted Successfully';
    begin
        UserPosting.Get(UserId);
        UserPosting.TestField("Job Journal Template");
        UserPosting.TestField("Job Journal Batch");
        JobJnlLine.Reset();
        JobJnlLine.SetRange("Journal Template Name", UserPosting."Job Journal Template");
        JobJnlLine.SetRange("Journal Batch Name", UserPosting."Job Journal Batch");
        JobJnlLine.DeleteAll();
        if JobJnlLine.FindLast() then
            "Line No" := JobJnlLine."Line No." + 1000;
        IRLine.Reset();
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then
            repeat
                "Line No" := "Line No" + 1000;
                JobJnlLine.Init();
                JobJnlLine."Journal Template Name" := UserPosting."Job Journal Template";
                JobJnlLine.Validate("Journal Template Name");
                JobJnlLine."Journal Batch Name" := UserPosting."Job Journal Batch";
                JobJnlLine.Validate("Journal Batch Name");
                JobJnlLine."Document No." := IR."No.";
                JobJnlLine."Line No." := "Line No";
                JobJnlLine."Posting Date" := IR."Posting Date";
                JobJnlLine.Validate("Posting Date");
                JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Usage;
                JobJnlLine.Type := JobJnlLine.Type::Item;
                JobJnlLine."No." := IRLine."No.";
                JobJnlLine.Validate("No.");
                JobJnlLine.Quantity := IRLine."Qty. to Issue";
                JobJnlLine.Validate(Quantity);
                JobJnlLine.Description := IRLine.Description;
                JobJnlLine.Validate(Description);
                JobJnlLine."Shortcut Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                JobJnlLine.Validate("Shortcut Dimension 1 Code");
                JobJnlLine."Shortcut Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                JobJnlLine.Validate("Shortcut Dimension 2 Code");
                JobJnlLine.ValidateShortcutDimCode(3, IRLine."Shortcut Dimension 3 Code");
                if IRLine."Qty. to Issue" > 0 then
                    JobJnlLine.Insert(true);
                QuantitynotIssued := IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                TotalQuantitynotIssued += IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                if QuantitynotIssued < 0 then
                    Error(Text002, IRLine."No.");
            until IRLine.Next() = 0;
        JobJnlLine.Reset();
        JobJnlLine.SetRange("Journal Template Name", UserPosting."Job Journal Template");
        JobJnlLine.SetRange("Journal Batch Name", UserPosting."Job Journal Batch");
        JobJnlLine.SetRange("Document No.", IR."No.");
        Codeunit.Run(Codeunit::"Job Jnl.-Post", JobJnlLine);
        JobLedgerEntry.Reset();
        JobLedgerEntry.SetRange("Document No.", IR."No.");
        JobLedgerEntry.SetRange("Posting Date", IR."Posting Date");
        if JobLedgerEntry.FindSet() then begin
            if TotalQuantitynotIssued <= 0 then begin
                IR.Posted := true;
                IR."Completely Received" := true;
            end else
                IR."Partially Posted" := true;
            IR."Doc. No. Occurrence" := IR."Doc. No. Occurrence" + 1;
            IR."Date Posted" := Today;
            IR."Time Posted" := Time;
            IR."Posted By" := UserId;
            if IR.Modify(true) then begin
                IRLine.Reset();
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.FindSet() then begin
                    IRLine."Quantity Issued" := IRLine."Qty. to Issue";
                    IRLine."Quantity Received" := IRLine."Qty. to Issue";
                    IRLine.Posted := true;
                    IRLine.Modify(true);
                end;
            end;
            Message(Text003, IR."No.");
        end;
    end; */


    procedure PostStockItem(IR: Record "Internal Request Header")
    var
        IRLine: Record "Internal Request Line";
        Item: Record Item;
        Batch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Committment: Codeunit "Commitments Mgt Procurement";
        QuantitynotIssued: Decimal;
        TotalQuantitynotIssued: Decimal;
        "Line No": Integer;
        Text002: Label 'Quantity to issue exceeds quantity requested for Item No %1';
        Text003: Label 'IR %1 Posted Successfully';
    begin
        //UserPosting.GET(USERID);
        // UserPosting.TESTFIELD("Item Journal Template");
        // UserPosting.TESTFIELD("Item Journal Batch")

        IR.TestField(Status, IR.Status::Released);
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'ITEM');//UserPosting."Item Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT');//UserPosting."Item Journal Batch");
        ItemJnlLine.DeleteAll();

        //Insert Default Batch
        Batch.Init();
        Batch."Journal Template Name" := 'ITEM';
        Batch.Name := 'DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name) then
            Batch.Insert();

        if ItemJnlLine.FindLast() then
            "Line No" := ItemJnlLine."Line No." + 1000;
        IRLine.Reset();
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then begin
            repeat
                if ((IRLine.Quantity = 0) and (IRLine."Qty. to Issue" = 0)) then
                    Error('Both Quantity Requested and Quantity to issue can not be 0');
                //Check Availability
                IRLine.CalcFields("Quantity In Stock");
                if IRLine."Qty. to Issue" > IRLine."Quantity In Stock" then
                    Error('Requested Quantity %1 of Item %2 is less than the actual Quantity in Stock of %3 in %4 Store', IRLine.Quantity,
                            IRLine."No.", IRLine."Quantity In Stock", IR."Location Code");
            until IRLine.Next() = 0;
        end;
        IRLine.Reset();
        IRLine.SetRange("Document Type", IRLine."Document Type"::Stock);
        IRLine.SetRange("Document No.", IR."No.");
        if IRLine.Find('-') then
            repeat
                "Line No" := "Line No" + 1000;
                Item.Get(IRLine."No.");
                ItemJnlLine.Init();
                ItemJnlLine."Journal Template Name" := 'ITEM';//UserPosting."Item Journal Template";
                ItemJnlLine.Validate("Journal Template Name");
                ItemJnlLine."Journal Batch Name" := 'DEFAULT';//UserPosting."Item Journal Batch";
                ItemJnlLine.Validate("Journal Batch Name");
                ItemJnlLine."Document No." := IR."No.";
                ItemJnlLine."Line No." := "Line No";
                ItemJnlLine."Posting Date" := Today;//IR."Posting Date";
                ItemJnlLine.Validate("Posting Date");
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Item No." := IRLine."No.";
                ItemJnlLine.Validate("Item No.");
                ItemJnlLine.Quantity := IRLine."Qty. to Issue";
                ItemJnlLine.Validate(Quantity);
                ItemJnlLine.Description := IRLine.Description;
                ItemJnlLine.Validate(Description);
                ItemJnlLine."Location Code" := IRLine."Location Code";
                ItemJnlLine.Validate("Location Code");
                ItemJnlLine."Shortcut Dimension 1 Code" := IRLine."Shortcut Dimension 1 Code";
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine."Shortcut Dimension 2 Code" := IRLine."Shortcut Dimension 2 Code";
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.ValidateShortcutDimCode(3, IRLine."Shortcut Dimension 3 Code");
                ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                if IRLine."Qty. to Issue" > 0 then
                    ItemJnlLine.Insert(true);
                QuantitynotIssued := IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                TotalQuantitynotIssued += IRLine.Quantity - (IRLine."Qty. to Issue" + IRLine."Quantity Issued");
                if QuantitynotIssued < 0 then
                    Error(Text002, IRLine."No.");
            until IRLine.Next() = 0;

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'ITEM');//UserPosting."Item Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", 'DEFAULT');//UserPosting."Item Journal Batch");
        ItemJnlLine.SetRange("Document No.", IR."No.");
        Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlLine);

        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange("Document No.", IR."No.");
        ItemLedgerEntry.SetRange("Posting Date", Today);
        if ItemLedgerEntry.FindSet() then begin
            if TotalQuantitynotIssued <= 0 then begin
                IR.Posted := true;
                IR."Completely Received" := true;
            end else
                IR.Posted := true;
            IR."Partially Posted" := true;

            IR."Doc. No. Occurrence" := IR."Doc. No. Occurrence" + 1;
            IR."Date Posted" := Today;
            IR."Posting Date" := Today;
            IR."Time Posted" := Time;
            IR."Posted By" := UserId;
            if IR.Modify(true) then begin
                IRLine.Reset();
                IRLine.SetRange("Document No.", IR."No.");
                if IRLine.FindSet() then begin
                    repeat
                        IRLine."Quantity Issued" := IRLine."Qty. to Issue";
                        IRLine."Quantity Received" := IRLine."Qty. to Issue";
                        IRLine.Posted := true;
                        IRLine.Modify(true);
                    until IRLine.Next() = 0;
                    Committment.UncommitStoreReq(IR);
                end;
            end;
            Message(Text003, IR."No.");
        end;
        Commit();
    end;


    procedure ReverseGPRDocument(var RecIRHeader: Record "Internal Request Header")
    var
        IRHeader: Record "Internal Request Header";
        IRLine: Record "Internal Request Line";
        IRLineReqNo: Code[20];
        Text005: Label 'The %1 has been sucessfully Reversed';
    begin
        //Error('WORK IN PROGRESS');
        //Begin Modify GPR Created
        IRLine.Reset();
        IRLine.SetCurrentKey("No.", "Requisition No.");
        IRLine.SetRange("Document No.", RecIRHeader."No.");
        IRLine.SetRange("Document Type", IRLine."Document Type"::RFQ);
        if IRLine.Find('-') then begin
            repeat
                IRLineReqNo := IRLine."Requisition No.";
                IRLine.Reversed := true;
                IRLine."Reversed GPR No." := RecIRHeader."No.";
                ReverseIRLines(IRLine."No.", IRLineReqNo, IRLine."Document Type"::Purchase);
                IRLine.Modify();
            until IRLine.Next() = 0;
        end;
        //Modify The Header Reversed
        IRHeader.Reset();
        IRHeader.SetRange("No.", RecIRHeader."No.");
        if IRHeader.FindFirst() then begin
            IRHeader.Init();
            IRHeader.Status := IRHeader.Status::Reversed;
            IRHeader.Reversed := true;
            IRHeader."Reversed By" := UserId;
            IRHeader.Modify();
        end;
        Message(Text005, RecIRHeader."No.");
    end;


    procedure ReverseIRLines("DocumentNo.": Code[20]; ReqNo: Code[20]; DocumentType: Option Stock,Purchase,CAPEX,"Return Order",RFQ)
    var
        IRLine2: Record "Internal Request Line";
    begin
        //Modify Corresponding IRLine Entry
        IRLine2.Reset();
        IRLine2.SetRange(IRLine2."No.", "DocumentNo.");
        IRLine2.SetRange(IRLine2."Document No.", ReqNo);
        if IRLine2.Find('-') then begin
            IRLine2."RFQ Created" := false;
            IRLine2.Selected := false;
            IRLine2."RFQ No" := '';
            IRLine2."Selected By" := '';
            IRLine2."Cleared For Rfq" := false;
            IRLine2.Modify();
        end;
        //End of Modification of Corresponding IRLine Entry
    end;

    procedure SendProspectiveSupplierForEvaluation(ProspectiveRec: Record "Prospective Suppliers")
    var
        CommitteeMembers: Record "Committee Member";
        TenderDocs: Record "Document required";
        TenderRec: Record "Procurement Request";
        TendersApplied: Record "Prospective Supplier Tender";
        SupplierEvalDocs: Record "Supplier Evaluation Document";
        SupplierEval: Record "Supplier Evaluation Header";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        TenderCommittee: Record "Tender Committees";
        ScoreDescBigTxt: BigText;
        Instrm: InStream;
        SetupTenderDocsErr: Label 'Please setup Documents Required for Tender No. %1';
        SupplierMovedToEvaluationMsg: Label 'Supplier %1 has been sent for evaluation successfully';
        TenderCommitteeNotExistErr: Label 'There is no approved tender committee for Tender No. %1 in Tender Committees Setup';
    begin
        //ProspectiveRec.TestField("Tender No.");
        TendersApplied.Reset();
        TendersApplied.SetRange("Prospect No.", ProspectiveRec."No.");
        TendersApplied.SetRange("Sent for Evaluation", false);
        if TendersApplied.Find('-') then begin
            repeat
                TenderCommittee.Reset();
                TenderCommittee.SetRange("Tender/Quotation No", TendersApplied."Tender No.");
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                if not TenderCommittee.FindFirst() then
                    Error(TenderCommitteeNotExistErr, TendersApplied."Tender No.")
                else begin
                    //Create evaluation for each committee member
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetRange(Type, CommitteeMembers.Type::Employee);
                    CommitteeMembers.SetFilter("Committee Member Type", '%1|%2', CommitteeMembers."Committee Member Type"::"Evaluation Member", CommitteeMembers."Committee Member Type"::"Opening & Evaluation Member");
                    if CommitteeMembers.FindSet() then
                        repeat
                            //Insert header
                            SupplierEval.Init();
                            SupplierEval."No." := '';
                            SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                            SupplierEval.Validate("Quote No");
                            SupplierEval.Type := SupplierEval.Type::Tender;
                            SupplierEval.User := CommitteeMembers."User ID";
                            SupplierEval."Supplier Code" := ProspectiveRec."No.";
                            SupplierEval.Validate("Supplier Code");
                            SupplierEval."Committee No." := TenderCommittee."Appointment No";
                            SupplierEval.Insert(true);

                            //Insert Documents
                            if TenderRec.Get(TenderCommittee."Tender/Quotation No") then begin
                                TenderDocs.Reset();
                                TenderDocs.SetRange("Quote No", TenderRec."No.");
                                if TenderDocs.Find('-') then begin
                                    repeat
                                        SupplierEvalDocs.Init();
                                        SupplierEvalDocs."Quote No." := SupplierEval."No.";
                                        SupplierEvalDocs."Document Code" := TenderDocs."Document Code";
                                        SupplierEvalDocs."Document Name" := TenderDocs."Document Name";
                                        SupplierEvalDocs.Mandatory := TenderDocs.Mandatory;
                                        SupplierEvalDocs."Supplier Code" := ProspectiveRec."No.";
                                        SupplierEvalDocs.Insert();
                                    until TenderDocs.Next() = 0;
                                end else
                                    Error(SetupTenderDocsErr, TenderRec."No.");

                                //Insert Scores
                                ScoreSetup.Reset();
                                ScoreSetup.SetRange(Active, true);
                                ScoreSetup.SetRange(Type, ScoreSetup.Type::Tender);
                                if ScoreSetup.Find('-') then begin
                                    repeat
                                        Scores.Init();
                                        Scores."Document No." := SupplierEval."No.";
                                        Scores."Supplier Code" := ProspectiveRec."No.";
                                        Scores."Score Parameter" := ScoreSetup.Code;
                                        Scores."Score Description" := ScoreSetup."Evaluation Description";
                                        Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                        Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                        ScoreSetup.CalcFields(Description);
                                        ScoreSetup.Description.CreateInStream(Instrm);
                                        ScoreDescBigTxt.Read(Instrm);
                                        Scores.Description := ScoreSetup.Description;
                                        Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                        Scores.Insert();

                                        //Insert Lines
                                        ScoreSetupLine.Reset();
                                        ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                        if ScoreSetupLine.Find('-') then begin
                                            repeat
                                                ScoreLines.Init();
                                                ScoreLines."Document No." := SupplierEval."No.";
                                                ScoreLines."Supplier Code" := ProspectiveRec."No.";
                                                ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                ScoreSetupLine.CalcFields(Description);
                                                ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                ScoreLines.Insert();
                                            until ScoreSetupLine.Next() = 0;
                                        end;

                                    until ScoreSetup.Next() = 0;
                                end else
                                    Error('');
                            end;
                        until CommitteeMembers.Next() = 0;

                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;

            until TendersApplied.Next() = 0;
        end;

        ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
        ProspectiveRec."Pre Qualified" := true;
        ProspectiveRec.Modify();

        Message(SupplierMovedToEvaluationMsg, ProspectiveRec.Name);

    end;

    procedure SendVendorForEvaluation(Vendor: Record Vendor)
    var
        SupplierEval: Record "Supplier Evaluation Header";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        EvaluationLine: Record "Vendor Evaluation Line";
        ScoreSetupLine: Record "Vendor Evaluation Setup Line";
        SupplierMovedToEvaluationMsg: Label 'Supplier %1 has been sent for evaluation successfully';
    begin
        //Insert header
        SupplierEval.Init();
        SupplierEval."No." := '';
        SupplierEval.Type := SupplierEval.Type::Existing;
        SupplierEval."Supplier Code" := Vendor."No.";
        SupplierEval.Validate("Supplier Code");
        SupplierEval.Period := GetOpenEvaluationPeriod();
        SupplierEval.Insert(true);
        //Insert Scores
        ScoreSetup.Reset();
        ScoreSetup.SetRange(Active, true);
        ScoreSetup.SetRange(Type, ScoreSetup.Type::Existing);
        if ScoreSetup.Find('-') then begin
            repeat
                //Insert Lines
                ScoreSetupLine.Reset();
                ScoreSetupLine.SetRange(HeaderCode, ScoreSetup.Code);
                if ScoreSetupLine.Find('-') then begin
                    repeat

                        EvaluationLine.Init();
                        EvaluationLine.No := SupplierEval."No.";
                        EvaluationLine.Supplier := Vendor."No.";
                        ScoreSetupLine.CalcFields(Description);
                        EvaluationLine."Evaluation Type" := ScoreSetup.Code;
                        EvaluationLine."Evaluation Line" := ScoreSetupLine.Code;
                        EvaluationLine.Validate("Evaluation Line");
                        EvaluationLine."Max Score" := ScoreSetupLine."Maximum Score";
                        EvaluationLine.Insert();
                    until ScoreSetupLine.Next() = 0;
                end;
            until ScoreSetup.Next() = 0;
        end else
            Error('');
        Message(SupplierMovedToEvaluationMsg, Vendor.Name);
    end;


    procedure TransferItem(ItemNo: Code[20]; TransferNo: Code[20]; CompanyGoingTo: Text[250]; CompanyComingFrom: Text; Qty: Decimal; LocationTo: Code[20]; LocationFrom: Code[20]; ItemTo: Code[20])
    var
        ItemJnlLine: Record "Item Journal Line";
        PurchSetup: Record "Purchases & Payables Setup";
        LineNo: Integer;
    begin
        PurchSetup.Reset();
        PurchSetup.Get();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", PurchSetup."Item Transfer Journal Template");
        ItemJnlLine.SetRange("Journal Batch Name", PurchSetup."Item Transfer Journal Batch");
        ItemJnlLine.DeleteAll();

        //Transfer From College

        LineNo := 0;
        ItemJnlLine.Init();
        LineNo := LineNo + 1000;
        ItemJnlLine."Journal Template Name" := PurchSetup."Item Transfer Journal Template";
        ItemJnlLine."Journal Batch Name" := PurchSetup."Item Transfer Journal Batch";
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine."Posting Date" := Today;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
        ItemJnlLine."Document No." := TransferNo;
        ItemJnlLine.Description := CompanyGoingTo + ':' + TransferNo + ':' + ItemNo;
        ItemJnlLine."Item No." := ItemNo;
        ItemJnlLine.Validate("Item No.");
        ItemJnlLine."Location Code" := LocationFrom;
        ItemJnlLine.Validate("Location Code");
        ItemJnlLine.Quantity := Qty;
        ItemJnlLine.Validate(Quantity);
        ItemJnlLine.Insert();
        Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);

        ItemJnlLine.Init();
        LineNo := LineNo + 1000;
        ItemJnlLine."Journal Template Name" := PurchSetup."Item Transfer Journal Template";
        ItemJnlLine."Journal Batch Name" := PurchSetup."Item Transfer Journal Batch";
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine."Posting Date" := Today;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Positive Adjmt.";
        ItemJnlLine."Document No." := TransferNo;
        ItemJnlLine.Description := CompanyGoingTo + ':' + TransferNo + ':' + ItemNo;
        ItemJnlLine."Item No." := ItemNo;
        ItemJnlLine.Validate("Item No.");
        ItemJnlLine."Location Code" := LocationTo;
        ItemJnlLine.Validate("Location Code");
        ItemJnlLine.Quantity := Qty;
        ItemJnlLine.Validate(Quantity);
        ItemJnlLine.Insert();
        Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);

        /* //Transfer To Hotel
        ItemJnlLine2.ChangeCompany(CompanyGoingTo);
        //PurchSetup2.CHANGECOMPANY(CompanyGoingTo);

        //ItemJnlLine2.RESET;
        ItemJnlLine2.SetRange("Journal Template Name", PurchSetup2."Item Transfer Journal Template");
        ItemJnlLine2.SetRange("Journal Batch Name", PurchSetup2."Item Transfer Journal Batch");
        //IF ItemJnlLine2.FIND('-') THEN
        ItemJnlLine2.DeleteAll();

        ItemJnlLine2.Init();
        ItemJnlLine2."Line No." := LineNo + 1000;
        ItemJnlLine2."Journal Template Name" := PurchSetup2."Item Transfer Journal Template";
        ItemJnlLine2."Journal Batch Name" := PurchSetup2."Item Transfer Journal Batch";
        ItemJnlLine2."Posting Date" := Today;
        ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
        ItemJnlLine2."Document No." := TransferNo;
        ItemJnlLine.Description := CompanyComingFrom + ':' + TransferNo + ':' + ItemNo;
        ItemJnlLine2."Item No." := ItemTo;
        ItemJnlLine2.Validate("Item No.");
        ItemJnlLine2."Location Code" := LocationTo;
        ItemJnlLine2.Validate("Location Code");
        ItemJnlLine2.Quantity := Qty;
        ItemJnlLine2.Validate(Quantity);
        ItemJnlLine2.Insert();
        ItemJnlLine2.Post(); */
    end;

    local procedure CheckifFullyordered(var IR: Record "Internal Request Header") FullyOrdered: Boolean
    var
        IRLines: Record "Internal Request Line";
    begin
        IRLines.Reset();
        IRLines.SetRange("Document Type", IR."Document Type");
        IRLines.SetRange("Document No.", IR."No.");
        if IRLines.FindFirst() then begin
            IRLines.CalcSums(Quantity);
            IRLines.CalcSums("Quantity Received");
            if IRLines.Quantity = IRLines."Quantity Received" then
                FullyOrdered := true;
        end;
    end;

    local procedure GetLineNo(DocNo: Code[20]): Integer
    var
        PurchaseLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", DocNo);
        if PurchaseLine.FindLast() then
            LineNo := LineNo + 1000
        else
            LineNo := 1000;
    end;

    local procedure GetQuoteDate(QuoteNo: Code[20]): Date
    var
        ProcurementRequest: Record "Procurement Request";
    begin
        ProcurementRequest.Reset();
        ProcurementRequest.SetRange("No.", QuoteNo);
        if ProcurementRequest.FindFirst() then
            exit(ProcurementRequest."Creation Date");
    end;

    local procedure GetQuoteDueDate(QuoteNo: Code[20]): Date
    var
        ProcurementRequest: Record "Procurement Request";
    begin
        ProcurementRequest.Reset();
        ProcurementRequest.SetRange("No.", QuoteNo);
        if ProcurementRequest.FindFirst() then
            exit(ProcurementRequest."Quotation Deadline");
    end;

    local procedure GetStaffCustNo(StaffNo: Code[50]): Code[50]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("Employee No.", StaffNo);
        if UserSetup.FindFirst() then begin
            UserSetup.TestField("Customer No.");
            exit(UserSetup."Customer No.");
        end else
            Error('Please set up Staff No. %1 in User Setup', StaffNo);

    end;

    local procedure InsertToFinancialSuppliers(var SupplierEvaluationHeader: Record "Supplier Evaluation Header")
    var
        BidderSelection: Record "Supplier Selection";
        TenderApplicant: Record "Tender Applicant";
    begin
        TenderApplicant.Reset();
        TenderApplicant.SetRange("Tender No.", SupplierEvaluationHeader."Quote No");
        TenderApplicant.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
        //TenderApplicant.SetRange("Tender Applicant Stage", TenderApplicant."Tender Applicant Stage"::"Technical Evaluation");
        if TenderApplicant.FindFirst() then begin
            BidderSelection.Init();
            BidderSelection."Reference No." := TenderApplicant."Tender No.";
            BidderSelection."Supplier Category" := TenderApplicant."Supplier Category";
            BidderSelection.Validate("Supplier Code", TenderApplicant."Supplier Code");
            BidderSelection.Validate(Invited, true);
            if not BidderSelection.Get(TenderApplicant."Tender No.", TenderApplicant."Supplier Code") then
                BidderSelection.Insert();
        end;
    end;

    local procedure CheckForActualZeroScore(var SupplierEvaluationHeader: Record "Supplier Evaluation Header")
    var
        EvaluationScoreLine: Record "Supplier Evaluation Score Line";
    begin
        EvaluationScoreLine.Reset();
        EvaluationScoreLine.SetRange("Document No.", SupplierEvaluationHeader."No.");
        EvaluationScoreLine.SetRange("Score Criteria", EvaluationScoreLine."Score Criteria"::Score);
        EvaluationScoreLine.SetRange(Score, 0);
        EvaluationScoreLine.SetRange("Actual Zero", false);
        if EvaluationScoreLine.FindFirst() then
            Error('You have defined a 0 score without selecting Actual Zero. Please do so before submitting');
    end;

    local procedure GetAwardedSupplierVendorNo(var IRLine: Record "Procurement Evaluation Line"; var VendNo: Code[50])
    var
        ProspectiveSuppliers: Record "Prospective Suppliers";
    begin
        if ProspectiveSuppliers.Get(IRLine."Vendor No") then begin
            if ProspectiveSuppliers."Vendor No" = '' then
                VendNo := ProspectiveSuppliers.CreateVendr(ProspectiveSuppliers)
            else
                VendNo := ProspectiveSuppliers."Vendor No";
        end;
    end;

    procedure EvaluateTenderApplicants(TenderRec: Record "Procurement Request")
    var
        ProspectiveSuppliers: Record "Prospective Suppliers";
        ProspectTenders: Record "Prospective Supplier Tender";
        TenderApplicants: Record "Tender Applicant";
        DefineEvaluationCriteriaErr: Label 'Please define an Evaluation Criteria for the tender';
        NoTenderApplicantsErr: Label 'There are no Tender Applicants selected';
        SuppliersSentEvalSuccessMsg: Label 'Supplier(s) sent for evaluation successfully';
        NotOpenedFullyErr: Label 'Tender %1 has not yet been fully opened';
    begin
        TenderRec.TestField("Sent For Evaluation", false);

        if not TenderRec."Sent For Opening" then
            Error('Please start by prompting the Tender Opening process');

        TenderRec.CalcFields("Tender Not Opened");

        if TenderRec."Tender Not Opened" then
            Error(NotOpenedFullyErr, TenderRec."No.");

        if TenderRec."Process Type" = TenderRec."Process Type"::Tender then begin
            if TenderRec."Award Criteria" = TenderRec."Award Criteria"::" " then
                Error(DefineEvaluationCriteriaErr);

            TenderRec.TestField("Technical Pass Mark");

            if TenderRec."Award Criteria" = TenderRec."Award Criteria"::"Highest Evaluated Score" then
                TenderRec.TestField("Formula Pass Mark");
        end;

        TenderApplicants.Reset();
        TenderApplicants.SetRange("Tender No.", TenderRec."No.");
        if TenderApplicants.FindSet() then begin
            repeat
                ProspectTenders.Init();
                ProspectTenders."Prospect No." := TenderApplicants."Supplier Code";
                ProspectTenders."Tender No." := TenderRec."No.";
                if not ProspectTenders.Get(TenderApplicants."Supplier Code", TenderRec."No.") then
                    ProspectTenders.Insert();

                case TenderRec."Process Type" of
                    TenderRec."Process Type"::Tender,
                    TenderRec."Process Type"::RFP:
                        begin
                            if ProspectiveSuppliers.Get(TenderApplicants."Supplier Code") then
                                SendTenderApplicantsForEvaluation(ProspectiveSuppliers);
                            TenderApplicants.Validate("Tender Applicant Stage", TenderApplicants."Tender Applicant Stage"::"Preliminary Evaluation");
                            TenderApplicants.Modify();
                        end;
                    TenderRec."Process Type"::"Supplier Prequalification":
                        begin
                            SendSuppliersForPrequalificationEvaluation(TenderApplicants);
                            TenderApplicants.Validate("Tender Applicant Stage", TenderApplicants."Tender Applicant Stage"::"Supplier Prequalification");
                            TenderApplicants.Modify();
                        end;
                end;
            until TenderApplicants.Next() = 0;

            TenderRec."Sent For Evaluation" := true;
            TenderRec.Validate(Status, TenderRec.Status::Evaluation);
            TenderRec.Modify();
            Message(SuppliersSentEvalSuccessMsg);
        end else
            Error(NoTenderApplicantsErr);
    end;

    procedure SendTenderApplicantsForEvaluation(ProspectiveRec: Record "Prospective Suppliers")
    var
        CommitteeMembers: Record "Committee Member";
        TenderRec: Record "Procurement Request";
        TendersApplied: Record "Prospective Supplier Tender";
        SupplierEvalHeader: Record "Supplier Evaluation Header";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        TenderCommittee: Record "Tender Committees";
        ScoreSetup: Record "Tender Evaluation Setup";
        ScoreSetupLine: Record "Tender Evaluation Setup Line";
        ScoreDescBigTxt: BigText;
        Instrm: InStream;
        NoParametersFoundErr: Label 'No parameters available';
        TenderCommitteeNotExistErr: Label 'There is no approved tender committee for Tender No. %1 in Tender Committees Setup';
        DefineOpeningCommitteMemberErr: Label 'Please define at least one Tender Evaluation Committee Member in Tender Committee No. %1';
    begin
        TendersApplied.Reset();
        TendersApplied.SetRange("Prospect No.", ProspectiveRec."No.");
        TendersApplied.SetRange("Sent for Evaluation", false);
        if TendersApplied.Find('-') then begin
            repeat
                TenderCommittee.Reset();
                TenderCommittee.SetRange("Tender/Quotation No", TendersApplied."Tender No.");
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                if not TenderCommittee.FindFirst() then
                    Error(TenderCommitteeNotExistErr, TendersApplied."Tender No.")
                else begin
                    //Create evaluation for each committee member
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetRange(Type, CommitteeMembers.Type::Employee);
                    CommitteeMembers.SetFilter("Committee Member Type", '%1|%2', CommitteeMembers."Committee Member Type"::"Evaluation Member", CommitteeMembers."Committee Member Type"::"Opening & Evaluation Member");
                    if CommitteeMembers.FindSet() then
                        repeat
                            if TenderRec.Get(TenderCommittee."Tender/Quotation No") then begin
                                //Insert header
                                SupplierEvalHeader.Init();
                                SupplierEvalHeader."No." := '';
                                SupplierEvalHeader."Quote No" := TenderCommittee."Tender/Quotation No";
                                SupplierEvalHeader.Validate("Quote No");
                                SupplierEvalHeader.Type := SupplierEvalHeader.Type::Tender;
                                SupplierEvalHeader.User := CommitteeMembers."User ID";
                                SupplierEvalHeader."Supplier Code" := ProspectiveRec."No.";
                                SupplierEvalHeader.Validate("Supplier Code");
                                SupplierEvalHeader."Committee No." := TenderCommittee."Appointment No";
                                SupplierEvalHeader."Tender Item Type" := TenderRec."Tender Item Type";
                                if TenderRec."Process Type" = TenderRec."Process Type"::"Supplier Prequalification" then
                                    SupplierEvalHeader.Validate("Evaluation Stage", SupplierEvalHeader."Evaluation Stage"::"Supplier Prequalification")
                                else
                                    SupplierEvalHeader.Validate("Evaluation Stage", SupplierEvalHeader."Evaluation Stage"::"Preliminary Evaluation");
                                SupplierEvalHeader.Insert(true);

                                //Insert Scores from Tender Setup
                                ScoreSetup.Reset();
                                ScoreSetup.SetRange("Tender No.", TendersApplied."Tender No.");
                                if ScoreSetup.Find('-') then begin
                                    repeat
                                        Scores.Init();
                                        Scores."Document No." := SupplierEvalHeader."No.";
                                        Scores."Supplier Code" := ProspectiveRec."No.";
                                        Scores."Score Parameter" := ScoreSetup."Evaluation Code";
                                        Scores."Score Description" := ScoreSetup."Evaluation Heading";
                                        Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                        Scores."Tender No." := TenderRec."No.";
                                        ScoreSetup.CalcFields(Description);
                                        ScoreSetup.Description.CreateInStream(Instrm);
                                        ScoreDescBigTxt.Read(Instrm);
                                        Scores.Description := ScoreSetup.Description;
                                        Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                        Scores."Evaluation Criteria" := ScoreSetup."Evaluation Criteria";
                                        if not Scores.Get(SupplierEvalHeader."No.", ProspectiveRec."No.", ScoreSetup."Evaluation Code") then
                                            Scores.Insert()
                                        else begin
                                            Scores."Score Description" := ScoreSetup."Evaluation Heading";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores."Evaluation Criteria" := ScoreSetup."Evaluation Criteria";
                                            Scores."Tender Item Type" := TenderRec."Tender Item Type";
                                            Scores.Modify();
                                        end;

                                        //Insert Lines
                                        ScoreSetupLine.Reset();
                                        ScoreSetupLine.SetRange(Code, ScoreSetup."Evaluation Code");
                                        if ScoreSetupLine.Find('-') then begin
                                            repeat
                                                ScoreLines.Init();
                                                ScoreLines."Document No." := SupplierEvalHeader."No.";
                                                ScoreLines."Supplier Code" := ProspectiveRec."No.";
                                                ScoreLines."Score Parameter" := ScoreSetup."Evaluation Code";
                                                ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                ScoreSetupLine.CalcFields(Description);
                                                ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                ScoreLines."Tender No." := TenderRec."No.";
                                                if not ScoreLines.Get(SupplierEvalHeader."No.", ProspectiveRec."No.", ScoreSetup."Evaluation Code", ScoreSetupLine."Line No.") then
                                                    ScoreLines.Insert();
                                            until ScoreSetupLine.Next() = 0;
                                        end;

                                    until ScoreSetup.Next() = 0;
                                end else
                                    Error(NoParametersFoundErr);
                            end;
                        until CommitteeMembers.Next() = 0
                    else
                        Error(DefineOpeningCommitteMemberErr, CommitteeMembers."Appointment No");

                    TendersApplied."Sent for Evaluation" := true;
                    TendersApplied.Modify();
                end;

            until TendersApplied.Next() = 0;
        end;

        ProspectiveRec."Supplier Status" := ProspectiveRec."Supplier Status"::Evaluation;
        ProspectiveRec.Modify();
    end;

    procedure NotifyTenderCommitteeMembers(TenderCommittee: Record "Tender Committees")
    var
        CommitteeMembers: Record "Committee Member";
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        AppointeeMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> You have been selected as a committee member for Tender No. <Strong>%2</Strong> - <Strong>%3</Strong> . <p style="font-family:Verdana,Arial;font-size:10pt">You have been appointed to the role of <Strong>%5</Strong> .</p> <p style="font-family:Verdana,Arial;font-size:10pt">You are hereby required to participate in the Tender Evaluation process.</p> <br><br><p style="font-family:Verdana,Arial;font-size:10pt">Thank you.<br><br>Kind regards,<br><br><Strong>%4<Strong></p><p style="font-family:Verdana,Arial;font-size:10pt">%6</p>';
        Receipient: List of [Text];
        EmailBody: Text;
        Subject: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        CommitteeMembers.Reset();
        CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
        if CommitteeMembers.FindSet() then begin
            repeat
                Clear(Receipient);
                Receipient.Add(CommitteeMembers."E-Mail Address");
                Subject := 'Tender Committee Appointment - ' + TenderCommittee.Title;
                EmailBody := StrSubstNo(AppointeeMsg, CommitteeMembers.Name, TenderCommittee."Tender/Quotation No", TenderCommittee.Title, 'Chief Executive Officer', CommitteeMembers.Role, CompanyInfo.Name);
                EmailMessage.Create(Receipient, Subject, EmailBody, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);
            until CommitteeMembers.Next() = 0;
        end;
    end;

    procedure SubmitEvaluationScores(SupplierEvaluationHeader: Record "Supplier Evaluation Header")
    var
        TenderRec: Record "Procurement Request";
        SupplierHeader: Record "Supplier Evaluation Header";
        InsertAllScoresErr: Label 'You have not inserted all scores. Please do so before submitting';
    begin
        TenderRec.Get(SupplierEvaluationHeader."Quote No");

        case SupplierEvaluationHeader."Evaluation Stage" of
            SupplierEvaluationHeader."Evaluation Stage"::"Preliminary Evaluation",
            SupplierEvaluationHeader."Evaluation Stage"::"Failed Preliminary":
                begin
                    /* if SupplierEvaluationHeader."Submitted Preliminary" then
                        Error('Preliminary Scores for %1 have already been submitted', SupplierEvaluationHeader."Supplier Name"); */

                    SupplierEvaluationHeader.CalcFields(Pass, "Overall Pass", "Blank Pass");

                    if SupplierEvaluationHeader."Blank Pass" then
                        Error(InsertAllScoresErr);

                    if SupplierEvaluationHeader."Overall Pass" then begin
                        //Mark All already submitted scores as passed
                        SupplierHeader.Reset();
                        SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                        SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                        SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                        SupplierHeader.SetRange("Submitted Preliminary", true);
                        if SupplierHeader.FindSet() then
                            repeat
                                UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Technical Evaluation");
                                SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Technical Evaluation");
                                SupplierHeader.Modify();
                            until SupplierHeader.Next() = 0;

                        SupplierEvaluationHeader.Validate("Submitted Preliminary", true);
                        SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Technical Evaluation");
                        UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Technical Evaluation");
                        SupplierEvaluationHeader.Modify();
                    end else begin
                        //Mark All already submitted scores as failed
                        SupplierHeader.Reset();
                        SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                        SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                        SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                        SupplierHeader.SetRange("Submitted Preliminary", true);
                        if SupplierHeader.FindSet() then
                            repeat
                                UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Preliminary");
                                SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Preliminary");
                                SupplierHeader.Modify();
                            until SupplierHeader.Next() = 0;

                        SupplierEvaluationHeader.Validate("Submitted Preliminary", true);
                        SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Preliminary");
                        UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Preliminary");
                        SupplierEvaluationHeader.Modify();
                    end;
                end;

            SupplierEvaluationHeader."Evaluation Stage"::"Technical Evaluation",
            SupplierEvaluationHeader."Evaluation Stage"::"Failed Technical":
                begin
                    /* if SupplierEvaluationHeader."Submitted Technical" then
                        Error('Technical Scores for %1 have already been submitted', SupplierEvaluationHeader."Supplier Name"); */

                    case SupplierEvaluationHeader."Tender Item Type" of
                        SupplierEvaluationHeader."Tender Item Type"::" ":
                            Error('Please define Tender Item Type');

                        SupplierEvaluationHeader."Tender Item Type"::Goods:
                            begin
                                SupplierEvaluationHeader.CalcFields(Conform, "Overall Conform", "Blank Conform");

                                if SupplierEvaluationHeader."Blank Conform" then
                                    Error(InsertAllScoresErr);

                                if SupplierEvaluationHeader."Overall Conform" then begin
                                    //Mark All already submitted scores as passed
                                    SupplierHeader.Reset();
                                    SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                                    SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                                    SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                                    SupplierHeader.SetRange("Submitted Technical", true);
                                    if SupplierHeader.FindSet() then
                                        repeat
                                            InsertToFinancialSuppliers(SupplierHeader);
                                            UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Financial Evaluation");
                                            SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Financial Evaluation");
                                            SupplierHeader.Modify();
                                        until SupplierHeader.Next() = 0;

                                    SupplierEvaluationHeader.Validate("Submitted Technical", true);
                                    SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Financial Evaluation");
                                    UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Financial Evaluation");
                                    InsertToFinancialSuppliers(SupplierEvaluationHeader);
                                    SupplierEvaluationHeader.Modify();
                                end else begin
                                    //Mark All already submitted scores as failed
                                    SupplierHeader.Reset();
                                    SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                                    SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                                    SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                                    SupplierHeader.SetRange("Submitted Technical", true);
                                    if SupplierHeader.FindSet() then
                                        repeat
                                            UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Techincal");
                                            SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Technical");
                                            SupplierHeader.Modify();
                                        until SupplierHeader.Next() = 0;

                                    SupplierEvaluationHeader.Validate("Submitted Technical", true);
                                    SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Technical");
                                    UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Techincal");
                                    SupplierEvaluationHeader.Modify();
                                end;
                            end;

                        SupplierEvaluationHeader."Tender Item Type"::Services:
                            begin
                                CheckForActualZeroScore(SupplierEvaluationHeader);

                                TenderRec.TestField("Technical Pass Mark");
                                SupplierEvaluationHeader.GetAverageScore();

                                if SupplierEvaluationHeader."Average Technical Score" >= TenderRec."Technical Pass Mark" then begin
                                    //Mark All already submitted as passed
                                    SupplierHeader.Reset();
                                    SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                                    SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                                    SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                                    SupplierHeader.SetRange("Submitted Technical", true);
                                    if SupplierHeader.FindSet() then
                                        repeat
                                            SupplierHeader.GetAverageScore();
                                            if SupplierHeader."Average Technical Score" >= TenderRec."Technical Pass Mark" then begin
                                                InsertToFinancialSuppliers(SupplierHeader);
                                                UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Financial Evaluation");
                                                SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Financial Evaluation");
                                                SupplierHeader.Modify();
                                            end;
                                        until SupplierHeader.Next() = 0;

                                    //Insert To Financial Suppliers
                                    InsertToFinancialSuppliers(SupplierEvaluationHeader);
                                    SupplierEvaluationHeader.Validate("Submitted Technical", true);
                                    SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Financial Evaluation");
                                    UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Financial Evaluation");
                                    SupplierEvaluationHeader.Modify();
                                end else begin
                                    //Mark All already submitted as passed
                                    SupplierHeader.Reset();
                                    SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                                    SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                                    SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                                    SupplierHeader.SetRange("Submitted Technical", true);
                                    if SupplierHeader.FindSet() then
                                        repeat
                                            SupplierHeader.Validate("Evaluation Stage", SupplierHeader."Evaluation Stage"::"Failed Technical");
                                            UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Techincal");
                                            SupplierHeader.Modify();
                                        until SupplierHeader.Next() = 0;

                                    SupplierEvaluationHeader.Validate("Submitted Technical", true);
                                    SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Technical");
                                    UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Techincal");
                                    SupplierEvaluationHeader.Modify();
                                end;
                            end;
                    end;
                end;

            SupplierEvaluationHeader."Evaluation Stage"::"Supplier Prequalification",
            SupplierEvaluationHeader."Evaluation Stage"::"Failed Supplier Prequalification":
                begin
                    if SupplierEvaluationHeader."Submitted Prequalification" then
                        Error('Prequalification Scores for %1 have already been submitted', SupplierEvaluationHeader."Supplier Name");

                    SupplierEvaluationHeader.CalcFields(Pass, "Overall Pass", "Blank Pass");

                    if SupplierEvaluationHeader."Blank Pass" then
                        Error(InsertAllScoresErr);

                    if SupplierEvaluationHeader."Overall Pass" then begin
                        //Mark All already submitted scores as passed
                        SupplierHeader.Reset();
                        SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                        SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                        SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                        SupplierHeader.SetRange("Submitted Prequalification", true);
                        if SupplierHeader.FindSet() then
                            repeat
                                //Insert To Qualified Suppliers
                                InsertToFinancialSuppliers(SupplierHeader);
                                UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Passed Prequalification");
                                SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Passed Supplier Prequalification");
                                SupplierHeader.Modify();
                            until SupplierHeader.Next() = 0;

                        SupplierEvaluationHeader.Validate("Submitted Prequalification", true);
                        SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Passed Supplier Prequalification");
                        UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Passed Prequalification");
                        InsertToFinancialSuppliers(SupplierEvaluationHeader);
                        SupplierEvaluationHeader.Modify();
                    end else begin
                        //Mark All already submitted scores as failed
                        SupplierHeader.Reset();
                        SupplierHeader.SetFilter("No.", '<>%1', SupplierEvaluationHeader."No.");
                        SupplierHeader.SetRange("Quote No", SupplierEvaluationHeader."Quote No");
                        SupplierHeader.SetRange("Supplier Code", SupplierEvaluationHeader."Supplier Code");
                        SupplierHeader.SetRange("Submitted Prequalification", true);
                        if SupplierHeader.FindSet() then
                            repeat
                                UpdateTenderApplicantStage(SupplierHeader."Quote No", SupplierHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Prequalification");
                                SupplierHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Supplier Prequalification");
                                SupplierHeader.Modify();
                            until SupplierHeader.Next() = 0;

                        SupplierEvaluationHeader.Validate("Submitted Prequalification", true);
                        SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Failed Supplier Prequalification");
                        UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Failed Prequalification");
                        SupplierEvaluationHeader.Modify();
                    end;
                end;
        end;
    end;

    procedure UpdateTenderApplicantStage(TenderNo: Code[50]; SupplierCode: Code[50]; ApplicantStage: Enum "Tender Applicant Stage")
    var
        TenderApplicant: Record "Tender Applicant";
    begin
        TenderApplicant.Reset();
        TenderApplicant.SetRange("Tender No.", TenderNo);
        TenderApplicant.SetRange("Supplier Code", SupplierCode);
        if TenderApplicant.FindFirst() then begin
            TenderApplicant.Validate("Tender Applicant Stage", ApplicantStage);
            TenderApplicant.Modify();
        end;
    end;

    procedure GetAverageTechnicalScore(TenderNo: Code[50]; SupplierCode: Code[50]): Decimal
    var
        EvaluationHeader: Record "Supplier Evaluation Header";
        AverageScore: Decimal;
        TotalScore: Decimal;
        DocCount: Integer;
    begin
        DocCount := 0;
        TotalScore := 0;
        AverageScore := 0;

        EvaluationHeader.Reset();
        EvaluationHeader.SetRange("Quote No", TenderNo);
        EvaluationHeader.SetRange("Supplier Code", SupplierCode);
        if EvaluationHeader.FindSet() then begin
            DocCount := EvaluationHeader.Count();
            repeat
                EvaluationHeader.CalcFields("Total Technical Score");
                TotalScore += EvaluationHeader."Total Technical Score";
            until EvaluationHeader.Next() = 0;

            AverageScore := TotalScore / DocCount;
        end;

        exit(AverageScore);
    end;

    procedure CalculateFinancialAnalysis(ProcurementEval: Record "Procurement Evaluation Header")
    var
        ProcurementRec: Record "Procurement Request";
        ProcurementEvalLines, ProcurementEvalLines2 : Record "Procurement Evaluation Line";
    begin
        if ProcurementEval."Calculation Type" = ProcurementEval."Calculation Type"::" " then
            Error('Please define a Calculation Type');

        ProcurementRec.Get(ProcurementEval."No.");
        ProcurementEval.CalcFields("Evaluation Criteria");

        case ProcurementEval."Process Type" of
            ProcurementEval."Process Type"::Tender:
                begin
                    case ProcurementRec."Award Criteria" of
                        ProcurementRec."Award Criteria"::"Lowest Bidder":
                            begin
                                case ProcurementEval."Calculation Type" of
                                    ProcurementEval."Calculation Type"::"Per Item":
                                        begin
                                            ProcurementEvalLines.Reset();
                                            ProcurementEvalLines.SetRange(ProcurementEvalLines."Document No.", ProcurementEval."No.");
                                            ProcurementEvalLines.SetFilter(ProcurementEvalLines."Amount Inclusive VAT", '>%1', 0);
                                            if ProcurementEvalLines.FindSet() then
                                                repeat
                                                    ProcurementEval.SetRange("Item Filter", ProcurementEvalLines."No.");
                                                    ProcurementEval.SetRange("Line No. Filter", ProcurementEvalLines."Line No");
                                                    ProcurementEval.CalcFields("Lowest Bid Price");
                                                    if ProcurementEvalLines."Amount Inclusive VAT" = ProcurementEval."Lowest Bid Price" then begin
                                                        ProcurementEvalLines.Validate(Suggested, true);
                                                        ProcurementEvalLines.Awarded := true;
                                                    end else begin
                                                        ProcurementEvalLines.Validate(Suggested, false);
                                                        ProcurementEvalLines.Awarded := false;
                                                    end;
                                                    ProcurementEvalLines.Modify();
                                                until ProcurementEvalLines.Next() = 0;
                                        end;
                                    ProcurementEval."Calculation Type"::"Per Lot":
                                        begin
                                            ProcurementEvalLines.Reset();
                                            ProcurementEvalLines.SetRange(ProcurementEvalLines."Document No.", ProcurementEval."No.");
                                            ProcurementEvalLines.SetFilter(ProcurementEvalLines."Amount Inclusive VAT", '>%1', 0);
                                            if ProcurementEvalLines.FindSet() then
                                                repeat
                                                    ProcurementEvalLines2.Copy(ProcurementEvalLines);
                                                    ProcurementEvalLines2.SetRange("Vendor No", ProcurementEvalLines."Vendor No");
                                                    ProcurementEvalLines2.CalcSums("Amount Inclusive VAT");
                                                    //repeat modify here
                                                    ProcurementEvalLines."Total Amount Per Vendor" := ProcurementEvalLines2."Amount Inclusive VAT";
                                                    ProcurementEval.CalcFields("Lowest Vendor Total");
                                                    if ProcurementEvalLines."Total Amount Per Vendor" = ProcurementEval."Lowest Vendor Total" then begin
                                                        ProcurementEvalLines.Validate(Suggested, true);
                                                        ProcurementEvalLines.Awarded := true;
                                                    end else begin
                                                        ProcurementEvalLines.Validate(Suggested, false);
                                                        ProcurementEvalLines.Awarded := false;
                                                    end;
                                                    ProcurementEvalLines.Modify();
                                                until ProcurementEvalLines.Next() = 0;
                                        end;
                                end;
                            end;

                        ProcurementRec."Award Criteria"::"Highest Evaluated Score":
                            begin
                                ProcurementRec.TestField("Formula Pass Mark");
                                ProcurementEval.CalcFields("Lowest Bid Price");
                                ProcurementEval.CalcFields("Highest Financial Score");

                                ProcurementEvalLines.Reset();
                                ProcurementEvalLines.SetRange("Document No.", ProcurementEval."No.");
                                ProcurementEvalLines.SetFilter("Amount Inclusive VAT", '>%1', 0);
                                if ProcurementEvalLines.FindSet() then
                                    repeat
                                        ProcurementEvalLines."Financial Score" := ProcurementRec."Formula Pass Mark" * (ProcurementEval."Lowest Bid Price" / ProcurementEvalLines.Amount);
                                        ProcurementEvalLines.Modify();
                                    until ProcurementEvalLines.Next = 0;

                                ProcurementEvalLines.Reset();
                                ProcurementEvalLines.SetRange(ProcurementEvalLines."Document No.", ProcurementEval."No.");
                                ProcurementEvalLines.SetRange("Financial Score", ProcurementEval."Highest Financial Score");
                                if ProcurementEvalLines.FindSet() then
                                    repeat
                                        ProcurementEvalLines.Suggested := true;
                                        ProcurementEvalLines.Awarded := true;
                                        ProcurementEvalLines.Modify();
                                    until ProcurementEvalLines.Next = 0;
                            end;
                    end;
                end;
            else begin
                case ProcurementEval."Calculation Type" of
                    ProcurementEval."Calculation Type"::"Per Item":
                        begin
                            ProcurementEvalLines.Reset();
                            ProcurementEvalLines.SetRange(ProcurementEvalLines."Document No.", ProcurementEval."No.");
                            ProcurementEvalLines.SetFilter(ProcurementEvalLines."Amount Inclusive VAT", '>%1', 0);
                            if ProcurementEvalLines.FindSet() then
                                repeat
                                    ProcurementEval.SetRange("Item Filter", ProcurementEvalLines."No.");
                                    ProcurementEval.SetRange("Line No. Filter", ProcurementEvalLines."Line No");
                                    ProcurementEval.CalcFields("Lowest Bid Price");
                                    if ProcurementEvalLines."Amount Inclusive VAT" = ProcurementEval."Lowest Bid Price" then begin
                                        ProcurementEvalLines.Validate(Suggested, true);
                                        ProcurementEvalLines.Awarded := true;
                                    end else begin
                                        ProcurementEvalLines.Validate(Suggested, false);
                                        ProcurementEvalLines.Awarded := false;
                                    end;
                                    ProcurementEvalLines.Modify();
                                until ProcurementEvalLines.Next() = 0;
                        end;
                    ProcurementEval."Calculation Type"::"Per Lot":
                        begin
                            ProcurementEvalLines.Reset();
                            ProcurementEvalLines.SetRange(ProcurementEvalLines."Document No.", ProcurementEval."No.");
                            ProcurementEvalLines.SetFilter(ProcurementEvalLines."Amount Inclusive VAT", '>%1', 0);
                            if ProcurementEvalLines.FindSet() then
                                repeat
                                    ProcurementEvalLines2.Copy(ProcurementEvalLines);
                                    ProcurementEvalLines2.SetRange("Vendor No", ProcurementEvalLines."Vendor No");
                                    ProcurementEvalLines2.CalcSums("Amount Inclusive VAT");
                                    //repeat modify here
                                    ProcurementEvalLines."Total Amount Per Vendor" := ProcurementEvalLines2."Amount Inclusive VAT";
                                    ProcurementEval.CalcFields("Lowest Vendor Total");
                                    if ProcurementEvalLines."Total Amount Per Vendor" = ProcurementEval."Lowest Vendor Total" then begin
                                        ProcurementEvalLines.Validate(Suggested, true);
                                        ProcurementEvalLines.Awarded := true;
                                    end else begin
                                        ProcurementEvalLines.Validate(Suggested, false);
                                        ProcurementEvalLines.Awarded := false;
                                    end;
                                    ProcurementEvalLines.Modify();
                                until ProcurementEvalLines.Next() = 0;
                        end;
                end;
            end;
        end;

        Commit();
    end;

    procedure SendToFinancialEvaluation(TenderRec: Record "Procurement Request")
    var
        SupplierSelection: Record "Supplier Selection";
        SupplierEval: Record "Supplier Evaluation Header";
        EvaluationExistsErr: Label 'Evaluation for Tender No %1 is not yet complete';
    begin
        TenderRec.TestField("Requisition No");
        TenderRec.TestField(Title);
        TenderRec.TestField("Quotation Deadline");
        TenderRec.TestField("Expected Closing Time");

        //Check if preliminary/technical evaluations exist
        SupplierEval.Reset();
        SupplierEval.SetRange("Quote No", TenderRec."No.");
        SupplierEval.SetFilter("Evaluation Stage", '%1|%2', SupplierEval."Evaluation Stage"::"Preliminary Evaluation", SupplierEval."Evaluation Stage"::"Technical Evaluation");
        if SupplierEval.FindFirst() then
            Error(EvaluationExistsErr, TenderRec."No.");

        SupplierSelection.Reset();
        SupplierSelection.SetRange(SupplierSelection."Reference No.", TenderRec."No.");
        SupplierSelection.SetRange(SupplierSelection.Invited, true);
        if SupplierSelection.Find('-') then begin
            repeat
                CreateProcurementEvaluation(SupplierSelection);
            until SupplierSelection.Next() = 0;
            Message('Suppliers Sent to Financial Evaluation Successfully');
        end;
    end;

    procedure TenderOpening(TenderRec: Record "Procurement Request")
    var
        CommitteeMembers: Record "Committee Member";
        TenderApplicants: Record "Tender Applicant";
        TenderCommittee: Record "Tender Committees";
        TenderOpening: Record "Tender Opening Register";
        CannotOpenBeforeDeadlineDateErr: Label 'You can not open this tender before the deadline date';
        CannotOpenBeforeDeadlineTimeErr: Label 'You can not open this tender before the deadline time';
        DefineEvaluationCriteriaErr: Label 'Please define an appropriate Evaluation Criteria for the tender';
        DefineItemTypeErr: Label 'Please define an appropriate Tender Item Type for the tender';
        NoTenderApplicantsErr: Label 'There are no Tender Applicants selected';
        TenderCommitteeNotExistErr: Label 'There is no approved tender committee for Tender No. %1 in Tender Committees Setup';
        DefineOpeningCommitteMemberErr: Label 'Please define at least one Tender Opening Committee Member in Tender Committee No. %1';
        SentForOpeningSuccessMsg: Label 'Tender %1 has been successfully sent for opening and Passwords have been shared to the respective committee members';
    begin
        TenderRec.TestField("Sent For Opening", false);

        if TenderRec."Process Type" = TenderRec."Process Type"::Tender then begin
            if TenderRec."Tender Item Type" = TenderRec."Tender Item Type"::" " then
                Error(DefineItemTypeErr);

            if TenderRec."Award Criteria" = TenderRec."Award Criteria"::" " then
                Error(DefineEvaluationCriteriaErr);

            if TenderRec."Tender Item Type" = TenderRec."Tender Item Type"::Services then
                TenderRec.TestField("Technical Pass Mark");
        end;

        if TenderRec."Process Type" = TenderRec."Process Type"::"Supplier Prequalification" then
            TenderRec.TestField(Category);

        if TenderRec."Quotation Deadline" > Today() then
            Error(CannotOpenBeforeDeadlineDateErr);

        if TenderRec."Expected Closing Time" > Time() then
            Error(CannotOpenBeforeDeadlineTimeErr);
        //mjk
        TenderApplicants.Reset();
        TenderApplicants.SetRange("Tender No.", TenderRec."No.");
        if TenderApplicants.FindSet() then begin
            repeat
                TenderCommittee.Reset();
                TenderCommittee.SetRange("Tender/Quotation No", TenderRec."No.");
                TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
                if not TenderCommittee.FindFirst() then
                    Error(TenderCommitteeNotExistErr, TenderRec."No.")
                else begin
                    CommitteeMembers.Reset();
                    CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
                    CommitteeMembers.SetRange(Type, CommitteeMembers.Type::Employee);
                    CommitteeMembers.SetFilter("Committee Member Type", '%1|%2', CommitteeMembers."Committee Member Type"::"Opening Member", CommitteeMembers."Committee Member Type"::"Opening & Evaluation Member");
                    if CommitteeMembers.FindSet() then begin
                        repeat
                            TenderOpening.Init();
                            TenderOpening.Validate("Tender No.", TenderRec."No.");
                            TenderOpening.Validate("Supplier No.", TenderApplicants."Supplier Code");
                            TenderOpening.Validate("User ID", CommitteeMembers."User ID");
                            TenderOpening.Validate("Tender Committee No.", CommitteeMembers."Appointment No");
                            case TenderRec."Process Type" of
                                TenderRec."Process Type"::Tender:
                                    TenderOpening.Validate("Document Type", TenderOpening."Document Type"::Tender);
                                TenderRec."Process Type"::"Supplier Prequalification":
                                    TenderOpening.Validate("Document Type", TenderOpening."Document Type"::"Supplier Prequalification");
                            end;
                            if not TenderOpening.Get(TenderRec."No.", TenderApplicants."Supplier Code", CommitteeMembers."User ID") then
                                TenderOpening.Insert(true);
                        until CommitteeMembers.Next() = 0;
                        UpdateTenderApplicantStage(TenderApplicants."Tender No.", TenderApplicants."Supplier Code", Enum::"Tender Applicant Stage"::"Tender Opening");
                    end else
                        Error(DefineOpeningCommitteMemberErr, CommitteeMembers."Appointment No");
                end;
            until TenderApplicants.Next() = 0;

            //Send passwords
            SendTenderOpeningPasswords(TenderRec);

            TenderRec.Validate("Sent For Opening", true);
            TenderRec.Validate(Status, TenderRec.Status::Opening);
            TenderRec.Modify();
            Message(SentForOpeningSuccessMsg, TenderRec."No.");
        end else
            Error(NoTenderApplicantsErr);
    end;

    procedure NotifyTenderOpeningCommitteeMembers(CommitteeMember: Record "Committee Member")
    var
        CompanyInfo: Record "Company Information";
        TenderRec: Record "Procurement Request";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        PasswordHandler: Codeunit "Password Handler";
        AppointeeMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> You are required to participate in the opening of Tender No. <Strong>%2</Strong> - <Strong>%3</Strong> . <p style="font-family:Verdana,Arial;font-size:10pt">Your password to allow for opening is <Strong>%5</Strong> <br>Please do not share this password as it is only unique to you.</p> <br><p style="font-family:Verdana,Arial;font-size:10pt">Thank you.<br><br>Kind regards,<br><br><Strong>%4<Strong></p><p style="font-family:Verdana,Arial;font-size:10pt">%6</p>';
        SMSMsg: Label 'Hi.Use password %1 for opening Tender-%2.';
        Receipient: List of [Text];
        EmailBody: Text;
        SMSBody: Text;
        Subject: Text;
        OpeningPassword: Text;
    begin
        CommitteeMember.TestField("Mobile Phone No.");
        CommitteeMember.TestField("E-Mail Address");
        // Mjk
        // TenderRec.Get(CommitteeMember."Tender No.");

        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        OpeningPassword := PasswordHandler.GeneratePassword(8);
        CommitteeMember.Validate("Opening Password", OpeningPassword);
        CommitteeMember.Modify();

        //Send E-mail
        Clear(Receipient);
        Receipient.Add(CommitteeMember."E-Mail Address");
        Subject := 'Tender Opening - ' + TenderRec.Title;
        EmailBody := StrSubstNo(AppointeeMsg, CommitteeMember.Name, TenderRec."No.", TenderRec.Title, 'Procurement Office', CommitteeMember."Opening Password", CompanyInfo.Name);
        EmailMessage.Create(Receipient, Subject, EmailBody, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);

        //Send SMS
        SMSBody := StrSubstNo(SMSMsg, CommitteeMember."Opening Password", TenderRec.Title);
        //SMSNotification.CreateSmsNotif(Enum::NotifSourceType::"Tender Opening", CommitteeMember."Mobile Phone No.", SMSBody, '', CommitteeMember."Committee Member No", false);
    end;

    procedure MarkTenderAsOpened(TenderOpening: Record "Tender Opening Register")
    begin
        TenderOpening.Validate("Tender Opened", true);
        TenderOpening.Validate("Opened By", UserId);
        TenderOpening.Validate("Date-Time Opened", CurrentDateTime());
        TenderOpening.Modify();

        Message('Tender %1 for Supplier %2 has been opened successfully', TenderOpening."Tender No.", TenderOpening."Supplier Name");
    end;

    procedure IsTenderOpeningPasswordCorrect(TenderOpening: Record "Tender Opening Register"; Password: Text): Boolean
    var
        CommitteeMember: Record "Committee Member";
        IncorrectPasswordErr: Label 'Incorrect password entered. Please try again';
    begin
        CommitteeMember.Reset();
        CommitteeMember.SetRange("Appointment No", TenderOpening."Tender Committee No.");
        CommitteeMember.SetRange("User ID", TenderOpening."User ID");
        if CommitteeMember.FindFirst() then begin
            if Password <> CommitteeMember."Opening Password" then begin
                Error(IncorrectPasswordErr);
                exit(false);
            end else
                exit(true);
        end;

        exit(false);
    end;

    procedure SendLPO(purchaseorder: Record "Purchase Header")
    var
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        AttachOutstr: OutStream;
        AwardLetter: Report "LPO New";
        ProspectiveSupplier: Record vendor;
        TenderEvaluationLine: Record "Purchase Header";

        Recipient: List of [Text];
        Base64Txt, FileName, Subject, EmailBody : Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached your LPo for <strong>%4<strong>.</p><p style="font-family:Verdana,Arial;font-size:9pt">. <b></b>.</p><br>. <b></b>.</p><br> Kind Regards,<p>%3</p>';
        // NewBody2: Label '1536951090'
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        TenderEvaluationLine.Reset();
        TenderEvaluationLine.SetRange("No.", purchaseorder."No.");
        if TenderEvaluationLine.FindSet() then
            //  repeat
            Subject := 'Send LPO - ' + purchaseorder."Posting Description";
        Clear(Recipient);
        ProspectiveSupplier.Get(TenderEvaluationLine."Buy-from Vendor No.");
        ProspectiveSupplier.TestField("E-mail");
        FileName := purchaseorder."Posting Description" + '_' + ProspectiveSupplier.Name + '_' + 'LPO' + '.pdf';

        Recipient.Add(ProspectiveSupplier."E-mail");
        EmailBody := StrSubstNo(NewBody, ProspectiveSupplier.Name, TenderEvaluationLine."Buy-from Vendor No.", CompanyInfo.Name, purchaseorder."Posting Description");
        EmailMessage.Create(Recipient, Subject, EmailBody, true);
        ///*************************************************************************************mjk
        AwardLetter.SetTableView(TenderEvaluationLine);

        TempBlob.CreateOutStream(AttachOutstr);
        if AwardLetter.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
            TempBlob.CreateInStream(AttachInstr);
            Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
            EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
        end;

        Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);
        // until TenderEvaluationLine.Next() = 0;
    end;

    procedure SendAwardLetter(TenderEvaluation: Record "Procurement Evaluation Header")
    var
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        AttachOutstr: OutStream;
        AwardLetter: Report "Supplier Award Letter";
        ProspectiveSupplier: Record "Prospective Suppliers";
        TenderEvaluationLine: Record "Procurement Evaluation Line";

        Recipient: List of [Text];
        Base64Txt, FileName, Subject, EmailBody : Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached your Award Letter for <strong>%4<strong>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Tender reference number is <b>%2</b>.</p><br>Please note: This Award Letter does not constitute a binding contract or a commitment to enter into a contract. Coalition for Humanity reserves the right to withdraw, amend, or cancel this award at its sole discretion and at any time, without incurring any liability. <b></b>.</p><br> Kind Regards,<p>%3</p>';
        // NewBody2: Label '1536951090'
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        TenderEvaluationLine.Reset();
        TenderEvaluationLine.SetRange("Document No.", TenderEvaluation."No.");
        TenderEvaluationLine.SetRange(Awarded, true);
        if TenderEvaluationLine.FindSet() then
            //  repeat
            Subject := 'Award Letter - ' + TenderEvaluation.Title;
        Clear(Recipient);
        ProspectiveSupplier.Get(TenderEvaluationLine."Vendor No");
        ProspectiveSupplier.TestField("E-mail");
        FileName := TenderEvaluation.Title + '_' + ProspectiveSupplier.Name + '_' + 'Award' + '.pdf';

        Recipient.Add(ProspectiveSupplier."E-mail");
        EmailBody := StrSubstNo(NewBody, ProspectiveSupplier.Name, TenderEvaluation."No.", CompanyInfo.Name, TenderEvaluation.Title);
        EmailMessage.Create(Recipient, Subject, EmailBody, true);
        ///*************************************************************************************mjk
        AwardLetter.SetTableView(TenderEvaluationLine);

        TempBlob.CreateOutStream(AttachOutstr);
        if AwardLetter.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
            TempBlob.CreateInStream(AttachInstr);
            Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
            EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
        end;

        Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);
        // until TenderEvaluationLine.Next() = 0;
    end;

    procedure SendRegretLetter(TenderEvaluation: Record "Procurement Evaluation Header")
    var
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        AttachInstr: InStream;
        AttachOutstr: OutStream;
        RegretLetter: Report "Supplier Regret Letter";
        ProspectiveSupplier: Record "Prospective Suppliers";
        TenderEvaluationLine: Record "Procurement Evaluation Line";
        ProcurementEvCriteriaLine: Record "Procurement Ev Criteria Line";
        Recipient: List of [Text];
        Base64Txt, FileName, Subject, EmailBody : Text;
        NewBody: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Please find attached your Regret Letter for <strong>%4<strong>.</p><p style="font-family:Verdana,Arial;font-size:9pt">Tender reference number is <b>%2</b>.</p><br>Kind Regards,<p>%3</p>';
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        TenderEvaluationLine.Reset();
        TenderEvaluationLine.SetRange("Document No.", TenderEvaluation."No.");
        TenderEvaluationLine.SetRange(Awarded, false);
        if TenderEvaluationLine.FindSet() then
            repeat
                Subject := 'Regret Letter - ' + TenderEvaluation.Title;
                Clear(Recipient);
                ProspectiveSupplier.Get(TenderEvaluationLine."Vendor No");
                ProspectiveSupplier.TestField("E-mail");
                FileName := TenderEvaluation.Title + '_' + ProspectiveSupplier.Name + '_' + 'Regret' + '.pdf';

                Recipient.Add(ProspectiveSupplier."E-mail");
                EmailBody := StrSubstNo(NewBody, ProspectiveSupplier.Name, TenderEvaluation."No.", CompanyInfo.Name, TenderEvaluation.Title);
                EmailMessage.Create(Recipient, Subject, EmailBody, true);

                RegretLetter.SetTableView(TenderEvaluation);
                TempBlob.CreateOutStream(AttachOutstr);
                if RegretLetter.SaveAs('', ReportFormat::Pdf, AttachOutstr) then begin
                    TempBlob.CreateInStream(AttachInstr);
                    Base64Txt := Base64Conv.ToBase64(AttachInstr, true);
                    EmailMessage.AddAttachment(FileName, 'application/pdf', Base64Txt);
                end;

                Email.Send(EmailMessage, Enum::"Email Scenario"::Procurement);
            until TenderEvaluationLine.Next() = 0;
    end;

    procedure SendSuppliersForPrequalificationEvaluation(TenderApplicants: Record "Tender Applicant")
    var
        TenderRec: Record "Procurement Request";
        TenderCommittee: Record "Tender Committees";
        CommitteeMembers: Record "Committee Member";
        TenderCommitteeCategory: Record "Tender Committee Category";
        TenderApplicantCategories: Record "Tender Applicant Category";
        TenderEvaluationSetup: Record "Tender Evaluation Setup";
        TenderEvaluationSetupLines: Record "Tender Evaluation Setup Line";
        SupplierEval: Record "Supplier Evaluation Header";
        Scores: Record "Supplier Evaluation Score";
        ScoreLines: Record "Supplier Evaluation Score Line";
        ScoreSetup: Record "Supplier Evaluation SetUp";
        ScoreSetupLine: Record "Supplier Evaluation Setup Line";
        TenderCommitteeNotExistErr: Label 'There is no approved tender committee for Tender No. %1 in Tender Committees Setup';
        ScoreDescBigTxt: BigText;
        Instrm: InStream;
    begin
        //1 applicant:
        /*
            - applicant
            - check committee
            - loop through committee categories
            - create evaluation for all members
        */
        TenderRec.Get(TenderApplicants."Tender No.");

        TenderCommittee.Reset();
        TenderCommittee.SetRange("Tender/Quotation No", TenderRec."No.");
        TenderCommittee.SetRange(Status, TenderCommittee.Status::Released);
        if TenderCommittee.FindFirst() then begin
            CommitteeMembers.Reset();
            CommitteeMembers.SetRange("Appointment No", TenderCommittee."Appointment No");
            CommitteeMembers.SetRange(Type, CommitteeMembers.Type::Employee);
            CommitteeMembers.SetFilter("Committee Member Type", '%1|%2', CommitteeMembers."Committee Member Type"::"Evaluation Member", CommitteeMembers."Committee Member Type"::"Opening & Evaluation Member");
            if CommitteeMembers.FindSet() then begin
                repeat
                    TenderCommitteeCategory.Reset();
                    TenderCommitteeCategory.SetRange("Appointment No.", CommitteeMembers."Appointment No");
                    if TenderCommitteeCategory.FindSet() then begin
                        repeat
                            TenderApplicantCategories.Reset();
                            TenderApplicantCategories.SetRange("Tender No.", TenderApplicants."Tender No.");
                            TenderApplicantCategories.SetRange("Supplier Category", TenderCommitteeCategory."Supplier Category");
                            if TenderApplicantCategories.FindSet() then begin
                                repeat
                                    //Insert header
                                    SupplierEval.Init();
                                    SupplierEval."No." := '';
                                    SupplierEval."Quote No" := TenderCommittee."Tender/Quotation No";
                                    SupplierEval.Validate("Quote No");
                                    SupplierEval.Type := SupplierEval.Type::Tender;
                                    SupplierEval.User := CommitteeMembers."User ID";
                                    SupplierEval."Supplier Category" := TenderApplicantCategories."Supplier Category";
                                    SupplierEval."Supplier Code" := TenderApplicantCategories."Supplier Code";
                                    SupplierEval.Validate("Supplier Code");
                                    SupplierEval."Committee No." := TenderCommittee."Appointment No";
                                    SupplierEval.Insert(true);

                                    //Insert Scores
                                    ScoreSetup.Reset();
                                    ScoreSetup.SetRange(Active, true);
                                    ScoreSetup.SetRange(Type, ScoreSetup.Type::Tender);
                                    if ScoreSetup.Find('-') then begin
                                        repeat
                                            Scores.Init();
                                            Scores."Document No." := SupplierEval."No.";
                                            Scores."Supplier Code" := TenderApplicantCategories."Supplier Code";
                                            Scores."Score Parameter" := ScoreSetup.Code;
                                            Scores."Score Description" := ScoreSetup."Evaluation Description";
                                            Scores."Maximum Score" := ScoreSetup."Maximum Score";
                                            Scores."Minimum Score" := ScoreSetup."Minimum Score";
                                            ScoreSetup.CalcFields(Description);
                                            ScoreSetup.Description.CreateInStream(Instrm);
                                            ScoreDescBigTxt.Read(Instrm);
                                            Scores.Description := ScoreSetup.Description;
                                            Scores."Score Criteria" := ScoreSetup."Score Criteria";
                                            Scores.Insert();

                                            //Insert Lines
                                            ScoreSetupLine.Reset();
                                            ScoreSetupLine.SetRange(Code, ScoreSetup.Code);
                                            if ScoreSetupLine.Find('-') then begin
                                                repeat
                                                    ScoreLines.Init();
                                                    ScoreLines."Document No." := SupplierEval."No.";
                                                    ScoreLines."Supplier Code" := TenderApplicantCategories."Supplier Code";
                                                    ScoreLines."Score Parameter" := ScoreSetup.Code;
                                                    ScoreLines."Line No." := ScoreSetupLine."Line No.";
                                                    ScoreLines."Maximum Score" := ScoreSetupLine."Maximum Score";
                                                    ScoreSetupLine.CalcFields(Description);
                                                    ScoreLines."Score Description" := ScoreSetupLine.Description;
                                                    ScoreLines."Score Criteria" := ScoreSetup."Score Criteria";
                                                    ScoreLines.Insert();
                                                until ScoreSetupLine.Next() = 0;
                                            end;

                                        until ScoreSetup.Next() = 0;
                                    end else
                                        Error('');
                                until TenderApplicantCategories.Next() = 0;
                            end;
                        until TenderCommitteeCategory.Next() = 0;
                    end;
                until CommitteeMembers.Next() = 0;
            end;
        end else
            Error(TenderCommitteeNotExistErr, TenderApplicants."Tender No.");
    end;

    procedure GenerateBarcode(DocNo: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        Client: HttpClient;
        Response: HttpResponseMessage;
        InStr: InStream;
        FixedAsset: Record "Fixed Asset";
        BarCodeBase64: Text;
        Uri: Text;
    begin
        FixedAsset.Get(DocNo);

        Client.Get('https://barcode.tec-it.com/barcode.ashx?data=' + TypeHelper.UrlEncode(DocNo) + '&code=Code128&translate-esc=on&imagetype=Jpg', Response);
        TempBlob.CreateInStream(InStr);
        Response.Content().ReadAs(InStr);

        BarCodeBase64 := Base64Convert.ToBase64(InStr);
        FixedAsset.Barcode.ImportStream(InStr, FixedAsset.Description);
        FixedAsset.Modify();
    end;

    procedure GenerateMultipleBarcodes()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        FixedAsset.SetRange(Blocked, false);
        if FixedAsset.FindSet() then
            repeat
                if not FixedAsset.Barcode.HasValue() then
                    GenerateBarcode(FixedAsset."No.");
            until FixedAsset.Next() = 0;
    end;

    procedure GenerateContractFromProcurementEvaluation(var IR: Record "Procurement Evaluation Header")
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        IRLine: Record "Procurement Evaluation Line";
        IRLine2: Record "Procurement Evaluation Line";
        ProcurementContract: Record "Procurement Contract";
        Committement: Codeunit "Commitments Mgt Procurement";
        NoseriesMgt: Codeunit NoSeriesManagement;
        AwardAtLeastOneVendorErr: Label 'Please award at least one supplier';
        OrderCreatedSuccessMsg: Label 'Contract No %1 has been created';
        DocNo, LPONo : Code[20];
        VendNo: Code[50];
        LineNo: Integer;
    begin
        IR.TestField("LPO/Contract Generated", false);

        IRLine.Reset();
        IRLine.SetRange(IRLine."Document No.", IR."No.");
        IRLine.SetRange(IRLine.Awarded, true);
        IRLine.SetFilter(IRLine.Quantity, '>%1', 0);
        IRLine.SetRange("LPO/Contract Generated", false);
        if IRLine.FindSet() then begin
            repeat
                PurchSetup.Get();
                IRLine2.Reset();
                IRLine2.SetRange(IRLine2."Document No.", IRLine."Document No.");
                IRLine2.SetRange(IRLine2.Awarded, IRLine.Awarded);
                IRLine2.SetRange(IRLine2."Vendor No", IRLine."Vendor No");
                if IRLine2.FindSet() then begin
                    //Get Vendor No.
                    GetAwardedSupplierVendorNo(IRLine2, VendNo);

                    ProcurementContract.Init();
                    ProcurementContract."Contract No." := '';
                    ProcurementContract.Insert(true);
                    ProcurementContract.Validate("Vendor No.", VendNo);
                    ProcurementContract.Validate(Description, IR.Title);
                    ProcurementContract.Validate("Contract Details", IRLine2.Specification);
                    ProcurementContract.Validate("Start Date", IR."Contract Date");
                    ProcurementContract.Validate("Tender/Quote No.", IR."No.");
                    ProcurementContract.Validate("Contract Ref No.", IR."Ref No.");
                    ProcurementContract.Validate("Prospective Supplier No.", IRLine2."Vendor No");
                    ProcurementContract.Validate("Shortcut Dimension 1 Code", IR."Shortcut Dimension 1 Code");
                    ProcurementContract.Validate("Shortcut Dimension 2 Code", IR."Shortcut Dimension 2 Code");
                    ProcurementContract.Modify();
                    repeat
                        Committement.UncommitPurchRequestOnCreateLPOAfterEvaluation(IR."No.", IR."Requisition No");
                        IRLine2."Quantity Received" := IRLine2."Quantity Received" + IRLine.Quantity;
                        IRLine2."LPO/Contract Generated" := true;
                        IRLine2.Modify();
                    until IRLine2.Next() = 0;
                end;
                Message(OrderCreatedSuccessMsg, ProcurementContract."Contract No.");
                LPONo := LPONo + ',' + ProcurementContract."Contract No.";
            until IRLine.Next() = 0;

            IR.Validate("LPO/Contract No.", LPONo);
            IR.Validate("LPO/Contract Generated", true);
            IR.Modify();
        end else
            Error(AwardAtLeastOneVendorErr);
    end;

    procedure GeneratePurchaseInvoiceFromContract(ProcurementContract: Record "Procurement Contract")
    var
        LineNo: Integer;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        ContractLines: Record "Procurement Contract Line";
        ItemLines: Record "Procurement Evaluation Line";
        NoInvoiceLinesForPeriodErr: Label 'No invoice lines have been selected';
    begin
        ContractLines.Reset;
        ContractLines.Setrange("Contract No.", ProcurementContract."Contract No.");
        ContractLines.SetRange(Selected, true);
        ContractLines.SetRange("Invoice Generated", false);
        if ContractLines.FindSet() then begin
            //Init Purchase Header
            PurchaseHeader.Init;
            PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Invoice;
            PurchaseHeader.Insert(true);
            PurchaseHeader.Validate("Buy-from Vendor No.", ProcurementContract."Vendor No.");
            PurchaseHeader.Validate("Posting Date", Today());
            PurchaseHeader.Validate("Document Date", Today());
            PurchaseHeader.Validate("Posting Description", ContractLines."Milestone Description");
            PurchaseHeader.Validate("Contract No.", ProcurementContract."Contract No.");
            PurchaseHeader.Validate("Assigned User ID", UserId);
            PurchaseHeader.Validate("Prices Including VAT", true);
            PurchaseHeader.Modify(true);

            //Init Purchase Lines
            repeat
                ItemLines.SetRange("Document No.", ProcurementContract."Tender/Quote No.");
                ItemLines.SetRange("Vendor No", ProcurementContract."Prospective Supplier No.");
                ItemLines.SetRange(Awarded, true);
                if ItemLines.FindSet() then begin
                    repeat
                        ItemLines.CalcFields(Specification);

                        LineNo := LineNo + 10000;
                        PurchaseLine.Init;
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Invoice;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := LineNo;
                        PurchaseLine.Insert(true);
                        PurchaseLine.Validate(Type, ItemLines.Type);
                        PurchaseLine.Validate("No.", ItemLines."No.");
                        PurchaseLine.Validate(Description, ContractLines."Milestone Description");
                        PurchaseLine.Validate(Specification, ItemLines.Specification);
                        PurchaseLine.Validate("VAT Prod. Posting Group", ItemLines."VAT Prod. Posting Group");
                        PurchaseLine.Validate(Quantity, 1);
                        PurchaseLine.Validate("Unit Cost", ContractLines.Amount);
                        PurchaseLine.Modify(true);
                    until ItemLines.Next() = 0;
                end else
                    Error('No awarded lines for the vendor');

                ContractLines."Invoice Generated" := true;
                ContractLines."Invoice No." := PurchaseHeader."No.";
                ContractLines."Generated By" := UserId();
                ContractLines.Modify;

            until ContractLines.Next = 0;

            Message('Invoice %1 has been created successfully', PurchaseHeader."No.");
        end else
            Error(NoInvoiceLinesForPeriodErr);
    end;

    procedure UpdateProcurementContractLines(PurchaseHeader: Record "Purchase Header")
    var
        ProcurementContractLines: Record "Procurement Contract Line";
    begin
        ProcurementContractLines.SetRange("Invoice Generated", true);
        ProcurementContractLines.SetRange("Invoice Posted", false);
        ProcurementContractLines.SetRange("Invoice No.", PurchaseHeader."No.");
        if ProcurementContractLines.FindSet() then begin
            repeat
                ProcurementContractLines.Validate("Invoice Posted", true);
                ProcurementContractLines.Validate("Posted Invoice No.", GetPostedPurchaseInvoiceNo(PurchaseHeader."No."));
                ProcurementContractLines.Modify();
            until ProcurementContractLines.Next() = 0;
        end;
    end;

    local procedure GetPostedPurchaseInvoiceNo(InvoiceNo: Code[20]): Code[20]
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        PurchInvHeader.SetRange("Pre-Assigned No.", InvoiceNo);
        if PurchInvHeader.FindFirst() then
            exit(PurchInvHeader."No.");
    end;

    procedure SendTenderOpeningPasswords(TenderRec: Record "Procurement Request")
    var
        TenderCommittees: Record "Tender Committees";
        CommitteeMembers: Record "Committee Member";
    begin

        TenderCommittees.Reset();
        TenderCommittees.SetRange("Tender/Quotation No", TenderRec."No.");
        if TenderCommittees.FindFirst() then begin
            CommitteeMembers.Reset();
            CommitteeMembers.SetRange("Appointment No", TenderCommittees."Appointment No");
            CommitteeMembers.SetRange(Type, CommitteeMembers.Type::Employee);
            CommitteeMembers.SetFilter("Committee Member Type", '%1|%2', CommitteeMembers."Committee Member Type"::"Opening Member", CommitteeMembers."Committee Member Type"::"Opening & Evaluation Member");
            if CommitteeMembers.FindSet() then
                repeat
                    NotifyTenderOpeningCommitteeMembers(CommitteeMembers);
                until CommitteeMembers.Next() = 0;
        end;

    end;

    procedure RestartTenderEvaluation(TenderRec: Record "Procurement Request")
    var
        SupplierEvaluationHeader: Record "Supplier Evaluation Header";
        SupplierSelection: Record "Supplier Selection";
    begin
        SupplierEvaluationHeader.Reset();
        SupplierEvaluationHeader.SetRange("Quote No", TenderRec."No.");
        if SupplierEvaluationHeader.FindSet() then begin
            repeat
                SupplierEvaluationHeader.Validate("Submitted Preliminary", false);
                SupplierEvaluationHeader.Validate("Submitted Technical", false);
                SupplierEvaluationHeader.Validate("Submitted Prequalification", false);

                UpdateTenderApplicantStage(SupplierEvaluationHeader."Quote No", SupplierEvaluationHeader."Supplier Code", Enum::"Tender Applicant Stage"::"Preliminary Evaluation");
                SupplierEvaluationHeader.Validate("Evaluation Stage", SupplierEvaluationHeader."Evaluation Stage"::"Preliminary Evaluation");

                SupplierEvaluationHeader.Modify();
            until SupplierEvaluationHeader.Next() = 0;
        end;

        //Delete Financial Suppliers
        SupplierSelection.SetRange("Reference No.", TenderRec."No.");
        if SupplierSelection.FindSet() then
            SupplierSelection.DeleteAll();
    end;

    procedure GetUserFullNameFromSystemGuid(UserGuid: Guid): Text
    var
        User: Record User;
    begin
        if User.Get(UserGuid) then
            exit(User."Full Name");
    end;

    procedure GetUserIDFromSystemGuid(UserGuid: Guid): Text
    var
        User: Record User;
    begin
        if User.Get(UserGuid) then
            exit(User."User Name");
    end;

    procedure CancelLPO(PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.Status := PurchaseHeader.Status::Cancelled;
        PurchaseHeader.Modify();
    end;
}


