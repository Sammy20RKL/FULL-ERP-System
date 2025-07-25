page 60025 "Grant Planning Lines"
{
    ApplicationArea = All;
    // `

    Caption = 'Grant Budget Lines';
    DataCaptionExpression = Rec.Caption2();
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Job-Task";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Grant Task No."; Rec."Grant Task No.")
                {
                    Caption = 'Grant Task No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Grant Task No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part(PlanningLines; "Grant Planning Line Subform")
            {
                SubPageLink = "Grant No." = field("Grant No."), "Grant Task No." = field("Grant Task No.");
                Caption = 'Grant Planning Line Subform';
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
                action("Transfer Budget Lines")
                {
                    Caption = 'Transfer Budget Lines';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Transfer Budget Lines action.';

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to Transfer Lines to Budget?', false) = true then begin

                            Job.Reset();
                            Job.Get(Rec."Grant No.");
                            StartDate := Job."Starting Date";

                            if Job."Approval Status" <> Job."Approval Status"::Approved then Message('The grant has to be approved to set budget');
                            mGLAccount := '';
                            BudgetSetup.Find('-');
                            PlanningLines.Reset();
                            PlanningLines.SetRange(PlanningLines."Grant Task No.", Rec."Grant Task No.");
                            PlanningLines.SetRange(PlanningLines."Transfered To Budget", false);
                            if PlanningLines.Find('-') then
                                repeat
                                    mGLAccount := '';
                                    //____________________________________
                                    if PlanningLines.Type = PlanningLines.Type::Item then begin
                                        objItem.Reset();
                                        objItem.SetRange(objItem."No.", PlanningLines."No.");
                                        if objItem.Find('-') then;
                                            // mGLAccount:=objItem."Item G/L Budget Account";//mutinda
                                    end
                                    else if PlanningLines.Type = PlanningLines.Type::Resource then begin
                                        objResource.Reset();
                                        objResource.SetRange(objResource."No.", PlanningLines."No.");
                                        if objResource.Find('-') then
                                            mGLAccount := '';//objResource."Item G/L Budget Account";
                                    end
                                    else if PlanningLines.Type = PlanningLines.Type::"G/L Account" then
                                        mGLAccount := PlanningLines."G/l Account";

                                    //_____________________________________

                                    if PlanningLines."Transfered To Budget" = false then begin
                                        BudgetEntry.Reset();
                                        if BudgetEntry.Find('+') then
                                            LastEntryNo := BudgetEntry."Entry No.";
                                        BudgetEntry.Init();
                                        BudgetEntry."Entry No." := LastEntryNo + 1;
                                        BudgetEntry."Budget Name" := BudgetSetup."Current Budget";
                                        BudgetEntry.Date := PlanningLines."Planning Date";
                                        BudgetEntry."G/L Account No." := PlanningLines."G/l Account";
                                        BudgetEntry.Description := PlanningLines.Description;
                                        BudgetEntry.Amount := PlanningLines."Unit Cost (LCY)";
                                        //BudgetEntry.Donor:=Job."Bill-to Partner No.";
                                        //BudgetEntry."Project No":=Job."No.";
                                        BudgetEntry."Global Dimension 1 Code" := PlanningLines."Global Dimension 1 Code";
                                        BudgetEntry."Global Dimension 2 Code" := PlanningLines."Global Dimension 2 Code";
                                        BudgetEntry."Budget Dimension 1 Code" := PlanningLines."Shortcut Dimension 3 Code";
                                        BudgetEntry."Budget Dimension 2 Code" := PlanningLines."Shortcut Dimension 4 Code";
                                        BudgetEntry."Budget Dimension 3 Code" := PlanningLines."Shortcut Dimension 5 Code";
                                        // BudgetEntry."Dimension Set ID":=PlanningLines.dime
                                        //BudgetEntry."Contract Entry No":=PlanningLines."Grant Contract Entry No.";
                                        BudgetEntry.Insert();
                                        PlanningLines."Transfered To Budget" := true;
                                        PlanningLines.Modify();

                                        Commit();
                                    end else begin
                                        BudgetEntry.Reset();
                                        //BudgetEntry.SETRANGE(BudgetEntry."Contract Entry No",PlanningLines."Grant Contract Entry No.");
                                        if BudgetEntry.Find('-') then begin
                                            BudgetEntry.Date := PlanningLines."Planning Date";
                                            BudgetEntry."Budget Name" := BudgetSetup."Current Budget";
                                            BudgetEntry."G/L Account No." := PlanningLines."G/l Account";
                                            BudgetEntry.Description := PlanningLines.Description;
                                            //BudgetEntry.Donor:=Job."Bill-to Partner No.";
                                            //BudgetEntry."Project No":=Job."No.";
                                            BudgetEntry."Global Dimension 1 Code" := PlanningLines."Global Dimension 1 Code";
                                            BudgetEntry."Global Dimension 2 Code" := PlanningLines."Global Dimension 2 Code";
                                            BudgetEntry."Budget Dimension 1 Code" := PlanningLines."Shortcut Dimension 3 Code";
                                            BudgetEntry."Budget Dimension 2 Code" := PlanningLines."Shortcut Dimension 4 Code";
                                            BudgetEntry.Amount := PlanningLines."Unit Cost (LCY)";
                                            BudgetEntry.Modify();
                                        end
                                    end
                                until PlanningLines.Next() = 0;
                            Message('Transfer Complete.');
                        end
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Job.Get(Rec."Grant No.") then
            CurrPage.Editable(not (Job.Blocked = Job.Blocked::All));
    end;

    var
        BudgetSetup: Record "Cash Management Setup";
        BudgetEntry: Record "G/L Budget Entry";
        objItem: Record Item;
        PlanningLines: Record "Job-Planning Line";
        Job: Record Jobs;
        objResource: Record Resource;
        mGLAccount: Code[20];
        StartDate: Date;
        LastEntryNo: Integer;
}

