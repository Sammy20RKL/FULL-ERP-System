table 65020 "WorkPlan Line Objectives"
{

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Monitoring & Evaluation", "Monitoring & Evaluation"::" ");
            end;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Objective Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'IF (Source=CONST(Strategic Plan)) "Objective Codes".No. ELSE IF (Source=CONST(Performance Contract)) "Performance Contracting Lines".Item/Activity';

            trigger OnLookup()
            begin
                Workplan.Get(Code);

                Workplan.TestField("Financial Year");

                GLBudgetName.Get(Workplan."Financial Year");
                GLBudgetName.TestField("Start Date");
                GLBudgetName.TestField("End Date");

                if Workplan.Source = Workplan.Source::"Strategic Plan" then begin
                    fnObjective.Reset();
                    fnObjective.SetRange("End Date", GLBudgetName."Start Date", GLBudgetName."End Date");
                    if Page.RunModal(Page::"Objective Codes", fnObjective) = Action::LookupOK then
                        "Objective Code" := fnObjective."No.";
                    Description := fnObjective.Description;
                    "Start Date" := fnObjective."Start Date";
                    "End Date" := fnObjective."End Date"
                end else
                    if Workplan.Source = Workplan.Source::"Performance Contract" then begin
                        PerformanceContractingLines.Reset();
                        PerformanceContractingLines.SetRange("Document No.", Workplan."Plan Code");
                        if Page.RunModal(Page::"Performance Contracting Lines", PerformanceContractingLines) = Action::LookupOK then
                            "Objective Code" := Format(PerformanceContractingLines."Line No.");
                        Description := PerformanceContractingLines."Item/Activity";
                    end;
            end;

            trigger OnValidate()
            begin
                Clear(Description);
            end;
        }
        field(16; "Monitoring & Evaluation"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,In Process,On Hold,Closed';
            OptionMembers = " ","In Process","On Hold",Closed;

            trigger OnValidate()
            begin
                if Workplan.Get(Code) then begin
                    if Workplan.Source = Workplan.Source::"Strategic Plan" then begin
                        SetStrategicDetails(Workplan."Plan Code");
                        "Strategic No." := Workplan."Plan Code";
                    end;
                    if Workplan.Source = Workplan.Source::"Performance Contract" then begin
                        PerformanceContracting.Get(Workplan."Plan Code");
                        "Strategic No." := PerformanceContracting."Strategic Plan";
                        "Performance Contracting No." := Workplan."Plan Code";
                    end;
                    Source := Workplan.Source;
                    Modify();
                end;
            end;
        }
        field(17; "Evaluation Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Strategic No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Source; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Strategic Plan,Performance Contract';
            OptionMembers = " ","Strategic Plan","Performance Contract";
        }
        field(20; "Performance Contracting No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "KRA Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "KRA Codes"."No.";

            trigger OnValidate()
            begin

                if KCodes.Get("KRA Code") then
                    "KRA Description" := KCodes.Description;
            end;
        }
        field(22; "KRA Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Attachment Link"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Objective Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("Monitoring & Evaluation", "Monitoring & Evaluation"::" ");
    end;

    trigger OnModify()
    begin
        //TESTFIELD("Monitoring & Evaluation", "Monitoring & Evaluation"::" ");
    end;

    var
        GLBudgetName: Record "G/L Budget Name";
        KCodes: Record "KRA Codes";
        fnObjective: Record "Objective Codes";
        PerformanceContracting: Record "Performance Contracting";
        PerformanceContractingLines: Record "Performance Contracting Lines";
        Workplan: Record "Work Plan Header";

    local procedure SetStrategicDetails(StrategicNo: Code[20])
    var
        MonitorinEvalua: Record "Monitoring & Evaluation";
        Strategic: Record "Strategic Plan";
    begin
        Strategic.Get(StrategicNo);


        MonitorinEvalua.Reset();
        MonitorinEvalua.SetRange("No.", Strategic.Code);
        if not MonitorinEvalua.FindFirst() then begin
            MonitorinEvalua."No." := Strategic.Code;
            MonitorinEvalua.Description := Strategic.Description;
            MonitorinEvalua."Start Date" := Strategic."Start Date";
            MonitorinEvalua."End Date" := Strategic."End Date";
            MonitorinEvalua.Mission := Strategic.Mission;
            MonitorinEvalua.Vision := Strategic.Vision;
            MonitorinEvalua.Closed := Strategic.Closed;
            MonitorinEvalua."Closed BY" := Strategic."Closed BY";
            MonitorinEvalua."Date Closed" := Strategic."Date Closed";
            MonitorinEvalua."Time Closed" := Strategic."Time Closed";
            MonitorinEvalua.Insert();
        end;
    end;
}

