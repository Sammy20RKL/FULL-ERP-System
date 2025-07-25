page 53119 "Supplier Eval Scores Card"
{
    Caption = 'Supplier Evaluation Scores Card';
    PageType = Card;
    SourceTable = "Supplier Evaluation Score";
    DeleteAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("Score Parameter"; Rec."Score Parameter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score Parameter field';
                }
                field("Score Description"; Rec."Score Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score Description field';
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
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
                field("Total Score"; Rec."Total Parameter Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Score field';
                }
            }
            part(Lines; "Supplier Eval Score Lines")
            {
                SubPageLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin

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





