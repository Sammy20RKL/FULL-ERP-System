table 53021 "Procurement Request"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            //  NotBlank = true;
            trigger OnValidate()
            begin
                PurchSetup.Get();

                if "Process Type" = "Process Type"::RFQ then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."Quotation Nos");
                end;

                if "Process Type" = "Process Type"::RFP then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."RFP Nos.");
                end;

                if "Process Type" = "Process Type"::Tender then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."Tender Nos.");
                end;
                if "Process Type" = "Process Type"::EOI then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."EOI Nos");
                end;
                if "Process Type" = "Process Type"::"FA Disposal Quote" then begin
                    if "No." <> xRec."No." then
                        NoSeriesMgt.TestManual(PurchSetup."FA Disposal Quote Nos");
                end;
            end;
        }
        field(2; Title; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Title';
        }
        field(3; "Requisition No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Internal Request Header"."No." where("Document Type" = filter(Purchase),
                                                                   Status = filter(Released),
                                                                   "Procurement Request No." = filter(''));
            Caption = 'Requisition No';

            trigger OnValidate()
            begin
                if "Requisition No" <> '' then begin
                    RequisitionHeader.Get("Requisition No");

                    //Delete Existing Lines
                    QuotationLines.SetRange("Document No.", "No.");
                    QuotationLines.DeleteAll();

                    //Delete Attachments
                    DocumentAttachment.SetRange("Table ID", Database::"Procurement Request");
                    DocumentAttachment.SetRange("No.", "No.");
                    DocumentAttachment.DeleteAll();

                    //Insert Header
                    "Procurement Plan No" := RequisitionHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code" := RequisitionHeader."Shortcut Dimension 1 Code";
                    Validate("Shortcut Dimension 1 Code");
                    "Shortcut Dimension 2 Code" := RequisitionHeader."Shortcut Dimension 2 Code";
                    Validate("Shortcut Dimension 2 Code");
                    "Currency Code" := RequisitionHeader."Currency Code";

                    //Insert Lines
                    RequisitionLines.Reset();
                    RequisitionLines.SetRange(RequisitionLines."Document No.", RequisitionHeader."No.");
                    if RequisitionLines.FindSet() then begin
                        repeat
                            QuotationLines.Init();
                            QuotationLines."Document No." := "No.";
                            QuotationLines."Line No" := RequisitionLines."Line No.";
                            QuotationLines.Type := RequisitionLines.Type;
                            QuotationLines.No := RequisitionLines."No.";
                            QuotationLines.Description := RequisitionLines.Description;
                            QuotationLines.Quantity := RequisitionLines.Quantity;
                            QuotationLines."Unit of Measure" := RequisitionLines."Unit of Measure";
                            QuotationLines."Procurement Plan" := RequisitionLines."Procurement Plan";
                            QuotationLines."Procurement Plan Item" := RequisitionLines."Procurement Plan Item";
                            QuotationLines."Budget Line" := RequisitionLines."Budget Line";
                            QuotationLines."Shortcut Dimension 1 Code" := RequisitionLines."Shortcut Dimension 1 Code";
                            QuotationLines.Validate("Shortcut Dimension 1 Code");
                            QuotationLines."Shortcut Dimension 2 Code" := RequisitionLines."Shortcut Dimension 2 Code";
                            QuotationLines.Validate("Shortcut Dimension 2 Code");
                            QuotationLines."Request Date" := RequisitionHeader."Requested Receipt Date";
                            QuotationLines."Expected Receipt Date" := RequisitionHeader."Expected Receipt Date";
                            QuotationLines.Committed := RequisitionLines.Committed;
                            RequisitionLines.CalcFields(Specification);
                            QuotationLines.Specification := RequisitionLines.Specification;
                            QuotationLines."VAT Prod. Posting Group" := RequisitionLines."VAT Prod. Posting Group";
                            QuotationLines."VAT %" := RequisitionLines."VAT %";
                            QuotationLines."Amount Inclusive VAT" := RequisitionLines."Amount Including VAT";
                            QuotationLines."Unit Price" := RequisitionLines."Direct Unit Cost";
                            QuotationLines.Amount := RequisitionLines."Amount Including VAT";
                            QuotationLines."Location Code" := RequisitionLines."Location Code";
                            if not QuotationLines.Get(QuotationLines."Document No.", QuotationLines."Line No") then
                                QuotationLines.Insert(true);
                        until RequisitionLines.Next() = 0;
                    end;

                    //Get Attachments
                    DocAttachMgt.CopyAttachmentsFromRec(RecordId(), Database::"Internal Request Header", "Requisition No", "No.", Enum::"Attachment Document Type"::"Procurement Request");

                end else begin
                    //Delete Existing Lines
                    QuotationLines.SetRange("Document No.", "No.");
                    QuotationLines.DeleteAll();

                    DocumentAttachment.SetRange("Table ID", Database::"Procurement Request");
                    DocumentAttachment.SetRange("No.", "No.");
                    DocumentAttachment.DeleteAll();
                end;
            end;
        }
        field(4; "Procurement Plan No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item";
            Caption = 'Procurement Plan No';
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(7; "Procurement type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement type';
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(9; "Process Type"; Enum "Procurement Process Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Process Type';
        }
        field(10; "Procurement Plan Item"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Plan Item"."Plan Item No" where("Plan Year" = field("Procurement Plan No"));
            Caption = 'Procurement Plan Item';
        }
        field(11; Category; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
            Caption = 'Category';
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
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
        field(13; "Shortcut Dimension 2 Code"; Code[20])
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
        field(14; TenderOpeningDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Opening Date';
        }
        field(16; TenderClosingDate; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'TenderClosingDate';
        }
        field(18; Addedum; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Addedum';
        }
        field(19; SiteView; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'SiteView';
        }
        field(20; Status; Enum "Tender Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(21; "Quotation Deadline"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Quotation Deadline';

            trigger OnValidate()
            begin
                if "Quotation Deadline" < Today then
                    Error('%1 can not be backdated', FieldCaption("Quotation Deadline"));
            end;
        }
        field(22; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            Caption = 'Dimension Set ID';
        }
        field(23; "Expected Closing Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Closing Time';
        }
        field(24; "Invited Suppliers"; Integer)
        {
            CalcFormula = count("Supplier Selection" where("Reference No." = field("No."),
                                                            Invited = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Invited Suppliers';
        }
        field(25; "E-Mail Body Text"; BLOB)
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail Body Text';
        }
        field(26; "E-Mail Subject"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail Subject';
        }
        field(27; Attachment; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment';
        }
        field(28; "Specify Body"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Specify Body';
        }
        field(29; "Tender Type"; Enum TenderTypes)
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Type';
        }
        field(30; "Submitted To Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Submitted To Portal';
        }
        field(31; "Ref No."; code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref No.';
        }
        field(32; "FA Disposal No."; code[20])
        {
            TableRelation = "FA Disposal" where(Status = const(Approved));
            DataClassification = CustomerContent;
            Caption = 'FA Disposal No.';

            trigger OnValidate()
            begin
                if FADisposal.Get("FA Disposal No.") then begin
                    Title := FADisposal.Comments;
                    FADisposalLine.SetRange(FADisposalLine."Document No.", FADisposal."No.");
                    if FADisposalLine.FindSet() then begin
                        repeat
                            QuotationLines.Init();
                            QuotationLines."Document No." := "No.";
                            QuotationLines."Line No" := FADisposalLine."Line No.";
                            QuotationLines.Type := QuotationLines.Type::"Fixed Asset";
                            QuotationLines.No := FADisposalLine."FA No.";
                            QuotationLines.Description := FADisposalLine.Description;
                            QuotationLines.Quantity := 1;
                            QuotationLines."FA Disposal Doc No." := "FA Disposal No.";
                            QuotationLines."Staff No." := "Staff No.";
                            QuotationLines."Staff Name" := "Staff Name";
                            if not QuotationLines.Get("No.", QuotationLines."Line No") then
                                QuotationLines.Insert(true)
                            else begin
                                QuotationLines.Type := QuotationLines.Type::"Fixed Asset";
                                QuotationLines.No := FADisposalLine."FA No.";
                                QuotationLines.Description := FADisposalLine.Description;
                                QuotationLines.Quantity := 1;
                                QuotationLines."FA Disposal Doc No." := "FA Disposal No.";
                                QuotationLines."Staff No." := "Staff No.";
                                QuotationLines."Staff Name" := "Staff Name";
                                QuotationLines.Modify();
                            end;
                        until FADisposalLine.Next() = 0;
                    end;
                end;
            end;
        }
        field(33; "Staff No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Staff No.';
        }
        field(34; "Staff Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Staff Name';
        }
        field(35; "Payment Terms"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms".Code;
            Caption = 'Payment Terms';
        }
        field(36; "Currency Code"; code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
            Caption = 'Currency Code';
        }
        field(17; "Award Criteria"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Lowest Bidder","Highest Evaluated Score";
            OptionCaption = ' ,Lowest Bidder,Highest Evaluated Score';
            Caption = 'Award Criteria';

            trigger OnValidate()
            begin
                if ("Award Criteria" = "Award Criteria"::"Highest Evaluated Score") and ("Tender Item Type" = "Tender Item Type"::Goods) then
                    Error('You can only choose Lowest Bidder for goods');
            end;
        }
        field(37; "Sent For Evaluation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sent For Evaluation';
        }
        field(38; "Technical Pass Mark"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Technical Pass Mark';
            trigger OnValidate()
            begin
                if "Technical Pass Mark" < 0 then
                    Error(NotLessThatZeroErr);

                if "Technical Pass Mark" > 100 then
                    Error(NotMoreThat100Err, FieldCaption("Technical Pass Mark"));

                "Formula Pass Mark" := 100 - "Technical Pass Mark";
            end;
        }
        field(39; "Formula Pass Mark"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Formula Pass Mark';

            trigger OnValidate()
            begin
                if "Formula Pass Mark" < 0 then
                    Error(NotLessThatZeroErr);

                if "Formula Pass Mark" > 100 then
                    Error(NotMoreThat100Err, FieldCaption("Formula Pass Mark"));

                "Technical Pass Mark" := 100 - "Formula Pass Mark";
            end;
        }
        field(40; "Tender Not Opened"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Tender Opening Register" where("Tender No." = field("No."), "Tender Opened" = const(false)));
            Editable = false;
            InitValue = false;
            Caption = 'Tender Not Opened';
        }
        field(41; "Sent For Opening"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sent For Opening';
        }
        field(42; "Tender Item Type"; Enum "Tender Item Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Tender Item Type';
        }
        field(43; "Category Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Supplier Category".Description where("Code" = field(Category)));
            Editable = false;
        }
        field(44; "Issue Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Date';
        }
        field(45; "Responsibility Centre"; Code[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Centre';
            TableRelation = "Responsibility Center".Code;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Title)
        {
        }
    }

    trigger OnInsert()
    begin
        PurchSetup.Get();

        case "Process Type" of
            "Process Type"::RFQ:
                begin
                    PurchSetup.TestField(PurchSetup."Quotation Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."Quotation Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Process Type"::RFP:
                begin
                    PurchSetup.TestField(PurchSetup."RFP Nos.");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."RFP Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Process Type"::Tender,
            "Process Type"::"Supplier Prequalification":
                begin
                    PurchSetup.TestField(PurchSetup."Tender Nos.");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."Tender Nos.", xRec."No. Series", 0D, "No.", "No. Series");

                    //Insert mandatory docs
                    //InsertProcurementDocuments("Process Type");
                end;
            "Process Type"::EOI:
                begin
                    PurchSetup.TestField(PurchSetup."EOI Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."EOI Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;

            "Process Type"::"FA Disposal Quote":
                begin
                    PurchSetup.TestField(PurchSetup."FA Disposal Quote Nos");
                    if "No." = '' then
                        NoSeriesMgt.InitSeries(PurchSetup."FA Disposal Quote Nos", xRec."No. Series", 0D, "No.", "No. Series");
                end;
        end;

        "Creation Date" := Today;
        "User ID" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField("Employee No.");
            "Staff No." := UserSetup."Employee No.";
            if EmpRec.Get("Staff No.") then
                "Staff Name" := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
            "Shortcut Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        EmpRec: Record Employee;
        FADisposal: Record "FA Disposal";
        FADisposalLine: Record "FA Disposal Line";
        RequisitionHeader: Record "Internal Request Header";
        RequisitionLines: Record "Internal Request Line";
        QuotationLines: Record "Procurement Request Lines";
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        DocumentAttachment: Record "Document Attachment";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DocAttachMgt: Codeunit "Document Attachment Custom";
        NotMoreThat100Err: Label '%1 can not be more than 100';
        NotLessThatZeroErr: Label '%1 can not be less than 0';

    procedure InsertProcurementDocuments(DocType: Enum "Procurement Process Type")
    var
        DocsRequired: Record "Document required";
        Documents: Record "Procurement Document";
        Methods: Record "Procurement Method";
        LineNo: Integer;
    begin
        Methods.Reset();
        Methods.SetRange(Type, DocType);
        if Methods.FindFirst() then begin
            Documents.Reset();
            Documents.SetRange(Type, Methods.Type);
            if Documents.Find('-') then
                repeat
                    LineNo := LineNo + 10000;
                    DocsRequired."Quote No" := "No.";
                    DocsRequired."Line No" := LineNo;
                    DocsRequired."Document Code" := Documents."Document Code";
                    DocsRequired."Document Name" := Documents.Description;
                    DocsRequired.Mandatory := Documents.Mandatory;
                    DocsRequired.Insert();
                until Documents.Next() = 0;
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}





