table 52910 "Employee Temp. Board"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[200])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get();
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Change Nos");
                    "No. Series" := '';
                end;
            end;

        }

        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
            trigger OnValidate()
            begin
                Name := "First Name" + '' + "Middle Name" + '' + "Last Name";
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            trigger OnValidate()
            begin
                Name := "First Name" + '' + "Middle Name" + '' + "Last Name";
            end;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            trigger OnValidate()
            begin
                Name := "First Name" + '' + "Middle Name" + '' + "Last Name";
            end;
        }
        field(5; Name; Text[30])
        {
            Caption = 'Name.';

            trigger OnValidate()
            begin

                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[250])
        {
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                if "Search Name" = '' then
                    "Search Name" := SetSearchNameToFullnameAndInitials();
            end;
        }
        field(8; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if not IsHandled then
                    PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if not IsHandled then
                    PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(12; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE("Employee No." = FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            ObsoleteReason = 'Replaced by Image field';
            ObsoleteState = Removed;
            SubType = Bitmap;
            ObsoleteTag = '18.0';
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Gender; Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");
            end;
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(31; Status; Enum "Employee Status")
        {
            Caption = 'Status';

            trigger OnValidate()
            begin
                EmployeeQualification.SetRange("Employee No.", "No.");
                EmployeeQualification.ModifyAll("Employee Status", Status);
                Modify();
            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type = CONST(Person));

            trigger OnValidate()
            begin

            end;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Employee No." = FIELD("No."),
                                                                          "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
                                                                          "From Date" = FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Company E-Mail");
            end;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(55; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(56; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(57; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(58; IBAN; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(59; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Employee Ledger Entry".Amount WHERE("Employee No." = FIELD("No."),
                                                                              "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                              "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
            TableRelation = "SWIFT Code";
            ValidateTableRelation = false;
        }
        field(80; "Application Method"; Enum "Application Method")
        {
            Caption = 'Application Method';
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(1100; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(1101; "Cost Object Code"; Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ObsoleteState = Pending;
            ObsoleteReason = 'This functionality will be replaced by the systemID field';
            ObsoleteTag = '15.0';
        }
        field(52115; "Payroll Suspenstion Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Suspenstion Date';
        }
        field(52116; "Payroll Reactivation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Reactivation Date';
        }
        field(52117; "Employee Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Board Member,Attachee,Intern';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,"Board Member",Attachee,Intern;
            Caption = 'Employee Type';
        }
        field(52154; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(52153; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(52019; Disabled; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
            Caption = 'Disabled';
        }
        field(52111; "Disability Certificate"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability Certificate';
        }
        field(52000; "Date of Birth - Age"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Date of Birth - Age';
        }
        field(52051; "ID No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'ID No.';
            trigger OnValidate()
            begin
                if (strlen("ID No.") < 7) or (strlen("ID No.") > 10) then
                    Error('ID Number can not be less than 7 and more than 10 characters');
            end;
        }
        field(52057; "Marital Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Caption = 'Marital Status';
        }
        field(52058; "Ethnic Origin"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'African,Indian,White,Coloured';
            OptionMembers = African,Indian,White,Coloured;
            Caption = 'Ethnic Origin';
        }
        field(52075; Religion; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Religion';
        }
        field(52122; "Ethnic Community"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Ethnic Communities";
            Caption = 'Ethnic Community';

            trigger OnValidate()
            begin
                if Ethnic.Get("Ethnic Community") then
                    "Ethnic Name" := Ethnic."Ethnic Name";
            end;
        }
        field(52123; "Ethnic Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Ethnic Name';
        }
        field(52124; "Home District"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Home District';
        }
        field(52005; "First Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Language';
        }
        field(52006; "Second Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language';
        }
        field(52007; "First Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Read';
        }
        field(52008; "First Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Write';
        }
        field(52009; "First Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'First Language Speak';
        }
        field(52010; "Second Language Read"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Read';
        }
        field(52011; "Second Language Write"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Write';
        }
        field(52012; "Second Language Speak"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Second Language Speak';
        }
        field(52013; "Other Language"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Language';
        }
        field(52014; "Job Position"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Job";
            Caption = 'Job Position';

            trigger OnValidate()
            begin
                if Jobs.Get("Job Position") then
                    "Job Position Title" := Jobs."Job Description";
            end;
        }
        field(52015; "Job Position Title"; Text[250])
        {
            Caption = 'Job Position Title';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Company Job"."Job Description" where("Job ID" = field("Job Position")));
        }
        field(52120; "Employment Type"; Enum "Employment Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Employment Type';
        }
        field(52054; "Contract Type"; Code[30])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract".Code;
            Caption = 'Contract Type';

            trigger OnValidate()
            begin


            end;
        }
        field(52055; "Type of Contract"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employment Contract";
            Caption = 'Type of Contract';

            trigger OnValidate()
            begin


            end;
        }
        field(52056; "Notice Period"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Notice Period';
        }

        field(52092; "Contract Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Number';
        }
        field(52114; "Contract Length"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Length';

            trigger OnValidate()
            begin
                Validate("Contract Start Date");


            end;
        }
        field(52002; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';

            trigger OnValidate()
            begin


            end;
        }
        field(52003; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
            Caption = 'Contract End Date';
        }
        field(52004; "Employment Date - Age"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Employment Date - Age';
        }
        field(52133; "Secondary Employee"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Secondary Employee';
        }
        field(52062; "Date Of Join"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Join';

            trigger OnValidate()
            var
                CurrentYear: Integer;
                JoinMonth: Integer;
            begin



            end;
        }
        field(52063; "End Of Probation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Of Probation Date';
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        Jobs: Record "Company Job";
        Ethnic: Record "Ethnic Communities";
        HumanResSetup: Record "Human Resources Setup";
        Res: Record Resource;
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Alternative Address";
        EmployeeQualification: Record "Employee Qualification";
        Relative: Record "Employee Relative";
        EmployeeAbsence: Record "Employee Absence";
        MiscArticleInformation: Record "Misc. Article Information";
        ConfidentialInformation: Record "Confidential Information";
        HumanResComment: Record "Human Resource Comment Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        BlockedEmplForJnrlErr: Label 'You cannot create this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
        BlockedEmplForJnrlPostingErr: Label 'You cannot post this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
        EmployeeLinkedToResourceErr: Label 'You cannot link multiple employees to the same resource. Employee %1 is already linked to that resource.', Comment = '%1 = employee no.';

    //  FullName: Text[1000];
    trigger OnInsert()
    var
        ResourcesSetup: Record "Resources Setup";
        Resource: Record Resource;
        IsHandled: Boolean;
    begin


        if "No." = '' then begin
            HumanResSetup.Get();
            HumanResSetup.TestField("Employee Change Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Change Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;


    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure SetSearchNameToFullnameAndInitials(): Code[250]
    begin
        //  exit(FullName() + ' ' + Initials);
    end;

}