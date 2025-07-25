pageextension 53007 "PurchReceiptLinesPageExt" extends "Purch. Receipt Lines"
{
    layout
    {
        addafter(Description)
        {
            field(SpecificationsTxt; SpecificationsTxt)
            {
                Caption = 'Specifications';
                ApplicationArea = All;
                MultiLine = false;
                ToolTip = 'Specifies the value of the Specifications field';

                trigger OnValidate()
                begin
                    Rec.CalcFields(Specification);
                    Rec.Specification.CreateInStream(Instr);
                    SpecificationsBigTxt.Read(Instr);

                    if SpecificationsTxt <> Format(SpecificationsBigTxt) then begin
                        Clear(Rec.Specification);
                        Clear(SpecificationsBigTxt);
                        SpecificationsBigTxt.AddText(SpecificationsTxt);
                        Rec.Specification.CreateOutStream(OutStr);
                        SpecificationsBigTxt.Write(OutStr);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Specification);
        Rec.Specification.CreateInStream(Instr);
        SpecificationsBigTxt.Read(Instr);
        SpecificationsTxt := Format(SpecificationsBigTxt);
    end;

    var
        SpecificationsBigTxt: BigText;
        Instr: InStream;
        OutStr: OutStream;
        SpecificationsTxt: Text;
}





