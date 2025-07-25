page 53106 "Supplier Preliminary Scores"
{
    Caption = 'Supplier Preliminary Scores';
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Score";
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Supplier Eval Scores Card";
    SourceTableView = where("Evaluation Criteria" = const("Preliminary Evaluation"));

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
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pass field.';
                }
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

    local procedure GetHeader()
    begin
        if SupplierEval.Get(Rec."Document No.") then;
    end;
}





