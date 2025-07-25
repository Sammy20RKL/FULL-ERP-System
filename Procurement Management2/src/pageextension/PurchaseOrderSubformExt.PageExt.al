pageextension 53005 "Purchase Order Subform Ext" extends "Purchase Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = true;
        }
        modify("Expected Receipt Date")
        {
            Visible = true;
        }


        addafter(Description)
        {
            field(SpecificationsTxt; SpecificationsTxt)
            {
                Caption = 'Specifications';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Specifications field';
                //MultiLine = true;

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
        addafter("Quantity Received")
        {
            field("Quantity Not Received"; QtyNotReceived)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the QtyNotReceived field';
                Visible = false;
            }
        }
        addafter("Line Amount")
        {
            field("Amount of Goods Not Received"; AmntNotReceived)
            {
                Visible = false;
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the AmntNotReceived field';
            }
        }
        addlast(Control1)
        {
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the depreciation book to which the line will be posted if you have selected Fixed Asset in the Type field for this line.';
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Rec.Specification);
        clear(SpecificationsBigTxt);
    end;

    trigger OnAfterGetRecord()
    begin
        GetRemaining();
        Rec.CalcFields(Specification);
        Rec.Specification.CreateInStream(Instr);
        SpecificationsBigTxt.Read(Instr);
        SpecificationsTxt := Format(SpecificationsBigTxt);
    end;

    var
        SpecificationsBigTxt: BigText;
        AmntNotReceived: Decimal;
        QtyNotReceived: Decimal;
        Instr: InStream;
        OutStr: OutStream;
        SpecificationsTxt: Text;

    procedure GetRemaining()
    begin
        //CalcFields("Quantity Received");
        if (Rec."Qty. to Receive" <> 0) and (Rec."Quantity Received" <> 0) then
            QtyNotReceived := Rec.Quantity - Rec."Quantity Received";
        AmntNotReceived := QtyNotReceived * Rec."Direct Unit Cost";
    end;
}





