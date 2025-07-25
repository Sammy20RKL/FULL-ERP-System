page 53026 "Item Transfer"
{
    PageType = Card;
    SourceTable = "Item Transfer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field';
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field';
                }
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field';
                }
                field("Company From"; Rec."Company From")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company From field';
                }
                field("Location From"; Rec."Location From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location From field';
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item field';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory field';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity to Transfer';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity to Transfer field';
                }
                label("Company Tranfering To:")
                {
                    Caption = 'Company Tranfering To:';
                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = All;
                }
                field("Company To"; Rec."Company To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company To field';
                }
                field("Receiving Employee"; Rec."Receiving Employee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Employee field';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Employee2.ChangeCompany(Rec."Company To");
                        Clear(EmployeeList);
                        //EmployeeList.ChangeCompany("Company To");
                        EmployeeList.SetTableView(Employee2);
                        EmployeeList.SetRecord(Employee2);
                        EmployeeList.LookupMode(true);
                        if EmployeeList.RunModal() = Action::LookupOK then begin
                            EmployeeList.GetRecord(Employee2);
                            Rec."Receiving Name" := Employee2."First Name" + ' ' + Employee2."Middle Name" + ' ' + Employee2."Last Name";
                        end;
                    end;
                }
                field("Receiving Name"; Rec."Receiving Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receiving Name field';
                }
                field("Location To"; Rec."Location To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location To field';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Location.ChangeCompany(Rec."Company To");
                        Clear(LocationList);
                        //LocationList.ChangeComp("Company To");
                        LocationList.SetTableView(Location);
                        LocationList.SetRecord(Location);
                        LocationList.LookupMode(true);
                        if LocationList.RunModal() = Action::LookupOK then begin
                            LocationList.GetRecord(Location);
                            Rec."Location To" := Location.Code;
                        end;
                    end;
                }
                field("Company Item"; Rec."Company Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Item field';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Items.ChangeCompany(Rec."Company To");
                        Clear(ItemList);
                        //ItemList.ChangeCompany("Company To");
                        ItemList.SetTableView(Items);
                        ItemList.SetRecord(Items);
                        ItemList.LookupMode(true);
                        if ItemList.RunModal() = Action::LookupOK then begin
                            ItemList.GetRecord(Items);
                            Rec."Company Item" := Items."No.";
                            Rec."Company Item Name" := Items.Description;
                        end;
                    end;
                }
                field("Company Item Name"; Rec."Company Item Name")
                {
                    Caption = 'Item Name';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Name field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Transfer Item")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Transfer Item action';

                trigger OnAction()
                begin
                    if Confirm(Text001, true, Rec.Item, Rec.Description, Rec."Company To") = false then begin
                        exit;
                    end;
                    ProcurementMgt.TransferItem(Rec.Item, Rec.No, Rec."Company To", Rec."Company From", Rec.Quantity, Rec."Location To", Rec."Location From", Rec."Company Item");
                    Message(Text002, Rec.Item, Rec.Description, Rec."Company To");
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        Employee2: Record Employee;
        Items: Record Item;
        Location: Record Location;
        ProcurementMgt: Codeunit "Procurement Management";
        EmployeeList: Page "Employee List";
        ItemList: Page "Item List";
        LocationList: Page "Location List";
        Text001: Label 'Do you want to transfer Item %1 - %2 to %3';
        Text002: Label 'Item %1 - %2 Transfered Successfully to %3';

    procedure ChangeCompany(CompTo: Text[250])
    begin
    end;
}





