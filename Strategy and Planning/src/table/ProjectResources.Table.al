table 65026 "Project Resources"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Resource Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Employee,Vendor,Item,Asset,Other';
            OptionMembers = ,Employee,Vendor,Item,Asset,Other;
        }
        field(4; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Resource Type" = const(Employee)) Employee."No." else if ("Resource Type" = const(Vendor)) Vendor."No." else if ("Resource Type" = const(Asset)) "Fixed Asset"."No." else if ("Resource Type" = const(Item)) Item."No.";

            trigger OnValidate()
            begin
                Clear(Description);
                case "Resource Type" of  //,Employee,Vendor,Item,Asset,Other
                    "Resource Type"::Employee:
                        begin
                            EmpRe.Get("No.");
                            Description := EmpRe."First Name" + ' ' + EmpRe."Middle Name" + ' ' + EmpRe."Last Name"
                        end;
                    "Resource Type"::Vendor:
                        begin
                            Vend.Get("No.");
                            Description := Vend.Name;
                        end;
                    "Resource Type"::Item:
                        begin
                            Items.Get("No.");
                            Description := Items.Description;
                        end;
                    "Resource Type"::Asset:
                        begin
                            Assets.Get("No.");
                            Description := Assets.Description;
                        end;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Cost; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Role; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Project Lead,Project Member';
            OptionMembers = " ","Project Lead","Project Member";
        }
    }

    keys
    {
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmpRe: Record Employee;
        Assets: Record "Fixed Asset";
        Items: Record Item;
        Vend: Record Vendor;
}

