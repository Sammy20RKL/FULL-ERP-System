page 53056 "Committee Members"
{
    Caption = 'Committee Members';
    PageType = ListPart;
    SourceTable = "Committee Member";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Committee Member No"; Rec."Committee Member No")
                {
                    ToolTip = 'Specifies the value of the Committee Member No field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                }
                field(Role; Rec.Role)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Role field';
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail Address field.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile Phone No. field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                    Editable = false;
                }
                field("Committee Member Type"; Rec."Committee Member Type")
                {
                    ToolTip = 'Specifies the value of the Committee Member Type field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Representative Department"; rec."Representative Department 1")
                {
                    //OptionCaptionML =', ,Finance,ProgramCH';
                    ToolTip = 'Specifies the value of the Committee Member Type field.';
                    ApplicationArea = All;

                }
                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Committee Member Type field.';
                    ApplicationArea = All;



                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ToolTip = 'Specifies the value of the Committee Member Type field.';
                    ApplicationArea = All;


                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    var
        CommitteeRec: Record "Tender Committees";

    local procedure GetHeader()
    begin
        if CommitteeRec.Get(Rec."Appointment No") then;
    end;
}





