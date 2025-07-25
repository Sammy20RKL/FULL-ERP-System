table 53019 "FA Disposal Line"
{
    Caption = 'FA Disposal Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "FA No."; Code[50])
        {
            Caption = 'FA No.';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset" where("Marked For Disposal" = const(false), Disposed = const(false));

            trigger OnValidate()
            begin
                fa.Get("FA No.");
                Description := FA.Description;

                FaDeprBook.Reset();
                FaDeprBook.SetRange("FA No.", "FA No.");
                if FaDeprBook.FindFirst() then begin
                    FaDeprBook.CalcFields("Book Value");
                    "Residual Value" := FaDeprBook."Book Value";
                end;
            end;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; Bids; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Procurement Request Lines" where("FA Disposal Doc No." = field("Document No."),
                                                                    No = field("FA No."),
                                                                    "Line No" = field("Line No."),
                                                                    "Bid Submitted" = const(true)));
            Editable = false;
            Caption = 'Bids';
        }
        field(6; "Highest Bid"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = max("Procurement Request Lines".Amount where("FA Disposal Doc No." = field("Document No."),
                                                                        No = field("FA No."),
                                                                        "Line No" = field("Line No."),
                                                                        "Bid Submitted" = const(true)));
            Editable = false;
            Caption = 'Highest Bid';
        }
        field(7; "Residual Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        FA: Record "Fixed Asset";
        FaDeprBook: Record "FA Depreciation Book";
}





