page 53073 "Supplier Selection"
{
    PageType = ListPart;
    SourceTable = "Supplier Selection";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supplier Category"; Rec."Supplier Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Category field';
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Code field';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field';
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the City field';
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field';
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field';
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                    Editable = false;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the County field';
                    Editable = false;
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Email field';
                }
                field(Invited; Rec.Invited)
                {
                    Caption = 'Invite';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Invite field';
                    Editable = false;
                }
                field(Notified; Rec.Notified)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notified field';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No. field.';
                    Enabled = false;
                }
                field("Applicant Stage"; Rec."Applicant Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applicant Stage field.';
                    Enabled = false;
                }
                field("Total Bid Sum"; Rec."Total Bid Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Bid Sum field.';
                }
                field("Applicant Comments"; ApplicantCommentsTxt)
                {
                    Caption = 'Applicant Comment';
                    Description = 'Applicant Comment';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Applicant Comment field';
                    ShowMandatory = true;
                    //MultiLine = true;
                    Enabled = false;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Applicant Comments");
                        Rec."Applicant Comments".CreateInStream(InStrm);
                        ApplicantCommentsBigTxt.Read(InStrm);

                        if ApplicantCommentsTxt <> Format(ApplicantCommentsBigTxt) then begin
                            Clear(Rec."Applicant Comments");
                            Clear(ApplicantCommentsBigTxt);
                            ApplicantCommentsBigTxt.AddText(ApplicantCommentsTxt);
                            Rec."Applicant Comments".CreateOutStream(OutStrm);
                            ApplicantCommentsBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process Type field.';
                    Enabled = false;
                }
                field("Date Submitted"; Rec."Date Submitted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Submitted field.';
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(BidPrices)
            {
                Caption = 'Bid Prices';
                ApplicationArea = All;
                RunObject = page "Supplier Price Lines";
                RunPageLink = "Quote No" = field("Reference No."), "Vendor No" = field("Supplier Code");
                Image = Price;
            }
            action(InviteSuppliers)
            {
                Caption = 'Invite Suppliers By Category';
                ApplicationArea = All;
                Image = SuggestCustomerPayments;

                trigger OnAction()
                begin
                    Rec.InviteSuppliersByCategory();
                end;
            }
            action(PreliminaryItems)
            {
                Caption = 'Preliminary Items';
                ApplicationArea = All;
                RunObject = page "Tender Applicant Evaluation";
                RunPageLink = "Tender No." = field("Reference No."), "Supplier Code" = field("Supplier Code");
                Image = Price;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Invited := true;
    end;

    var
        ApplicantCommentsBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        ApplicantCommentsTxt: Text;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        TenderRec: Record "Procurement Request";
    begin
        Rec.CalcFields("Applicant Comments");
        Rec."Applicant Comments".CreateInStream(InStrm);
        ApplicantCommentsBigTxt.Read(InStrm);
        ApplicantCommentsTxt := Format(ApplicantCommentsBigTxt);
    end;
}





