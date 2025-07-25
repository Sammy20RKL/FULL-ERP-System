page 53021 "Procurement Methods List"
{
    ApplicationArea = All;
    Caption = 'Procurement Methods';
    PageType = List;
    SourceTable = "Procurement Method";
    UsageCategory = Lists;
    CardPageId = "Procurement Methods";

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
            }
        }
    }
}





