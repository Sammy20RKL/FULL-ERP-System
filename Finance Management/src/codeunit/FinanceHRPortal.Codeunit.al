codeunit 51015 FinanceHRPortal
{
    Permissions = tabledata 454 = RIMD;

    [ServiceEnabled]
    procedure PrintPayslip(employeeNo: Code[20]; Period: Date) BaseImage: Text
    var
        ErrorOccurred: Boolean;
        ErrorMessage: Text;
    begin
        Clear(ErrorOccurred);
        Clear(ErrorMessage);

        if not GetPayslip(employeeNo, Period, BaseImage, ErrorMessage) then
            ErrorOccurred := true;

        if ErrorOccurred then
            Error(ErrorMessage);
    end;

    internal procedure GetPayslip(employeeno: Code[20]; period: Date; var BaseImage: Text; var ErrorMessage: Text): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not Employee.Get(employeeno) then begin
            ErrorMessage := 'Employee not found';
            exit(false);
        end;

        TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        RecRef.GetTable(Employee);

        // if not Report.SaveAs(Report::"New Payslipx-Self Service", '', ReportFormat::Pdf, OutStr, RecRef) then begin
        //     ErrorMessage := 'Failed to generate payslip';
        //     exit(false);
        // end;

        TempBlob.CreateInstream(InStr, TEXTENCODING::UTF8);
        BaseImage := Base64Convert.ToBase64(InStr);
        exit(true);
    end;

    [ServiceEnabled]
    procedure PrintP9(employeeNo: Code[20]; Year: Integer) BaseImage: Text
    var
        ErrorMessage: Text;
    begin
        if not GetP9(employeeNo, Year, BaseImage, ErrorMessage) then
            Error(ErrorMessage);
    end;

    internal procedure GetP9(employeeno: Code[20]; year: Integer; var BaseImage: Text; var ErrorMessage: Text): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not Employee.Get(employeeno) then begin
            ErrorMessage := 'Employee not found';
            exit(false);
        end;

        TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        RecRef.GetTable(Employee);

        //if not Report.SaveAs(Report::"P9A Report-Self Service", '', ReportFormat::Pdf, OutStr, RecRef) then begin
        //    ErrorMessage := 'Failed to generate P9';
        //    exit(false);
        //end;

        TempBlob.CreateInstream(InStr, TEXTENCODING::UTF8);
        BaseImage := Base64Convert.ToBase64(InStr);
        exit(true);
    end;

    [ServiceEnabled]
    procedure PrintEmployeeStatement(employeeNo: Code[20]) BaseImage: Text
    var
        ErrorMessage: Text;
    begin
        if not GetEmployeeStatement(employeeNo, BaseImage, ErrorMessage) then
            Error(ErrorMessage);
    end;

    internal procedure GetEmployeeStatement(employeeno: Code[20]; var BaseImage: Text; var ErrorMessage: Text): Boolean
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not Employee.Get(employeeno) then begin
            ErrorMessage := 'Employee not found';
            exit(false);
        end;

        TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        RecRef.GetTable(Employee);

        if not Report.SaveAs(Report::"Standard Statement", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            ErrorMessage := 'Failed to generate employee statement';
            exit(false);
        end;

        TempBlob.CreateInstream(InStr, TEXTENCODING::UTF8);
        BaseImage := Base64Convert.ToBase64(InStr);
        exit(true);
    end;

    [ServiceEnabled]
    procedure GetEmployeeDetails(employeeNo: Code[20]; var FirstName: Text; var LastName: Text; var MiddleName: Text)
    begin
        if not Employee.Get(employeeNo) then
            Error('Employee not found');

        FirstName := Employee."First Name";
        LastName := Employee."Last Name";
        MiddleName := Employee."Middle Name";
    end;

    [ServiceEnabled]
    procedure CreateImprestRequisition(requisitionNo: Code[20]; empNo: Code[20]; referenceNo: Text; paymentNarration: Text[250]; destination: Code[20]; donorCode: Code[20]; projectCode: Code[20]; startDate: Date; returnDate: Date) DocNo: Code[20]
    var
        payments: Record Payments;

    begin
        if requisitionNo = '' then begin
            payments.Init();
            payments."Staff No." := empNo;

            if Employee.Get(empNo) then begin
                payments.payee := Employee."First Name" + ' ' + Employee."Last Name";
                payments.Payee := payments.payee;
                payments."Account Name" := payments.payee;
            end;

            payments."Shortcut Dimension 1 Code" := donorCode;
            payments."Shortcut Dimension 2 Code" := projectCode;
            payments."Payment Type" := payments."Payment Type"::Imprest;
            payments."Account Type" := payments."Account Type"::Customer;
            payments."Payment Narration" := paymentNarration;

            if startDate <> 0D then begin
                payments."Date of Project" := startDate;
                payments."Travel Date" := startDate;
            end;

            if returnDate <> 0D then
                payments."Date of Completion" := returnDate;

            payments.Validate("Staff No.");
            payments.Date := Today;
            payments.Status := payments.Status::Open;

            if not payments.Insert(true) then
                Error('Failed to create imprest requisition');

            DocNo := payments."No.";
        end else begin
            payments.Get(requisitionNo);
            payments."Shortcut Dimension 1 Code" := donorCode;
            payments."Shortcut Dimension 2 Code" := projectCode;
            payments."Payment Narration" := paymentNarration;
            payments.Destination := destination;

            if startDate <> 0D then begin
                payments."Date of Project" := startDate;
                payments."Travel Date" := startDate;
            end;

            if returnDate <> 0D then
                payments."Date of Completion" := returnDate;

            if not payments.Modify(true) then
                Error('Failed to update imprest requisition');

            DocNo := payments."No.";
        end;
    end;

    [ServiceEnabled]
    procedure CreateImprestLine(empNo: Code[20]; imprestNo: Code[20]; imprLineNo: Integer; expenditureType: Code[20]; projectNo: Code[20]; taskNo: Code[20]; imprestAmount: Decimal) DocNo: Code[20]
    var
        payments: Record Payments;
        imprestLines: Record "Payment Lines";
        LineNo: Integer;
    begin
        if not payments.Get(imprestNo) then
            Error('Imprest not found');

        if payments."Staff No." <> empNo then
            Error('You are not the requestor of this imprest');

        if payments.Status <> payments.Status::Open then
            Error('Imprest is not open for editing');

        if imprLineNo > 0 then begin
            if not imprestLines.Get(imprestNo, imprLineNo) then
                Error('Imprest line not found');

            imprestLines."Expenditure Type" := expenditureType;
            imprestLines.Validate("Expenditure Type");
            imprestLines."Account No" := projectNo;
            imprestLines.Validate("Account No");
            imprestLines.Amount := imprestAmount;
            imprestLines.Validate(Amount);

            if not imprestLines.Modify(true) then
                Error('Failed to update imprest line');
        end else begin
            imprestLines.Reset();
            imprestLines.SetRange("No", imprestNo);
            if imprestLines.FindLast() then
                LineNo := imprestLines."Line No" + 10000
            else
                LineNo := 10000;

            imprestLines.Init();
            imprestLines.No := imprestNo;
            imprestLines.Validate(No);
            imprestLines."Line No" := LineNo;
            imprestLines."Expenditure Type" := expenditureType;
            imprestLines.Validate("Expenditure Type");
            imprestLines."Account No" := projectNo;
            imprestLines.Validate("Account No");
            imprestLines.Amount := imprestAmount;
            imprestLines.Validate(Amount);

            if not imprestLines.Insert(true) then
                Error('Failed to add imprest line');
        end;

        DocNo := imprestNo;
    end;

    [ServiceEnabled]
    procedure DeleteImprestLine(imprestNo: Code[20]; lineNo: Integer)
    var
        imprestLines: Record "Payment Lines";
    begin
        if not imprestLines.Get(imprestNo, lineNo) then
            Error('Imprest line not found');

        if not imprestLines.Delete(true) then
            Error('Failed to delete imprest line');
    end;

    [ServiceEnabled]
    procedure CreateImprestSurrender(surrenderNo: Code[20]; empNo: Code[20]; imprestNo: Code[20]) DocNo: Code[20]
    var
        payments: Record Payments;
    begin
        if surrenderNo = '' then begin
            payments.Init();
            payments."Staff No." := empNo;

            if Employee.Get(empNo) then begin
                payments.payee := Employee."First Name" + ' ' + Employee."Last Name";
                payments."Account Name" := payments.payee;
            end;

            payments."Payment Type" := payments."Payment Type"::"Imprest Surrender";
            payments."Imprest Issue Doc. No" := imprestNo;
            payments.Date := Today;
            payments."Surrender Date" := Today;
            payments."Posting Date" := Today;
            payments.Status := payments.Status::Open;

            if not payments.Insert(true) then
                Error('Failed to create imprest surrender');

            payments.Validate("Imprest Issue Doc. No");
            if not payments.Modify(true) then
                Error('Failed to validate imprest surrender');

            DocNo := payments."No.";
        end else begin
            payments.Get(surrenderNo);
            payments."Payment Type" := payments."Payment Type"::"Imprest Surrender";
            payments."Imprest Issue Doc. No" := imprestNo;
            payments.Validate("Imprest Issue Doc. No");
            payments.Date := Today;

            if not payments.Modify(true) then
                Error('Failed to update imprest surrender');

            DocNo := payments."No.";
        end;
    end;

    [ServiceEnabled]
    procedure UpdateImprestSurrenderLine(empNo: Code[20]; imprestNo: Code[20]; actualAmount: Decimal; lineNo: Integer; comments: Text[250])
    var
        payments: Record Payments;
        imprestLines: Record "Payment Lines";
    begin
        if not payments.Get(imprestNo) then
            Error('Imprest not found');

        if payments."Staff No." <> empNo then
            Error('You are not the requestor of this imprest');

        if payments.Status <> payments.Status::Open then
            Error('Imprest is not open for editing');

        if not imprestLines.Get(imprestNo, lineNo) then
            Error('Imprest line not found');

        imprestLines."Actual Spent" := actualAmount;
        imprestLines.Validate("Actual Spent");
        imprestLines.Comments := comments;

        if not imprestLines.Modify(true) then
            Error('Failed to update imprest surrender line');
    end;

    [ServiceEnabled]
    procedure CreateStaffClaimRequisition(requisitionNo: Code[20]; empNo: Code[20]; claimType: Integer; department: Code[20]; projectCode: Code[20]; paymentNarration: Text[250]) DocNo: Code[20]
    var
        payments: Record Payments;
    begin
        if requisitionNo = '' then begin
            payments.Init();
            payments."Staff No." := empNo;

            if Employee.Get(empNo) then begin
                payments.payee := Employee."First Name" + ' ' + Employee."Last Name";
                payments."Account Name" := payments.payee;
            end;

            payments."Payment Type" := payments."Payment Type"::"Staff Claim";
            payments."Payment Narration" := paymentNarration;
            payments."Shortcut Dimension 1 Code" := projectCode;
            payments."Shortcut Dimension 2 Code" := department;
            payments."Claim Type" := claimType;
            payments.Validate("Claim Type");
            payments.Date := Today;
            payments."Account Type" := payments."Account Type"::Employee;
            payments.Status := payments.Status::Open;

            if not payments.Insert(true) then
                Error('Failed to create staff claim');

            DocNo := payments."No.";
        end else begin
            payments.Get(requisitionNo);
            payments."Payment Narration" := paymentNarration;
            payments."Shortcut Dimension 1 Code" := projectCode;
            payments."Shortcut Dimension 2 Code" := department;
            payments."Claim Type" := claimType;
            payments.Validate("Claim Type");

            if not payments.Modify(true) then
                Error('Failed to update staff claim');

            DocNo := payments."No.";
        end;
    end;

    [ServiceEnabled]
    procedure CreateStaffClaimLine(empNo: Code[20]; docNo: Code[20]; expenditureType: Code[20]; projectNo: Code[20]; taskNo: Code[20]; claimAmount: Decimal; expenditureDate: Date; expenditureDescr: Text[100]; remarks: Text) RequisitionNo: Code[20]
    var
        payments: Record Payments;
        paymentLines: Record "Payment Lines";
        LineNo: Integer;
    begin
        if not payments.Get(docNo) then
            Error('Document not found');

        if payments."Staff No." <> empNo then
            Error('You are not the requestor of this claim');

        if payments.Status <> payments.Status::Open then
            Error('Claim is not open for editing');

        paymentLines.Reset();
        paymentLines.SetRange("No", docNo);
        if paymentLines.FindLast() then
            LineNo := paymentLines."Line No" + 10000
        else
            LineNo := 10000;

        paymentLines.Init();
        paymentLines."Line No" := LineNo;
        paymentLines."Account Type" := paymentLines."Account Type"::"G/L Account";
        paymentLines.Validate("Account Type");
        paymentLines."Expenditure Type" := expenditureType;
        paymentLines.No := docNo;
        paymentLines.Validate(No);
        paymentLines.Validate("Expenditure Type");
        paymentLines.Amount := claimAmount;
        paymentLines.Validate(Amount);
        paymentLines."Expenditure Date" := expenditureDate;
        paymentLines."Expenditure Description" := expenditureDescr;

        if not paymentLines.Insert(true) then
            Error('Failed to add claim line');

        RequisitionNo := docNo;
    end;

    [ServiceEnabled]
    procedure DeleteStaffClaimLine(docNo: Code[20]; lineNo: Integer)
    var
        staffClaimLines: Record "Payment Lines";
    begin
        if not staffClaimLines.Get(docNo, lineNo) then
            Error('Claim line not found');

        if not staffClaimLines.Delete(true) then
            Error('Failed to delete claim line');
    end;

    [ServiceEnabled]
    procedure GetPayments(employeeNumber: Code[30]; documentType: Text; status: Text) data: Text
    var
        tbl_payments: Record Payments;
    begin
        case documentType of
            'Petty Cash Surrender':
                begin
                    tbl_payments.Reset();
                    tbl_payments.SetRange("Account No.", employeeNumber);
                    tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Petty Cash Surrender");
                    tbl_payments.SetRange(Status, tbl_payments.Status::Released);
                    if tbl_payments.FindSet() then
                        repeat
                            data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                                    Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' + Format(tbl_payments.Posted) + '*' +
                                    Format(tbl_payments."Total Amount") + '::::';
                        until tbl_payments.Next() = 0;
                end;

            'Staff Claim':
                begin
                    tbl_payments.Reset();
                    tbl_payments.SetRange("Account No.", employeeNumber);
                    tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Staff Claim");
                    if tbl_payments.FindSet() then
                        repeat
                            data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                                    Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' +
                                    tbl_payments."Payment Narration" + '::::';
                        until tbl_payments.Next() = 0;
                end;

            'Imprest':
                begin
                    tbl_payments.Reset();
                    tbl_payments.SetRange("Account No.", employeeNumber);
                    tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::Imprest);
                    if tbl_payments.FindSet() then
                        repeat
                            data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                                    Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' +
                                    Format(tbl_payments.Posted) + '*' + Format(tbl_payments."Imprest Amount") + '*' +
                                    tbl_payments.Payee + '*' + Format(tbl_payments.Surrendered) + '*' +
                                    Format(tbl_payments."Payment Narration") + '::::';
                        until tbl_payments.Next() = 0;
                end;

            'Surrender':
                begin
                    tbl_payments.Reset();
                    tbl_payments.SetRange("Account No.", employeeNumber);
                    tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Imprest Surrender");
                    if tbl_payments.FindSet() then
                        repeat
                            tbl_payments.CalcFields("Imprest Amount", "Actual Amount Spent");
                            data += tbl_payments."No." + '*' + Format(tbl_payments.Date) + '*' + tbl_payments."Payment Narration" + '*' +
                                    Format(tbl_payments.Status) + '*' + Format(tbl_payments."Actual Petty Cash Amount Spent") + '*' +
                                    Format(tbl_payments.Posted) + '*' + tbl_payments.Payee + '*' + Format(tbl_payments."Imprest Amount") + '*' +
                                    Format(tbl_payments."Imprest Issue Doc. No") + '*' + Format(tbl_payments."Payment Narration") + '*' +
                                    Format(tbl_payments."Actual Amount Spent") + '::::';
                        until tbl_payments.Next() = 0;
                end;
        end;
    end;

    [ServiceEnabled]
    procedure AddFileLinks(recordType: Text[100]; recordNo: Code[20]; filename: Text; fileLink: Text; extensionType: Text) status: Text
    begin
        case recordType of
            'Purchase Requisition':
                status := ConvertFile(fileLink, extensionType, 38, filename, recordNo, 1);
            'Imprest Surrender':
                status := ConvertFile(fileLink, extensionType, 57000, filename, recordNo, 2);
            'Leave':
                status := ConvertFile(fileLink, extensionType, 69205, filename, recordNo, 3);
            'Imprest Requisition':
                status := ConvertFile(fileLink, extensionType, 57000, filename, recordNo, 3);
            'Claim':
                status := ConvertFile(fileLink, extensionType, 57000, filename, recordNo, 3);
            'Store Requisition':
                status := ConvertFile(fileLink, extensionType, 38, filename, recordNo, 11);
        end;
    end;

    local procedure ConvertFile(fileLink: Text; extensionType: Text; tableId: Integer; fileName: Text; recordNo: Code[20]; documentType: Integer) status: Text
    var
        tbl_documentAttachments: Record "Document Attachment";
        fileInstream: InStream;
        fileId: Guid;
    begin
        tbl_documentAttachments.Init();
        tbl_documentAttachments."Table ID" := tableId;
        tbl_documentAttachments."File Name" := fileName;

        case documentType of
            1, 11:
                tbl_documentAttachments."Document Type" := tbl_documentAttachments."Document Type"::Invoice;
        end;

        tbl_documentAttachments."Line No." := 10000;
        tbl_documentAttachments."No." := recordNo;
        tbl_documentAttachments."File Extension" := extensionType;

        case extensionType.ToLower() of
            'pdf':
                tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::PDF;
            'docx':
                tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Word;
            'xlsx':
                tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Excel;
            'png', 'jpeg', 'jpg':
                tbl_documentAttachments."File Type" := tbl_documentAttachments."File Type"::Image;
        end;

        fileId := tbl_documentAttachments."Document Reference ID".ImportStream(fileInstream, fileName);
        if tbl_documentAttachments.Insert(true) then
            status := 'success*The document was successfully attached'
        else
            status := 'error*An error occurred during the process of creating a document link';
    end;

    [ServiceEnabled]
    procedure SendPaymentsApproval(docNo: Code[30])
    var

    begin
        CashManagementSetup.Get();
        GeneralLedgerSetup.Get();

        if not PaymentsRec.Get(docNo) then
            Error('Payment document not found');

        case PaymentsRec."Payment Type" of
            PaymentsRec."Payment Type"::"Bank Transfer":
                begin
                    PaymentsRec.TestField("Receiving Bank Amount");
                    PaymentsRec.TestField("Source Bank Amount");
                    PaymentsRec.TestField("Source Bank");
                    PaymentsRec.TestField("Payment Narration");
                    PaymentsRec.TestField("Account No.");
                    PaymentsRec.TestField(Date);

                    if PaymentsRec."Receiving Amount LCY" <> PaymentsRec."Source Amount LCY" then
                        Error('Please make sure both Receiving and Source Amounts are the same');
                end;

            PaymentsRec."Payment Type"::Imprest:
                begin
                    PaymentsRec.CalcFields("Imprest Amount");
                    if PaymentsRec."Imprest Amount" <= 0 then
                        Error('Imprest Amount cannot be less than or equal to 0');

                    PaymentsRec.TestField("Payment Narration");

                    Committment.CheckImprestCommittment(PaymentsRec);
                    Committment.ImprestCommittment(PaymentsRec, ErrorMsg);
                    if ErrorMsg <> '' then
                        Error(ErrorMsg);
                    Commit();
                end;

            PaymentsRec."Payment Type"::"Imprest Surrender":
                begin
                    PaymentsRec.TestField("Surrender Date");
                    PaymentsRec.TestField("Surrender Date");
                end;

            PaymentsRec."Payment Type"::"Payment Voucher":
                begin
                    PaymentsRec.TestField("Paying Bank Account");
                    PaymentsRec.TestField("Shortcut Dimension 1 Code");
                    PaymentsRec.TestField("Shortcut Dimension 2 Code");
                    PaymentsRec.TestField(Payee);
                    PaymentsRec.TestField("Payment Narration");

                    PLines.Reset();
                    PLines.SetRange(No, PaymentsRec."No.");
                    if PLines.FindSet() then
                        repeat
                            if PLines."Account No" = '' then
                                Error('Account No. Field is Blank. Please Fill the Line No. %1 with amount %2.', PLines."Line No", PLines.Amount);
                        until PLines.Next() = 0;

                    Committment.CheckPVCommittment(PaymentsRec);
                    Committment.PVCommittment(PaymentsRec, ErrorMsg);
                    if ErrorMsg <> '' then
                        Error(ErrorMsg);
                end;

            PaymentsRec."Payment Type"::"Petty Cash":
                begin
                    PaymentsRec.CalcFields("Petty Cash Amount");
                    if PaymentsRec."Petty Cash Amount" <= 0 then
                        Error('Petty Cash Amount cannot be less than or equal to 0');

                    if PaymentsRec."Petty Cash Amount" > CashManagementSetup."Petty Cash Max" then
                        Error('Petty Cash amount cannot be greater than %1.%2', GeneralLedgerSetup."LCY Code", CashManagementSetup."Petty Cash Max");

                    Committment.CheckPettyCashCommittment(PaymentsRec);
                    Committment.PettyCashCommittment(PaymentsRec, ErrorMsg);
                    if ErrorMsg <> '' then
                        Error(ErrorMsg);
                end;

            PaymentsRec."Payment Type"::"Staff Claim":
                begin
                    if PaymentsRec."Payment Narration" = '' then
                        Error('Please define the Purpose for this claim');

                    PLines.Reset();
                    PLines.SetRange(PLines.No, PaymentsRec."No.");
                    if PLines.FindSet() then
                        repeat
                            PLines.TestField("Expenditure Date");
                            PLines.TestField("Expenditure Description");
                            if PLines.Amount <= 0 then
                                Error('One of your lines has an amount less than or equal to 0');
                        until PLines.Next() = 0;

                    Committment.CheckStaffClaimCommittment(PaymentsRec);
                    Committment.StaffClaimCommittment(PaymentsRec, ErrorMsg);
                    if ErrorMsg <> '' then
                        Error(ErrorMsg);
                end;
        end;

        if ApprovalMgt.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
            ApprovalMgt.OnSendPaymentsForApproval(PaymentsRec);

        UpdateApprovalEntries(docNo, PaymentsRec."Created By");
    end;

    [ServiceEnabled]
    procedure CancelPaymentsApproval(docNo: Code[30])
    begin
        if not PaymentsRec.Get(docNo) then
            Error('Payment document not found');

        case PaymentsRec."Payment Type" of
            PaymentsRec."Payment Type"::"Bank Transfer":
                begin
                    Committment.CancelPaymentsCommitments(PaymentsRec);
                    ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                end;

            PaymentsRec."Payment Type"::Imprest:
                begin
                    Committment.CancelPaymentsCommitments(PaymentsRec);
                    ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                end;

            PaymentsRec."Payment Type"::"Imprest Surrender":
                begin
                    Committment.CancelPaymentsCommitments(PaymentsRec);
                    ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                end;
        end;

        ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
    end;

    local procedure UpdateApprovalEntries(DocNo: Code[100]; SenderID: Code[50])
    var
        ApprovalEntryRec: Record "Approval Entry";
    begin
        ApprovalEntryRec.Reset();
        ApprovalEntryRec.SetRange("Document No.", DocNo);
        ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
        if ApprovalEntryRec.FindSet() then
            repeat
                ApprovalEntryRec."Sender ID" := SenderID;
                ApprovalEntryRec.Modify();
            until ApprovalEntryRec.Next() = 0;
    end;

    [ServiceEnabled]
    procedure ApproveRequest(docNo: Code[20]; username: Text) Result: Text
    var
        approvalManagement: Codeunit "Approvals Mgmt.";
    begin
        approvalEntry.Reset();
        approvalEntry.SetRange("Document No.", docNo);
        approvalEntry.SetRange("Approver ID", username);
        approvalEntry.SetRange(Status, approvalEntry.Status::Open);

        if not approvalEntry.FindSet() then
            Error('No approval requests found for this document and user');

        approvalManagement.ApproveApprovalRequests(approvalEntry);

        approvalEntry.Reset();
        approvalEntry.SetRange("Document No.", docNo);
        approvalEntry.SetRange("Approver ID", username);
        approvalEntry.SetRange(Status, approvalEntry.Status::Approved);

        if approvalEntry.FindSet() then
            Result := 'success*The Record has been approved successfully'
        else
            Result := 'danger*Sorry, you could not approve the request. Kindly try again.';
    end;

    [ServiceEnabled]
    procedure OpenPaymentsDocument(docNo: Code[30])
    begin
        PaymentsRec.Reset();
        PaymentsRec.SetRange("No.", DocNo);
        PaymentsRec.SetRange(Posted, true);
        PaymentsRec.SetRange(Status, PaymentsRec.Status::Released);

        if not PaymentsRec.FindSet() then
            Error('Oops! You can only open a document that is approved and not posted');

        PaymentsRec.Status := PaymentsRec.Status::Open;
        if not PaymentsRec.Modify(true) then
            Error('The document cannot be reopened');
    end;

    [ServiceEnabled]
    procedure UploadAttachedDocument(docNo: Code[50]; fileName: Text; fileExt: Text; attachment: Text; tableID: Integer)
    var
        DocAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        FromRecRef: RecordRef;

    begin
        if fileName = '' then
            Error('No file to upload');

        case tableID of
            Database::Payments:
                begin
                    if not PaymentsRec.Get(docNo) then
                        Error('Payment document not found');
                    FromRecRef.GetTable(PaymentsRec);
                end;
            else
                Error('Unsupported table ID');
        end;

        TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Base64Convert.FromBase64(attachment, Outstr);
        TempBlob.CreateInStream(InStr, TEXTENCODING::UTF8);

        DocAttachment.Init();
        DocAttachment.Validate("File Extension", fileExt);
        DocAttachment.Validate("File Name", fileName);
        DocAttachment.Validate("Table ID", FromRecRef.Number);
        DocAttachment.Validate("No.", docNo);
        DocAttachment."Document Reference ID".ImportStream(InStr, '', fileName);

        if not DocAttachment.Insert(true) then
            Error('Failed to attach document');
    end;

    [ServiceEnabled]
    procedure DeleteDocumentAttachment(docNo: Code[20]; tableID: Integer; docID: Integer)
    var
        DocAttachment: Record "Document Attachment";
    begin
        DocAttachment.Reset();
        DocAttachment.SetRange("Table ID", tableID);
        DocAttachment.SetRange("No.", docNo);
        DocAttachment.SetRange(ID, docID);

        if not DocAttachment.FindFirst() then
            Error('Attachment not found');

        if DocAttachment."Document Reference ID".HasValue then begin
            Clear(DocAttachment."Document Reference ID");
            DocAttachment.Modify(true);
        end;

        if not DocAttachment.Delete(true) then
            Error('Failed to delete attachment');
    end;

    [ServiceEnabled]
    procedure GetDocumentAttachment(tableId: Integer; no: Code[20]; recID: Integer) BaseImage: Text
    var
        TenantMedia: Record "Tenant Media";
        docAttachment: Record "Document Attachment";
        imageID: GUID;
    begin
        docAttachment.Reset();
        docAttachment.SetRange("Table ID", tableId);
        docAttachment.SetRange("No.", no);
        docAttachment.SetRange(ID, recID);

        if not docAttachment.FindFirst() then
            Error('Attachment not found');

        if not docAttachment."Document Reference ID".Hasvalue then
            Error('Attachment has no content');

        imageID := docAttachment."Document Reference ID".MediaId;
        if not TenantMedia.Get(imageID) then
            Error('Media content not found');

        TenantMedia.CalcFields(Content);
        TenantMedia.Content.CreateInstream(InStr, TEXTENCODING::UTF8);
        BaseImage := Base64Convert.ToBase64(InStr);
    end;

    var
        Employee: Record Employee;
        PaymentsRec: Record Payments;
        PLines: Record "Payment Lines";
        ApprovalEntry: Record "Approval Entry";
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        // TempBlob_lRec: Codeunit "Temp Blob";
        // FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        ApprovalMgt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        RecRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
        ErrorMsg: Text;
}