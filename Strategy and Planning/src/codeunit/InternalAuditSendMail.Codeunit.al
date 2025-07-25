codeunit 65000 "Internal Audit - Send Mail"
{

    trigger OnRun()
    begin
        //MESSAGE( FORMAT( CALCDATE('7D',120322D) ) );
        //SendInternalAuditFindingDueDate(120322D);
        //InternalAuditProjectOverdue(190322D);
        //SendInternalAuditFindingDueDate(311222D);
        //MESSAGE( FORMAT( CALCDATE('-3D',120622D) ) );
        //SendPerformanceContract(CALCDATE('-3D',120622D));
    end;

    procedure SendPerformanceContract(DueDate: Date)
    var
        PerformanceContractn: Record "Performance Contracting";
        PerformanceContractnLines: Record "Performance Contracting Lines";
        Addr1: Text;
        Addr2: Text;
        messagetext: Text;
    begin
        Clear(Addr1);
        Addr1 := UserId();

        PerformanceContractn.Reset();
        PerformanceContractn.SetRange(Closed, false);
        PerformanceContractn.SetFilter("Due Date", '<>%1', 0D);
        if PerformanceContractn.FindFirst() then
            repeat
                Clear(messagetext);
                if CalcDate('-1M', PerformanceContractn."Due Date") = DueDate then
                    messagetext := 'Kindly know that you  have a month left to submitted performance contracting documents.'
                else
                    if CalcDate('-1W', PerformanceContractn."Due Date") = DueDate then
                        messagetext := 'Kindly know that you  have a week left to submitted performance contracting documents'
                    else
                        if CalcDate('-3D', PerformanceContractn."Due Date") = DueDate then
                            messagetext := 'Kindly know that you  have 3 days left to submitted performance contracting documents';

                if messagetext <> '' then begin
                    PerformanceContractnLines.Reset();
                    PerformanceContractnLines.SetRange("Document No.", PerformanceContractn.Code);
                    PerformanceContractnLines.SetFilter("Row Text", '<>%1', '');
                    if PerformanceContractnLines.FindFirst() then
                        repeat
                            Clear(Addr2);
                            Addr2 := SetPerformanceDeptemails(PerformanceContractnLines."Row Text");
                            if (DelChr(Addr2, '=', ';') <> '') and (Addr1 <> '') then
                                SentEmailLogEntries(PerformanceContractn.Code,
                                                            10000,
                                                            Today,
                                                           UserId,
                                                           'P001',
                                                                3,
                                                            Addr1,
                                                            Addr2,
                                                               '',
                          'Due Performance Contracting Documents',
                                                          'Hello',
                                                      messagetext,
                                                               '',
                                                               '',
                    PerformanceContractnLines."Row Text",
                              PerformanceContractnLines."Row No.",
                     Format(PerformanceContractnLines."Line No."),
                                        'Performance Contracting',
                                                           false);
                        until PerformanceContractnLines.Next() = 0;
                end;
            until PerformanceContractn.Next() = 0;
    end;

    local procedure SetPerformanceDeptemails(DeptId: Code[20]) emails: Text
    var
        EmpRecs: Record Employee;
        Departmen: Record "Performance Contracting Dept.";
        Contacts: Record "Performance Contracting Users";
    begin
        Departmen.Reset();
        if Departmen.Get(DeptId) then begin

            Contacts.Reset();
            Contacts.SetRange("Document No.", Departmen.Code);
            if Contacts.FindFirst() then
                repeat
                    EmpRecs.Get(Contacts.Resource);
                    if EmpRecs."E-Mail" <> '' then
                        emails += EmpRecs."Company E-Mail" + '; ';
                until Contacts.Next() = 0;

        end;
    end;

    procedure SendemailLogPerProcess(Attempt: Boolean; ProcessType: Option " ",Project,"Action Step","Performance Contracting") LineNum: Integer
    var
        EmailLog: Record "Sent EmailLog";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailLog.Reset();
        EmailLog.SetRange(Attempt, Attempt);
        EmailLog.SetRange("Process Type", ProcessType);
        if EmailLog.FindFirst() then
            repeat
                EmailLog.Attempt := true;
                EmailLog.Modify();

                EmailMessage.Create(EmailLog."Sent To", EmailLog.Subject, EmailLog.Body);
                if EmailLog."Copy To" <> '' then
                    EmailMessage.AddRecipient(Enum::"Email Recipient Type"::Cc, EmailLog."Copy To");
                Email.Send(EmailMessage);

                EmailLog.Validate(Sent, true);
                EmailLog.Modify();
            until EmailLog.Next() = 0;

        /*
      EmailLog.SETRANGE("No.", DocuNum);
      EmailLog.SETRANGE("Document Date",DocuDate);
      IF EmailLog.FINDLAST THEN
      LineNum := EmailLog."Line No.";*/

    end;

    local procedure SentEmailLogEntries(DocuNum: Code[20]; LineNum: Integer; DocuDate: Date; CreatedBY: Code[50]; ProcessCode: Code[20]; ProcessType: Option " ",Project,"Action Step","Performance Contracting"; SentFrom: Text; SentTo: Text; CopyTo: Text; Subject: Text; Salutation: Text; Body: Text; Body2: Text; Body3: Text; Body4: Text; Body5: Text; Body6: Text; SendFrom: Text; Sent: Boolean)
    var
        SentEmailLog: Record "Sent EmailLog";
    begin
        SentEmailLog.Init();
        SentEmailLog."No." := DocuNum;
        SentEmailLog."Line No." := SentEmailLogNextNo(DocuNum, DocuDate) + LineNum;
        SentEmailLog."Document Date" := DocuDate;
        SentEmailLog."Created BY" := CreatedBY;
        SentEmailLog."Process Code" := ProcessCode;
        SentEmailLog."Process Type" := ProcessType;
        SentEmailLog."Sent From" := SentFrom;
        SentEmailLog."Sent To" := SentTo;
        SentEmailLog."Copy To" := CopyTo;
        SentEmailLog.Subject := Subject;
        SentEmailLog.Salutation := Salutation;
        SentEmailLog.Body := Body;
        SentEmailLog.Body2 := Body2;
        SentEmailLog.Body3 := Body3;
        SentEmailLog.Body4 := Body4;
        SentEmailLog.Body5 := Body5;
        SentEmailLog."Send From" := SendFrom;
        SentEmailLog.Validate(Sent, Sent);
        SentEmailLog.Insert();
    end;

    local procedure SentEmailLogNextNo(DocuNum: Code[20]; DocuDate: Date) LineNum: Integer
    var
        SentEmailLog: Record "Sent EmailLog";
    begin
        SentEmailLog.Reset();
        SentEmailLog.SetRange("No.", DocuNum);
        SentEmailLog.SetRange("Document Date", DocuDate);
        if SentEmailLog.FindLast() then
            LineNum := SentEmailLog."Line No.";
    end;
}

