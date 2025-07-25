codeunit 53010 "Proc. Reporting Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", 'SubstituteReport', '', false, false)]
    local procedure SubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        case ReportId of
            Report::"Standard Purchase - Order":
                NewReportId := Report::LPO;
        end;
    end;
}
