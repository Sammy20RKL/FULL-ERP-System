table 53041 "Supplier Evaluation Score Line"
{
    Caption = 'Supplier Evaluation Score Line';
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
            DataClassification = CustomerContent;
            Caption = 'Supplier Code';
        }
        field(3; "Score Parameter"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Score Parameter';
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; "Score Description"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Score Description';
        }
        field(6; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
        }
        field(8; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
            //BlankZero = true;

            trigger OnValidate()
            begin
                if "Score Criteria" = "Score Criteria"::Score then begin
                    if Score > "Maximum Score" then
                        Error('%1 can not be greater than the Maximum set score of %2', Score, "Maximum Score");
                end;
            end;
        }
        field(10; "Score Criteria"; Enum "Supplier Eval Score Types")
        {
            DataClassification = CustomerContent;
            Caption = 'Score Criteria';
        }
        field(11; "Pass/Fail"; Option)
        {
            OptionMembers = " ","Pass","Fail";
            DataClassification = CustomerContent;
            Caption = 'Pass/Fail';

            trigger OnValidate()
            begin
                case "Pass/Fail" of
                    "Pass/Fail"::" ",
                    "Pass/Fail"::Fail:
                        "Pass/Fail Score" := 0;
                    "Pass/Fail"::Pass:
                        "Pass/Fail Score" := 1;
                end;

            end;
        }
        field(12; "Pass/Fail Score"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Pass/Fail Score';
        }
        field(13; "Evaluation Criteria"; Enum "Tender Evaluation Criteria")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Evaluation Score"."Evaluation Criteria" where("Document No." = field("Document No."),
                                                                                        "Score Parameter" = field("Score Parameter")));
            Caption = 'Evaluation Criteria';
        }
        field(14; "Tender No."; Code[50])
        {
            Editable = false;
            Caption = 'Tender No.';
            DataClassification = CustomerContent;
        }
        field(15; "Conform/Not Conform"; Option)
        {
            OptionMembers = " ","Conform","Not Conform";
            DataClassification = CustomerContent;
            Caption = 'Conform/Not Conform';

            trigger OnValidate()
            begin
                case "Conform/Not Conform" of
                    "Conform/Not Conform"::" ",
                    "Conform/Not Conform"::"Not Conform":
                        "Conform/Not Conform Score" := 0;
                    "Conform/Not Conform"::Conform:
                        "Conform/Not Conform Score" := 1;
                end;

            end;
        }
        field(16; "Conform/Not Conform Score"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Conform/Not Conform Score';
        }
        field(17; "Actual Zero"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Zero';
        }
        field(18; "Tender Item Type"; Enum "Tender Item Type")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request"."Tender Item Type" where("No." = field("Tender No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Supplier Code", "Score Parameter", "Line No.")
        {
            Clustered = true;
        }
    }
}





