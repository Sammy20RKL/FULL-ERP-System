table 53008 "Committee Member"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Procurement Request";
            Caption = 'Ref No';
        }
        field(2; Commitee; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = false;
            TableRelation = "Procurement Committees";
            Caption = 'Commitee';
        }
        field(3; "Committee Member No"; Code[10])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = if (Type = const(Employee)) Employee
            else
            if (Type = const("External Consultant")) Vendor;
            Caption = 'Committee Member No';

            trigger OnValidate()
            begin
                case Type of
                    Type::Employee:
                        begin
                            if Empl.Get("Committee Member No") then begin
                                Empl.TestField("User ID");
                                Empl.TestField("Company E-Mail");
                                Name := Empl."First Name" + ' ' + Empl."Last Name";
                                "E-Mail Address" := Empl."Company E-Mail";
                                "User ID" := Empl."User ID";
                                "Mobile Phone No." := Empl."Mobile Phone No.";
                            end;
                        end;
                    Type::"External Consultant":
                        begin
                            if Vendor.Get("Committee Member No") then begin
                                Vendor.TestField("E-Mail");
                                Name := Vendor.Name;
                                "E-Mail Address" := Vendor."E-Mail";
                                "Mobile Phone No." := Vendor."Mobile Phone No.";
                            end;
                        end;
                end;
            end;
        }
        field(4; Name; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(5; "Appointment No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Appointment No';

            trigger OnValidate()
            begin
                if Appoitment.Get("Appointment No") then begin
                    "Appointment No" := Appoitment."Appointment No";
                    Commitee := Appoitment."Committee ID";
                end;
            end;
        }
        field(6; Chair; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Chair';
        }
        field(7; Secretary; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Secretary';
        }
        field(8; "Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Tender No.';
        }
        field(9; Role; Text[2000])
        {
            DataClassification = CustomerContent;
            Caption = 'Role';
        }
        field(10; "Committee Member Type"; Enum "Tender Committee Member Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Committee Member Type';
        }
        field(11; "Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Employee","External Consultant";
            Caption = 'Type';
        }
        field(12; "E-Mail Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail Address';
        }
        field(13; "Opening Password"; Text[8])
        {
            DataClassification = CustomerContent;
            //ExtendedDatatype = Masked;
            Editable = false;
        }
        field(14; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";
        }
        field(15; "Mobile Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Mobile Phone No.';
        }
        field(17; "Representative Department"; Code[200])
        {
            TableRelation = Employee."Job Title";
        }
        field(18; "Representative Department 1"; Option)
        {
            OptionMembers = ," ",Finance,ProgramCH;
        }
        //field(19; "Representative Department Type" ; Enum respe )
        //{}
    }

    keys
    {
        key(Key1; "Appointment No", "Committee Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Empl: Record Employee;
        Appoitment: Record "Tender Committees";
        Vendor: Record Vendor;
}





