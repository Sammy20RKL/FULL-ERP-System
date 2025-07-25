table 65022 "WorkPlan Line Sub-Activities"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Objective Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = '"Objective Codes"';
            Editable = false;
            TableRelation = "Objective Codes"."No.";

            trigger OnValidate()
            begin
                if Objec.Get("Objective Code") then
                    Description := Objec.Description;
            end;
        }
        field(4; "Activities Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Activities";

            trigger OnValidate()
            begin
                WorkActivities.Reset();
                WorkActivities.SetRange(Code, "Activities Code");
                if WorkActivities.Find('-') then
                    "Description [Activities]" := WorkActivities.Description
            end;
        }
        field(5; "Responsible Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(6; Output; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Approved Total Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "First Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Second Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Third Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Fourth Quarter"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Sub Activity Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WorkPlan Sub-Activities";

            trigger OnValidate()
            begin
                Subactivities.Reset();
                Subactivities.SetRange(Code, "Sub Activity Code");
                if Subactivities.Find('-') then
                    "Description [Sub Activities]" := Subactivities.Description
            end;
        }
        field(13; "Description [Activities]"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Description [Sub Activities]"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Key Performance Indicator"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; July; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; August; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; September; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; October; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; November; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; December; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; January; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; February; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; March; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; April; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; June; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "GOK Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Approved Total Budget" := "GOK Approved Budget" + "Donor Funds Approved Budget";
            end;
        }
        field(28; "Donor Funds Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Approved Total Budget" := "GOK Approved Budget" + "Donor Funds Approved Budget";
            end;
        }
        field(29; May; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Unit of Measure"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Donor in Kind"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Quarter 1 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(33; "Quarter 2 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(34; "Quarter 3 Target"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Target" := "Quarter 1 Target" + "Quarter 2 Target" + "Quarter 3 Target" + "Quarter 4 Target";
            end;
        }
        field(35; "Quarter 4 Target"; Decimal)
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
                //Update Strategic Plan<>Actuals
                WkPlan.Reset();
                if WkPlan.Get(Code) then begin
                    WkPlan.Validate("Financial Year");
                    WkPlan.Modify();
                    WkPlan.TestField("Start Date");
                    WkPlan.TestField("End Date");
                    StPlan.Reset();
                    if StPlan.Get(WkPlan."Plan Code") then begin
                        StsLines.Reset();
                        StsLines.SetRange("Header No.", StPlan.Code);
                        StsLines.SetRange("Objective Code", "Objective Code");
                        StsLines.SetRange("Strategic Code", "Strategic Code");
                        StsLines.SetRange("Entry No.", "Line No");
                        if StsLines.FindFirst() then begin
                            WpLines.Reset();
                            //WpLines.SETRANGE(Code,WkPlan.Code);
                            WpLines.SetRange("Objective Code", "Objective Code");
                            WpLines.SetRange("Strategic Code", "Strategic Code");
                            WpLines.SetRange("Line No", "Line No");
                            if WpLines.Find('-') then begin
                                WpLines.CalcSums("Quarter 1 Actual", "Quarter 2 Actual", "Quarter 3 Actual", "Quarter 4 Actual");
                                if StPlan."Start Date" = WkPlan."Start Date" then
                                    StsLines."Year 1 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 1 Actual" - xRec."Quarter 1 Actual";
                                if CalcDate('<+1Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 2 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 1 Actual" - xRec."Quarter 1 Actual";
                                if CalcDate('<+2Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 3 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 1 Actual" - xRec."Quarter 1 Actual";
                                if CalcDate('<+3Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 4 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 1 Actual" - xRec."Quarter 1 Actual";
                                if CalcDate('<+4Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 5 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 1 Actual" - xRec."Quarter 1 Actual";
                                StsLines.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(38; "Quarter 2 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual";
                //Update Strategic Plan<>Actuals
                WkPlan.Reset();
                if WkPlan.Get(Code) then begin
                    WkPlan.Validate("Financial Year");
                    WkPlan.Modify();
                    WkPlan.TestField("Start Date");
                    WkPlan.TestField("End Date");
                    StPlan.Reset();
                    if StPlan.Get(WkPlan."Plan Code") then begin
                        StsLines.Reset();
                        StsLines.SetRange("Header No.", StPlan.Code);
                        StsLines.SetRange("Objective Code", "Objective Code");
                        StsLines.SetRange("Strategic Code", "Strategic Code");
                        StsLines.SetRange("Entry No.", "Line No");
                        if StsLines.FindFirst() then begin
                            WpLines.Reset();
                            //WpLines.SETRANGE(Code,WkPlan.Code);
                            WpLines.SetRange("Objective Code", "Objective Code");
                            WpLines.SetRange("Strategic Code", "Strategic Code");
                            WpLines.SetRange("Line No", "Line No");
                            if WpLines.Find('-') then begin
                                WpLines.CalcSums("Quarter 1 Actual", "Quarter 2 Actual", "Quarter 3 Actual", "Quarter 4 Actual");
                                if StPlan."Start Date" = WkPlan."Start Date" then
                                    StsLines."Year 1 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 2 Actual" - xRec."Quarter 2 Actual";
                                if CalcDate('<+1Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 2 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 2 Actual" - xRec."Quarter 2 Actual";
                                if CalcDate('<+2Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 3 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 2 Actual" - xRec."Quarter 2 Actual";
                                if CalcDate('<+3Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 4 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 2 Actual" - xRec."Quarter 2 Actual";
                                if CalcDate('<+4Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 5 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 2 Actual" - xRec."Quarter 2 Actual";
                                StsLines.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(39; "Quarter 3 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual";
                //Update Strategic Plan<>Actuals
                WkPlan.Reset();
                if WkPlan.Get(Code) then begin
                    WkPlan.Validate("Financial Year");
                    WkPlan.Modify();
                    WkPlan.TestField("Start Date");
                    WkPlan.TestField("End Date");
                    StPlan.Reset();
                    if StPlan.Get(WkPlan."Plan Code") then begin
                        StsLines.Reset();
                        StsLines.SetRange("Header No.", StPlan.Code);
                        StsLines.SetRange("Objective Code", "Objective Code");
                        StsLines.SetRange("Strategic Code", "Strategic Code");
                        StsLines.SetRange("Entry No.", "Line No");
                        if StsLines.FindFirst() then begin
                            WpLines.Reset();
                            //WpLines.SETRANGE(Code,WkPlan.Code);
                            WpLines.SetRange("Objective Code", "Objective Code");
                            WpLines.SetRange("Strategic Code", "Strategic Code");
                            WpLines.SetRange("Line No", "Line No");
                            if WpLines.Find('-') then begin
                                WpLines.CalcSums("Quarter 1 Actual", "Quarter 2 Actual", "Quarter 3 Actual", "Quarter 4 Actual");
                                if StPlan."Start Date" = WkPlan."Start Date" then
                                    StsLines."Year 1 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 3 Actual" - xRec."Quarter 3 Actual";
                                if CalcDate('<+1Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 2 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 3 Actual" - xRec."Quarter 3 Actual";
                                if CalcDate('<+2Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 3 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 3 Actual" - xRec."Quarter 3 Actual";
                                if CalcDate('<+3Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 4 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 3 Actual" - xRec."Quarter 3 Actual";
                                if CalcDate('<+4Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 5 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 3 Actual" - xRec."Quarter 3 Actual";
                                StsLines.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(40; "Quarter 4 Actual"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Total Quarter Actual" := "Quarter 1 Actual" + "Quarter 2 Actual" + "Quarter 3 Actual" + "Quarter 4 Actual";
                //Update Strategic Plan<>Actuals
                WkPlan.Reset();
                if WkPlan.Get(Code) then begin
                    WkPlan.Validate("Financial Year");
                    WkPlan.Modify();
                    WkPlan.TestField("Start Date");
                    WkPlan.TestField("End Date");
                    StPlan.Reset();
                    if StPlan.Get(WkPlan."Plan Code") then begin
                        StsLines.Reset();
                        StsLines.SetRange("Header No.", StPlan.Code);
                        StsLines.SetRange("Objective Code", "Objective Code");
                        StsLines.SetRange("Strategic Code", "Strategic Code");
                        StsLines.SetRange("Entry No.", "Line No");
                        if StsLines.FindFirst() then begin
                            WpLines.Reset();
                            //WpLines.SETRANGE(Code,WkPlan.Code);
                            WpLines.SetRange("Objective Code", "Objective Code");
                            WpLines.SetRange("Strategic Code", "Strategic Code");
                            WpLines.SetRange("Line No", "Line No");
                            if WpLines.Find('-') then begin
                                WpLines.CalcSums("Quarter 1 Actual", "Quarter 2 Actual", "Quarter 3 Actual", "Quarter 4 Actual");
                                if StPlan."Start Date" = WkPlan."Start Date" then
                                    StsLines."Year 1 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 4 Actual" - xRec."Quarter 4 Actual";
                                if CalcDate('<+1Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 2 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 4 Actual" - xRec."Quarter 4 Actual";
                                if CalcDate('<+2Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 3 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 4 Actual" - xRec."Quarter 4 Actual";
                                if CalcDate('<+3Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 4 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 4 Actual" - xRec."Quarter 4 Actual";
                                if CalcDate('<+4Y>', StPlan."Start Date") = WkPlan."Start Date" then
                                    StsLines."Year 5 Actual" := WpLines."Quarter 1 Actual" + WpLines."Quarter 2 Actual" + WpLines."Quarter 3 Actual" + WpLines."Quarter 4 Actual" + "Quarter 4 Actual" - xRec."Quarter 4 Actual";
                                StsLines.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(42; "Total Quarter Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(43; "Strategic Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Objective Description"; Text[150])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(45; "Strategic Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Strategic Codes"."No.";

            trigger OnValidate()
            begin
                Clear("Strategic Description");
                if SCodes.Get("Strategic Code") then
                    "Strategic Name" := SCodes.Description;
                "Strategic Description" := SCodes.Description;
            end;
        }
        field(46; "Strategic Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(47; "KRA Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "KRA Codes"."No.";

            trigger OnValidate()
            begin

                if KCodes.Get("KRA Code") then
                    "KRA Description" := KCodes.Description;
            end;
        }
        field(48; "KRA Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Sub-Activities"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Strategies."Entry No." where("Objective Code" = field("Objective Code"), "Strategic Code" = field("Strategic Code"));
        }
    }

    keys
    {
        key(Key1; "Code", "Objective Code", "Activities Code", "Sub Activity Code", "KRA Code", "Strategic Code", "Description [Activities]", "Description [Sub Activities]", "Key Performance Indicator")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        KCodes: Record "KRA Codes";
        Objec: Record "Objective Codes";
        Objectiv: Record "Objective Codes";
        SCodes: Record "Strategic Codes";
        StPlan: Record "Strategic Plan";
        StsLines: Record Strategies;
        WorkActivities: Record "WorkPlan Activities";
        WkPlan: Record "Work Plan Header";
        WpLines: Record "WorkPlan Line Sub-Activities";
        Subactivities: Record "WorkPlan Sub-Activities";
}

