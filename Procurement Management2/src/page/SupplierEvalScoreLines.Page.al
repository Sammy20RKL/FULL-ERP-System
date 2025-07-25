page 53120 "Supplier Eval Score Lines"
{
    Caption = 'Supplier Evaluation Score Lines';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Score Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Score Description"; DescTxt)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the DescTxt field';
                    MultiLine = true;
                }
                field(Score; Rec.Score)
                {
                    Visible = ScoreVisible;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Actual Zero"; Rec."Actual Zero")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Actual Zero field.';
                    Visible = ScoreVisible;
                    Editable = Rec.Score = 0;
                }
                field("Pass/Fail"; Rec."Pass/Fail")
                {
                    Visible = YesNoVisible;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pass/Fail field';
                }
                field("Conform/Not Conform"; Rec."Conform/Not Conform")
                {
                    Visible = ConformVisible;
                    ShowMandatory = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conform/Not Conform field.';
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    Visible = ScoreVisible;
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Maximum Score field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    var
        DescBigTxt: BigText;
        ScoreVisible: Boolean;
        YesNoVisible: Boolean;
        ConformVisible: Boolean;
        Instrm: InStream;
        DescTxt: Text;

    local procedure SetPageView()
    begin
        case Rec."Score Criteria" of
            Rec."Score Criteria"::Score:
                begin
                    ScoreVisible := true;
                    YesNoVisible := false;
                    ConformVisible := false;
                end;
            Rec."Score Criteria"::"Pass/Fail":
                begin
                    YesNoVisible := true;
                    ScoreVisible := false;
                    ConformVisible := false;
                end;
            Rec."Score Criteria"::"Conform/Not Conform":
                begin
                    ConformVisible := true;
                    YesNoVisible := false;
                    ScoreVisible := false;
                end;
            else begin
                YesNoVisible := false;
                ScoreVisible := false;
                ConformVisible := false;
            end;
        end;

        Rec.CalcFields("Score Description");
        Rec."Score Description".CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
    end;
}





