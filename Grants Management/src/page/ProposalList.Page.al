page 60009 "Proposal List"
{
    ApplicationArea = All;
    Caption = 'Grant List';
    CardPageId = "Proposal Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = Jobs;
    SourceTableView = where(Status = const(Proposal), "Approval Status" = filter(Open | "Pending Approval"));

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
            systempart(Control8; Links)
            {
                Editable = false;
                Visible = true;
            }
            systempart(Control7; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Grant")
            {
                Caption = '&Grant';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortcutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
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
                        //RunObject = Page Page51516539;
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
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';
                }
            }
        }
        area(Processing)
        {
            action("G/l")
            {
                Caption = 'G/l';
                RunObject = page "G/L Account Card";
                ToolTip = 'Executes the G/l action.';
            }
        }
        area(Reporting)
        {
        }
    }
}

