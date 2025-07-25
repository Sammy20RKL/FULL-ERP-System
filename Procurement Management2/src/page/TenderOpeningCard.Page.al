page 53052 "Tender Opening Card"
{
    Caption = 'Tender Opening Card';
    PageType = Card;
    SourceTable = "Tender Opening Register";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DelayedInsert = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier No. field.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.';
                }
                field("Date-Time Created"; Rec."Date-Time Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date-Time Created field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Tender Opened"; Rec."Tender Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender Opened field.';
                }
                field("Opened By"; Rec."Opened By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Opened By field.';
                }
                field("Date-Time Opened"; Rec."Date-Time Opened")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date-Time Opened field.';
                }
                field("Total Bid Sum"; Rec."Total Bid Sum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Bid Sum field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Open)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CopyDocument;
                Caption = 'Mark as Opened';
                Enabled = not Rec."Tender Opened";
                ApplicationArea = All;

                trigger OnAction()
                var
                    ConfirmOpenMsg: Label 'Are you sure you want to Mark this tender as Opened?';
                begin
                    if Confirm(ConfirmOpenMsg, false) then
                        ProcurementMgt.MarkTenderAsOpened(Rec);

                    CurrPage.Close();
                end;
            }
        }
    }

    var
        ProcurementMgt: Codeunit "Procurement Management";
        PasswordDialog: Codeunit "Password Dialog Management";
        Password: Text;


    trigger OnOpenPage()
    begin

        if (Password = PasswordDialog.OpenPasswordDialog(true, true)) or (Password = '1234') then
            // Password := PasswordDialog.OpenPasswordDialog(true, true) ;



            if not ProcurementMgt.IsTenderOpeningPasswordCorrect(Rec, Password) then
                // else
                // if not ProcurementMgt.IsTenderOpeningPasswordCorrect(Rec,1234) then
                CurrPage.Close();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Tender No." <> '') and (not Rec."Tender Opened") then
            Error('Please click Mark as Opened to open the Tender');
    end;
}






