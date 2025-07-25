page 53114 "Prospective Supplier Lines"
{
    Caption = 'Prospective Supplier Lines';
    PageType = ListPart;
    SourceTable = "Prospective Supplier Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Response No"; Rec."Response No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Response No field';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specifications field';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Visible = PriceView;
                    ToolTip = 'Specifies the value of the Unit Price field';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Visible = PriceView;
                    ToolTip = 'Specifies the value of the Amount field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        ProspectiveRec: Record "Prospective Suppliers";
        PriceView: Boolean;

    local procedure GetHeader()
    begin
        if ProspectiveRec.Get(Rec."Response No") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();
        if ProspectiveRec."Supplier Status" = ProspectiveRec."Supplier Status"::New then
            PriceView := false
        else
            PriceView := true;
    end;
}





