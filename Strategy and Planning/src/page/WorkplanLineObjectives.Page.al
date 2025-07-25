page 65022 "Workplan Line Objectives"
{
    ApplicationArea = All;
    Caption = 'Objectives';
    PageType = ListPart;
    SourceTable = "WorkPlan Line Objectives";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("KRA Code"; Rec."KRA Code")
                {
                    ToolTip = 'Specifies the value of the KRA Code field.';
                }
                field("KRA Description"; Rec."KRA Description")
                {
                    ToolTip = 'Specifies the value of the KRA Description field.';
                }
                field("Objective Code"; Rec."Objective Code")
                {
                    ToolTip = 'Specifies the value of the Objective Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Monitoring & Evaluation"; Rec."Monitoring & Evaluation")
                {
                    Editable = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Monitoring & Evaluation field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            separator(Action11)
            {
            }
            action("Work Line Activities") // check on editable
            {
                Image = PostedCreditMemo;
                RunObject = page "Workplan Line Sub-Activities";
                RunPageLink = Code = field(Code), "Objective Code" = field("Objective Code"), "KRA Code" = field("KRA Code");
                ToolTip = 'Executes the Work Line Activities action.';
            }
            separator(Action10)
            {
            }
            action("Send to - Monitoring & Eval.") //check
            {
                Image = Evaluate;
                ToolTip = 'Executes the Send to - Monitoring & Eval. action.';

                trigger OnAction()
                var
                    CompleteTxt: Label 'Successfully Send to monitoring & evaluation.';
                    ConfirmationTxt: Label 'This action will send this  workplan activity too monitoring & evaluation. Do you wish to proceed!';
                begin
                    Rec.TestField("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::" ");

                    if not Confirm(ConfirmationTxt, true) then
                        exit;

                    Rec.Validate("Monitoring & Evaluation", Rec."Monitoring & Evaluation"::"In Process");
                    Rec.Modify();
                    Message(CompleteTxt);
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        workplan.Reset();
        workplan.SetRange(workplan.Code, Rec.Code);
        if workplan.FindFirst() then begin
            if workplan.Status <> workplan.Status::Open then
                Error('You can only edit an open document');
        end;
    end;

    var
        workplan: Record "Work Plan Header";
}

