page 53041 "Project Header Card"
{
    PageType = Card;
    SourceTable = "New Project Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = IsOpen;

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Name field';
                }
                field("Project Date"; Rec."Project Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Date field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
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
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Duration field';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Start Date field';
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual End Date field';
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Duration field';
                }
                field("Project Budget"; Rec."Project Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Budget field';
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
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Team)
            {
                Image = TeamSales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Project Team";
                RunPageLink = "Project No" = field("No.");
                Visible = IsApproved;
                ApplicationArea = All;
                ToolTip = 'Executes the Team action';
            }
            action(Task)
            {
                Image = Task;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Project Tasks";
                RunPageLink = "Project No" = field("No.");
                Visible = IsApproved;
                ApplicationArea = All;
                ToolTip = 'Executes the Task action';
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsOpen;
                ApplicationArea = All;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    Rec.TestField("Project Name");
                    Rec.TestField("Estimated Start Date");
                    Rec.TestField("Estimated End Date");
                    Rec.TestField("Project Budget");
                    if Confirm('Do you want to send this project for approval?', false) = true then begin
                        //    IF ApprovalsMgmt.CheckProjectWorkflowEnabled(Rec) THEN
                        //      ApprovalsMgmt.OnSendProjectForApproval(Rec);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSubmitted;
                ApplicationArea = All;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the approval request?', false) = true then begin
                        //    IF ApprovalsMgmt.IsProjectWorkflowEnabled(Rec) THEN
                        //    ApprovalsMgmt.OnCancelProjectRequestApproval(Rec);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                    /*if Confirm('Do you want to cancel the approval request?',false)=true then
                      begin
                        if ApprovalsMgmt.CheckProjectTaskWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnCancelProjectTaskRequestApproval(Rec);
                      end;
                    
                    Approval Entries - OnAction()
                    ApprovalEntries.Setfilters(Database::"Project Tasks",ApprovalEntry."Document Type"::"Project Tasks",No);
                    ApprovalEntries.Run();
                    */

                end;
            }
            action("Approval Entries")
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSubmitted;
                ApplicationArea = All;
                ToolTip = 'Executes the Approval Entries action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    //ApprovalEntries.Setfilters(DATABASE::Project,ApprovalEntry."Document Type"::Project,"No.");
                    ApprovalEntries.Run();
                end;
            }
            action(Suspend)
            {
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsApproved;
                ApplicationArea = All;
                ToolTip = 'Executes the Suspend action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to suspend this project?', false) = true then begin
                        Rec.Status := Rec.Status::Suspended;
                    end;
                end;
            }
            action(Resume)
            {
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = IsSuspended;
                ApplicationArea = All;
                ToolTip = 'Executes the Resume action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to resume this project?', false) = true then begin
                        Rec.Status := Rec.Status::Open;
                    end;
                end;
            }
            action(Finish)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Verified";
                ApplicationArea = All;
                ToolTip = 'Executes the Finish action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to finish this project?', false) = true then begin
                        Rec.Status := Rec.Status::Finished;
                        Rec.Validate("Actual End Date", Today);
                    end;
                end;
            }
            action("Project Team")
            {
                Image = TeamSales;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = IsFinished;
                ApplicationArea = All;
                ToolTip = 'Executes the Project Team action';

                trigger OnAction()
                begin
                    Project.Reset();
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst() then
                        Report.Run(Report::"Project Team", true, false, Project)
                end;
            }
            action("Project Tasks")
            {
                Image = Task;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = IsFinished;
                ApplicationArea = All;
                ToolTip = 'Executes the Project Tasks action';

                trigger OnAction()
                begin
                    Project.Reset();
                    Project.SetRange("No.", Rec."No.");
                    if Project.FindFirst() then
                        Report.Run(Report::"Project Tasks", true, false, Project)
                end;
            }
            action(Verify)
            {
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Pending Verification";
                ApplicationArea = All;
                ToolTip = 'Executes the Verify action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to verify this project?', false) = true then begin
                        Rec.Status := Rec.Status::Verified;
                    end;
                end;
            }
            action("Send for Verification")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"Approved";
                ApplicationArea = All;
                ToolTip = 'Executes the Send for Verification action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this project for verification?', false) = true then begin
                        ProjectTasks.Reset();
                        ProjectTasks.SetRange("Project No", Rec."No.");
                        if ProjectTasks.FindFirst() then begin
                            repeat
                                if ProjectTasks.Status <> ProjectTasks.Status::Finished then
                                    if ProjectTasks.Status <> ProjectTasks.Status::Suspended then
                                        Error(TaskStatusError, ProjectTasks."Task No");
                            until ProjectTasks.Next() = 0;
                        end else
                            Error(TaskError, Rec."No.");
                        Rec.Status := Rec.Status::"Pending Verification";
                    end;
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
        IsApproved: Boolean;
        IsFinished: Boolean;
        IsOpen: Boolean;
        IsSubmitted: Boolean;
        IsSuspended: Boolean;
        TaskStatusError: Label 'Task %1 must be finished or suspended before sending for verification.';
        TaskError: Label 'There must be at least one task for project %1 before  you send for verification.';

    local procedure SetPageControls()
    begin
        IsOpen := false;
        IsSubmitted := false;
        IsApproved := false;
        IsSuspended := false;
        IsFinished := false;
        case Rec.Status of
            Rec.Status::Open:
                IsOpen := true;
            Rec.Status::"Pending Approval":
                IsSubmitted := true;
            Rec.Status::Approved:
                IsApproved := true;
            Rec.Status::Finished:
                IsFinished := true;
            Rec.Status::Suspended:
                IsSuspended := true;
        end;
    end;
}





