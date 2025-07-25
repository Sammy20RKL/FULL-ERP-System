table 53024 "Procurement Evaluation Header"
{
    Caption = 'Procurement Evaluation Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
        }
        field(2; Title; Text[70])
        {
            Caption = 'Title';
            DataClassification = CustomerContent;
        }
        field(3; "Requisition No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header";
            Caption = 'Requisition No';
        }
        field(4; "LPO/Contract Generated"; Boolean)
        {
            Caption = 'LPO/Contract Generated';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Tender: Record "Procurement Request";
            begin
                if "LPO/Contract Generated" then begin
                    if Tender.Get("No.") then begin
                        Tender.Validate(Status, Tender.Status::Archived);
                        Tender.Modify();
                    end;
                end;
            end;
        }
        field(5; Minutes; Boolean)
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Committees";
            Caption = 'Minutes';
        }
        field(6; "Awarding Committee"; Code[20])
        {
            Caption = 'Awarding Committee';
            DataClassification = CustomerContent;
        }
        field(7; "Date of Award"; Date)
        {
            Caption = 'Date of Award';
            DataClassification = CustomerContent;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(9; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(12; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(13; Comments; Blob)
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        field(14; Suggested; Boolean)
        {
            Caption = 'Suggested';
            DataClassification = CustomerContent;
        }
        field(15; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
            DataClassification = CustomerContent;
        }
        field(16; "Payment Terms"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
            Caption = 'Payment Terms';
        }
        field(17; "Contact Job Position"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Job Position';

            trigger OnValidate()
            begin
            end;
        }
        field(18; "Contact Job Position Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Job Position Title';
        }
        field(19; "Ref No."; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref No.';
        }
        field(20; "Sign-Off Employee"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Caption = 'Sign-Off Employee';

            trigger OnValidate()
            begin
                if EmpRec.Get("Sign-Off Employee") then begin
                    "Sign-Off Employee Name" := EmpRec.FullName();
                end;
            end;
        }
        field(21; "Sign-Off Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sign-Off Employee Name';
        }
        field(22; "Sign-Off Employee Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sign-Off Employee Title';
        }
        field(23; "Lowest Bid Price"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Procurement Evaluation Line"."Amount Inclusive VAT" where("Document No." = field("No."),
                                                                                    "Amount Inclusive VAT" = filter(> 0),
                                                                                    "No." = field("Item Filter"),
                                                                                    "Vendor No" = field("Vendor Filter"),
                                                                                    "Line No" = field("Line No. Filter")));
            Editable = false;
            Caption = 'Lowest Bid Price';
        }
        field(24; "Highest Financial Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = max("Procurement Evaluation Line"."Financial Score" where("Document No." = field("No."), Amount = filter(> 0)));
            Editable = false;
            Caption = 'Highest Financial Scores';
        }
        field(25; "Contact Person Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact Person Name';
        }
        field(26; "LPO/Contract No."; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'LPO/Contract No.';
        }
        field(27; "Calculation Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Per Lot","Per Item";
            OptionCaption = ' ,Per Lot,Per Item';
            Caption = 'Calculation Type';
        }
        field(28; "Item Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Item Filter';
        }
        field(29; "Vendor Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Vendor Filter';
        }
        field(30; "Evaluation Criteria"; Option)
        {
            OptionMembers = " ","Lowest Bidder",Formula;
            OptionCaption = ' ,Lowest Bidder,Formula';
            Caption = 'Evaluation Criteria';
            FieldClass = FlowField;
            CalcFormula = lookup("Procurement Request"."Award Criteria" where("No." = field("No.")));
            Editable = false;
        }
        field(31; "Lowest Vendor Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Procurement Evaluation Line"."Total Amount Per Vendor" where("Document No." = field("No."),
                                                                                        "Amount Inclusive VAT" = filter(> 0),
                                                                                        "No." = field("Item Filter"),
                                                                                        "Vendor No" = field("Vendor Filter"),
                                                                                        "Line No" = field("Line No. Filter")));
            Editable = false;
            Caption = 'Lowest Vendor Total';
        }
        field(32; "Remarks"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
            Subtype = Memo;
        }
        field(33; "Prepared By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepared By';
        }
        field(34; "Process Type"; Enum "Procurement Process Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Process Type';
        }
        field(35; "Award Comment"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Background Profile"; Blob)
        {
            DataClassification = CustomerContent;
            Subtype = Memo;
        }
        field(37; "Least Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min("Procurement Evaluation Line".Amount where("Document No." = field("No."), Amount = filter(> 0)));
            Editable = false;
            Caption = 'Least Amount';
        }
        field(38; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(39; "Responsibility Centre"; Code[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Responsibility Centre';
            TableRelation = "Responsibility Center".Code;
        }
        field(40; "Line No. Filter"; Integer)
        {
            FieldClass = FlowFilter;
            Caption = 'Line No. Filter';
        }
        field(41; "Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        QuoteEvaluation.SetRange("Document No.", "No.");
        if QuoteEvaluation.FindSet() then
            QuoteEvaluation.DeleteAll();
    end;

    var
        EmpRec: Record Employee;
        QuoteEvaluation: Record "Procurement Evaluation Line";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





