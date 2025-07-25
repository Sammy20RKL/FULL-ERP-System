page 53032 "Tender Scope of Work"
{
    Caption = 'Tender Scope of Work';
    PageType = ListPart;
    SourceTable = "Tender Scope of Work";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Description;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Scope Type"; Rec."Scope Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scope Type field';

                    trigger OnValidate()
                    begin
                        SetControlApperance();
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Indent)
            {
                Caption = 'Manually Indent';
                Image = Indent;
                ApplicationArea = All;
                ToolTip = 'Executes the Manually Indent action';

                trigger OnAction()
                begin
                    ProcMgt.IndentTenderScopeOfWork(Rec."Tender No.", Rec."Scope Type");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetControlApperance();
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        NameEmphasize := Rec."Scope Type" <> Rec."Scope Type"::"Scope Parameter";
    end;

    trigger OnOpenPage()
    begin
        SetControlApperance();
    end;

    var
        TenderRec: Record "Procurement Request";
        ProcMgt: Codeunit "Procurement Management";
        NameEmphasize: Boolean;
        NameIndent: Integer;

    local procedure GetHeader()
    begin
        TenderRec.SetRange("No.", Rec."Tender No.");
        if TenderRec.FindFirst() then;
    end;

    local procedure SetControlApperance()
    begin
        GetHeader();
    end;
}





