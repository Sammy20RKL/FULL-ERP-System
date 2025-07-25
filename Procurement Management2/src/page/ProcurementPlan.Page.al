page 53067 "Procurement Plan"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Procurement Plan";
    PromotedActionCategories = 'New,Process,Report,Approvals,Import/Export';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Plan Submission Cut-off"; Rec."Plan Submission Cut-off")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Submission Cut-off Date field.';
                    ShowMandatory = true;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Budget field.';
                }
                field("Total Budget Allocation"; Rec."Total Budget Allocation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Budget Allocation field';
                }
                field("Current Plan"; Rec."Current Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Plan field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            part(Control8; "Procurement Plan Items")
            {
                SubPageLink = "Plan Year" = field(Name);
                ApplicationArea = All;
                Editable = Rec.Status = Rec.Status::Open;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Export)
            {
                Caption = 'Export Procurement Plan Template';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = Export;
                ApplicationArea = All;
                ToolTip = 'Executes the Export Procurement Plan Template action';

                trigger OnAction()
                begin
                    Clear(ExportPlan);
                    ExportPlan.Run();
                end;
            }
            action(Import)
            {
                Caption = 'Import Procurement Plan';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = Import;
                ApplicationArea = All;
                ToolTip = 'Executes the Import Procurement Plan action';

                trigger OnAction()
                begin
                    Clear(ImportPlan);
                    ImportPlan.GetBudgetCode(Rec.Name);
                    ImportPlan.Run();
                end;
            }
            action("Send Plan For Approval")
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = SendApprovalRequest;
                Enabled = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                Caption = 'Send Plan For Approval';
                ToolTip = 'Executes the Send Approval Plan action';

                trigger OnAction()
                var
                    ConfirmApprovalMsg: Label 'Are you sure you want to send an approval request?';
                begin
                    if Confirm(ConfirmApprovalMsg, false) then
                        if ApprovalMgt.CheckProcurementPlanWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendProcurementPlanForApproval(Rec);

                    CurrPage.Close();
                end;
            }
            action("Cancel Plan Approval Request")
            {
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Image = CancelApprovalRequest;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";
                ApplicationArea = All;
                Caption = 'Cancel Plan Approval Request';
                ToolTip = 'Executes the Cancel Approval Plan action';

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelProcurementPlanRequest(Rec);
                end;
            }
            action("View Approvals")
            {
                Caption = 'View Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the View Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Procurement Plan");
                    Approvals.SetRange("Document No.", Rec.Name);
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.RunModal();
                end;
            }
        }
        area(Reporting)
        {
            action(PrintPlan)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Print Procurement Plan';
                Image = PrintForm;

                trigger OnAction()
                var
                    PlanRec: Record "Procurement Plan";
                    PlanReport: Report "Procurement Plans";
                begin
                    PlanRec.SetRange(Name, Rec.Name);
                    PlanReport.SetTableView(PlanRec);
                    PlanReport.Run();
                end;
            }
        }
    }

    var
        ExportPlan: XMLport "Export Procurement Plan";
        ImportPlan: XMLport "Import Procurement Plan";
        ApprovalMgt: Codeunit "Approval Mgt Procurement Ext";
}





