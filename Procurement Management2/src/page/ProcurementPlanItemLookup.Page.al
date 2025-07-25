
page 53136 "Procurement Plan Item Lookup"
{
    Caption = 'Procurement Plan Item Lookup';
    PageType = List;
    SourceTable = "Procurement Plan Item";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';

                field("Quarter Value"; Rec."Quarter Value")
                {
                    ToolTip = 'Specifies the value of the Quarter Item is Needed field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Plan Item No"; Rec."Plan Item No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Item No field';
                    Editable = false;
                }
                field("Month Name"; Rec."Month Name")
                {
                    ToolTip = 'Specifies the value of the Month Name field';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Supplier Category Code"; Rec."Supplier Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category Code field.';
                }
                field("Supplier Category Name"; Rec."Supplier Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category Name field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    Caption = 'Item Description';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field';
                }
                field("Expenditure Type"; Rec."Expenditure Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expenditure Type field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Planned Quantity';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planned Quantity field';
                }
                field("Ordered Quantity"; Rec."Ordered Quantity")
                {
                    ToolTip = 'Specifies the value of the Ordered Quantity field';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field';
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    Caption = 'Procurement Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Procurement Type field';
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field';
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field';
                    Visible = false;
                }
            }
        }
    }

    var
        DatesMgt: Codeunit "Dates Management";
        SelectionFilterMgt: Codeunit SelectionFilterManagement;

    procedure GetSelectionFilter(): Text
    var
        PlanItems: Record "Procurement Plan Item";
    begin
        CurrPage.SetSelectionFilter(PlanItems);
        exit(GetSelectionFilterForPlanItem(PlanItems));
    end;

    procedure SelectActivePlanItemsForRequisition(var PurchReqLine: Record "Internal Request Line"): Text
    var
        ProcPlanItem: Record "Procurement Plan Item";
    begin
        exit(SelectInPlanItemList(ProcPlanItem, PurchReqLine));
    end;

    procedure SelectInPlanItemList(var PlanItems: Record "Procurement Plan Item"; PurchReqLine: Record "Internal Request Line"): Text
    var
        PurchReqHeader: Record "Internal Request Header";
        PlanItemsPage: Page "Procurement Plan Item Lookup";
    begin
        PurchReqHeader.Get(PurchReqLine."Document No.");

        PlanItems.SetRange("Plan Year", PurchReqHeader."Procurement Plan");
        PlanItems.SetRange("Shortcut Dimension 1 Code", PurchReqHeader."Shortcut Dimension 1 Code");
        PlanItems.SetRange("Shortcut Dimension 2 Code", PurchReqHeader."Shortcut Dimension 2 Code");
        PlanItems.SetRange(Quarter, DatesMgt.GetQuarter(PurchReqHeader."Order Date"));
        PlanItems.SetFilter(Quantity, '>%1', 0);
        PlanItems.CalcFields("Ordered Quantity");
        if PlanItems.FindSet() and ((PlanItems.Quantity - PlanItems."Ordered Quantity") > 0) then begin
            PlanItemsPage.SetTableView(PlanItems);
            PlanItemsPage.LookupMode(true);
            if PlanItemsPage.RunModal() = Action::LookupOK then
                exit(PlanItemsPage.GetSelectionFilter());
        end;
    end;

    local procedure GetSelectionFilterForPlanItem(var PlanItems: Record "Procurement Plan Item"): Text
    var
        RecRef: RecordRef;
    begin
        RecRef.GetTable(PlanItems);
        exit(SelectionFilterMgt.GetSelectionFilter(RecRef, PlanItems.FieldNo("Plan Item No")));
    end;
}





