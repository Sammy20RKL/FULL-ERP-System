page 53146 "Tender Applicants"
{
    Caption = 'Tender Applicants';
    PageType = ListPart;
    SourceTable = "Tender Applicant";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Supplier Category"; Rec."Supplier Category")
                {
                    ToolTip = 'Specifies the value of the Supplier Category field.';
                    ApplicationArea = All;
                    Visible = CategoryVisible;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ToolTip = 'Specifies the value of the Supplier Code field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                    ApplicationArea = All;
                }
                field("Supplier Email"; Rec."Supplier Email")
                {
                    ToolTip = 'Specifies the value of the Supplier Email field.';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                    ApplicationArea = All;
                }
                field("Tender Applicant Stage"; Rec."Tender Applicant Stage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Applicant Stage field.';
                    Enabled = false;
                }
                field("Total Bid Sum"; Rec."Total Bid Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Bid Sum field.';
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    Enabled = false;
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
            action("Tender Opening Records")
            {
                Caption = 'Tender Opening Records';
                ApplicationArea = All;
                RunObject = page "Tender Opening List";
                RunPageLink = "Tender No." = field("Tender No."), "Supplier No." = field("Supplier Code");
                RunPageMode = View;
                Image = Archive;
            }
            action(BidPrices)
            {
                Caption = 'Bid Prices';
                ApplicationArea = All;
                RunObject = page "Supplier Price Lines";
                RunPageLink = "Quote No" = field("Tender No."), "Vendor No" = field("Supplier Code");
                Image = Price;
            }
            action(PreliminaryItems)
            {
                Caption = 'Preliminary Items';
                ApplicationArea = All;
                RunObject = page "Tender Applicant Evaluation";
                RunPageLink = "Tender No." = field("Tender No."), "Supplier Code" = field("Supplier Code");
                Image = Price;
            }
            action(Categories)
            {
                Caption = 'Prequalified Categories';
                ApplicationArea = All;
                RunObject = page "Tender Applicant Categories";
                RunPageLink = "Tender No." = field("Tender No."), "Supplier Code" = field("Supplier Code");
                Image = Category;
                Visible = SupplierPrequalification;
            }
        }
    }

    var
        CategoryVisible: Boolean;
        SupplierPrequalification: Boolean;

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
        if TenderRec.Get(Rec."Tender No.") then;

        case TenderRec."Process Type" of
            TenderRec."Process Type"::"Supplier Prequalification":
                begin
                    CategoryVisible := false;
                    SupplierPrequalification := true;
                end;
            else begin
                CategoryVisible := true;
                SupplierPrequalification := false;
            end;
        end;

        Rec.CalcFields("Applicant Comments");
        Rec."Applicant Comments".CreateInStream(InStrm);
        ApplicantCommentsBigTxt.Read(InStrm);
        ApplicantCommentsTxt := Format(ApplicantCommentsBigTxt);
    end;

    var
        ApplicantCommentsBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        ApplicantCommentsTxt: Text;
}






