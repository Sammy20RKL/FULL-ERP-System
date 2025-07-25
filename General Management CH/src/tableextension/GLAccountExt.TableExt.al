tableextension 50007 "GL_AccountExt" extends "G/L Account"
{
    fields
    {
        field(50000; "Disbursed Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                              "G/L Account No." = field(filter(Totaling)),
                                                              "Business Unit Code" = field("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                              Date = field("Date Filter"),
                                                              "Budget Name" = field("Budget Filter"),
                                                              "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Disbursed Budget';
        }
        field(50001; "Approved Budget"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No." = field("No."),
                                                              "G/L Account No." = field(filter(Totaling)),
                                                              "Business Unit Code" = field("Business Unit Filter"),
                                                              "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                              "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                              Date = field(upperlimit("Date Filter")),
                                                              "Budget Name" = field("Budget Filter"),
                                                              "Dimension Set ID" = field("Dimension Set ID Filter")));
            Caption = 'Approved Budget';
        }
        field(50006; Commitment; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("No."), "Commitment Date" = field("Date Filter"),
                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                        Account = field(filter(Totaling)), "Commitment Type" = filter(Commitment | "Commitment Reversal"), "Dimension Set ID" = field("Dimension Set ID Filter"),
                        "Budget Code" = field("Budget Filter")));
            Caption = 'Commitment';
        }
        field(50007; Encumberance; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Commitment Entries"."Committed Amount" where(Account = field("No."), "Commitment Date" = field("Date Filter"),
                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                        Account = field(filter(Totaling)), "Commitment Type" = filter(Encumberance | "Encumberance Reversal"), "Dimension Set ID" = field("Dimension Set ID Filter"),
                        "Budget Code" = field("Budget Filter")));
            Caption = 'Encumberance';
        }
        field(50008; "Votebook Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Votebook Entry';
        }
        field(50009; "Old Account No"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Old Account No';
        }
    }

    var
        CreateGL: Label 'Do you want to create this G/L Account in %1 Company?';

    procedure ReplicateGLAcc()
    var
        CompanyRec: Record Company;
        GLAccount: Record "G/L Account";
        GLAccount2: Record "G/L Account";
    begin
        GLAccount.Copy(Rec);

        CompanyRec.Reset();
        CompanyRec.SetFilter(Name, '<>%1', CompanyName);
        if CompanyRec.Find('-') then begin
            repeat
                GLAccount2.ChangeCompany(CompanyRec.Name);
                if not GLAccount2.Get(GLAccount."No.") then begin
                    if Confirm(CreateGL, false, CompanyRec.Name) then;
                    GLAccount2.Init();
                    GLAccount2.TransferFields(GLAccount);
                    GLAccount2.Insert();
                end;
            until CompanyRec.Next() = 0;
        end;
    end;
}





