page 53128 "Vendor Evaluation Periods"
{
    Caption = 'Vendor Evaluation Periods';
    PageType = List;
    SourceTable = "Vendor Evaluation Periods";

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
                field("Start date"; Rec."Start date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field';
                }
            }
        }
    }
}





