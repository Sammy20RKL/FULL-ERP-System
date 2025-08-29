page 52926 "Board MemberList"
{
    CardPageId = "Board Member Appl.";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    ModifyAllowed = true;
    SourceTable = "Employee Temp. Board";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {

                }
                field(Name; Rec.Name) { }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}