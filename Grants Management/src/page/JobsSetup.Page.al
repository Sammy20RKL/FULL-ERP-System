page 60059 "Jobs-Setup"
{
    ApplicationArea = All;
    Caption = 'Jobs-Setup';
    PageType = Card;
    SourceTable = "Jobs-Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Automatic Update Job Item Cost"; Rec."Automatic Update Job Item Cost")
                {
                    ToolTip = 'Specifies the value of the Automatic Update Job Item Cost field.', Comment = '%';
                    Caption = 'Automatic Update Job Item Cost';
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Job Nos."; Rec."Job Nos.")
                {
                    ToolTip = 'Specifies the value of the Job Nos. field.', Comment = '%';
                    Caption = 'Job Nos.';
                }
                field("System Contract Nos"; Rec."System Contract Nos")
                {
                    ToolTip = 'Specifies the value of the System Contract Nos field.', Comment = '%';
                    Caption = 'System Contract Nos';
                }
                field("Closeout Nos"; Rec."Closeout Nos")
                {
                    ToolTip = 'Specifies the value of the Closeout Nos field.', Comment = '%';
                    Caption = 'Closeout Nos';
                }
                field("Grant Task Nos"; Rec."Grant Task Nos")
                {
                    ToolTip = 'Specifies the value of the Grant Task Nos field.', Comment = '%';
                    Caption = 'Grant Task Nos';
                }
                field("Concept Nos"; Rec."Concept Nos")
                {
                    ToolTip = 'Specifies the value of the Concept Nos field.', Comment = '%';
                    Caption = 'Concept Nos';
                }
                field("Proposal Nos"; Rec."Proposal Nos")
                {
                    ToolTip = 'Specifies the value of the Proposal Nos field.', Comment = '%';
                    Caption = 'Proposal Nos';
                }
            }
        }
    }
}
