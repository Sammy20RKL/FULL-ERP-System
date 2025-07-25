page 65001 "Strategic Plan"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Strategic Plan";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Mission; Rec.Mission)
                {
                    ToolTip = 'Specifies the value of the Mission field.';
                }
                field(Vision; Rec.Vision)
                {
                    ToolTip = 'Specifies the value of the Vision field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Sent E-Mail to HOD"; Rec."Sent E-Mail to HOD")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sent E-Mail to HOD field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Closed; Rec.Closed)
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
            part(Control14; "Key Result Area")
            {
                SubPageLink = "Document No." = field(Code);
            }
            part(Control8; "Strategic Objectives")
            {
                SubPageLink = "Document No." = field(Code);
                Visible = false;
            }
            part(Control15; Strategies)
            {
                SubPageLink = Code = field(Code);
                Visible = false;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Action20)
            {
                action("Attach Strategic Plan")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Attach Strategic Plan action.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action("Strategic Objectives")
                {
                    Caption = 'Strategies';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Strategic Lines";
                    RunPageLink = "Header No." = field(Code);
                    ToolTip = 'Executes the Strategies action.';
                }
                action("Implementation Matrix")
                {
                    Image = RegisteredDocs;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Implementation Matrix action.';

                    trigger OnAction()
                    begin
                        Splan.Reset();
                        Splan.SetRange(Code, Rec.Code);
                        if Splan.FindFirst() then
                            Report.Run(Report::"Strategic Matrix", true, false, Splan);
                    end;
                }
            }
        }
        area(Processing)
        {
            group(Action21)
            {
                action("Approve Strategic Plan")
                {
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approve Strategic Plan action.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        if not Confirm('This action will approve the current strategic plan. Do you want to proceed?', true) then exit;
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved By" := UserId;
                        Rec."Date Approved" := Today;
                        Rec."Time Approved" := Time;
                        Message('The Strategic Plan has been Approved');
                    end;
                }
                action("Send Notification - HOD")
                {
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Send Notification - HOD action.';

                    trigger OnAction()
                    var
                        EmpRecs: Record Employee;
                        StrategicPlanRec: Record "Strategic Plan";
                        StrategicSetup: Record "Strategic Setup";
                        StrategyLines: Record Strategies;
                        StrategicMatrix: Report "Strategic Matrix";
                        Base64Convert: Codeunit "Base64 Convert";
                        Email: Codeunit Email;
                        EmailMessage: Codeunit "Email Message";
                        TempBlob: Codeunit "Temp Blob";
                        AttachInstr: InStream;
                        Counter: Integer;
                        AttachOutstr: OutStream;
                        Addr: Text;
                        Base64Txt: Text;
                        EmailBody: Text;
                        FileName: Text;
                        FilePath: Text;
                        EmailBodyTxtBuiler: TextBuilder;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        Rec.TestField("Sent E-Mail to HOD", false);

                        Clear(FileName);
                        StrategicSetup.Get();
                        StrategicSetup.TestField("Strategic Document Path");

                        FilePath := StrategicSetup."Strategic Document Path";

                        Clear(Addr);
                        StrategyLines.Reset();
                        StrategyLines.SetRange("Header No.", Rec.Code);
                        if StrategyLines.FindFirst() then
                            repeat
                                StrategyLines.TestField("Responsible Person");
                                EmpRecs.Get(StrategyLines."Responsible Person");

                                Counter := Counter + 1;
                                if Counter = 1 then
                                    Addr := EmpRecs."Company E-Mail"
                                else
                                    Addr := Addr + ('; ' + EmpRecs."Company E-Mail");
                            until StrategyLines.Next() = 0;

                        EmailBodyTxtBuiler.Append('Hello,');
                        EmailBodyTxtBuiler.Append('<br><br>');
                        EmailBodyTxtBuiler.Append('Kindly begin drafting your workplan as per the given format ' + '');
                        EmailBodyTxtBuiler.Append('<br><br>');
                        EmailBodyTxtBuiler.Append('Regards,');
                        EmailBodyTxtBuiler.Append('<br><br>');
                        EmailBodyTxtBuiler.Append('<b>Strategy & Planning Department</b>');
                        EmailBody := EmailBodyTxtBuiler.ToText();

                        EmailMessage.Create(Addr, 'Preparation of Workplan', EmailBody, true);

                        FileName := DelChr(Rec.Code, '=', '/|.|-') + ' ' + Format(Date2DMY(Rec."Start Date", 3)) + ' Implementation Matrix' + '.xlsx';

                        StrategicPlanRec.Reset();
                        StrategicPlanRec.SetRange(Code, Rec.Code);
                        StrategicMatrix.SetTableView(StrategicPlanRec);

                        TempBlob.CreateOutStream(AttachOutstr);
                        if StrategicMatrix.SaveAs('', ReportFormat::Excel, AttachOutstr) then begin
                            TempBlob.CreateInStream(AttachInstr);
                            Base64Txt := Base64Convert.ToBase64(AttachInstr, true);
                            EmailMessage.AddAttachment(FileName, 'application/xlsx', Base64Txt);
                        end;

                        Email.Send(EmailMessage);

                        Commit();

                        Rec."Sent E-Mail to HOD" := true;
                        Rec.Modify();

                        Message('Mail Sent.');

                        /*
                        SMTPMail.CreateMessage('MyCredit Limited',SenderAdd,MakeEmailLines."Send To",'Private Placement eStatement as at ' +FORMAT(TODAY,0,'<Month Text> <Closing><Day>, <Year4>'),'',TRUE);
                            SMTPMail.AppendBody('Dear '+ Members."First Name"+',');
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('We sincerely thank you for your continued business support.');
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('Please find attached your private placement eStatement as at '+ '<b>'+FORMAT(TODAY,0,'<Month Text> <Closing><Day>, <Year4>')+'</b>');
                            {SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('To view your statement, you can save it then when promoted for a password to open, enter <b>your ID</b>');
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('<b>number</b> .');}
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('For any clarification, please contact your Relationship Manager or the below contacts.');
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('<b>Email</b>: ' + CompanyInformation."E-Mail");
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('<b>Phone</b>: ' + CompanyInformation."Phone No.");
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('Thank You.');
                            SMTPMail.AppendBody('<br><br>');
                            SMTPMail.AppendBody('<b>MyCredit Limited</b>');
                            //SMTPMail.AddCC(ValidateAccountTocc);
                            SMTPMail.AddAttachment(MakeEmailLines.Path,'eStatement ' + FORMAT(TODAY,0,'<Month Text> <Closing><Day>, <Year4>') + '.pdf');
                            SMTPMail.Send;
                        */

                    end;
                }
                action(Close)
                {
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Close action.';

                    trigger OnAction()
                    begin
                        if not Confirm('This action will allow closure of current strategic plan. Do you want to proceed?', true) then exit;

                        Rec.Closed := true;
                        Rec."Closed BY" := UserId;
                        Rec."Date Closed" := Today;
                        Rec."Time Closed" := Time;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::"Strategic Plan"
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            CurrPage.Editable(false);
    end;

    var
        Splan: Record "Strategic Plan";
        ApprovedStatus: Boolean;
        EditThis: Boolean;

    local procedure FnApproved()
    begin
        ApprovedStatus := true;
        if Rec.Status = Rec.Status::Approved then
            ApprovedStatus := false;
    end;
}

