page 53022 "Request for Quote & Order"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Internal Request Line";
    SourceTableView = where("Header Status" = filter(Released),
                            "RFQ Created" = const(false),
                            "Document Type" = filter(Purchase),
                            "Cleared For Rfq" = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Specifications; Rec.Specification)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specification field';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Amount Including VAT field';
                }
                field(Selected; Rec.Selected)
                {
                    Caption = 'Select';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field';
                }
                field("Selected By"; Rec."Selected By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Selected By field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(MakeQuote)
            {
                Caption = 'Make GPR From Selected';
                Image = CreatePutAway;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Make GPR From Selected action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to create a GPR document from selected entries', false) = true then begin
                        ProcMgt.CreateRFQFromSelected();
                    end;
                end;
            }
        }
    }

    var
        ProcMgt: Codeunit "Procurement Management";
}





