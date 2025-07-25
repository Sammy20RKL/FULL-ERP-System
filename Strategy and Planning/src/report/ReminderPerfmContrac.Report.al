report 65000 "Reminder - Perfm. Contrac"
{
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        InternalAuditSendMail: Codeunit "Internal Audit - Send Mail";
    begin
        InternalAuditSendMail.SendemailLogPerProcess(false, 3);
    end;
}

