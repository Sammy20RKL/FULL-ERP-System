page 53058 "Procurement Committees"
{
    ApplicationArea = All;
    Caption = 'Procurement Committees';
    PageType = List;
    SourceTable = "Procurement Committees";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Members; Rec.Members)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Members field';
                }
            }
        }
    }
}





