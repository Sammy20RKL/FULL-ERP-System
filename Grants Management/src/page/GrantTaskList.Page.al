page 60016 "Grant Task List"
{
    ApplicationArea = All;
    Caption = 'Grant Activity List';
    DataCaptionFields = "Grant No.";
    Editable = false;
    PageType = Card;
    SourceTable = "Job-Task";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
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
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Grant Task Type"; Rec."Grant Task Type")
                {
                    Caption = 'Grant Task Type';
                    ToolTip = 'Specifies the value of the Grant Task Type field.';
                }
                field("WIP-Total"; Rec."WIP-Total")
                {
                    Caption = 'WIP-Total';
                    ToolTip = 'Specifies the value of the WIP-Total field.';
                }
                field(Totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                    ToolTip = 'Specifies the value of the Totaling field.';
                }
                field("Grant Posting Group"; Rec."Grant Posting Group")
                {
                    Caption = 'Grant Clusters';
                    ToolTip = 'Specifies the value of the Grant Clusters field.';
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
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = page "Grant Task Card";
                    RunPageLink = "Grant No." = field("Grant No."), "Grant Task No." = field("Grant Task No.");
                    ShortcutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
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

    trigger OnAfterGetRecord()
    begin
        GrantNoOnFormat();
        GrantTaskNoOnFormat();
    end;

    var

        "Grant No.Emphasize": Boolean;

        "Grant Task No.Emphasize": Boolean;

    local procedure GrantNoOnFormat()
    begin
        "Grant No.Emphasize" := Rec."Grant Task Type" <> Rec."Grant Task Type"::Posting;
    end;

    local procedure GrantTaskNoOnFormat()
    begin
        "Grant Task No.Emphasize" := Rec."Grant Task Type" <> Rec."Grant Task Type"::Posting;
    end;
}

