table 53014 "Item Transfer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Item; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;

            trigger OnValidate()
            begin

                if Items.Get(Item) then begin
                    Description := Items.Description;
                    Items.CalcFields(Inventory);
                    Inventory := Items.Inventory;
                end;
            end;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Employee No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Receiving Employee"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Employee.Get("Receiving Employee");
                "Employee Name" := Employee.FullName();
                /*
                TestField("Company To");
                
                Employee2.ChangeCompany("Company To");
                Clear(EmployeeList);
                EmployeeList.SETTABLEVIEW(Employee2);
                EmployeeList.SETRECORD(Employee2);
                EmployeeList.LOOKUPMODE(true);
                if EmployeeList.RunModal()=Action::LookupOK then
                  begin
                    EmployeeList.GetRecord(Employee2);
                    "Receiving Name":=Employee2."First Name"+' '+Employee2."Middle Name"+' '+Employee2."Last Name";
                  end;
                */
                /*
                Employee2.SetRange("No.","Receiving Employee");
                if Employee2.FindFirst() then
                  begin
                    "Receiving Name":=Employee2."First Name"+' '+Employee2."Middle Name"+' '+Employee2."Last Name";
                  end;
                
                
                
                PurchHeader2.ChangeCompany('New company');
                PurchHeader2.SetRange("Document Type",PurchHeader2."Document Type"::Order);
                Clear(PurchList);
                PurchList.SETTABLEVIEW(PurchHeader2);
                PurchList.SETRECORD(PurchHeader2);
                PurchList.LOOKUPMODE(true);
                if PurchList.RunModal() = Action::LookupOK then begin
                PurchList.GetRecord(PurchHeader2);
                PONumber := PurchHeader2."No.";
                end;
                */

            end;
        }
        field(9; "Receiving Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Company To"; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;
        }
        field(11; "Company From"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; Transfered; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(14; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; Inventory; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Location From"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = Location;
            Caption = 'Issuing Store';
        }
        field(17; "Location To"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Receiving Store';
        }
        field(18; "Company Item"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Company Item Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        PurchSetup.Get();
        PurchSetup.TestField("Store Transfer Nos");
        NoSeriesMgt.InitSeries(PurchSetup."Store Transfer Nos", xRec."No. Series", 0D, No, "No. Series");


        "User ID" := UserId;

        if UserSetup.Get("User ID") then begin
            if Employee.Get(UserSetup."Employee No.") then begin
                "Employee No" := Employee."No.";
                "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        end;


        Date := Today;
        "Company From" := CompanyName;
    end;

    var
        Employee: Record Employee;
        Items: Record Item;
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}





