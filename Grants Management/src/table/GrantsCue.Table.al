table 60039 "Grants Cue"
{
    Caption = 'Grants Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Grants"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Jobs where (Status=filter(Contract), "Approval Status"=filter(Open),"Approval Status"=filter("Pending Approval")));
            Caption = 'Open Grant Agreement';
        }
        field(3; "Approved Grants"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Jobs where (Status=filter(Contract), "Approval Status"=filter(Approved)));
            Caption = 'Approved Grant Agreement';
        }
        field(4; Donors; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Customer);
            Caption = 'Donors';
        }
        field(5; "Projects"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula=count(Jobs where (Status=filter(Project), "Approval Status"=filter(Approved)));
        }
        field(6; "Pending Project Proposals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula=count(Jobs where (Status=filter(Project), "Approval Status"=filter(Open),"Approval Status"=filter("Pending Approval")));
        }
        field(7;"Project Partners"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula=count("Project Partners");
        }
        field(8; "Partner List"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula=count(Vendor);
        }
         field(9; "Requests to Approve"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(10; "Requests Sent for Approval"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Sender ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests Sent for Approval';
            FieldClass = FlowField;
        }
         field(11; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(12; "Grant Close Out"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Close Out Check List");
            Caption = 'Grant Close Out';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
