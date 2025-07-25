page 53117 "Supplier Evaluation Setup Card"
{
    Caption = 'Supplier Evaluation Setup Card';
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
                field("Evalueation Description"; Rec."Evaluation Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluation Heading field';
                }
                field("Evaluation Criteria"; Rec."Evaluation Criteria")
                {
                    ToolTip = 'Specifies the value of the Evaluation Criteria field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                        CurrPage.Lines.Page.GetHeader();
                        CurrPage.Lines.Page.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                    Visible = false;
                }
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Maximum Score field';
                }
            }
            part(Lines; "Supplier Eval Setup Lines")
            {
                SubPageLink = Code = field(Code);
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::Tender;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Rec.Description);
        Clear(DesciptionBigTxt);
        DescriptionTxt := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Tender;
        Rec.Active := true;
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





