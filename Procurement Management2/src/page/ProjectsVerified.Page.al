page 53050 "Projects Verified"
{
    CardPageID = "Project Header Card";
    Editable = false;
    PageType = List;
    SourceTable = "New Project Header";
    SourceTableView = where(Status = const(Verified));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Name field';
                }
                field("Project Date"; Rec."Project Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Date field';
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Start Date field';
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated End Date field';
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Duration field';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Start Date field';
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual End Date field';
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Duration field';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
        }
    }

    actions
    {
    }
}





