table 53046 "Project Task Components"
{
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
            TableRelation = "Project Tasks"."Task No" where("Project No" = field("Project No"));
            Caption = 'Task No';
        }
        field(3; Component; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Component';
        }
        field(4; "Component Budget"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Component Budget';

            trigger OnValidate()
            begin
                TaskBudget := "Component Budget";
                ProjectTasks.Reset();
                ProjectTasks.SetRange("Project No", "Project No");
                ProjectTasks.SetRange("Task No", "Task No");
                if ProjectTasks.FindFirst() then begin
                    ProjectTaskComponents.Reset();
                    ProjectTaskComponents.SetRange("Project No", "Project No");
                    ProjectTaskComponents.SetRange("Task No", "Task No");
                    if ProjectTaskComponents.FindFirst() then
                        repeat
                            if ProjectTaskComponents.Component <> Component then
                                TaskBudget += ProjectTaskComponents."Component Budget";
                        until ProjectTaskComponents.Next() = 0;
                    if ProjectTasks."Task Budget" < TaskBudget then
                        Error(BudgetError, "Task No", "Project No", TaskBudget - ProjectTasks."Task Budget");
                end;
            end;
        }
        field(5; "Progress Level"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Progress Level';

            trigger OnValidate()
            begin
                Progress := "Progress Level";
                ProjectTaskComponents.Reset();
                ProjectTaskComponents.SetRange("Project No", "Project No");
                ProjectTaskComponents.SetRange("Task No", "Task No");
                if ProjectTaskComponents.FindFirst() then
                    repeat
                        if ProjectTaskComponents.Component <> Component then
                            Progress += ProjectTaskComponents."Progress Level";
                    until ProjectTaskComponents.Next() = 0;
                if Progress > 100 then
                    Error(ProgressError, "Task No", "Project No", Progress - 100);
            end;
        }
    }

    keys
    {
        key(Key1; "Project No", "Task No", Component)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ProjectTaskComponents: Record "Project Task Components";
        ProjectTasks: Record "Project Tasks";
        Progress: Decimal;
        TaskBudget: Decimal;
        ProgressError: Label 'Accumulative progress level for task %1 of project %2 has exceeded 100% by %3';
        BudgetError: Label 'You have exceeded task %1 of project %2 budget by %3';
}





