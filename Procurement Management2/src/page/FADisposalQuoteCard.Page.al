page 53037 "FA Disposal Quote Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Suppliers,Tasks';
    SourceTable = "Procurement Request";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("FA Disposal No."; Rec."FA Disposal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Disposal No. field';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 3 Code field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part("ProcLines"; "FA Disposal Quote Lines")
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit Bid")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                image = UnitConversions;
                ApplicationArea = All;
                ToolTip = 'Executes the Submit Bid action';

                trigger OnAction()
                var
                    FADispLines: Record "Procurement Request Lines";
                begin
                    if Confirm('Are you sure?', false) then begin
                        FADispLines.Reset();
                        FADispLines.SetRange("Document No.", Rec."No.");
                        if FADispLines.FindSet() then
                            repeat
                                FADispLines."Bid Submitted" := true;
                                FADispLines.Modify();
                            until FADispLines.Next() = 0;

                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();

                        Message('Bid submitted successfully');
                        CurrPage.Close();
                    end;

                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Process Type" := Rec."Process Type"::"FA Disposal Quote";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type" := Rec."Process Type"::"FA Disposal Quote";
    end;

    local procedure TestTheFields()
    begin
        Rec.TestField("Requisition No");
        Rec.TestField(Title);
        Rec.TestField("Quotation Deadline");
        Rec.TestField("Expected Closing Time");
    end;
}





