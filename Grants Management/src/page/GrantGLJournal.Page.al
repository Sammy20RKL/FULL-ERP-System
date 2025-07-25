page 60024 "Grant G/L Journal"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Grant G/L Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(Content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the value of the Batch Name field.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord();
                    GenJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    GenJnlManagement.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali();
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    Caption = 'Document Date';
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                    Caption = 'External Document No.';
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    Caption = 'Account Type';
                    ToolTip = 'Specifies the value of the Account Type field.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                    end;
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Account No.';
                    ToolTip = 'Specifies the value of the Account No. field.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    Visible = false;
                    Caption = 'Business Unit Code';
                    ToolTip = 'Specifies the value of the Business Unit Code field.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    Visible = false;
                    Caption = 'Salespers./Purch. Code';
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                    Caption = 'Campaign No.';
                    ToolTip = 'Specifies the value of the Campaign No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    AssistEdit = true;
                    Visible = false;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal() = Action::OK then
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter());
                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                    ToolTip = 'Specifies the value of the Gen. Posting Type field.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                    ToolTip = 'Specifies the value of the Gen. Prod. Posting Group field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                    Caption = 'VAT Bus. Posting Group';
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Visible = false;
                    Caption = 'VAT Prod. Posting Group';
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field("VAT %"; Rec."VAT %")
                {
                    Visible = false;
                    Caption = 'VAT %';
                    ToolTip = 'Specifies the value of the VAT % field.';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Visible = false;
                    Caption = 'VAT Amount';
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    Visible = false;
                    Caption = 'VAT Difference';
                    ToolTip = 'Specifies the value of the VAT Difference field.';
                }
                field("Bal. VAT Amount"; Rec."Bal. VAT Amount")
                {
                    Visible = false;
                    Caption = 'Bal. VAT Amount';
                    ToolTip = 'Specifies the value of the Bal. VAT Amount field.';
                }
                field("Bal. VAT Difference"; Rec."Bal. VAT Difference")
                {
                    Visible = false;
                    Caption = 'Bal. VAT Difference';
                    ToolTip = 'Specifies the value of the Bal. VAT Difference field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type';
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.';
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';

                    trigger OnValidate()
                    begin
                        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Bal. Gen. Posting Type"; Rec."Bal. Gen. Posting Type")
                {
                    Caption = 'Bal. Gen. Posting Type';
                    ToolTip = 'Specifies the value of the Bal. Gen. Posting Type field.';
                }
                field("Bal. Gen. Bus. Posting Group"; Rec."Bal. Gen. Bus. Posting Group")
                {
                    Caption = 'Bal. Gen. Bus. Posting Group';
                    ToolTip = 'Specifies the value of the Bal. Gen. Bus. Posting Group field.';
                }
                field("Bal. Gen. Prod. Posting Group"; Rec."Bal. Gen. Prod. Posting Group")
                {
                    Caption = 'Bal. Gen. Prod. Posting Group';
                    ToolTip = 'Specifies the value of the Bal. Gen. Prod. Posting Group field.';
                }
                field("Bal. VAT Bus. Posting Group"; Rec."Bal. VAT Bus. Posting Group")
                {
                    Visible = false;
                    Caption = 'Bal. VAT Bus. Posting Group';
                    ToolTip = 'Specifies the value of the Bal. VAT Bus. Posting Group field.';
                }
                field("Bal. VAT Prod. Posting Group"; Rec."Bal. VAT Prod. Posting Group")
                {
                    Visible = false;
                    Caption = 'Bal. VAT Prod. Posting Group';
                    ToolTip = 'Specifies the value of the Bal. VAT Prod. Posting Group field.';
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    Visible = false;
                    Caption = 'Bill-to/Pay-to No.';
                    ToolTip = 'Specifies the value of the Bill-to/Pay-to No. field.';
                }
                field("Ship-to/Order Address Code"; Rec."Ship-to/Order Address Code")
                {
                    Visible = false;
                    Caption = 'Ship-to/Order Address Code';
                    ToolTip = 'Specifies the value of the Ship-to/Order Address Code field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    Caption = 'ShortcutDimCode[3]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    Caption = 'ShortcutDimCode[4]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    Caption = 'ShortcutDimCode[5]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';

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
                    Visible = false;
                    Caption = 'ShortcutDimCode[6]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';

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
                    Visible = false;
                    Caption = 'ShortcutDimCode[7]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    Caption = 'ShortcutDimCode[8]';
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                    Caption = 'Payment Terms Code';
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    Visible = false;
                    Caption = 'Applies-to Doc. Type';
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    Visible = false;
                    Caption = 'Applies-to Doc. No.';
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    Visible = false;
                    Caption = 'Applies-to ID';
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    Visible = false;
                    Caption = 'On Hold';
                    ToolTip = 'Specifies the value of the On Hold field.';
                }
                field("Bank Payment Type"; Rec."Bank Payment Type")
                {
                    Visible = false;
                    Caption = 'Bank Payment Type';
                    ToolTip = 'Specifies the value of the Bank Payment Type field.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    Caption = 'Reason Code';
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Project No.';
                    ToolTip = 'Specifies the value of the Project No. field.';

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    Caption = 'Project Task No.';
                    ToolTip = 'Specifies the value of the Project Task No. field.';
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    Caption = 'Project Line Type';
                    ToolTip = 'Specifies the value of the Project Line Type field.';
                }
                field("Job Unit Of Measure Code"; Rec."Job Unit Of Measure Code")
                {
                    Visible = false;
                    Caption = 'Project Unit Of Measure Code';
                    ToolTip = 'Specifies the value of the Project Unit Of Measure Code field.';
                }
                field("Job Quantity"; Rec."Job Quantity")
                {
                    Caption = 'Project Quantity';
                    ToolTip = 'Specifies the value of the Project Quantity field.';
                }
                field("Job Unit Cost"; Rec."Job Unit Cost")
                {
                    Caption = 'Project Unit Cost';
                    ToolTip = 'Specifies the value of the Project Unit Cost field.';
                }
                field("Job Unit Cost (LCY)"; Rec."Job Unit Cost (LCY)")
                {
                    Caption = 'Project Unit Cost (LCY)';
                    ToolTip = 'Specifies the value of the Project Unit Cost (LCY) field.';
                }
                field("Job Total Cost"; Rec."Job Total Cost")
                {
                    Caption = 'Project Total Cost';
                    ToolTip = 'Specifies the value of the Project Total Cost field.';
                }
                field("Job Total Cost (LCY)"; Rec."Job Total Cost (LCY)")
                {
                    Caption = 'Project Total Cost (LCY)';
                    ToolTip = 'Specifies the value of the Project Total Cost (LCY) field.';
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    Caption = 'Project Unit Price';
                    ToolTip = 'Specifies the value of the Project Unit Price field.';
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    Visible = false;
                    Caption = 'Project Unit Price (LCY)';
                    ToolTip = 'Specifies the value of the Project Unit Price (LCY) field.';
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    Caption = 'Project Line Amount';
                    ToolTip = 'Specifies the value of the Project Line Amount field.';
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    Caption = 'Project Line Amount (LCY)';
                    ToolTip = 'Specifies the value of the Project Line Amount (LCY) field.';
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    Caption = 'Project Line Discount Amount';
                    ToolTip = 'Specifies the value of the Project Line Discount Amount field.';
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    Caption = 'Project Line Discount %';
                    ToolTip = 'Specifies the value of the Project Line Discount % field.';
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    Visible = false;
                    Caption = 'Project Total Price';
                    ToolTip = 'Specifies the value of the Project Total Price field.';
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    Caption = 'Project Total Price (LCY)';
                    ToolTip = 'Specifies the value of the Project Total Price (LCY) field.';
                }
            }
            group(Control30)
            {
                ShowCaption = false;
                label(Control36)
                {
                    CaptionClass = Text19039985;
                    ShowCaption = false;
                }
                field(AccName; AccName)
                {
                    Editable = false;
                    Caption = 'AccName';
                    ToolTip = 'Specifies the value of the AccName field.';
                }
                field(BalAccName; BalAccName)
                {
                    Caption = 'Bal. Account Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bal. Account Name field.';
                }
                field(Balance; Balance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Visible = BalanceVisible;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field(TotalBalance; TotalBalance + Rec."Balance (LCY)" - xRec."Balance (LCY)")
                {
                    AutoFormatType = 1;
                    Caption = 'Total Balance';
                    Editable = false;
                    Visible = TotalBalanceVisible;
                    ToolTip = 'Specifies the value of the Total Balance field.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //RunObject = Page Page39005830;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';
                }
            }
            group("A&ccount")
            {
                Caption = 'A&ccount';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = codeunit "Gen. Jnl.-Show Card";
                    ShortcutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = codeunit "Gen. Jnl.-Show Entries";
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
                }
            }
        }
        area(Processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action(Reconcile)
                {
                    Caption = 'Reconcile';
                    Image = Reconcile;
                    ShortcutKey = 'Ctrl+F11';
                    ToolTip = 'Executes the Reconcile action.';

                    trigger OnAction()
                    begin
                        GLReconcile.SetGenJnlLine(Rec);
                        GLReconcile.Run();
                    end;
                }
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintGenJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortcutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        TotalBalanceVisible := true;
        BalanceVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateBalance();
        Rec.SetUpNewLine(xRec, Balance, BelowxRec);
        Clear(ShortcutDimCode);
        Clear(AccName);
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        OpenedFromBatch := (Rec."Journal Batch Name" <> '') and (Rec."Journal Template Name" = '');
        if OpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
            exit;
        end;
        GenJnlManagement.TemplateSelection(Page::"Grant G/L Journal", 7, false, Rec, JnlSelected);
        GenJnlManagement.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;

        BalanceVisible: Boolean;
        OpenedFromBatch: Boolean;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;

        TotalBalanceVisible: Boolean;
        CurrentJnlBatchName: Code[10];
        ShortcutDimCode: array[8] of Code[20];
        Balance: Decimal;
        TotalBalance: Decimal;
        Text19039985: Label 'Account Name';
        AccName: Text[50];
        BalAccName: Text[50];

    local procedure UpdateBalance()
    begin
        GenJnlManagement.CalcBalance(Rec, xRec, Balance, TotalBalance, ShowBalance, ShowTotalBalance);
        BalanceVisible := ShowBalance;
        TotalBalanceVisible := ShowTotalBalance;
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord();
        GenJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
        UpdateBalance();
    end;
}

