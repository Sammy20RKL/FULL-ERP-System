table 60025 "FAWE Email Notifications"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = false;
            NotBlank = true;
        }
        field(2; "Email Sender"; Text[50])
        {
        }
        field(3; "Email Recipient"; Text[50])
        {
        }
        field(4; "Sender Name"; Text[50])
        {
        }
        field(5; Body; Text[250])
        {
        }
        field(6; "Table"; Code[20])
        {
        }
        field(7; "User Id"; Code[30])
        {
        }
        field(8; "Date Sent"; Date)
        {
        }
        field(9; "Time Sent"; Time)
        {
        }
        field(10; Description; Text[200])
        {
        }
        field(11; "Send Status"; Boolean)
        {
        }
        field(12; Source; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Proposal,Contract,Project,Grant Application,Scholarship,Student,Grant,KCDFDoc,GranteeApplication,Consultant,ImprestAccounting';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Proposal,Contract,Project,"Grant Application",Scholarship,Student,Grant,KCDFDoc,GranteeApplication,Consultant,ImprestAccounting;
        }
        field(13; "Document No"; Code[30])
        {
        }
        field(14; Subject; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

