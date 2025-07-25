page 53141 "Proc Plan Item Approval"
{
    PageType = ListPart;
    SourceTable = "Procurement Plan Approval Line";
    Caption = 'Procurement Plan Approval Items';
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Date; Rec.Date)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Quarter Value"; Rec."Quarter Value")
                {
                    ToolTip = 'Specifies the value of the Quarter Item is Needed field';
                    ApplicationArea = All;
                    Visible = false;
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Month Name"; Rec."Month Name")
                {
                    ToolTip = 'Specifies the value of the Month Name field';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Supplier Category Code"; Rec."Supplier Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category Code field.';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Supplier Category Name"; Rec."Supplier Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category Name field.';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Caption = 'Item Description';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                    Visible = false;
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expenditure Type field.';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value nof the Quantity field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    Caption = 'Estimated Cost';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Cost field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    Visible = false;
                    Caption = 'VAT Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Code field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("Amount To Post"; Rec."Amount To Post")
                {
                    Caption = 'Total Estimated Cost (inc. VAT)';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Estimated Cost (inc. VAT) field';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field(Justification; Rec.Justification)
                {
                    ToolTip = 'Specifies the value of the Justification field';
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                }
                field("User Department"; Rec."User Department")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Department field.';
                }
                field(Reviewed; Rec.Reviewed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reviewed field.';
                    Style = Favorable;
                    StyleExpr = Rec.Reviewed;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    Visible = false;
                    Caption = 'Procurement Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Type field';
                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
                    Editable = false;
                    Caption = 'VAT Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Amount field';
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    Caption = 'Source of Funds';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source of Funds field';
                    Visible = false;
                }
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Budget';
                    ToolTip = 'Specifies the value of the Approved Budget field';
                    Visible = false;
                }
                field(Actual; Rec.Actuals)
                {
                    Caption = 'Actuals';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actuals field';
                    Visible = false;
                }
                field(Commitment; Rec.Commitments)
                {
                    Caption = 'Commitments';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commitments field';
                    Visible = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dimension Set ID field';
                }
            }
        }
    }
}





