page 60038 "Phase Reporting SchedulesAudit"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Phase Reporting Schedules";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field(Phase; Rec.Phase)
                {
                    Caption = 'Phase';
                    ToolTip = 'Specifies the value of the Phase field.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    Caption = 'Table ID';
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Partner/Donor"; Rec."Partner/Donor")
                {
                    Caption = 'Partner/Donor';
                    ToolTip = 'Specifies the value of the Partner/Donor field.';
                }
                field(Project; Rec.Project)
                {
                    Caption = 'Project';
                    ToolTip = 'Specifies the value of the Project field.';
                }
                field(Months; Rec.Months)
                {
                    Caption = 'Months';
                    ToolTip = 'Specifies the value of the Months field.';
                }
                field("User Id"; Rec."User Id")
                {
                    Caption = 'User Id';
                    ToolTip = 'Specifies the value of the User Id field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    Caption = 'Reporting Date';
                    ToolTip = 'Specifies the value of the Reporting Date field.';
                }
                field(Notified; Rec.Notified)
                {
                    Caption = 'Notified';
                    ToolTip = 'Specifies the value of the Notified field.';
                }
                field("Audit Dates"; Rec."Audit Dates")
                {
                    Caption = 'Audit Dates';
                    ToolTip = 'Specifies the value of the Audit Dates field.';
                }
                field(AlertSent; Rec.AlertSent)
                {
                    Caption = 'AlertSent';
                    ToolTip = 'Specifies the value of the AlertSent field.';
                }
            }
        }
    }

    actions
    {
    }
}

