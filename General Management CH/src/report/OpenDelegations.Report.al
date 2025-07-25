report 50001 "Open Delegations"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Approvals Delegation"; "Approvals Delegation")
        {
            DataItemTableView = where(Status = const(Delegated));

            trigger OnAfterGetRecord()
            begin
                if "Approvals Delegation"."Delegation End Date" <= Today then begin
                    SendResumptionEmail("Approvals Delegation");
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Text000: Label 'Approvals Delegation has been Automatically resumed from %1 to you';
        Text001: Label 'Dear %1, <p> The delegation No. %2 running from %3 to %4 has been automatically resumed from %5 to you following the lapse of the same</p>.<p> This message has been automatically generated, no need to reply.<p/>';
        Text003: Label 'Dear %1, <p> The delegation No. %2 running from %3 to %4 have been assigned to you from %5 to proceed to %6</p>.<p> This message has been automatically generated, no need to reply.<p/>';
        Text002: Label 'You have been assigned approval rights by %1';

    procedure SendDelegationEmail(var DelegationsRec: Record "Approvals Delegation")
    var
        CompanyInfo: Record "Company Information";
        UserRec: Record User;
        UserRec1: Record User;
        UserRec2: Record "User Setup";
        UserRec3: Record "User Setup";
        Receipient, RecipientCC : List of [Text];
        Body: Text;
        DelegatedTo: Text;
        SenderEmail: Text;
        SenderName: Text;
        Subject: Text;
        Username: Text;
    begin

        CompanyInfo.Get();

        UserRec.Reset();
        UserRec.SetRange("User Name", DelegationsRec."Current User");
        if UserRec.Find('-') then;

        if UserRec."Full Name" <> '' then
            Username := UserRec."Full Name"
        else
            Username := DelegationsRec."Current User";

        UserRec2.Get(DelegationsRec."Current User");
        //UserRec2.TESTFIELD("E-Mail");

        UserRec1.Reset();
        UserRec1.SetRange("User Name", DelegationsRec."Delegated To");
        if UserRec1.Find('-') then;

        if UserRec1."Full Name" <> '' then
            DelegatedTo := UserRec1."Full Name"
        else
            DelegatedTo := DelegationsRec."Delegated To";

        UserRec3.Get(DelegationsRec."Delegated To");
        //UserRec3.TESTFIELD("E-Mail");

        SenderEmail := CompanyInfo."E-Mail";
        SenderName := CompanyInfo.Name;
        Receipient.Add(UserRec3."E-Mail");
        Subject := StrSubstNo(Text002, Username);
        Body := StrSubstNo(Text003, DelegatedTo, DelegationsRec."Delegation No.", DelegationsRec."Delegation Start Date", DelegationsRec."Delegation End Date", Username, DelegationsRec."Reason for Delegation");
        if SenderEmail <> '' then
            if Receipient.Count <> 0 then begin
                EmailMessage.Create(Receipient, Subject, Body, true, RecipientCC, RecipientCC);
                Email.Send(EmailMessage);
            end;
    end;

    procedure SendResumptionEmail(var DelegationsRec: Record "Approvals Delegation")
    var
        CompanyInfo: Record "Company Information";
        UserRec: Record User;
        UserRec1: Record User;
        UserRec2: Record "User Setup";
        UserRec3: Record "User Setup";
        Receipient, ReceipientCC : List of [Text];
        Body: Text;
        CurrentUser: Text;
        SenderEmail: Text;
        SenderName: Text;
        Subject: Text;
        Username: Text;
    begin

        CompanyInfo.Get();

        UserRec.Reset();
        UserRec.SetRange("User Name", DelegationsRec."Delegated To");
        if UserRec.Find('-') then;

        if UserRec."Full Name" <> '' then
            Username := UserRec."Full Name"
        else
            Username := DelegationsRec."Delegated To";

        UserRec2.Get(DelegationsRec."Delegated To");
        //UserRec2.TESTFIELD("E-Mail");

        UserRec1.Reset();
        UserRec1.SetRange("User Name", DelegationsRec."Current User");
        if UserRec1.Find('-') then;

        if UserRec1."Full Name" <> '' then
            CurrentUser := UserRec1."Full Name"
        else
            CurrentUser := DelegationsRec."Current User";

        UserRec3.Get(DelegationsRec."Current User");
        //UserRec3.TESTFIELD("E-Mail");

        SenderEmail := CompanyInfo."E-Mail";
        SenderName := CompanyInfo.Name;
        Receipient.Add(UserRec3."E-Mail");
        ReceipientCC.Add(UserRec2."E-Mail");
        Subject := StrSubstNo(Text000, Username);
        Body := StrSubstNo(Text001, CurrentUser, DelegationsRec."Delegation No.", DelegationsRec."Delegation Start Date", DelegationsRec."Delegation End Date", Username);

        EmailMessage.Create(Receipient, Subject, Body, true, ReceipientCC, ReceipientCC);
        Email.Send(EmailMessage);
        //Reset Status
        DelegationsRec.Status := DelegationsRec.Status::Resumed;
        DelegationsRec.Modify();
        //
    end;
}
