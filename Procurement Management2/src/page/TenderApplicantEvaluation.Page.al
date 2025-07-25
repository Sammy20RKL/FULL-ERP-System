page 53138 "Tender Applicant Evaluation"
{
    Caption = 'Tender Applicant Evaluation';
    PageType = ListPart;
    SourceTable = "Tender Applicant Evaluation";
    SourceTableView = sorting("Tender No.", "Supplier Code", Code, "Line No.");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; DescTxt)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the DescTxt field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Description);
                        Rec.Description.CreateInStream(Instrm);
                        DescBigTxt.Read(Instrm);

                        if DescTxt <> Format(DescBigTxt) then begin
                            Clear(Rec.Description);
                            Clear(DescBigTxt);
                            DescBigTxt.AddText(DescTxt);
                            Rec.Description.CreateOutStream(OutStrm);
                            DescBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    Enabled = false;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field.';
                    Enabled = false;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                    Enabled = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Enabled = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        GetHeader();
    end;

    trigger OnAfterGetRecord()
    begin
        GetHeader();
    end;

    var
        DescBigTxt: BigText;
        Instrm: InStream;
        Outstrm: OutStream;
        DescTxt: Text;

    local procedure GetHeader()
    begin
        Rec.CalcFields(Description);
        Rec.Description.CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
    end;
}






