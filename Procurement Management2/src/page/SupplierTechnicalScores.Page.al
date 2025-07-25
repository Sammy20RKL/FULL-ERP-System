page 53113 "Supplier Technical Scores"
{
    Caption = 'Supplier Technical Scores';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Score";
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Supplier Eval Scores Card";
    SourceTableView = where("Evaluation Criteria" = const("Technical Evaluation"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
                }
                field("Score Parameter"; Rec."Score Parameter")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Score Parameter field';
                }
                field("Score Description"; Rec."Score Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Score Description field';
                }
                field("Total Score"; Rec."Total Parameter Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Score field';
                    Visible = TechnicalServices;
                }
                field(Conform; Rec.Conform)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conform field.';
                    Visible = TechnicalGoods;
                }
            }
        }
    }

    trigger OnInit()
    begin
        TechnicalGoods := false;
        TechnicalServices := false;
    end;

    trigger OnOpenPage()
    begin
        GetHeader();
    end;

    trigger OnAfterGetRecord()
    begin
        GetHeader();

        Rec.CalcFields(Description);
        Rec.Description.CreateInStream(InStrm);
        DesciptionBigTxt.Read(InStrm);
        DescriptionTxt := Format(DesciptionBigTxt);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        Rec."Tender No." := SupplierEval."Quote No";
    end;

    var
        SupplierEval: Record "Supplier Evaluation Header";
        DesciptionBigTxt: BigText;
        InStrm: InStream;
        DescriptionTxt: Text;
        TechnicalServices, TechnicalGoods : Boolean;

    procedure GetHeader()
    begin
        if SupplierEval.Get(Rec."Document No.") then begin
            case SupplierEval."Tender Item Type" of
                SupplierEval."Tender Item Type"::" ",
            SupplierEval."Tender Item Type"::Services:
                    TechnicalServices := true;
                SupplierEval."Tender Item Type"::Goods:
                    TechnicalGoods := true;
            end;
        end;
    end;
}





