page 53124 "Vendor Evaluation SubForm"
{
    PageType = ListPart;
    SourceTable = "Vendor Evaluation Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field';
                }
                field(Supplier; Rec.Supplier)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier field';
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Type field';
                }
                field("Evaluation Line"; Rec."Evaluation Line")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Category field';
                }
                field("Line Description"; DescTxt)
                {
                    ApplicationArea = All;
                    MultiLine = false;
                    ToolTip = 'Specifies the value of the DescTxt field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Line Description");
                        Rec."Line Description".CreateInStream(Instrm);
                        DescBigTxt.Read(Instrm);

                        if DescTxt <> Format(DescBigTxt) then begin
                            Clear(Rec."Line Description");
                            Clear(DescBigTxt);
                            DescBigTxt.AddText(DescTxt);
                            Rec."Line Description".CreateOutStream(OutStrm);
                            DescBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field';

                    trigger OnValidate()
                    begin
                        if Rec.Score > Rec."Max Score" then
                            Error('Score Cannot Exceed Maximum Score');
                    end;
                }
                field("Max Score"; Rec."Max Score")
                {
                    Visible = false;
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Score field';
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Score field';
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pass field';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
        Rec.CalcFields("Line Description");
        Rec."Line Description".CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
    end;
}
