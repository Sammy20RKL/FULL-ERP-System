table 65011 "Performance Contracting Lines"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Row No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item/Activity"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Measure; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Annual Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Specific Indicator Components"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Evidence; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Department; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; Resource; Integer)
        {
            CalcFormula = count("Performance Resource" where("Document No." = field("Document No."), "Document Line No." = field("Line No."), Department = field(Department)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Row Text"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Heading; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Class; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Indicator,SubIndicator';
            OptionMembers = " ",Indicator,SubIndicator;

            trigger OnValidate()
            begin
                Clear(Indicator);
                Clear(SubIndicator);
                Clear("SubGroup Order");
                if Class = Class::Indicator then begin
                    Indicator := true;
                    "SubGroup Order" := "Group Order";
                end else begin
                    if Class = Class::SubIndicator then begin
                        SubIndicator := true;
                        "SubGroup Order" := "Group Order";
                    end;
                end;
            end;
        }
        field(17; "Totaling Type"; Option)
        {
            Caption = 'Totaling Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Formula';
            OptionMembers = " ",Formula;

            trigger OnValidate()
            begin
                Validate(Totaling);
            end;
        }
        field(18; Totaling; Text[250])
        {
            Caption = 'Totaling';
            DataClassification = ToBeClassified;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //LookupTotaling;
            end;

            trigger OnValidate()
            begin
                /* CASE "Totaling Type" OF
                    "Totaling Type"::"2", "Totaling Type"::"5":
                        BEGIN
                            Totaling := UPPERCASE(Totaling);
                            CheckFormula(Totaling);
                        END;
                END; */
            end;
        }
        field(19; Show; Option)
        {
            Caption = 'Show';
            DataClassification = ToBeClassified;
            OptionCaption = 'Yes,No,If Any Column Not Zero,When Positive Balance,When Negative Balance';
            OptionMembers = Yes,No,"If Any Column Not Zero","When Positive Balance","When Negative Balance";
        }
        field(20; Bold; Boolean)
        {
            Caption = 'Bold';
            DataClassification = ToBeClassified;
        }
        field(21; Italic; Boolean)
        {
            Caption = 'Italic';
            DataClassification = ToBeClassified;
        }
        field(22; Underline; Boolean)
        {
            Caption = 'Underline';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Double Underline" and Underline then begin
                    "Double Underline" := false;
                    Message(ForceUnderLineMsg, FieldCaption("Double Underline"));
                end;
            end;
        }
        field(23; "Double Underline"; Boolean)
        {
            Caption = 'Double Underline';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Double Underline" and Underline then begin
                    Underline := false;
                    Message(ForceUnderLineMsg, FieldCaption(Underline));
                end;
            end;
        }
        field(24; "Show Opposite Sign"; Boolean)
        {
            Caption = 'Show Opposite Sign';
            DataClassification = ToBeClassified;
        }
        field(25; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }
        field(27; Detailed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Quarter 1 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(32; "Quarter 2 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(33; "Quarter 3 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(34; "Quarter 4 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(36; "Total Quarter Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(37; "Quarter 1 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual";
            end;
        }
        field(38; "Quarter 2 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual"
            end;
        }
        field(39; "Quarter 3 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual"
            end;
        }
        field(40; "Quarter 4 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual"
            end;
        }
        field(42; "Total Quarter Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Submitted; Boolean)
        {
            CalcFormula = exist("Performance Contract Comments" where("Document No." = field("Document No."), "Documet Line No." = field("Line No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Performance Contract Comments" where("Document No." = field("Document No."), "Line No." = field("Line No."));
        }
        field(61; Q1; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(62; Q2; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; Q3; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; Q4; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "User ID"; Code[50])
        {
            CalcFormula = lookup("Performance Resource"."User ID" where("Document No." = field("Document No."), "Document Line No." = field("Line No."), Department = field(Department)));
            Caption = 'User ID';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(73; Indicator; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(74; SubIndicator; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Group Order"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(76; "SubGroup Order"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Remarks Q2"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Remarks Q3"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Remarks Q4"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Annual Target", "Quarter 2 Target", "Quarter 3 Target", "Quarter 4 Target", "Total Quarter Target", "Quarter 1 Actual", "Quarter 2 Actual", "Quarter 3 Actual", "Quarter 4 Actual", "Total Quarter Actual";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item/Activity", "Document No.", "Line No.")
        {
        }
    }

    var
        ForceUnderLineMsg: Label '%1 will be set to false.', Comment = '%1= Field underline ';
        Text001: Label 'The parenthesis at position %1 is misplaced.';
        Text002: Label 'You cannot have two consecutive operators. The error occurred at position %1.';
        Text003: Label 'There is an operand missing after position %1.';
        Text004: Label 'There are more left parentheses than right parentheses.';
        Text005: Label 'There are more right parentheses than left parentheses.';

    procedure CheckFormula(Formula: Code[250])
    var
        HasOperator: Boolean;
        i: Integer;
        ParenthesesLevel: Integer;
    begin
        ParenthesesLevel := 0;
        for i := 1 to StrLen(Formula) do begin
            if Formula[i] = '(' then
                ParenthesesLevel := ParenthesesLevel + 1
            else
                if Formula[i] = ')' then
                    ParenthesesLevel := ParenthesesLevel - 1;
            if ParenthesesLevel < 0 then
                Error(Text001, i);
            if Formula[i] in ['+', '-', '*', '/', '^'] then begin
                if HasOperator then
                    Error(Text002, i);

                HasOperator := true;

                if i = StrLen(Formula) then
                    Error(Text003, i);

                if Formula[i + 1] = ')' then
                    Error(Text003, i);
            end else
                HasOperator := false;
        end;
        if ParenthesesLevel > 0 then
            Error(Text004);

        if ParenthesesLevel < 0 then
            Error(Text005);
    end;

    local procedure GetAccSchedSetup()
    begin
        /*IF "Schedule Name" <> AccSchedName.Name THEN
          AccSchedName.GET("Schedule Name");
        IF AccSchedName."Analysis View Name" <> '' THEN
          IF AccSchedName."Analysis View Name" <> AnalysisView.Code THEN
            IF NOT AnalysisView.GET(AccSchedName."Analysis View Name") THEN BEGIN
              MESSAGE(
                Text015,
                AccSchedName.TABLECAPTION,AnalysisView.TABLECAPTION,AccSchedName."Analysis View Name",
                AccSchedName.FIELDCAPTION("Analysis View Name"),AccSchedName.TABLECAPTION);
              AccSchedName."Analysis View Name" := '';
              AccSchedName.MODIFY;
            END;
        
        IF AccSchedName."Analysis View Name" = '' THEN BEGIN
          IF NOT HasGLSetup THEN BEGIN
            GLSetup.GET;
            HasGLSetup := TRUE;
          END;
          CLEAR(AnalysisView);
          AnalysisView."Dimension 1 Code" := GLSetup."Global Dimension 1 Code";
          AnalysisView."Dimension 2 Code" := GLSetup."Global Dimension 2 Code";
        END;*/

    end;

    procedure Indent()
    begin
        if Indentation < 10 then
            Indentation += 1;
    end;

    procedure Outdent()
    begin
        if Indentation > 0 then
            Indentation -= 1;
    end;
}

