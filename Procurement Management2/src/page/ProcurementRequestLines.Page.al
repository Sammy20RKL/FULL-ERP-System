page 53015 "Procurement Request Lines"
{
    PageType = ListPart;
    SourceTable = "Procurement Request Lines";
    DeleteAllowed = true;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Category Code field';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                    Editable = false;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                    Editable = false;
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                    Editable = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                    Editable = false;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan field';
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Plan Item field';
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Budget Line field';
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount LCY field';
                }
                field("Requisition No"; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requisition No field.';
                    Enabled = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }

    /*  trigger OnNewRecord(BelowxRec: Boolean)
     begin
         Clear(Rec.Specification);
         Clear(SpecificationBigTxt);
         SpecificationTxt := '';
     end;
  */

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





