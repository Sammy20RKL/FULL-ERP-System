page 65027 "Monitoring & Evaluation Lines"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "WorkPlan Line Objectives";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Objective Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Source; Rec.Source)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source field.';
                }
                field("Monitoring & Evaluation"; Rec."Monitoring & Evaluation")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Monitoring & Evaluation field.';
                }
                field("Evaluation Comments"; Rec."Evaluation Comments")
                {
                    ToolTip = 'Specifies the value of the Evaluation Comments field.';
                }
                field("Attachment Link"; Rec."Attachment Link")
                {
                    ExtendedDatatype = URL;
                    ToolTip = 'Specifies the value of the Attachment Link field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            separator(Action14)
            {
            }
            action("Send Back ")
            {
                Image = Return;
                ToolTip = 'Executes the Send Back  action.';

                trigger OnAction()
                var
                    CompleteTxt: Label 'Successfully Send to Workplan.';
                    ConfirmationTxt: Label 'This action will send this activity back to workplan. Do you wish to proceed!';
                begin
                    Rec.TestField("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::"In Process");

                    if not Confirm(ConfirmationTxt, true) then
                        exit;

                    Rec."Monitoring & Evaluation" := Rec."Monitoring & Evaluation"::" ";
                    Rec.Modify();
                    Message(CompleteTxt);
                end;
            }
            separator(Action13)
            {
            }
            action("Put On Hold")
            {
                Image = Pause;
                ToolTip = 'Executes the Put On Hold action.';

                trigger OnAction()
                var
                    CompleteTxt: Label 'Successfully put on hold.';
                    ConfirmationTxt: Label 'This action will send this activity on hold. Do you wish to proceed!';
                begin
                    Rec.TestField("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::"In Process");

                    if not Confirm(ConfirmationTxt, true) then
                        exit;

                    Rec."Monitoring & Evaluation" := Rec."Monitoring & Evaluation"::"On Hold";
                    Rec.Modify();
                    Message(CompleteTxt);
                end;
            }
            separator(Action11)
            {
            }
            action("In Process")
            {
                Image = Continue;
                ToolTip = 'Executes the In Process action.';

                trigger OnAction()
                var
                    CompleteTxt: Label 'Successfully set to continue monitoring & evaluation.';
                    ConfirmationTxt: Label 'This action will enable continuation of monitoring & evaluation. Do you wish to proceed!';
                begin
                    Rec.TestField("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::"On Hold");

                    if not Confirm(ConfirmationTxt, true) then
                        exit;

                    Rec."Monitoring & Evaluation" := Rec."Monitoring & Evaluation"::"In Process";
                    Rec.Modify();
                    Message(CompleteTxt);
                end;
            }
            separator(Action18)
            {
            }
            action(Close)
            {
                Image = Close;
                ToolTip = 'Executes the Close action.';

                trigger OnAction()
                var
                    CompleteTxt: Label 'Successfully Send to monitoring & evaluation.';
                    ConfirmationTxt: Label 'This action will send this  workplan activity too monitoring & evaluation. Do you wish to proceed!';
                begin
                    Rec.TestField("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::"In Process");

                    if not Confirm(ConfirmationTxt, true) then
                        exit;

                    Rec."Monitoring & Evaluation" := Rec."Monitoring & Evaluation"::Closed;
                    Rec.Modify();
                    Message(CompleteTxt);
                end;
            }
            separator(Action20)
            {
            }
            /* action("Add Attachment")
            {
                Image = Attach;

                trigger OnAction()
                var
                    docname: Code[30];
                    ProcSetup: Record "Marketing Setup";
                    filename: Text;
                    FileName2: Text;
                    filecu: Codeunit "File Management";
                    TempoFile: Text;
                begin
                    docname := Rec.Code + Rec."Objective Code";
                    docname := CONVERTSTR(docname, '/', '_');
                    docname := CONVERTSTR(docname, '\', '_');

                    ProcSetup.RESET;
                    ProcSetup.GET;
                    ProcSetup.TESTFIELD("Overal Templates Storage");
                    //filename:=filecu.OpenFileDialog('Select TOR File','TOR File','PDF Files (*.PDF)|*.PDF|All Files (*.*)|*.*');
                    //TempoFile:=filecu.UploadFile('Upload File',filename);
                    //FileName2:=ProcSetup."Overal Templates Storage"+docname+''+'_'+filecu.GetFileName(filename);
                    //filecu.CopyClientFile(filename,FileName2,TRUE);
                    FileName2 := ProcSetup."Overal Templates Storage" + docname + '' + '_' + Rec.Description + '.pdf';
                    UPLOAD('Upload File', 'Documents', 'PDF Files (*.PDF)|*.PDF|All Files (*.*)|*.*', filename, FileName2);
                    //filecu.CopyClientFile(TempoFile,FileName2,TRUE);

                    Rec."Attachment Link" := FileName2;
                end;
            } */
            /* action("View Attachment")
            {
                Image = AvailableToPromise;

                trigger OnAction()
                var
                    ToFile: Text;
                begin
                    ToFile := 'ToFile.pdf';
                    DOWNLOAD(Rec."Attachment Link", 'Download file', 'C:\', 'Text file(*.pdf)|*.pdf', ToFile);
                end;
            } */
        }
    }
}

