table 60007 "Jobs-Setup"
{
    Caption = 'Jobs Setup';


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Job Nos."; Code[10])
        {
            Caption = 'Job Nos.';
            TableRelation = "No. Series";
        }
        field(1001; "Automatic Update Job Item Cost"; Boolean)
        {
            Caption = 'Automatic Update Job Item Cost';
        }
        field(1002; "Grant Task Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1003; "Concept Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1004; "Proposal Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1005; "Auto Update Project Status"; Boolean)
        {
        }
        field(1006; "System Contract Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1007; "Closeout Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(1008; "Donor Contact Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1009; "Donor Proposal Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1010; "Grantee Attachments"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(1011; "Grantee Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50002; "GGBC Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Student Application Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Referee Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Scholarship Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50006; "UploadedFs Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50007; "Project Overview Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50008; "Profile Pics Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50009; "Donor TypeNos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Schools Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50011; "University Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50012; "Postal Code Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50013; "Bank Detail Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50014; "myCounty Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50015; "myBanks Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50016; "myBranch Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50017; "mySubcounty Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50018; "Doc Library Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50019; "POCA Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50020; "Proposal Calls"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50021; "Indicator Matrix Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50022; "Grant History Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50023; "Reporting Uploads Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50024; "GAP Minutes Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50025; "GAP Minutes Line Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50026; "Notification Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50027; "Feedback Email Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50028; "Applicant Instituion"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50029; "Wards Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50030; "Peer Review Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50031; "Pre-GAP Minutes Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50032; "Consultant RefereeNos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50033; "Feedbacks Nos"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(50034; "Consultant No"; Code[30])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

