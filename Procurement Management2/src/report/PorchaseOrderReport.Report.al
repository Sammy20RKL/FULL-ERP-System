report 53052 "Porchase Order Report"
{
    ApplicationArea = All;
    Caption = 'Porchase Order Report';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
