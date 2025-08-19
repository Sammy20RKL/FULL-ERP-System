codeunit 60001 "WorkFlow Responses"
{
    procedure ReleaseGrantCloseOut(var CloseOut: Record "Close Out Check List")
    var
        GrantCloseOut: Record "Close Out Check List";

    begin
        GrantCloseOut.Reset();
        GrantCloseOut.SetRange("Closeout No.",CloseOut."Closeout No.");
        if GrantCloseOut.FindFirst() then begin
            GrantCloseOut.Status := GrantCloseOut.Status::Approved;
            GrantCloseOut.Modify(true);
        end;
    end;

    procedure ReOpenGrantCloseOut(var CloseOut: Record "Close Out Check List")
    var
        GrantCloseOut: Record "Close Out Check List";

    begin
        // GrantCloseOut.Reset();
        // GrantCloseOut.SetRange("Closeout No.",CloseOut."Closeout No.");
        // if GrantCloseOut.FindFirst() then begin
            CloseOut.Status := CloseOut.Status::Open;
            CloseOut.Modify(true);
        // end;
    end;
}
