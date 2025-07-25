page 53010 "Purchase Request Subform"
{
    PageType = ListPart;
    SourceTable = "Internal Request Line";
    SourceTableView = where("Document Type" = const(Purchase));
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    Editable = not OpenApprovalEntriesExist;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field';
                }
                field(LPO; Rec.LPO)
                {
                    ApplicationArea = All;
                    Visible = ShowSupplier;
                    Editable = OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the LPO field';
                }
                field(Supplier; Rec.Supplier)
                {
                    Visible = ShowSupplier;
                    Editable = OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier field';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    //Editable = NOT IsStatusPending;
                    Visible = ShowSupplier;
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                }
                field("Document Created"; Rec."Document Created")
                {
                    Caption = 'Document Created ?';
                    Visible = false;
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Created ? field';
                }
                field(Type; Rec.Type)
                {
                    Editable = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = not OpenApprovalEntriesExist and (Rec.Type = Rec.Type::Item);
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field';
                }
                field("No."; Rec."No.")
                {
                    Enabled = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    Enabled = not OpenApprovalEntriesExist;
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(SpecificationTxt; SpecificationTxt)
                {
                    Caption = 'Specification';
                    Description = 'Specification';
                    ApplicationArea = All;
                    Enabled = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the Specification field';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Specification);
                        Rec.Specification.CreateInStream(InStrm);
                        SpecificationBigTxt.Read(InStrm);

                        if SpecificationTxt <> Format(SpecificationBigTxt) then begin
                            Clear(Rec.Specification);
                            Clear(SpecificationBigTxt);
                            SpecificationBigTxt.AddText(SpecificationTxt);
                            Rec.Specification.CreateOutStream(OutStrm);
                            SpecificationBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';

                    trigger OnValidate()
                    begin

                        if Item.Get(Rec."No.") then begin
                            UOM.Reset();
                            UOM.SetRange("Item No.", Rec."No.");
                            UOM.SetRange(Code, Item."Purch. Unit of Measure");
                            if UOM.Find('-') then begin
                                ExpectedQty := Rec.Quantity * UOM."Qty. per Unit of Measure";
                            end;
                        end;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Unit Cost field';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Enabled = ShowSupplier;
                    Visible = ShowSupplier;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Enabled = ShowSupplier;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field';
                }
                field("VAT %"; Rec."VAT %")
                {
                    Visible = ShowSupplier;
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT % field';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Amount field';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Amount Including VAT field';
                }
                field("Qty. to Order"; Rec."Qty. to Receive")
                {
                    Editable = not IsStatusPending;
                    Caption = 'Qty. to Order';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Order field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = not IsStatusPending;
                    //  Visible = ShowDim;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = not IsStatusPending;
                    // Visible = ShowDim;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Editable = false;
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Procurement Plan field';
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Line field';
                }
                field("Approved Budget Amount"; Rec."Approved Budget Amount")
                {
                    Caption = 'Approved Plan Amount';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Plan Amount field';
                }
                field("Commitment Amount"; Rec."Commitment Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitment Amount field';
                }
                field("Actual Expense"; Rec."Actual Expense")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Expense field';
                }
                field("Available amount"; Rec."Available amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available amount field';
                }
                field("Current Budget Balance"; Rec."Current Budget Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Budget Balance field.';
                }
                field("Budget Balance After"; Rec."Budget Balance After")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Balance After field.';
                }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Quantity field';
                    Visible = false;
                }
                field("Ordered Quantity"; Rec."Ordered Quantities")
                {
                    ToolTip = 'Specifies the value of the Ordered Quantity field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ordered Amount"; Rec."Ordered Amount")
                {
                    ToolTip = 'Specifies the value of the Ordered Quantity field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field';

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field';

                    trigger OnDrillDown()
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("<Control21>"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Caption = '<Control21>';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the <Control21> field';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Planned Estimated Unit Cost';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Estimated Unit Cost field';
                    Visible = false;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    Enabled = not IsStatusPending;
                    Visible = ShowSupplier;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Base Amount field';
                }
                field("Line No"; Rec."Line No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field("Document No."; Rec."Document No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Selection)
            {
                Caption = 'Select Plan Items';
                Image = Select;

                action(SelectMultiItems)
                {
                    AccessByPermission = tabledata "Procurement Plan Item" = R;
                    ApplicationArea = All;
                    Caption = 'Select Multiple Plan Items';
                    Ellipsis = true;
                    Image = NewItem;
                    ToolTip = 'Add one or more Plan items from the full list of your procurement plan items.';

                    trigger OnAction()
                    begin
                        Rec.SelectMultiplePlanItems(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Specification);
        Rec.Specification.CreateInStream(InStrm);
        SpecificationBigTxt.Read(InStrm);
        SpecificationTxt := Format(SpecificationBigTxt);

        Rec.ShowShortcutDimCode(ShortcutDimCode);
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled) then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
        SetControlAppearance();
        LineFieldEditable();
    end;

    trigger OnInit()
    begin
        ShowSupplier := false;
        IsStatusPending := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;
        GetPurchaseHeader();
        Rec."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
        Clear(Rec.Specification);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::Purchase;

        PurchSetup.Get();
        Rec."Procurement Plan" := PurchSetup."Effective Procurement Plan";

        GetPurchaseHeader();
        Rec."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";

        Clear(Rec.Specification);
        Clear(SpecificationBigTxt);
        SpecificationTxt := '';
    end;

    trigger OnOpenPage()
    begin
        //ShowShortcutDimCode(ShortcutDimCode);
        if PurchaseHeader.Get(Rec."Document No.") then begin
            if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = PurchaseHeader.Status::Fulfilled)
                 then
                ShowSupplier := true
            else
                ShowSupplier := false
        end;
        SetControlAppearance();
        LineFieldEditable();
    end;

    var
        PurchaseHeader: Record "Internal Request Header";
        Item: Record Item;
        UOM: Record "Item Unit of Measure";
        PurchSetup: Record "Purchases & Payables Setup";
        SpecificationBigTxt: BigText;
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowDim: Boolean;
        ShowSupplier: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        ExpectedQty: Decimal;
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationTxt: Text;

    procedure ShowFields(MultiDonor: Boolean)
    begin
        /* if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;
        CurrPage.Update; */
    end;

    local procedure GetPurchaseHeader()
    begin
        if PurchaseHeader.Get(Rec."Document No.") then;
    end;

    local procedure LineFieldEditable()
    begin
        if PurchaseHeader.Get(Rec."Document No.") then begin
            case PurchaseHeader.Status of
                PurchaseHeader.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                PurchaseHeader.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else begin
                    CanEdit := true;
                    IsStatusPending := false;
                end;
            end;
        end;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);

        GetPurchaseHeader();
        if (PurchaseHeader.Status = PurchaseHeader.Status::Released) or (PurchaseHeader.Status = Rec.Status::Disapproved) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(PurchaseHeader.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(PurchaseHeader.RecordId);
    end;

    local procedure ShowSup(var Show: Boolean)
    begin
        if Show = true then
            ShowSupplier := true
        else
            ShowSupplier := false;
        CurrPage.Update();
    end;
}





