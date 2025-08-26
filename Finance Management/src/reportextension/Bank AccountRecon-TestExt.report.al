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
                // ***************
                // Prepared By
                // ***************
                PreparedBy := "UserId";
                PreparedDate := CreateDateTime("Statement Date", 0T);

                if PreparedUserSetup.Get(PreparedBy) then
                    PreparedUserSetup.CalcFields(Signature);

                // ***************
                // Reviewed & Approved
                // ***************
                ApprovalEntry.Reset();
                ApprovalEntry.SetCurrentKey("Sequence No.");
                ApprovalEntry.SetRange("Table ID", Database::"Bank Acc. Reconciliation");
                ApprovalEntry.SetRange("Document No.", "Statement No.");
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);

                if ApprovalEntry.FindSet() then
                    repeat
                        case ApprovalEntry."Sequence No." of
                            1:
                                begin // First approval = Reviewed By
                                    ReviewedBy := ApprovalEntry."Last Modified By User ID";
                                    ReviewedDate := ApprovalEntry."Last Date-Time Modified";
                                    if ReviewedUserSetup.Get(ReviewedBy) then
                                        ReviewedUserSetup.CalcFields(Signature);
                                end;

                            2:
                                begin // Second approval = Approved By
                                    ApprovedBy := ApprovalEntry."Last Modified By User ID";
                                    ApprovedDate := ApprovalEntry."Last Date-Time Modified";
                                    if ApprovedUserSetup.Get(ApprovedBy) then
                                        ApprovedUserSetup.CalcFields(Signature);
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
            Caption = 'Bank Acc Reconcilliation Test - AACC';
            Type = RDLC;
            LayoutFile = './src/report_layout/BankAccReconTest (2).rdlc';
        }
    }

    var
        PreparedBy: Text[100];
        ReviewedBy: Text[100];
        ApprovedBy: Text[100];
        PreparedDate: DateTime;
        ReviewedDate: DateTime;
        ApprovedDate: DateTime;


        PreparedUserSetup: Record "User Setup";
        ReviewedUserSetup: Record "User Setup";
        ApprovedUserSetup: Record "User Setup";
}
