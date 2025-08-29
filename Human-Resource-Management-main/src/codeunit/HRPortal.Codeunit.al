codeunit 52011 HRPortal
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

        if not Report.SaveAs(Report::"New Payslipx-Self Service", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            ErrorMessage := 'Failed to generate payslip';
            exit(false);
        end;

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

        if not Report.SaveAs(Report::"P9A Report-Self Service", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            ErrorMessage := 'Failed to generate P9';
            exit(false);
        end;

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
    procedure CreateLeaveApplication(leaveNo: Code[20]; employeeNo: Code[20]; leaveType: Code[20]; annualLeaveType: Integer; days: Decimal; startDate: Date; reliever: Code[20]; remarks: Text) DocNo: Code[20]
    var
        leaveApplications: Record "Leave Application";
        LeaveReliever: Record "Leave Relievers";
    begin
        if leaveNo = '' then begin
            leaveApplications.Reset();
            leaveApplications.SetRange(Status, leaveApplications.Status::Open);
            leaveApplications.SetRange("Employee No", employeeNo);
            if leaveApplications.FindSet(true) then
                Error('Sorry, you already have an open leave application. Kindly use it.');

            leaveApplications.Init();
            leaveApplications."Employee No" := employeeNo;
            leaveApplications.VALIDATE("Employee No");
            leaveApplications."Leave Code" := leaveType;
            leaveApplications.VALIDATE("Leave Code");
            leaveApplications."Days Applied" := days;
            leaveApplications."Start Date" := startDate;
            leaveApplications.VALIDATE("Start Date");
            leaveApplications."Relieving Name" := reliever;
            // if reliever <> '' then
            //    leaveApplications."Leave Reliever" := true;

            //  leaveApplications.VALIDATE("Reliever No.");
            If leaveApplications.Insert(true) then begin
                LeaveReliever.Init();
                LeaveReliever."Leave Code" := leaveApplications."Application No";
                LeaveReliever."Staff No" := reliever;
                LeaveReliever.Validate("Staff No");
                LeaveReliever.Insert(true);

            end ELSE
                Error('The leave application was unsuccessful. Kindly try again later');

        end else begin
            leaveApplications.RESET();
            leaveApplications.SETRANGE("Application No", leaveNo);
            leaveApplications.SETRANGE("Employee No", employeeNo);
            IF leaveApplications.FINDSET() THEN BEGIN
                leaveApplications."Employee No" := employeeNo;
                leaveApplications.VALIDATE("Employee No");
                leaveApplications."Leave Code" := leaveType;
                leaveApplications.VALIDATE("Leave Code");
                leaveApplications."Days Applied" := days;
                leaveApplications."Start Date" := startDate;
                leaveApplications.VALIDATE("Start Date");
                leaveApplications."Relieving Name" := reliever;
                //   if reliever <> '' then
                //      leaveApplications."Leave Reliever" := true;
                //   leaveApplications.VALIDATE("Reliever No.");
                IF leaveApplications.MODIFY(TRUE) THEN BEGIN
                    LeaveReliever.Init();
                    LeaveReliever."Leave Code" := leaveApplications."Application No";
                    LeaveReliever."Staff No" := reliever;
                    LeaveReliever.Validate("Staff No");
                    LeaveReliever.Insert(true);

                end ELSE
                    Error('The leave application was unsuccessful. Kindly try again later');

            end;
        end;
    end;

    [TryFunction]
    procedure SendLeaveApproval(docNo: Code[30])
    var
        leaveApplications: Record "Leave Application";
        VarVariant: Variant;

    begin
        leaveApplications.Reset();
        leaveApplications.setrange("Application No", docNo);
        if leaveApplications.FindFirst() then begin
            leaveApplications.TestField("Leave Period");
            leaveApplications.TestField("Days Applied");
            leaveApplications.TestField("Start Date");
            leaveApplications.TestField("End Date");
            leaveApplications.TestField("Leave Code");

            VarVariant := leaveApplications;
            //Send reliever app
            //    HRMgnt.SendLeaveRelieverNotice(leaveApplications."Application No");
            //send approval
            If ApprovalMgt.CheckLeaveRecallWorkflowEnabled(VarVariant) then
                ApprovalMgt.OnSendLeaveRequestApproval(VarVariant);

            UpdateApprovalEntries(DocNo, leaveApplications."User ID");
            // JsObject.Add('Error', 'FALSE');

        end else begin
            ErrorMsg := 'Sorry, Your leave application could not be found. Kindly contact the administrator';
            Error(ErrorMsg);
        end;
    end;

    [ServiceEnabled]
    procedure CancelLeaveApproval(DocNo: Code[50])
    var
        leaveApplications: Record "Leave Application";
        VarVariant: Variant;
    begin
        leaveApplications.Reset();
        leaveApplications.setrange("Application No", docNo);
        if leaveApplications.FindFirst() then begin
            //leaveApplications.Status := leaveApplications.Status::"Open";
            VarVariant := leaveApplications;
            ApprovalMgt.OnCancelLeaveRequestApproval(VarVariant);
            //  JsObject.Add('Error', 'FALSE');
        end
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
    procedure UploadAttachedDocument(docNo: Code[50]; fileName: Text; fileExt: Text; attachment: Text; tableID: Integer)
    var
        DocAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        FromRecRef: RecordRef;

    begin
        if fileName = '' then
            Error('No file to upload');

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
        ApprovalEntry: Record "Approval Entry";

        GeneralLedgerSetup: Record "General Ledger Setup";
        // TempBlob_lRec: Codeunit "Temp Blob";
        // FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        Committment: Codeunit "Commitments Mgt HR";
        HRMgnt: Codeunit "HR Management";
        RecRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
        ErrorMsg: Text;
}