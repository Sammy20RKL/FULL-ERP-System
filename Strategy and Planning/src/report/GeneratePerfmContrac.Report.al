report 65001 "Generate - Perfm. Contrac"
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
        InternalAuditSendMail.SendPerformanceContract(Today);
    end;
}

