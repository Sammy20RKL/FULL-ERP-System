codeunit 65005 "Workflow Responses SP"
{
    //Projects
    procedure ReleaseProjects(Req: Record "Project Header")
    var
        ReqRec: Record "Project Header";
    begin
        if ReqRec.Get(Req.Code) then begin
            ReqRec."Status" := ReqRec."Status"::Approved;
            ReqRec.Modify();
        end;
    end;

    procedure ReopenProjects(Req: Record "Project Header")
    var
        ReqRec: Record "Project Header";
    begin
        if ReqRec.Get(Req.Code) then begin
            ReqRec."Status" := ReqRec."Status"::Open;
            ReqRec.Modify();
        end;
    end;

    //Workplans
    procedure ReleaseWorkplan(var Workplan: Record "Work Plan Header")
    var
        WorkplanRec: Record "Work Plan Header";
    begin
        WorkplanRec.Reset();
        WorkplanRec.SetRange(Code, Workplan.Code);
        if WorkplanRec.FindFirst() then begin
            WorkplanRec.Status := WorkplanRec.Status::Approved;
            WorkplanRec.Modify(true);
        end;
    end;

    procedure ReopenWorkplan(var Workplan: Record "Work Plan Header")
    var
        WorkplanRec: Record "Work Plan Header";
    begin
        WorkplanRec.Reset();
        WorkplanRec.SetRange(Code, Workplan.Code);
        if WorkplanRec.FindFirst() then begin
            WorkplanRec.Status := WorkplanRec.Status::Open;
            WorkplanRec.Modify(true);
        end;
    end;
}
