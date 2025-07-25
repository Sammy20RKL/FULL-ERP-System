table 53040 "Supplier Evaluation Score"
{
    Caption = 'Supplier Evaluation Score';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(2; "Supplier Code"; Code[50])
        {
            Caption = 'Supplier Code';
            DataClassification = CustomerContent;
        }
        field(3; "Score Parameter"; Code[50])
        {
            Caption = 'Score Parameter';
            DataClassification = CustomerContent;
            TableRelation = "Supplier Evaluation SetUp";
        }
        field(4; "Score Description"; Text[100])
        {
            Caption = 'Score Description';
            DataClassification = CustomerContent;
        }
        field(5; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Score > "Maximum Score" then
                    Error('Score %1 can not be greater than %2', Score, "Maximum Score");
            end;
        }
        field(6; "Maximum Score"; Decimal)
        {
            Caption = 'Maximum Score';
            DataClassification = CustomerContent;
        }
        field(7; "Tender No."; code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; Pass; Boolean)
        {
            Caption = 'Pass';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Document No." = field("Document No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Parameter" = field("Score Parameter"),
                                                                        "Score Criteria" = const("Pass/Fail"),
                                                                        "Pass/Fail" = filter(Fail | " ")));
        }
        field(9; "Minimum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Score';
        }
        field(10; Description; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
            Caption = 'Description';
        }
        field(11; "Total Parameter Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Supplier Evaluation Score Line".Score where("Document No." = field("Document No."),
                                                                            "Supplier Code" = field("Supplier Code"),
                                                                            "Score Parameter" = field("Score Parameter")));
            Caption = 'Total Parameter Score';
        }
        field(12; "Score Criteria"; Enum "Supplier Eval Score Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Score Criteria';
        }
        field(13; "Evaluation Criteria"; Enum "Tender Evaluation Criteria")
        {
            DataClassification = CustomerContent;
        }
        field(14; Conform; Boolean)
        {
            Caption = 'Conform';
            FieldClass = FlowField;
            CalcFormula = - exist("Supplier Evaluation Score Line" where("Document No." = field("Document No."),
                                                                        "Supplier Code" = field("Supplier Code"),
                                                                        "Score Parameter" = field("Score Parameter"),
                                                                        "Score Criteria" = const("Conform/Not Conform"),
                                                                        "Conform/Not Conform" = filter("Not Conform" | " ")));
        }
        field(15; "Tender Item Type"; Enum "Tender Item Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request"."Tender Item Type" where("No." = field("Tender No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Supplier Code", "Score Parameter")
        {
            Clustered = true;
        }
    }
}





