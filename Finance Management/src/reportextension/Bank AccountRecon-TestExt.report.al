reportextension 51112 "Bank Acc Reconcilliation Test" extends "Bank Acc. Recon. - Test"
{
    dataset
    {
        add("Bank Acc. Reconciliation")
        {
            column(PreparedBy; PreparedBy) { }
            column(ReviewedBy; ReviewedBy) { }
            column(ApprovedBy; ApprovedBy) { }

            column(PreparedSignature; PreparedUserSetup.Signature) { }
            column(ReviewedSignature; ReviewedUserSetup.Signature) { }
            column(ApprovedSignature; ApprovedUserSetup.Signature) { }

            column(PreparedDate; PreparedDate) { }
            column(ReviewedDate; ReviewedDate) { }
            column(ApprovedDate; ApprovedDate) { }
        }

        modify("Bank Acc. Reconciliation")
        {
            trigger OnAfterAfterGetRecord()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                // --------------------
                // Prepared By
                // --------------------
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Table ID", Database::"Bank Acc. Reconciliation");
                ApprovalEntry.SetRange("Document No.", "Statement No.");
                if ApprovalEntry.FindFirst() then begin
                    PreparedBy := ApprovalEntry."Sender ID";
                    PreparedDate := ApprovalEntry."Date-Time Sent for Approval";
                    if UserSetup.Get(PreparedBy) then begin
                        UserSetup.CalcFields(Signature);
                        PreparedUserSetup := UserSetup;
                    end;
                end;

                // --------------------
                // Reviewed By & Approved By
                // --------------------
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange("Table ID", Database::"Bank Acc. Reconciliation");
                ApprovalEntry.SetRange("Document No.", "Statement No.");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                ApprovalEntry.SetCurrentKey("Sequence No.");

                if ApprovalEntry.FindSet() then
                    repeat
                        case ApprovalEntry."Sequence No." of
                            1:
                                begin
                                    ReviewedBy := ApprovalEntry."Last Modified By User ID";
                                    ReviewedDate := ApprovalEntry."Last Date-Time Modified";
                                    if UserSetup1.Get(ReviewedBy) then begin
                                        UserSetup1.CalcFields(Signature);
                                        ReviewedUserSetup := UserSetup1;
                                    end;
                                end;
                            2:
                                begin
                                    ApprovedBy := ApprovalEntry."Last Modified By User ID";
                                    ApprovedDate := ApprovalEntry."Last Date-Time Modified";
                                    if UserSetup2.Get(ApprovedBy) then begin
                                        UserSetup2.CalcFields(Signature);
                                        ApprovedUserSetup := UserSetup2;
                                    end;
                                end;
                        end;
                    until ApprovalEntry.Next() = 0;
            end;
        }
    }

    rendering
    {
        layout(Custom)
        {
            Caption = 'BankAccReconTest(2)';
            Type = RDLC;
            LayoutFile = './src/report_layout/BankAccReconTest(2).rdl';
        }
    }

    var
        PreparedBy: Text[100];
        ReviewedBy: Text[100];
        ApprovedBy: Text[100];
        PreparedDate: DateTime;
        ReviewedDate: DateTime;
        ApprovedDate: DateTime;

        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";

        PreparedUserSetup: Record "User Setup";
        ReviewedUserSetup: Record "User Setup";
        ApprovedUserSetup: Record "User Setup";
}
