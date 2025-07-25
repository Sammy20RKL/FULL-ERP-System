table 53045 "Project Tasks"
{
    DrillDownPageID = "Project Tasks";
    LookupPageID = "Project Tasks";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "New Project Header";
            Caption = 'Project No';
        }
        field(2; "Task No"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Task No';

            trigger OnValidate()
            begin
            end;
        }
        field(3; Descriprion; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Descriprion';
        }
        field(4; "Responsible Person"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Project Team"."ID No" where("Project No" = field("Project No"));
            Caption = 'Responsible Person';
        }
        field(5; "User ID"; Code[25])
        {
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            Caption = 'User ID';
        }
        field(6; Category; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Email,"Phone Call","Field Visit",Training,Meeting,"Report Preparation","Report Presentation";
            Caption = 'Category';
        }
        field(7; Importance; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Low,Moderate,High;
            Caption = 'Importance';
        }
        field(8; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Started,Suspended,Finished,"Pending Approval",Approved,Rejected;
            Caption = 'Status';

            trigger OnValidate()
            begin
                if Status = Status::Started then begin
                    Project.Get("Project No");
                    Project.TestField("Estimated Start Date");
                    if Project."Actual Start Date" = 0D then begin
                        Project."Actual Start Date" := Today;
                        Project.Modify();
                    end;
                end;
            end;
        }
        field(9; "Progress Level %"; Decimal)
        {
            CalcFormula = sum("Project Task Components"."Progress Level" where("Project No" = field("Project No"),
                                                                                "Task No" = field("Task No")));
            FieldClass = FlowField;
            Caption = 'Progress Level %';
        }
        field(10; "Task Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Task Budget';

            trigger OnValidate()
            begin
                Project.Reset();
                Project.SetRange("No.", "Project No");
                if Project.FindFirst() then begin
                    TaskBudget := "Task Budget";
                    ProjectTasks.Reset();
                    ProjectTasks.SetRange("Project No", "Project No");
                    ProjectTasks.SetFilter("Task No", '<>%1', "Task No");
                    if ProjectTasks.FindFirst() then
                        repeat
                            TaskBudget += ProjectTasks."Task Budget";
                        until ProjectTasks.Next() = 0;
                    if Project."Project Budget" < TaskBudget then
                        Error('You have exceeded project %1 budget by %2', "Project No", TaskBudget - Project."Project Budget");
                end;
            end;
        }
        field(11; "Estimated Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Start Date';
        }
        field(12; "Estimated End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated End Date';
        }
        field(13; "Actual Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Start Date';
        }
        field(14; "Actual End date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual End date';
        }
        field(15; No; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
        }
        field(16; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "Project No", "Task No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := UserId;
    end;

    var
        Project: Record "New Project Header";
        ProjectTasks: Record "Project Tasks";
        TaskBudget: Decimal;
}





