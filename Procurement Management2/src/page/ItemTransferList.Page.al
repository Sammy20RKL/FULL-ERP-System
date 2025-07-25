page 53025 "Item Transfer List"
{
    CardPageID = "Item Transfer";
    PageType = List;
    SourceTable = "Item Transfer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Receiving Employee"; Rec."Receiving Employee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Employee field';
                }
                field("Receiving Name"; Rec."Receiving Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Name field';
                }
                field("Company To"; Rec."Company To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company To field';
                }
                field("Company From"; Rec."Company From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company From field';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
            }
        }
    }

    actions
    {
    }
}





