page 53078 "Purchase Request-Tracking"
{
    CardPageID = "Purchase Request Tracking Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approval Entries';
    SourceTable = "Internal Request Header";
    SourceTableView = where("Document Type" = const(Purchase),
                            Archived = const(true),
                            Status = filter(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order Date field';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Receipt Date field';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Description field';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field("Reason Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason Description field';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Print)
            {
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Print/Preview action';

                trigger OnAction()
                begin
                    IR.Reset();
                    IR.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Purchase Request Tracking", true, false, IR);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageView();
    end;

    trigger OnInit()
    begin
        RfqVisible := false;
    end;

    trigger OnOpenPage()
    begin
        SetPageView();
    end;

    var
        IR: Record "Internal Request Header";
        RfqVisible: Boolean;

    local procedure SetPageView()
    begin
        if Rec.Status = Rec.Status::Released then
            RfqVisible := true
        else
            RfqVisible := false;
    end;
}





