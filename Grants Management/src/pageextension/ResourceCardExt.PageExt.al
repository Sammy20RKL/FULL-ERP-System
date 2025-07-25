pageextension 60002 "Resource Card Ext" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {

            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                Caption = 'User ID';
            }
            field("Resource G/L Budget Account"; Rec."Resource G/L Budget Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Resource G/L Budget Account field.', Comment = '%';
                Caption = 'Resource G/L Budget Account';
            }
            field(Institution; Rec.Institution)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Institution field.', Comment = '%';
                Caption = 'Institution';
            }
            field(Email; Rec.Email)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                Caption = 'Email';
            }
        }
    }
}
