page 60018 "Grant Planning List"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Grant Budget List';
    DataCaptionExpression = Rec.Caption();
    DelayedInsert = true;
    Editable = false;
    PageType = Card;
    SourceTable = "Job-Planning Line";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Line Type"; Rec."Line Type")
                {
                    Caption = 'Line Type';
                    ToolTip = 'Specifies the value of the Line Type field.';
                }
                field("Budget Period"; Rec."Budget Period")
                {
                    Caption = 'Budget Period';
                    ToolTip = 'Specifies the value of the Budget Period field.';
                }
                field("Grant No."; Rec."Grant No.")
                {
                    Caption = 'Grant No.';
                    ToolTip = 'Specifies the value of the Grant No. field.';
                }
                field("Grant Task No."; Rec."Grant Task No.")
                {
                    Caption = 'Grant Task No.';
                    ToolTip = 'Specifies the value of the Grant Task No. field.';
                }
                field("Total Year 1"; Rec."Total Year 1")
                {
                    Caption = 'Total Year 1';
                    ToolTip = 'Specifies the value of the Total Year 1 field.';
                }
                field("Total Year 2"; Rec."Total Year 2")
                {
                    Caption = 'Total Year 2';
                    ToolTip = 'Specifies the value of the Total Year 2 field.';
                }
                field("Total Year 3"; Rec."Total Year 3")
                {
                    Caption = 'Total Year 3';
                    ToolTip = 'Specifies the value of the Total Year 3 field.';
                }
                field("Total Year 4"; Rec."Total Year 4")
                {
                    Caption = 'Total Year 4';
                    ToolTip = 'Specifies the value of the Total Year 4 field.';
                }
                field("Total Year 5"; Rec."Total Year 5")
                {
                    Caption = 'Total Year 5';
                    ToolTip = 'Specifies the value of the Total Year 5 field.';
                }
                field("Total Year 6"; Rec."Total Year 6")
                {
                    Caption = 'Total Year 6';
                    ToolTip = 'Specifies the value of the Total Year 6 field.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    Caption = 'Planning Date';
                    ToolTip = 'Specifies the value of the Planning Date field.';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'Expense Account';
                    ToolTip = 'Specifies the value of the Expense Account field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Transfered To Budget"; Rec."Transfered To Budget")
                {
                    Caption = 'Transfered To Budget';
                    ToolTip = 'Specifies the value of the Transfered To Budget field.';
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
                field("Audit Provision"; Rec."Audit Provision")
                {
                    Caption = 'Audit Provision';
                    ToolTip = 'Specifies the value of the Audit Provision field.';
                }
                field("Currency Date"; Rec."Currency Date")
                {
                    Visible = false;
                    Caption = 'Currency Date';
                    ToolTip = 'Specifies the value of the Currency Date field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field(Partner; Rec.Partner)
                {
                    Caption = 'Partner';
                    ToolTip = 'Specifies the value of the Partner field.';
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
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    Caption = 'Variant Code';
                    ToolTip = 'Specifies the value of the Variant Code field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                    ToolTip = 'Specifies the value of the Work Type Code field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    Visible = false;
                    Caption = 'Quantity (Base)';
                    ToolTip = 'Specifies the value of the Quantity (Base) field.';
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
                field("Unit Price"; Rec."Unit Price")
                {
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
                    Caption = 'Line Discount Amount';
                    ToolTip = 'Specifies the value of the Line Discount Amount field.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
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
                field(Transferred; Rec.Transferred)
                {
                    Caption = 'Transferred';
                    ToolTip = 'Specifies the value of the Transferred field.';
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Caption = 'Disbursed Amount';
                    ToolTip = 'Specifies the value of the Disbursed Amount field.';
                }
                field("Accounted Amount"; Rec."Accounted Amount")
                {
                    Caption = 'Accounted Amount';
                    ToolTip = 'Specifies the value of the Accounted Amount field.';
                }
                field("Unaccounted Amount"; Rec."Unaccounted Amount")
                {
                    Caption = 'Unaccounted Amount';
                    ToolTip = 'Specifies the value of the Unaccounted Amount field.';
                }
                field(Invoiced; Rec.Invoiced)
                {
                    Caption = 'Invoiced';
                    ToolTip = 'Specifies the value of the Invoiced field.';
                }
                field("Invoice Type"; Rec."Invoice Type")
                {
                    Caption = 'Invoice Type';
                    ToolTip = 'Specifies the value of the Invoice Type field.';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    Caption = 'Invoice No.';
                    ToolTip = 'Specifies the value of the Invoice No. field.';
                }
                field("Invoiced Cost Amount (LCY)"; Rec."Invoiced Cost Amount (LCY)")
                {
                    Caption = 'Invoiced Cost Amount (LCY)';
                    ToolTip = 'Specifies the value of the Invoiced Cost Amount (LCY) field.';
                }
                field("Invoiced Amount (LCY)"; Rec."Invoiced Amount (LCY)")
                {
                    Caption = 'Invoiced Amount (LCY)';
                    ToolTip = 'Specifies the value of the Invoiced Amount (LCY) field.';
                }
                field("User ID"; Rec."User ID")
                {
                    Visible = false;
                    Caption = 'User ID';
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Visible = false;
                    Caption = 'Serial No.';
                    ToolTip = 'Specifies the value of the Serial No. field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Visible = false;
                    Caption = 'Lot No.';
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("Grant Contract Entry No."; Rec."Grant Contract Entry No.")
                {
                    Caption = 'Grant Contract Entry No.';
                    ToolTip = 'Specifies the value of the Grant Contract Entry No. field.';
                }
                field("Ledger Entry Type"; Rec."Ledger Entry Type")
                {
                    Visible = false;
                    Caption = 'Ledger Entry Type';
                    ToolTip = 'Specifies the value of the Ledger Entry Type field.';
                }
                field("Ledger Entry No."; Rec."Ledger Entry No.")
                {
                    Visible = false;
                    Caption = 'Ledger Entry No.';
                    ToolTip = 'Specifies the value of the Ledger Entry No. field.';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    Visible = false;
                    Caption = 'System-Created Entry';
                    ToolTip = 'Specifies the value of the System-Created Entry field.';
                }
                field("Budget Line Item"; Rec."Budget Line Item")
                {
                    Caption = 'Budget Line Item';
                    ToolTip = 'Specifies the value of the Budget Line Item field.';
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
                action("Edit Planning Lines")
                {
                    Caption = 'Edit Planning Lines';
                    Ellipsis = true;
                    Image = EditLines;
                    ToolTip = 'Executes the Edit Planning Lines action.';

                    trigger OnAction()
                    var
                        JT: Record "Job-Task";
                    begin

                        Rec.TestField("Grant No.");
                        Rec.TestField("Grant Task No.");
                        JT.Get(Rec."Grant No.", Rec."Grant Task No.");
                        JT.FilterGroup := 2;
                        JT.SetRange("Grant No.", Rec."Grant No.");
                        JT.SetRange("Grant Task Type", JT."Grant Task Type"::Posting);
                        //IF JT.FIND('-') THEN
                        JT.FilterGroup := 0;

                        Page.RunModal(Page::"Grant Planning Lines", JT);
                    end;
                }
                action("Create &Sales Invoice")
                {
                    Caption = 'Create &Sales Invoice';
                    Ellipsis = true;
                    Image = Invoice;
                    ToolTip = 'Executes the Create &Sales Invoice action.';

                    trigger OnAction()
                    begin
                        CreateSalesInvoice(false);
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
                        CreateSalesInvoice(true);
                    end;
                }
                action("Get Sales/Credit Memo")
                {
                    Caption = 'Get Sales/Credit Memo';
                    Ellipsis = true;
                    Image = GetSourceDoc;
                    ToolTip = 'Executes the Get Sales/Credit Memo action.';

                    trigger OnAction()
                    begin
                        //JobCreateInvoice.GetSalesInvoice(Rec);
                    end;
                }
                action("Post Budget")
                {
                    Caption = 'Post Budget';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ToolTip = 'Executes the Post Budget action.';

                    trigger OnAction()
                    begin
                        Job.Reset();
                        Job.SetRange(Job."No.", Rec."Grant No.");
                        if Job.Find('-') then
                            if Job."Approval Status" <> Job."Approval Status"::Approved then Message('The grant has to be approved to set budget');

                        if Confirm('Are you sure you want to Transfer Lines to Budget?', false) = true then begin

                            Job.Reset();
                            Job.Get(Rec."Grant No.");
                            StartDate := Job."Starting Date";

                            BudgetSetup.Find('-');
                            PlanningLines.Reset();
                            PlanningLines.SetRange(PlanningLines."Grant No.", Rec."Grant No.");
                            PlanningLines.SetRange(PlanningLines.Type, PlanningLines.Type::"G/L Account");
                            //PlanningLines.SETRANGE(PlanningLines.Partner,' ');
                            PlanningLines.SetRange(PlanningLines."Budget in use", false);
                            if PlanningLines.Find('-') then begin
                                repeat

                                    if PlanningLines."Transfered To Budget" = false then begin

                                        BudgetEntry.Reset();
                                        if BudgetEntry.Find('+') then
                                            LastEntryNo := BudgetEntry."Entry No.";
                                            //ERROR('%1',LastEntryNo);

                                        BudgetEntry.Init();
                                        BudgetEntry."Entry No." := LastEntryNo + 1;
                                        BudgetEntry."Budget Name" := BudgetSetup."Current Budget";
                                        BudgetEntry.Date := StartDate;
                                        BudgetEntry."G/L Account No." := PlanningLines."G/l Account";
                                        BudgetEntry.Description := PlanningLines.Description;
                                        BudgetEntry.Amount := PlanningLines."Unit Cost (LCY)";
                                        BudgetEntry."Global Dimension 1 Code" := PlanningLines."Global Dimension 1 Code";
                                        BudgetEntry."Global Dimension 2 Code" := PlanningLines."Global Dimension 2 Code";
                                        BudgetEntry."Budget Dimension 1 Code" := PlanningLines."Shortcut Dimension 3 Code";
                                        BudgetEntry."Budget Dimension 2 Code" := PlanningLines."Shortcut Dimension 4 Code";
                                        BudgetEntry."Budget Dimension 3 Code" := PlanningLines."Shortcut Dimension 5 Code";


                                        // BudgetEntry."Contract Entry No":=PlanningLines."Grant Contract Entry No.";
                                        BudgetEntry.Insert();
                                        PlanningLines."Transfered To Budget" := true;
                                        PlanningLines.Modify();

                                        Commit();
                                    end else begin
                                        BudgetEntry.Reset();
                                        //BudgetEntry.SETRANGE(BudgetEntry."Contract Entry No",PlanningLines."Grant Contract Entry No.");
                                        if BudgetEntry.Find('-') then begin
                                            BudgetEntry.Date := StartDate;
                                            BudgetEntry."Budget Name" := BudgetSetup."Current Budget";
                                            BudgetEntry."G/L Account No." := PlanningLines."No.";
                                            BudgetEntry.Description := PlanningLines.Description;
                                            BudgetEntry.Amount := PlanningLines."Total Cost (LCY)";
                                            BudgetEntry."Global Dimension 1 Code" := PlanningLines."Global Dimension 1 Code";
                                            BudgetEntry."Global Dimension 2 Code" := PlanningLines."Global Dimension 2 Code";
                                            BudgetEntry."Budget Dimension 1 Code" := PlanningLines."Shortcut Dimension 3 Code";
                                            BudgetEntry."Budget Dimension 2 Code" := PlanningLines."Shortcut Dimension 4 Code";
                                            BudgetEntry."Budget Dimension 3 Code" := PlanningLines."Shortcut Dimension 5 Code";
                                            BudgetEntry.Amount := PlanningLines."Total Cost (LCY)";
                                            BudgetEntry.Modify();
                                        end
                                    end

                                until PlanningLines.Next() = 0;


                                Message('Transfer Complete.');
                            end
                        end
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Unaccounted Amount" := Rec."Disbursed Amount" - Rec."Accounted Amount";
    end;

    trigger OnOpenPage()
    begin
        if ActiveField = 1 then;
        if ActiveField = 2 then;
        if ActiveField = 3 then;
        if ActiveField = 4 then;
    end;

    var
        BudgetSetup: Record "Cash Management Setup";
        BudgetEntry: Record "G/L Budget Entry";
        PlanningLines: Record "Job-Planning Line";
        Job: Record Jobs;
        StartDate: Date;
        LastEntryNo: Integer;
        ActiveField: Option " ",Cost,CostLCY,PriceLCY,Price;


    procedure CreateSalesInvoice(CrMemo: Boolean)
    var
        JobPlanningLine: Record "Job-Planning Line";
    begin
        Rec.TestField("Line No.");
        JobPlanningLine.Copy(Rec);
        CurrPage.SetSelectionFilter(JobPlanningLine);
        //JobCreateInvoice.CreateSalesInvoice(JobPlanningLine,CrMemo)
    end;


    procedure SetActiveField(ActiveField2: Integer)
    begin
        ActiveField := ActiveField2;
    end;
}

