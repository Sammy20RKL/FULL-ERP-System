page 65012 "Performance Contracting List"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Performance Contracting";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Decription; Rec.Decription)
                {
                    ToolTip = 'Specifies the value of the Decription field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Strategic Plan"; Rec."Strategic Plan")
                {
                    ToolTip = 'Specifies the value of the Strategic Plan field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action(Lines)
                {
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Performance Contracting Lines";
                    RunPageLink = "Document No." = field(Code);
                    ToolTip = 'Executes the Lines action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Strategic Plan");
                    end;
                }
            }
        }
        area(Reporting)
        {
            group(Action10)
            {
                action("Performance Contracting")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Performance Contracting action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Strategic Plan");
                        Rec.Reset();
                        Rec.SetRange(Code, Rec.Code);
                        Report.Run(Report::"Year Performance", true, false, Rec);
                        //REPORT.RUN(51511534,TRUE,FALSE,Rec);
                    end;
                }
                separator(Action12)
                {
                }
                action("Year Performance_SubIndicator")
                {
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Year Performance_SubIndicator action.';

                    trigger OnAction()
                    begin
                        Rec.TestField("Strategic Plan");
                        Rec.Reset();
                        Rec.SetRange(Code, Rec.Code);
                        Report.Run(Report::"Year Performance_SubIndicator", true, false, Rec);
                        //REPORT.RUN(51511534,TRUE,FALSE,Rec);
                    end;
                }
            }
        }
    }
}

