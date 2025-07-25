page 53059 "Bidders Selection"
{
    PageType = Card;
    SourceTable = "Supplier Selection";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field';
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field';
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field';
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field';
                    Editable = false;
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Email field';
                }
                field(Invited; Rec.Invited)
                {
                    Caption = 'Invite';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invite field';
                    Editable = false;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notified field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No. field';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Supplier Selection")
            {
                Caption = 'Supplier Selection';

                action("Generate Quote Evaluation")
                {
                    Caption = 'Generate Quote Evaluation';
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Generate Quote Evaluation action';

                    trigger OnAction()
                    var
                        SupplierSelection: Record "Supplier Selection";
                    begin
                        SupplierSelection.SetRange(SupplierSelection.Invited, true);
                        SupplierSelection.SetRange(SupplierSelection."Reference No.", Rec."Reference No.");
                        if SupplierSelection.FindFirst() then begin
                            repeat
                            //SupplierSelection.CreateQuoteEvaluation(SupplierSelection);
                            until SupplierSelection.Next() = 0;
                        end;
                        SupplierSelection.SetRange(Invited);
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Invited := true;
    end;
}





