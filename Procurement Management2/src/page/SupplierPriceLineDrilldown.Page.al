page 53004 "Supplier Price Line Drilldown"
{
    Caption = 'Supplier Price Line Drilldown';
    PageType = List;
    SourceTable = "Supplier Price Line";
    UsageCategory = None;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Quote No"; Rec."Quote No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No field.';
                    Enabled = false;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No field.';
                    Enabled = false;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                    Enabled = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    Enabled = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                    Enabled = false;
                }
                field(SpecificationTxt; SpecificationTxt)
                {
                    Caption = 'Specification';
                    Description = 'Specification';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specification field';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Specification);
                        Rec.Specification.CreateInStream(InStrm);
                        SpecificationBigTxt.Read(InStrm);

                        if SpecificationTxt <> Format(SpecificationBigTxt) then begin
                            Clear(Rec.Specification);
                            Clear(SpecificationBigTxt);
                            SpecificationBigTxt.AddText(SpecificationTxt);
                            Rec.Specification.CreateOutStream(OutStrm);
                            SpecificationBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                    Enabled = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                    Enabled = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quoted Unit Amount field.';
                }
                field("Amount Inclusive VAT"; Rec."Amount Inclusive VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount Inclusive VAT field.';
                    Enabled = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                    Enabled = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    begin
        Rec.CalcFields(Specification);
        Rec.Specification.CreateInStream(InStrm);
        SpecificationBigTxt.Read(InStrm);
        SpecificationTxt := Format(SpecificationBigTxt);
    end;

    var
        SpecificationBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationTxt: Text;
}







