page 53014 "Supplier Categories"
{
    PageType = List;
    SourceTable = "Supplier Category";
    SourceTableView = where(Type = filter(Supplier));
    CardPageId = "Supplier Category Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("No. Prequalified"; Rec."No. Prequalified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Prequalified field';
                }
            }
        }
    }

    actions
    {
    }

    procedure SelectMultipleCategories(): Text
    var
        SupplierCategory: Record "Supplier Category";
    begin
        exit(SelectInCategoryList(SupplierCategory));
    end;

    procedure SelectInCategoryList(var SupplierCategory: Record "Supplier Category"): Text
    var
        SupplierCategories: Page "Supplier Categories";
    begin
        SupplierCategories.SetTableView(SupplierCategory);
        SupplierCategories.LookupMode(true);
        if SupplierCategories.RunModal() = Action::LookupOK then
            exit(SupplierCategories.GetSelectionFilter());
    end;

    procedure GetSelectionFilter(): Text
    var
        SupplierCategory: Record "Supplier Category";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(SupplierCategory);
        exit(GetSelectionFilterForCategories(SupplierCategory));
    end;

    procedure GetSelectionFilterForCategories(var SupplierCategory: Record "Supplier Category"): Text
    var
        RecRef: RecordRef;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        RecRef.GetTable(SupplierCategory);
        exit(SelectionFilterManagement.GetSelectionFilter(RecRef, SupplierCategory.FieldNo("Code")));
    end;
}





