pageextension 50019 "Document Attachment Ext " extends "Document Attachment Details"
{
    layout
    {
        addafter("Attached Date")
        {
            field("Table ID"; Rec."Table ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ID of the table to which the attachment is related.';
                Caption = 'Table ID';
                Editable = false;
            }
            field(ID; Rec.ID)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ID of the attachment.';
                Caption = 'Attachment ID';
                Editable = false;
            }
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the attachment.';
                Caption = 'Attachment No.';
                Editable = false;
            }
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the type of document for the attachment.';
                Caption = 'Document Type';
                Editable = false;
            }

        }

    }
    actions
    {
        // modify(AttachmentsUpload)
        // {
        //     Visible=false;
        //     ApplicationArea=All;
        // }

    }
}
