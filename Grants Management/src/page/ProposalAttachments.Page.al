page 60011 "Proposal Attachments"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Incoming Document Attachment";
    SourceTableView = where(Name = filter('Grant Proposal' | 'Grant Agreement' | 'Concept Notes'));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Created Date-Time"; Rec."Created Date-Time")
                {
                    Caption = 'Created Date-Time';
                    ToolTip = 'Specifies the value of the Created Date-Time field.';
                }
                field("Created By User Name"; Rec."Created By User Name")
                {
                    Caption = 'Created By User Name';
                    ToolTip = 'Specifies the value of the Created By User Name field.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("File Extension"; Rec."File Extension")
                {
                    Caption = 'File Extension';
                    ToolTip = 'Specifies the value of the File Extension field.';
                }
                field(Content; Rec.Content)
                {
                    Caption = 'Content';
                    ToolTip = 'Specifies the value of the Content field.';
                }
            }
        }
    }

    actions
    {
        /* area(creation)
        {
            action("View Document")
            {
                Image = ViewDetails;
                Promoted = true;
                Scope = Repeater;

                trigger OnAction()
                var
                    NVInStream: InStream;
                    result: Text[200];
                begin
                    Content.CREATEINSTREAM(NVInStream);
                    result := BLOBExport(NVInStream, Rec.Name, TRUE);
                end;
            }
        } */
    }

    /* var
        FileMgt: Codeunit "File Management";
        PathHelper: DotNet BCPath;
        [RunOnClient]
        DirectoryHelper: DotNet BCDirectory;
        [RunOnClient]
        ClientFileHelper: DotNet BCFile;
        ServerFileHelper: DotNet BCFile;
        ServerDirectoryHelper: DotNet BCDirectory;
        ZipArchive: DotNet BCZipArchive;
        ZipArchiveMode: DotNet BCZipArchiveMode;
        FileName: Text[100];


    procedure BLOBExport(var InStream: InStream; Name: Text; IsCommonDialog: Boolean): Text
    var
        ToFile: Text;
        Path: Text;
        IsDownloaded: Boolean;
    begin
        IF IsCommonDialog THEN BEGIN
            IF STRPOS(Name, '*') = 0 THEN
                ToFile := Name
            ELSE
                ToFile := DELCHR(INSSTR(Name, 'Default', 1), '=', '*');
            Path := PathHelper.GetDirectoryName(ToFile);
            ToFile := FileMgt.GetFileName(ToFile);
        END ELSE BEGIN
            ToFile := FileMgt.ClientTempFileName(FileMgt.GetExtension(Name));
            Path := FileMgt.Magicpath;
        END;
        IsDownloaded := DOWNLOADFROMSTREAM(InStream, 'Export', Path, FileMgt.GetToFilterText('', Name), ToFile);
        IF IsDownloaded THEN
            EXIT(ToFile);
        EXIT('');
    end; */
}

