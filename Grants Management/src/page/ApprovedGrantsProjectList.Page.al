page 60035 "Approved Grants Project List"
{
    ApplicationArea = All;
    Caption = 'Project Summary List';
    CardPageId = "Approved Project Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Jobs;
    SourceTableView = where(Status = const(Project), "Approval Status" = filter(Approved));

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Person Responsible"; Rec."Person Responsible")
                {
                    Visible = false;
                    Caption = 'Person Responsible';
                    ToolTip = 'Specifies the value of the Person Responsible field.';
                }
                field("Next Invoice Date"; Rec."Next Invoice Date")
                {
                    Visible = false;
                    Caption = 'Next Invoice Date';
                    ToolTip = 'Specifies the value of the Next Invoice Date field.';
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    Visible = false;
                    Caption = 'Kind of Program';
                    ToolTip = 'Specifies the value of the Kind of Program field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'Search Description';
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control9; Links)
            {
                Visible = true;
            }
            systempart(Control8; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("W&IP")
            {
                Caption = 'W&IP';
                Visible = false;
                action("Calculate WIP")
                {
                    Caption = 'Calculate WIP';
                    Ellipsis = true;
                    Image = CalculateWIP;
                    ToolTip = 'Executes the Calculate WIP action.';

                    trigger OnAction()
                    var
                        Job: Record Jobs;
                    begin
                        Rec.TestField("No.");
                        Job.Copy(Rec);
                        Job.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::"Job Calculate WIP", true, false, Job);
                    end;
                }
                action("Post WIP to G/L")
                {
                    Caption = 'Post WIP to G/L';
                    Ellipsis = true;
                    Image = Post;
                    ToolTip = 'Executes the Post WIP to G/L action.';

                    trigger OnAction()
                    var
                        Job: Record Jobs;
                    begin
                        Rec.TestField("No.");
                        Job.Copy(Rec);
                        Job.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::"Job Post WIP to G/L", true, false, Job);
                    end;
                }
                action("WIP Entries")
                {
                    Caption = 'WIP Entries';
                    RunObject = page "Grant WIP Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.", "Job Posting Group", "WIP Posting Date");
                    ToolTip = 'Executes the WIP Entries action.';
                }
                action("WIP G/L Entries")
                {
                    Caption = 'WIP G/L Entries';
                    RunObject = page "Grant WIP G/L Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.");
                    ToolTip = 'Executes the WIP G/L Entries action.';
                }
            }
            group("&Prices")
            {
                Caption = '&Prices';
                Visible = false;
                action(Resource)
                {
                    Caption = 'Resource';
                    RunObject = page "Grant Resource Prices";
                    RunPageLink = "Job No." = field("No.");
                    ToolTip = 'Executes the Resource action.';
                }
                action(Item)
                {
                    Caption = 'Item';
                    RunObject = page "Grant Item Prices";
                    RunPageLink = "Job No." = field("No.");
                    ToolTip = 'Executes the Item action.';
                }
                action("G/L Account")
                {
                    Caption = 'G/L Account';
                    RunObject = page "Grant G/L Account Prices";
                    RunPageLink = "Job No." = field("No.");
                    ToolTip = 'Executes the G/L Account action.';
                }
            }
            group("Plan&ning")
            {
                Caption = 'Plan&ning';
                Visible = false;
                action("Resource &Allocated per Job")
                {
                    Caption = 'Resource &Allocated per Job';
                    RunObject = page "Resource Allocated per Job";
                    ToolTip = 'Executes the Resource &Allocated per Job action.';
                }
                separator(Action26)
                {
                }
                action("Res. Group All&ocated per Job")
                {
                    Caption = 'Res. Group All&ocated per Job';
                    RunObject = page "Res. Gr. Allocated per Job";
                    ToolTip = 'Executes the Res. Group All&ocated per Job action.';
                }
            }
            group("&Grant")
            {
                Caption = '&Grant';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page "Proposal Card";
                    RunPageLink = "No." = field("No.");
                    ShortcutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action(Budget)
                {
                    Caption = 'Budget';
                    Image = EditLines;
                    RunObject = page Budget;
                    ToolTip = 'Executes the Budget action.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Job), "No." = field("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    action("Dimensions-Single")
                    {
                        Caption = 'Dimensions-Single';
                        RunObject = page "Grant Task Dimensions";
                        RunPageLink = "Job No." = field("No."), "Job Task No." = const();
                        ShortcutKey = 'Shift+Ctrl+D';
                        ToolTip = 'Executes the Dimensions-Single action.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        Caption = 'Dimensions-&Multiple';
                        ToolTip = 'Executes the Dimensions-&Multiple action.';

                        trigger OnAction()
                        begin
                            // CurrPage.SETSELECTIONFILTER(Job);
                            // DefaultDimMultiple.SetMultiJob(Job);
                            // DefaultDimMultiple.RUNMODAL;
                        end;
                    }
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = page "Grant Ledger Entries";
                    RunPageLink = "Job No." = field("No.");
                    RunPageView = sorting("Job No.", "Job Task No.", "Entry Type", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'Executes the Ledger E&ntries action.';
                }
                action("Grant Task Lines")
                {
                    Caption = 'Grant Task Lines';
                    ToolTip = 'Executes the Grant Task Lines action.';

                    trigger OnAction()
                    var
                        JTLines: Page "Grant Task Lines";
                    begin
                        JTLines.SetJobNo(Rec."No.");
                        JTLines.Run();
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Grant Statistics";
                    RunPageLink = "No." = field("No.");
                    ShortcutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
            }
        }
        area(Reporting)
        {
            action(test)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Caption = 'test';
                ToolTip = 'Executes the test action.';
                //RunObject = Report Report39003906;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        objResource.Reset();
        objResource.SetRange(objResource."User ID", UserId);
        if objResource.Find('-') then
            Rec.SetFilter("Principal Investigator", objResource."No.");
    end;

    trigger OnOpenPage()
    begin
        objResource.Reset();
        objResource.SetRange(objResource."User ID", UserId);
        if objResource.Find('-') then
            Rec.SetFilter("Principal Investigator", objResource."No.");
    end;

    var
        objResource: Record Resource;
}

