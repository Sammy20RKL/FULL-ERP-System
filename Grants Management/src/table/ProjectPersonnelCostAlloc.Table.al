table 60036 "Project Personnel Cost Alloc"
{

    fields
    {
        field(1; Project; Code[50])
        {
            TableRelation = Jobs;
        }
        field(2; "Employee No"; Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                Emp.Get("Employee No");
                "Employee Name" := Emp.FullName();
                "Project Role" := Emp.Title;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Project Role"; Code[30])
        {
            TableRelation = "Project Roles";

            trigger OnValidate()
            begin
                Projects.Get(Project);
                "Start Date" := Projects."Starting Date";
                "End Date" := Projects."Ending Date";
            end;
        }
        field(5; "Start Date"; Date)
        {
        }
        field(6; "End Date"; Date)
        {
        }
        field(7; "% Allocation Value"; Integer)
        {
        }
        field(8; comment; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Project, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Projects: Record Jobs;
        Res: Record Resource;
}

