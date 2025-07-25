page 65023 "Workplan Line Activities"
{
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = ListPart;
    SourceTable = "WorkPlan Line Activities";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    ToolTip = 'Specifies the value of the Objective Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

