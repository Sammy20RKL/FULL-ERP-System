codeunit 65004 "Page Mgt SP Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        case RecordRef.Number of
            Database::"Project Header":
                PageID := Page::"Project Card";
            Database::"Work Plan Header":
                PageID := (Page::"Work Plan");
        end;
    end;
}
