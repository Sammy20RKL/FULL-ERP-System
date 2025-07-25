page 60058 "Grants Lookup Values List"
{
    ApplicationArea = All;
    Caption = 'Close Out Checklist Setup';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Grants Lookup Values";
    SourceTableView = sorting(Order, Type, Code) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    Enabled = true;
                    Caption = 'Type';
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Code"; Rec.Code)
                {
                    Enabled = true;
                    Caption = 'Code';
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Checklist Details';
                    Editable = true;
                    ToolTip = 'Specifies the value of the Checklist Details field.';
                }
            }
        }
    }

    actions
    {
    }
}

