codeunit 53008 "Page Mgt Ext Procurement"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', false, false)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin

        case RecordRef.Number of
            //Requisitions
            Database::"Internal Request Header":
                PageID := (GetRequisitionsPageID(RecordRef));
            //tender Evaluation
            Database::"Procurement Evaluation Header":
                PageID := (Page::"Procurement Evaluation Card");
            //Supplier Evaluation
            Database::"Supplier Evaluation Header":
                PageID := (Page::"Supplier Evaluation Card");
            Database::"FA Disposal":
                PageID := (Page::"FA Disposal Card");
            Database::"Tender Committees":
                PageID := Page::"Committee Creation Card";
            Database::"Procurement Plan":
                PageID := Page::"Procurement Plan";
            Database::"User Changes":
                PageID := Page::"User Change Card";
        end;

    end;

    local procedure GetRequisitionsPageID(RecordRef: RecordRef): Integer
    var
        IR: Record "Internal Request Header";
    begin
        RecordRef.SetTable(IR);
        case IR."Document Type" of
            IR."Document Type"::Purchase:
                exit(Page::"Purchase Request");
            IR."Document Type"::Stock:
                exit(Page::"Store Request");
        end;
    end;
}





