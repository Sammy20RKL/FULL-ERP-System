page 60060 "Grants Management Cue"
{
    ApplicationArea = All;
    Caption = 'Grants Management Cue';
    PageType = CardPart;
    SourceTable = "Grants Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Grants Management")
            {
                field(Grants; Rec.Grants)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grants field';
                }
                field("Approved Grants"; Rec."Approved Grants")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Grants field';
                }
                field("Grant Close Out";Rec."Grant Close Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Grant Close Out field';
                }
            }
            cuegroup("Donor Management")
            {
                field(Donors; Rec.Donors)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Donors field';
                }

                field("Partner List"; Rec."Partner List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Partner List field';
                }
            }
            cuegroup("Project Management")
            {
                field("Projects"; Rec."Projects")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Projects field';
                }
                field("Pending Project Proposals"; Rec."Pending Project Proposals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pending Project Proposals field';
                }
                field("Project Partners"; Rec."Project Partners")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Partners field';
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                Visible = true;

                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies the value of the Requests to Approve field';
                }
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Approval Request Entries";
                    ToolTip = 'Specifies the value of the Requests Sent for Approval field';
                }
            }
        }
    }
    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID Filter", UserId);

        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
