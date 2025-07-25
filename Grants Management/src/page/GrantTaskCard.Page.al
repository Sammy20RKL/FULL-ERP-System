page 60028 "Grant Task Card"
{
    ApplicationArea = All;
    Caption = 'Grant Activity Card';
    DataCaptionExpression = Rec.Caption();
    DeleteAllowed = false;
    InsertAllowed = false;
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
                    ToolTip = 'Specifies the value of the Grant Task No. field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Grant Task Type"; Rec."Grant Task Type")
                {
                    Caption = 'Job Task Type';
                    ToolTip = 'Specifies the value of the Job Task Type field.';
                }
                field(Totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                    ToolTip = 'Specifies the value of the Totaling field.';
                }
                field("Grant Posting Group"; Rec."Grant Posting Group")
                {
                    Caption = 'Job Posting Group';
                    ToolTip = 'Specifies the value of the Job Posting Group field.';
                }
                field("New Page"; Rec."New Page")
                {
                    Caption = 'New Page';
                    ToolTip = 'Specifies the value of the New Page field.';
                }
                field("No. of Blank Lines"; Rec."No. of Blank Lines")
                {
                    Caption = 'No. of Blank Lines';
                    ToolTip = 'Specifies the value of the No. of Blank Lines field.';
                }
            }
            group(WIP)
            {
                Caption = 'WIP';
                field("WIP Method Used"; Rec."WIP Method Used")
                {
                    Caption = 'WIP Method Used';
                    ToolTip = 'Specifies the value of the WIP Method Used field.';
                }
                field("WIP Posting Date"; Rec."WIP Posting Date")
                {
                    Caption = 'WIP Posting Date';
                    ToolTip = 'Specifies the value of the WIP Posting Date field.';
                }
                field("WIP Account"; Rec."WIP Account")
                {
                    Caption = 'WIP Account';
                    ToolTip = 'Specifies the value of the WIP Account field.';
                }
                field("WIP Balance Account"; Rec."WIP Balance Account")
                {
                    Caption = 'WIP Balance Account';
                    ToolTip = 'Specifies the value of the WIP Balance Account field.';
                }
                field("WIP Amount"; Rec."WIP Amount")
                {
                    Caption = 'WIP Amount';
                    ToolTip = 'Specifies the value of the WIP Amount field.';
                }
                field("Invoiced Sales Amount"; Rec."Invoiced Sales Amount")
                {
                    Caption = 'Invoiced Sales Amount';
                    ToolTip = 'Specifies the value of the Invoiced Sales Amount field.';
                }
                field("Invoiced Sales Account"; Rec."Invoiced Sales Account")
                {
                    Caption = 'Invoiced Sales Account';
                    ToolTip = 'Specifies the value of the Invoiced Sales Account field.';
                }
                field("Invoiced Sales Bal. Account"; Rec."Invoiced Sales Bal. Account")
                {
                    Caption = 'Invoiced Sales Bal. Account';
                    ToolTip = 'Specifies the value of the Invoiced Sales Bal. Account field.';
                }
                field("WIP Posting Date Filter"; Rec."WIP Posting Date Filter")
                {
                    Caption = 'WIP Posting Date Filter';
                    ToolTip = 'Specifies the value of the WIP Posting Date Filter field.';
                }
                field("WIP Planning Date Filter"; Rec."WIP Planning Date Filter")
                {
                    Caption = 'WIP Planning Date Filter';
                    ToolTip = 'Specifies the value of the WIP Planning Date Filter field.';
                }
                field("WIP Schedule (Total Cost)"; Rec."WIP Schedule (Total Cost)")
                {
                    Caption = 'WIP Schedule (Total Cost)';
                    ToolTip = 'Specifies the value of the WIP Schedule (Total Cost) field.';
                }
                field("WIP Schedule (Total Price)"; Rec."WIP Schedule (Total Price)")
                {
                    Caption = 'WIP Schedule (Total Price)';
                    ToolTip = 'Specifies the value of the WIP Schedule (Total Price) field.';
                }
                field("WIP Usage (Total Cost)"; Rec."WIP Usage (Total Cost)")
                {
                    Caption = 'WIP Usage (Total Cost)';
                    ToolTip = 'Specifies the value of the WIP Usage (Total Cost) field.';
                }
                field("WIP Usage (Total Price)"; Rec."WIP Usage (Total Price)")
                {
                    Caption = 'WIP Usage (Total Price)';
                    ToolTip = 'Specifies the value of the WIP Usage (Total Price) field.';
                }
                field("WIP Contract (Total Cost)"; Rec."WIP Contract (Total Cost)")
                {
                    Caption = 'WIP Contract (Total Cost)';
                    ToolTip = 'Specifies the value of the WIP Contract (Total Cost) field.';
                }
                field("WIP Contract (Total Price)"; Rec."WIP Contract (Total Price)")
                {
                    Caption = 'WIP Contract (Total Price)';
                    ToolTip = 'Specifies the value of the WIP Contract (Total Price) field.';
                }
                field("WIP (Invoiced Price)"; Rec."WIP (Invoiced Price)")
                {
                    Caption = 'WIP (Invoiced Price)';
                    ToolTip = 'Specifies the value of the WIP (Invoiced Price) field.';
                }
                field("WIP (Invoiced Cost)"; Rec."WIP (Invoiced Cost)")
                {
                    Caption = 'WIP (Invoiced Cost)';
                    ToolTip = 'Specifies the value of the WIP (Invoiced Cost) field.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Grant Task")
            {
                Caption = '&Grant Task';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = page "Grant Task Dimensions";
                    RunPageLink = "Job No." = field("Grant No."), "Job Task No." = field("Grant Task No.");
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';
                }
            }
        }
    }
}

