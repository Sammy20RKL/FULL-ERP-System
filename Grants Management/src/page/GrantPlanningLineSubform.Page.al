page 60026 "Grant Planning Line Subform"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Grant Budget Line Subform';
    DataCaptionExpression = Rec.Caption();
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Job-Planning Line";

    layout
    {
        area(Content)
        {
            repeater(Control51)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    Editable = TypeEditable;
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Donor Expense Code"; Rec."Donor Expense Code")
                {
                    Caption = 'Donor Expense Code';
                    ToolTip = 'Specifies the value of the Donor Expense Code field.';
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    Caption = 'Planning Date';
                    ToolTip = 'Specifies the value of the Planning Date field.';
                }
                field("Budget Period"; Rec."Budget Period")
                {
                    Caption = 'Budget Period';
                    ToolTip = 'Specifies the value of the Budget Period field.';
                }
                field("No."; Rec."No.")
                {
                    Editable = "No.Editable";
                    Caption = 'Expense Account';
                    ToolTip = 'Specifies the value of the Expense Account field.';
                }
                field(Restriction; Rec.Restriction)
                {
                    Caption = 'Restriction';
                    ToolTip = 'Specifies the value of the Restriction field.';
                }
                field("Grant Contract Entry No."; Rec."Grant Contract Entry No.")
                {
                    Caption = 'Grant Contract Entry No.';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Grant Contract Entry No. field.';
                }
                field("Pending donor Issues"; Rec."Pending donor Issues")
                {
                    Visible = false;
                    Caption = 'Pending donor Issues';
                    ToolTip = 'Specifies the value of the Pending donor Issues field.';
                }
                field("Budget in use"; Rec."Budget in use")
                {
                    Caption = 'Budget in use';
                    ToolTip = 'Specifies the value of the Budget in use field.';
                }
                field("Special Condition for Travel"; Rec."Special Condition for Travel")
                {
                    Visible = false;
                    Caption = 'Special Condition for Travel';
                    ToolTip = 'Specifies the value of the Special Condition for Travel field.';
                }
                field("Audit Provision"; Rec."Audit Provision")
                {
                    Visible = false;
                    Caption = 'Audit Provision';
                    ToolTip = 'Specifies the value of the Audit Provision field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Currency Date"; Rec."Currency Date")
                {
                    Editable = "Currency DateEditable";
                    Visible = false;
                    Caption = 'Currency Date';
                    ToolTip = 'Specifies the value of the Currency Date field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = DescriptionEditable;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Partner; Rec.Partner)
                {
                    Caption = 'Partner';
                    ToolTip = 'Specifies the value of the Partner field.';
                }
                field("Budget Grouping Code"; Rec."Budget Grouping Code")
                {
                    Caption = 'Budget Grouping Code';
                    ToolTip = 'Specifies the value of the Budget Grouping Code field.';
                }
                field("Income Account"; Rec."Income Account")
                {
                    Caption = 'Income Account';
                    ToolTip = 'Specifies the value of the Income Account field.';
                }
                field("Description 3"; Rec."Description 3")
                {
                    Caption = 'Description 3';
                    ToolTip = 'Specifies the value of the Description 3 field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    Caption = 'Gen. Bus. Posting Group';
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    Caption = 'Gen. Prod. Posting Group';
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = "Variant CodeEditable";
                    Visible = false;
                    Caption = 'Variant Code';
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = "Location CodeEditable";
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Editable = "Work Type CodeEditable";
                    Visible = false;
                    Caption = 'Work Type Code';
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = "Unit of Measure CodeEditable";
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = QuantityEditable;
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';

                    trigger OnValidate()
                    begin
                        //Check if quantity is less than zero
                        if (Rec.Quantity <= 0) then
                            Error('Quantity should not be less than 0');
                        // END
                    end;
                }
                field("Direct Unit Cost (LCY)"; Rec."Direct Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Direct Unit Cost (LCY)';
                    ToolTip = 'Specifies the value of the Direct Unit Cost (LCY) field.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = "Unit CostEditable";
                    Caption = 'Unit Cost';
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                    ToolTip = 'Specifies the value of the Unit Cost (LCY) field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Caption = 'Total Cost';
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field("Total Cost (LCY)"; Rec."Total Cost (LCY)")
                {
                    Caption = 'Total Cost (LCY)';
                    ToolTip = 'Specifies the value of the Total Cost (LCY) field.';
                }
                field("ICIPE Contribution"; Rec."ICIPE Contribution")
                {
                    Caption = '<Own Contribution>';
                    ToolTip = 'Specifies the value of the <Own Contribution> field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = "Unit PriceEditable";
                    Visible = false;
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Visible = false;
                    Caption = 'Unit Price (LCY)';
                    ToolTip = 'Specifies the value of the Unit Price (LCY) field.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = "Line AmountEditable";
                    Caption = 'Line Amount';
                    ToolTip = 'Specifies the value of the Line Amount field.';
                }
                field("Line Amount (LCY)"; Rec."Line Amount (LCY)")
                {
                    Visible = false;
                    Caption = 'Line Amount (LCY)';
                    ToolTip = 'Specifies the value of the Line Amount (LCY) field.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = "Line Discount AmountEditable";
                    Visible = false;
                    Caption = 'Line Discount Amount';
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Editable = "Line Discount %Editable";
                    Visible = false;
                    Caption = 'Line Discount %';
                    ToolTip = 'Specifies the value of the Line Discount % field.';
                }
                field("Total Price"; Rec."Total Price")
                {
                    Visible = false;
                    Caption = 'Total Price';
                    ToolTip = 'Specifies the value of the Total Price field.';
                }
                field("Total Price (LCY)"; Rec."Total Price (LCY)")
                {
                    Visible = false;
                    Caption = 'Total Price (LCY)';
                    ToolTip = 'Specifies the value of the Total Price (LCY) field.';
                }
                field("Invoiced Amount (LCY)"; Rec."Invoiced Amount (LCY)")
                {
                    Visible = false;
                    Caption = 'Invoiced Amount (LCY)';
                    ToolTip = 'Specifies the value of the Invoiced Amount (LCY) field.';
                }
                field("Invoiced Cost Amount (LCY)"; Rec."Invoiced Cost Amount (LCY)")
                {
                    Visible = false;
                    Caption = 'Invoiced Cost Amount (LCY)';
                    ToolTip = 'Specifies the value of the Invoiced Cost Amount (LCY) field.';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    Visible = false;
                    Caption = 'Invoice Type';
                    ToolTip = 'Specifies the value of the Invoice Type field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    Visible = false;
                    Caption = 'Invoice No.';
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field(Invoiced; Rec.Invoiced)
                {
                    Visible = false;
                    Caption = 'Invoiced';
                    ToolTip = 'Specifies the value of the Invoiced field.';
                }
                field(Transferred; Rec.Transferred)
                {
                    Visible = false;
                    Caption = 'Transferred';
                    ToolTip = 'Specifies the value of the Transferred field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Grant Task No."; Rec."Grant Task No.")
                {
                    Caption = 'Grant Task No.';
                    ToolTip = 'Specifies the value of the Grant Task No. field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create &Sales Invoice")
                {
                    Caption = 'Create &Sales Invoice';
                    Ellipsis = true;
                    Image = Invoice;
                    ToolTip = 'Executes the Create &Sales Invoice action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #39004417. Unsupported part was commented. Please check it.
                        /*CurrPage.PlanningLines.FORM.*/
                        _CreateSalesInvoice(false);

                    end;
                }
                action("Create Sales &Credit Memo")
                {
                    Caption = 'Create Sales &Credit Memo';
                    Ellipsis = true;
                    Image = CreditMemo;
                    ToolTip = 'Executes the Create Sales &Credit Memo action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #39004417. Unsupported part was commented. Please check it.
                        /*CurrPage.PlanningLines.FORM.*/
                        _CreateSalesInvoice(true);

                    end;
                }
                action("Get Sales Invoice/Credit Memo")
                {
                    Caption = 'Get Sales Invoice/Credit Memo';
                    Ellipsis = true;
                    ToolTip = 'Executes the Get Sales Invoice/Credit Memo action.';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #39004417. Unsupported part was commented. Please check it.
                        /*CurrPage.PlanningLines.FORM.*/
                        GetInvoice();

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        "Unit CostEditable" := true;
        "Line AmountEditable" := true;
        "Line Discount %Editable" := true;
        "Line Discount AmountEditable" := true;
        "Unit PriceEditable" := true;
        "Work Type CodeEditable" := true;
        "Location CodeEditable" := true;
        "Variant CodeEditable" := true;
        "Unit of Measure CodeEditable" := true;
        QuantityEditable := true;
        DescriptionEditable := true;
        "No.Editable" := true;
        TypeEditable := true;
        "Currency DateEditable" := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.TestField(Transferred, false);

        if Rec."System-Created Entry" = true then
            if not Confirm(Text001, false) then
                Error('')
            else
                Rec."System-Created Entry" := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        OnAfterGetCurrRecord();
    end;

    var

        "Currency DateEditable": Boolean;

        DescriptionEditable: Boolean;

        "Line AmountEditable": Boolean;

        "Line Discount %Editable": Boolean;

        "Line Discount AmountEditable": Boolean;

        "Location CodeEditable": Boolean;

        "No.Editable": Boolean;

        QuantityEditable: Boolean;

        TypeEditable: Boolean;

        "Unit CostEditable": Boolean;

        "Unit of Measure CodeEditable": Boolean;

        "Unit PriceEditable": Boolean;

        "Variant CodeEditable": Boolean;

        "Work Type CodeEditable": Boolean;
        Text001: Label 'This Job Planning Line is generated automatically. Do you want to continue?';


    procedure _CreateSalesInvoice(CrMemo: Boolean)
    var
        JobPlanningLine: Record "Job-Planning Line";
    begin
        Rec.TestField("Line No.");
        JobPlanningLine.Copy(Rec);
        CurrPage.SetSelectionFilter(JobPlanningLine);
        //JobCreateInvoice.CreateSalesInvoice(JobPlanningLine,CrMemo)
    end;


    procedure CreateSalesInvoice(CrMemo: Boolean)
    var
        JobPlanningLine: Record "Job-Planning Line";
    begin
        Rec.TestField("Line No.");
        JobPlanningLine.Copy(Rec);
        CurrPage.SetSelectionFilter(JobPlanningLine);
        //JobCreateInvoice.CreateSalesInvoice(JobPlanningLine,CrMemo)
    end;

    local procedure SetEditable(Edit: Boolean)
    begin
        //CurrForm."Line Type".EDITABLE := Edit;
        //CurrForm."Planning Date".EDITABLE := Edit;
        "Currency DateEditable" := Edit;
        //CurrForm."Document No.".EDITABLE := Edit;
        TypeEditable := Edit;
        "No.Editable" := Edit;
        DescriptionEditable := Edit;
        QuantityEditable := Edit;
        "Unit of Measure CodeEditable" := Edit;
        "Variant CodeEditable" := Edit;
        "Location CodeEditable" := Edit;
        "Work Type CodeEditable" := Edit;
        "Unit PriceEditable" := Edit;
        "Line Discount AmountEditable" := Edit;
        "Line Discount %Editable" := Edit;
        "Line AmountEditable" := Edit;
        "Unit CostEditable" := Edit;
    end;


    procedure GetInvoice()
    begin
        //JobCreateInvoice.GetSalesInvoice(Rec);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        SetEditable(not Rec.Transferred);
    end;
}

