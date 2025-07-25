page 53005 "Supplier List"
{
    //ApplicationArea = All;
    Caption = 'Supplier List';
    PageType = List;
    SourceTable = Vendor;
    SourceTableView=where ("Vendor Posting Group"=filter('CREDITORS'));
    UsageCategory = Lists;
    ApplicationArea=All;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}






