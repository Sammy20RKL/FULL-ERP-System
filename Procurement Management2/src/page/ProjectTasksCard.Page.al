page 53048 "Project Tasks Card"
{
    PageType = Card;
    SourceTable = "Project Tasks";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = IsOpen;

                field("Task No"; Rec."Task No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task No field';
                }
                field(Descriprion; Rec.Descriprion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Descriprion field';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                }
                field(Importance; Rec.Importance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Importance field';
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Progress Level % field';
                }
                field("Task Budget"; Rec."Task Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task Budget field';
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Start Date field';
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated End Date field';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Start Date field';
                }
                field("Actual End date"; Rec."Actual End date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual End date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';

                    trigger OnValidate()
                    begin
                        SetPageControls();
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Task Components")
            {
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Project Task Components";
                RunPageLink = "Project No" = field("Project No"),
                              "Task No" = field("Task No");
                Visible = ComponentVisible;
                ApplicationArea = All;
                ToolTip = 'Executes the Task Components action';
            }
            action(Start)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Open";
                ApplicationArea = All;
                ToolTip = 'Executes the Start action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to start this task?', false) = true then begin
                        Rec."Actual Start Date" := Today;
                        Rec.Status := Rec.Status::Started;
                        Rec.Modify();
                        ProjectTasks.Reset();
                        ProjectTasks.SetRange("Project No", Rec."Project No");
                        if ProjectTasks.FindFirst() then begin
                            if ProjectTasks."Project No" = Rec."Project No" then begin
                                Project.Reset();
                                Project.SetRange("No.", Rec."Project No");
                                if Project.FindFirst() then begin
                                    Project."Actual Start Date" := Today;
                                    Project.Modify();
                                end;
                            end;
                        end;
                    end;
                end;
            }
            action(Suspend)
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Started";
                ApplicationArea = All;
                ToolTip = 'Executes the Suspend action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this task?', false) = true then
                        Rec.Status := Rec.Status::Suspended;
                end;
            }
            action(Resume)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Suspended";
                ApplicationArea = All;
                ToolTip = 'Executes the Resume action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this project?', false) = true then
                        Rec.Status := Rec.Status::Started;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Started";
                ApplicationArea = All;
                ToolTip = 'Executes the Finish action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this project?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec."Actual End date" := Today;
                        Rec.Modify();
                    end;
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    Rec.TestField("Task No");
                    Rec.TestField(Descriprion);
                    Rec.TestField("Responsible Person");
                    Rec.TestField(Category);
                    Rec.TestField(Importance);
                    Rec.TestField("Task Budget");
                    if Confirm('Do you want to send this project for approval?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                        //      ApprovalsMgmt.OnSendProjectTaskForApproval(Rec);
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Pending Approval";
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) THEN
                        //    ApprovalsMgmt.OnCancelProjectTaskRequestApproval(Rec);
                    end;
                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Pending Approval";
                ApplicationArea = All;
                ToolTip = 'Executes the Approval Entries action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    //ApprovalEntries.Setfilters(DATABASE::"Project Tasks",ApprovalEntry."Document Type"::"Project Tasks",No);
                    ApprovalEntries.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageControls();
    end;

    trigger OnOpenPage()
    begin
        SetPageControls();
    end;

    var
        Project: Record "New Project Header";
        ProjectTasks: Record "Project Tasks";
        ComponentVisible: Boolean;
        IsFinished: Boolean;
        IsOpen: Boolean;
        IsStarted: Boolean;
        IsSuspended: Boolean;

    local procedure SetPageControls()
    begin
        IsStarted := false;
        IsSuspended := false;
        IsOpen := false;
        ComponentVisible := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::Started:
                begin
                    IsStarted := true;
                    ComponentVisible := true;
                end;
            Rec.Status::Suspended:
                IsSuspended := true;
            Rec.Status::Finished:
                IsFinished := true;
            Rec.Status::Approved:
                ComponentVisible := true;
        end;
    end;
}





