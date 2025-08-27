pageextension 51999 BankAccountRecon extends "Bank Acc. Reconciliation"
{
    actions
    {
        addafter("P&osting")
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                action(SendApproval)
                {
                    ApplicationArea = All;
                    Caption = 'Send  For Approval';
                    ToolTip = 'Executes the Send Proposed Budget For Approval action';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Mgt Finance Ext";
                    begin
                        if ApprovalMgt.CheckBankRecWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendBankRecApproval(Rec);
                    end;
                }
            }
        }
    }
}