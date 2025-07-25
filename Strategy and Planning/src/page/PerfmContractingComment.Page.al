page 65018 "Perfm. Contracting Comment"
{
    ApplicationArea = All;
    PageType = CardPart;
    SourceTable = "Performance Contracting Lines";

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.';
                }
                field("Totaling Type"; Rec."Totaling Type")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Totaling Type field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Rec."Row Text" <> '' then
            if not Confirm('This action will mark entry as submitted. Do you want to proceed!', true) then exit;
        createcommententries();
    end;

    local procedure createcommententries()
    var
        PerfmContracComment: Record "Performance Contract Comments";
    begin
        PerfmContracComment.Reset();
        PerfmContracComment.SetRange("Document No.", Rec."Document No.");
        PerfmContracComment.SetRange("Documet Line No.", Rec."Line No.");
        if not PerfmContracComment.FindFirst() then begin
            PerfmContracComment.Init();
            PerfmContracComment."Document No." := Rec."Document No.";
            PerfmContracComment."Line No." := setnextseqnum(Rec."Document No.") + 10000;
            PerfmContracComment."Document Date" := Today;
            PerfmContracComment."Document Time" := Time;
            PerfmContracComment."Created BY" := UserId;
            PerfmContracComment."Documet Line No." := Rec."Line No.";
            PerfmContracComment."Row No." := Rec."Row No.";
            PerfmContracComment.Resource := Format(Rec.Class);
            PerfmContracComment.Remarks := Format(Rec."Totaling Type");
            PerfmContracComment.Insert();
        end;

        Clear(Rec.Class);
        Clear(Rec."Totaling Type");
        Rec.Modify();
    end;

    local procedure setnextseqnum(DocNo: Code[20]) LineN: Integer
    var
        PerfmContracComment: Record "Performance Contract Comments";
    begin
        PerfmContracComment.Reset();
        PerfmContracComment.SetRange("Document No.", DocNo);
        if PerfmContracComment.FindLast() then
            LineN := PerfmContracComment."Line No."
    end;
}

