page 53148 "Tender Evaluation Setup Lines"
{
    Caption = 'Tender Evaluation Setup Lines';
    PageType = ListPart;
    SourceTable = "Tender Evaluation Setup Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field(Description; DescTxt)
                {
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
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    Visible = MaxVisible;
                    ToolTip = 'Specifies the value of the Maximum Score field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Rec.Description);
        Clear(DescBigTxt);
        DescTxt := '';
    end;

    trigger OnOpenPage()
    begin
        GetHeader();
    end;

    trigger OnAfterGetRecord()
    begin
        GetHeader();
    end;

    var
        ScoreSetupHeader: Record "Supplier Evaluation SetUp";
        DescBigTxt: BigText;
        MaxVisible: Boolean;
        Instrm: InStream;
        Outstrm: OutStream;
        DescTxt: Text;

    local procedure GetHeader()
    begin
        Rec.CalcFields(Description);
        Rec.Description.CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);


        if ScoreSetupHeader.Get(Rec.Code) then;

        case ScoreSetupHeader."Score Criteria" of
            ScoreSetupHeader."Score Criteria"::Score:
                MaxVisible := true;
            else
                MaxVisible := false;
        end;
    end;
}





