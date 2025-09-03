Table 52908 "Payroll Project Allocation"
{

    fields
    {
        field(1; Period; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period"."Starting Date";
            //TableRelation = "Payroll Calender_AU"."Date Opened";
        }
        field(2; "Employee No"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
            //TableRelation = "Payroll Employee_AU";

            trigger OnValidate()
            begin
                if HREmployees.Get("Employee No") then
                    "Employee Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name";
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Project Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DONOR'));
            CaptionClass = '1,2,1';
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Project Code");
            end;
        }
        field(5; Allocation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Budget Line Code"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('STRATEGIC'));
            CaptionClass = '1,2,2';
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Budget Line Code");
            end;
        }
        field(7; "Close"; boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Close';
            //ToolTip = 'Indicates if the project allocation is closed.';
        }
        // field(8; "Shortcut Dimension 1 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 1 Code';
        //     CaptionClass = '1,1,1';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        //     end;
        // }
        // field(9; "Shortcut Dimension 2 Code"; Code[20])
        // {
        //     Caption = 'Shortcut Dimension 2 Code';
        //     CaptionClass = '1,1,2';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        //     end;
        // }
        field(11; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
           CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(12; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(13; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(14; "Shortcut Dimension 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(15; "Shortcut Dimension 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(16; "Shortcut Dimension 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), Blocked = const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(10; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
        }



    }

    keys
    {
        key(Key1; Period, "Project Code", "Employee No", "Budget Line Code")
        {
            Clustered = true;
        }


    }

    fieldgroups
    {
    }
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    var
        HREmployees: Record Employee;
        DimMgt: Codeunit DimensionManagement;
}

