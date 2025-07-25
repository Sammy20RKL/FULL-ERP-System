page 53153 "Procurement Contract"
{
    Caption = 'Procurement Contract';
    PageType = Card;
    SourceTable = "Procurement Contract";
    PromotedActionCategories = 'New,Process,Report,Attachments,Generate Invoices';

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Contract Status" = Rec."Contract Status"::New;
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Contract Ref No."; Rec."Contract Ref No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Ref No. field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                }
                field("Contract Details"; ContractDetailsTxt)
                {
                    Caption = 'Contract Details';
                    Description = 'Contract Details';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specification field';
                    ShowMandatory = true;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Contract Details");
                        Rec."Contract Details".CreateInStream(InStrm);
                        ContractDetailsBigTxt.Read(InStrm);

                        if ContractDetailsTxt <> Format(ContractDetailsBigTxt) then begin
                            Clear(Rec."Contract Details");
                            Clear(ContractDetailsBigTxt);
                            ContractDetailsBigTxt.AddText(ContractDetailsTxt);
                            Rec."Contract Details".CreateOutStream(OutStrm);
                            ContractDetailsBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field("Tender/Quote No."; Rec."Tender/Quote No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Quote No. field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Total Contract Amount"; Rec."Total Contract Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("Service Required?"; Rec."Service Required?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Required? field.';
                }
                field("Proposed Action"; Rec."Proposed Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposed Action field.';
                }
            }
            part(Control7; "Procurement Evaluation Lines")
            {
                Caption = 'Awarded Items';
                Editable = false;
                SubPageLink = "Document No." = field("Tender/Quote No."), Awarded = const(true), "Vendor No" = field("Prospective Supplier No.");
                ApplicationArea = All;
            }
            part(ContractLines; "Procurement Contract Lines")
            {
                Caption = 'Contract Milestones';
                SubPageLink = "Contract No." = field("Contract No.");
                UpdatePropagation = Both;
                ApplicationArea=All;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(52146740),
                              "No." = FIELD("Contract No.");
            }
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
            action(Activate)
            {
                ApplicationArea = All;
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Activate Contract';
                Enabled = Rec."Contract Status" = Rec."Contract Status"::New;
                trigger OnAction()
                begin
                    Rec."Contract Status" := Rec."Contract Status"::Active;
                    Rec.Modify();
                end;
            }
            action(Terminate)
            {
                ApplicationArea = All;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Terminate Contract';
                Enabled = Rec."Contract Status" = Rec."Contract Status"::Active;
                trigger OnAction()
                begin
                    Rec."Contract Status" := Rec."Contract Status"::Terminated;
                    Rec.Modify();
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Reopen Contract';
                Enabled = Rec."Contract Status" = Rec."Contract Status"::Active;
                trigger OnAction()
                begin
                    Rec."Contract Status" := Rec."Contract Status"::New;
                    Rec.Modify();
                end;
            }
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            action("Generate Invoices")
            {
                ApplicationArea = All;
                Caption = 'Generate Selected Invoices';
                Image = PurchaseInvoice;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Generate Selected Invoices';
                Enabled = Rec."Contract Status" = Rec."Contract Status"::Active;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Generate the selected invoice(s)?') then
                        ProcurementManagement.GeneratePurchaseInvoiceFromContract(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Contract Details");
        Rec."Contract Details".CreateInStream(InStrm);
        ContractDetailsBigTxt.Read(InStrm);
        ContractDetailsTxt := Format(ContractDetailsBigTxt);
    end;

    var
        ContractDetailsTxt: Text;
        ContractDetailsBigTxt: BigText;
        InStrm: InStream;
        OutStrm: OutStream;
        ProcurementManagement: Codeunit "Procurement Management";
}






