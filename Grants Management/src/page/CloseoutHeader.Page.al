page 60033 "Close out Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Close Out Check List";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Closeout No."; Rec."Closeout No.")
                {
                    Editable = false;
                    Caption = 'Closeout No.';
                    ToolTip = 'Specifies the value of the Closeout No. field.';
                }
                field("Grant No"; Rec."Grant No")
                {
                    Caption = 'Grant No';
                    ToolTip = 'Specifies the value of the Grant No field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(PI; Rec.PI)
                {
                    Caption = 'PI';
                    ToolTip = 'Specifies the value of the PI field.';
                }
                field("PI Name"; Rec."PI Name")
                {
                    Editable = false;
                    Caption = 'PI Name';
                    ToolTip = 'Specifies the value of the PI Name field.';
                }
                field(Subcontractor; Rec.Subcontractor)
                {
                    Caption = 'Subcontractor';
                    ToolTip = 'Specifies the value of the Subcontractor field.';
                }
                field("Donor/Sponsor Code"; Rec."Donor/Sponsor Code")
                {
                    Editable = false;
                    Caption = 'Donor/Sponsor Code';
                    ToolTip = 'Specifies the value of the Donor/Sponsor Code field.';
                }
                field("Subcontractor no"; Rec."Subcontractor no")
                {
                    Caption = 'Subcontractor no';
                    ToolTip = 'Specifies the value of the Subcontractor no field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(User; Rec.User)
                {
                    Editable = false;
                    Caption = 'User';
                    ToolTip = 'Specifies the value of the User field.';
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Comments';
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(Control1000000017; "Close out Lines")
            {
                SubPageLink = "Closeout Nos" = field("Closeout No.");
                Caption = 'Close out Lines';
            }
        }
        area(FactBoxes)
        {
            systempart(Control1000000013; Outlook)
            {
            }
            systempart(Control1000000014; Notes)
            {
            }
            systempart(Control1000000015; MyNotes)
            {
            }
            systempart(Control1000000016; Links)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load Checklist")
            {
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Load Checklist';
                ToolTip = 'Executes the Load Checklist action.';

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Open then Error('Sorry, Close out number %1 is not open for appending the lines', Rec."Closeout No.");

                    //Delete the lines for the period--
                    objCloseoutLines.Reset();
                    objCloseoutLines.SetRange(objCloseoutLines."Closeout Nos", Rec."Closeout No.");
                    if objCloseoutLines.Find('-') then
                        if Confirm('Lines exist for this close out do you want to overwrite?') then
                            objCloseoutLines.DeleteAll(true)
                        else
                            exit;

                    //gET lAST NUMBER
                    objCloseoutLines.Reset();
                    objCloseoutLines.SetRange(objCloseoutLines."Line No");
                    if objCloseoutLines.Find('+') then iNo := objCloseoutLines."Line No";

                    //Get and load the cheklist
                    objLookup.Reset();
                    objLookup.SetRange(objLookup.Type, objLookup.Type::"Close Out Checklist");
                    objLookup.SetRange(objLookup."Grants no.", Rec."Grant No");
                    if objLookup.Find('-') then
                        repeat
                            objCloseoutLines.Init();
                            objCloseoutLines."Line No" := objCloseoutLines."Line No" + 1;
                            objCloseoutLines."Closeout Nos" := Rec."Closeout No.";
                            objCloseoutLines.Sections := objLookup.Remarks;
                            objCloseoutLines.Insert();
                        until objLookup.Next() = 0;


                    objLookup.Reset();
                    objLookup.SetRange(objLookup.Type, objLookup.Type::"Sub Contractor Close Out Checklist");
                    objLookup.SetRange(objLookup."Grants no.", Rec."Grant No");
                    if objLookup.Find('-') then objLookup.DeleteAll();
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",None,"Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","Employee Transfer","Salary Advance","Staff Clearance",Payroll;
                begin
                    DocumentType := DocumentType::Closeout;
                    ApprovalEntries.Setfilters(DATABASE::"Close Out Check List", DocumentType, Rec."Closeout No.");
                    ApprovalEntries.Run();
                end;
            }
            action("Send Approval Request")
            {
                Caption = 'Send Approval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Send Approval Request action.';

                trigger OnAction()
                var
                    AppMgmt: Codeunit "Approval Mgt Grant Ext";
                begin
                    IF CONFIRM('Send this Closeout for Approval?', TRUE) = FALSE THEN EXIT;
                    AppMgmt.OnSendCloseOutGrantApprovalRequest(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelAllLines;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Cancel Approval Request action.';

                trigger OnAction()
                var
                    AppMgmt: Codeunit "Approval Mgt Grant Ext";
                begin
                    IF CONFIRM('Cancel Approval Request?', TRUE) = FALSE THEN EXIT;
                    AppMgmt.OnCancelCloseOutGrantApprovalRequest(Rec);
                end;
            }
            action("Print Checklist")
            {
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageOnRec = false;
                Caption = 'Print Checklist';
                ToolTip = 'Executes the Print Checklist action.';

                trigger OnAction()
                begin
                    objCloseOut.Reset();
                    objCloseOut.SetRange(objCloseOut."Closeout No.", Rec."Closeout No.");
                    if objCloseOut.Find('-') then
                        Report.Run(39003925, true, true, objCloseOut);
                end;
            }
        }
    }

    var
        objCloseOut: Record "Close Out Check List";
        objCloseoutLines: Record "Closeout Checklist Lines";
        objLookup: Record "Grants Lookup Values";
        iNo: Integer;
}

