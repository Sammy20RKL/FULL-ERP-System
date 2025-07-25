page 53126 "Vendor Evaluation Setup Card"
{
    PageType = Card;
    SourceTable = "Supplier Evaluation SetUp";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field';
                }
                field("Evaluation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Heading field';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field';
                }
                field(Description; DescriptionTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the DescriptionTxt field';

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Description);
                        Rec.Description.CreateInStream(InStrm);
                        DesciptionBigTxt.Read(InStrm);

                        if DescriptionTxt <> Format(DesciptionBigTxt) then begin
                            Clear(Rec.Description);
                            Clear(DesciptionBigTxt);
                            DesciptionBigTxt.AddText(DescriptionTxt);
                            Rec.Description.CreateOutStream(OutStrm);
                            DesciptionBigTxt.Write(OutStrm)
                        end;

                    end;
                }
                field("Score Criteria"; Rec."Score Criteria")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score Criteria field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Maximum Score field';
                }
            }
            part(Lines; "Vendor Eval Setup Lines")
            {
                SubPageLink = HeaderCode = field(Code);
                ApplicationArea = All;
            }
        }
    }

    //SourceTableView = where(Type = const(Existing));
    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::Existing;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Existing;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Description);
        Rec.Description.CreateInStream(InStrm);
        DesciptionBigTxt.Read(InStrm);
        DescriptionTxt := Format(DesciptionBigTxt);
    end;

    var
        DesciptionBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        DescriptionTxt: Text;
}





