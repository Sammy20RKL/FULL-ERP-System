page 53076 "Store Request Subform"
{
    PageType = ListPart;
    SourceTable = "Internal Request Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field';
                }
                field("No."; Rec."No.")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ShowMandatory = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field(Quantity; Rec.Quantity)
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Qty. to Issue"; Rec."Qty. to Issue")
                {
                    Enabled = CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. to Issue field';
                }
                field("Quantity Issued"; Rec."Quantity Issued")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Issued field';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Quantity field';
                }
                field("Quantity In Stock"; Rec."Quantity In Stock")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity In Stock field';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Unit Cost field';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Amount field';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description 2 field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Enabled = not CanEdit and not IsStatusPending;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
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
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field';

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Line No."; Rec."Line No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type" := Rec."Document Type"::Stock;
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Document Type" := Rec."Document Type"::Stock;
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        LineFieldEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        LineFieldEditable();
    end;

    trigger OnInit()
    begin
        CanEdit := true;
    end;

    trigger OnOpenPage()
    begin
        LineFieldEditable();
    end;

    var
        InternalRequestHeader: Record "Internal Request Header";
        CanEdit: Boolean;
        IsStatusPending: Boolean;
        ShowDim: Boolean;
        ShortcutDimCode: array[8] of Code[20];

    procedure ShowFields(MultiDonor: Boolean)
    begin

        if MultiDonor then
            ShowDim := true
        else
            ShowDim := false;

        CurrPage.Update();
    end;

    local procedure LineFieldEditable()
    var
        DocStatus: Option Open,Released,"Pending Approval","Pending Prepayment",Canceled,Disapproved,Committed,Fulfilled;
    begin
        if InternalRequestHeader.Get(Rec."Document No.") then begin
            DocStatus := InternalRequestHeader.Status;
            case InternalRequestHeader.Status of
                InternalRequestHeader.Status::Released:
                    begin
                        CanEdit := true;
                        IsStatusPending := false;
                    end;
                InternalRequestHeader.Status::"Pending Approval":
                    begin
                        CanEdit := false;
                        IsStatusPending := true;
                    end
                else
                    CanEdit := false;
                    IsStatusPending := false;
            end;
        end;
    end;
}





