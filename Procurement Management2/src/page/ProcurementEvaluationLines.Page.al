page 53096 "Procurement Evaluation Lines"
{
    PageType = ListPart;
    SourceTable = "Procurement Evaluation Line";
    InsertAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Vendor Name";
                Editable = not TenderGenerated;
                field("Vendor No"; Rec."Vendor No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No field';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(SpecificationsTxt; SpecificationsTxt)
                {
                    Caption = 'Specifications';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Amount field';
                }
                field("Negotiated Unit Amount"; Rec."Negotiated Unit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Negotiated Unit Amount field';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Total Amount';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Code field';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Amount field';
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Inclusive VAT field';
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Committed Amount field';
                }
                field("Financial Score"; Rec."Financial Score")
                {
                    ToolTip = 'Specifies the value of the Financial Score field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Suggested; Rec.Suggested)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Suggested field';
                }
                field(Awarded; Rec.Awarded)
                {
                    Caption = 'Award';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Award field';
                }
                field("Quote No"; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No field';
                }
            }
        }
    }

    actions
    {
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
        SpecificationsBigTxt: BigText;
        SpecificationsTxt: Text;
        Inst: InStream;
        TenderEval: Record "Procurement Evaluation Header";
        TenderGenerated: Boolean;

    local procedure SetControlAppearance()
    begin
        if TenderEval.Get(Rec."Document No.") then;

        if TenderEval."LPO/Contract Generated" then
            TenderGenerated := true
        else
            TenderGenerated := false;

        Rec.CalcFields(Specification);
        Rec.Specification.CreateInStream(Inst);
        SpecificationsBigTxt.Read(Inst);
        SpecificationsTxt := Format(SpecificationsBigTxt);
    end;

}





