codeunit 53009 "Doc Attachment Procurement"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure AddCustomTablesOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Procurement Request":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Internal Request Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"Procurement Evaluation Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure AddCustomTablesOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        ProcurementRequest: Record "Procurement Request";
        InternalRequestHeader: Record "Internal Request Header";
        ProcurementEvaluationHeader: Record "Procurement Evaluation Header";
    begin
        case DocumentAttachment."Table ID" of
            Database::"Procurement Request":
                begin
                    RecRef.Open(Database::"Procurement Request");
                    if ProcurementRequest.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ProcurementRequest);
                end;
            Database::"Internal Request Header":
                begin
                    RecRef.Open(Database::"Internal Request Header");
                    if InternalRequestHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(InternalRequestHeader);
                end;
            Database::"Procurement Evaluation Header":
                begin
                    RecRef.Open(Database::"Procurement Evaluation Header");
                    if ProcurementEvaluationHeader.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(ProcurementEvaluationHeader);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure InsertCustomTablesOnAfterInitFieldsFromRecRef(var RecRef: RecordRef; var DocumentAttachment: Record "Document Attachment")
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            Database::"Procurement Request",
            Database::"Procurement Evaluation Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", GetAttachmentDocumentTypeFromRec(RecRef));
                end;
            Database::"Internal Request Header":
                begin
                    FieldRef := RecRef.Field(3);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.Validate("No.", RecNo);
                    DocumentAttachment.Validate("Document Type", GetAttachmentDocumentTypeFromRec(RecRef));
                end;
        end;
    end;


    local procedure GetAttachmentDocumentTypeFromRec(RecRef: RecordRef): Enum "Document Attachment File Type"
    begin
        case RecRef.Number of
            Database::"Procurement Request":
                exit(Enum::"Attachment Document Type"::"Procurement Request");
            Database::"Procurement Evaluation Header":
                exit(Enum::"Attachment Document Type"::"Procurement Evaluation");
        end;
    end;
}






