table 53049 "Tender Evaluation Setup"
{
    Caption = 'Tender Evaluation Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Evaluation Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Evaluation SetUp".Code where(Active = const(true));
            Caption = 'Evaluation Code';

            trigger OnValidate()
            begin
                if SupplierEvalSetup.Get("Evaluation Code") then begin
                    SupplierEvalSetup.CalcFields(Description);
                    Rec.TransferFields(SupplierEvalSetup);

                    //Insert Parameters
                    SupplierEvalSetupLine.Reset();
                    SupplierEvalSetupLine.SetRange(Code, "Evaluation Code");
                    if SupplierEvalSetupLine.FindSet() then
                        repeat
                            SupplierEvalSetupLine.CalcFields(Description);
                            TenderEvalSetupLine.TransferFields(SupplierEvalSetupLine);
                            TenderEvalSetupLine."Tender No." := "Tender No.";
                            if not TenderEvalSetupLine.Get("Tender No.", SupplierEvalSetupLine.Code, SupplierEvalSetupLine."Line No.") then
                                TenderEvalSetupLine.Insert()
                            else begin
                                SupplierEvalSetupLine.CalcFields(Description);
                                TenderEvalSetupLine.TransferFields(SupplierEvalSetupLine);
                                TenderEvalSetupLine.Modify();
                            end;
                        until SupplierEvalSetupLine.Next() = 0;
                end;
            end;
        }
        field(2; "Evaluation Heading"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Evaluation Heading';
        }
        field(3; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
        }
        field(7; Description; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'Description';
        }
        field(9; "Score Criteria"; Enum "Supplier Eval Score Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Score Criteria';
        }
        field(11; "Evaluation Criteria"; Enum "Tender Evaluation Criteria")
        {
            DataClassification = CustomerContent;
        }
        field(12; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Tender No.", "Evaluation Code")
        {
            Clustered = true;
        }
        key(Criteria; "Evaluation Criteria")
        {
            MaintainSqlIndex = false;
        }
    }

    var
        SupplierEvalSetup: Record "Supplier Evaluation SetUp";
        SupplierEvalSetupLine: Record "Supplier Evaluation Setup Line";
        TenderEvalSetupLine: Record "Tender Evaluation Setup Line";


    trigger OnDelete()
    begin
        TenderEvalSetupLine.SetRange("Tender No.", "Tender No.");
        TenderEvalSetupLine.SetRange(Code, "Evaluation Code");
        TenderEvalSetupLine.DeleteAll();
    end;
}





