page 53108 "Prospective Supplier Card"
{
    PageType = Card;
    SourceTable = "Prospective Suppliers";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender No. field';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field';
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Company PIN No"; Rec."Company PIN No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company PIN No. field';
                    ShowMandatory = true;
                }
                field("Supplier Types"; Rec."Supplier Types")
                {
                    Caption = 'Supplier Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Type field';
                }
                field("Organization Type"; Rec."Organization Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organization Type field';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field';
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No field';
                }
                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Code field';
                }
                group("Company Address")
                {
                    field("Physical Address"; Rec."Physical Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Physical Address field';
                        ShowMandatory = true;
                    }
                    field("E-mail"; Rec."E-mail")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the E-mail field';
                        ShowMandatory = true;
                    }
                    field("Telephone No"; Rec."Telephone No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone No field';
                    }
                    field("Mobile No"; Rec."Mobile No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No field';
                    }
                    field("Postal Address"; Rec."Postal Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Postal Address field';
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Post Code field';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the City field';
                    }
                }
                group("Contact Person")
                {
                    field(Title; Rec.Title)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Title field';
                    }
                    field("Contact Person Name"; Rec."Contact Person Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contact Person Name field';
                        ShowMandatory = true;
                    }
                    field("Job Title"; Rec."Job Title")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Job Title field';
                    }
                    field("Contact Phone No."; Rec."Contact Phone No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contact Phone No. field';
                        ShowMandatory = true;
                    }
                    field("Contact E-Mail Address"; Rec."Contact E-Mail Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contact E-Mail Address field';
                        ShowMandatory = true;
                    }
                }
                group("Bank Account Details")
                {
                    field("Bank Account Type"; Rec."Bank Account Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank Account Type field';
                        ShowMandatory = true;
                    }
                    field("KBA Bank Code"; Rec."KBA Bank Code")
                    {
                        Caption = 'Bank Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank Code field';
                        ShowMandatory = true;
                    }
                    field("KBA Branch Code"; Rec."KBA Branch Code")
                    {
                        Caption = 'Branch Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Branch Code field';
                        ShowMandatory = true;
                    }
                    field("Bank account No"; Rec."Bank account No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank account No field';
                        ShowMandatory = true;
                    }
                    field("Currency Code"; Rec."Currency Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Currency Code field';
                    }
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field';
                }
                field("Contract Period"; Rec."Contract Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Period field';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field';
                    Visible = false;
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fiscal Year field';
                }
                field("Supplier Status"; Rec."Supplier Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Status field';
                }
                field(Selected; Rec.Selected)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Selected field';
                    Visible = false;
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pre Qualified field';
                }
                field("Fax No"; Rec."Fax No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fax No field';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Name field';
                    Visible = false;
                }
                field("Registration No"; Rec."Registration No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registration No field';
                }
                field("PIN Certificate Expiry"; Rec."PIN Certificate Expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN Certificate Expiry field';
                }
                field("Tenders Applied"; Rec."Tenders Applied")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tenders Applied field';
                }
            }
            part(SupplierCategories; "Prospective Supplier Category")
            {
                Caption = 'Supplier Categories';
                SubPageLink = "Supplier Code" = field("No.");
                ApplicationArea = All;
            }
            part("Tenders"; "Prospective Supplier Tenders")
            {
                Caption = 'Tenders Applied';
                SubPageLink = "Prospect No." = field("No.");
                ApplicationArea = All;
                Editable = false;
            }
            part("Prospective Supplier Lines"; "Prospective Supplier Lines")
            {
                SubPageLink = "Response No" = field("No.");
                Visible = false;
                ApplicationArea = All;
            }
        }
        area(FactBoxes)
        {
            part(Attachments; "Document Attachment Factbox")
            {
                Caption = 'Portal Attachments';
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Caption = 'Attachments';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateVendor)
            {
                Caption = 'Create Vendor';
                Image = CreateDocument;
                Promoted = false;
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Vendor action';

                trigger OnAction()
                begin
                    Rec.CreateVendr(Rec);
                end;
            }
            action(Evaluate)
            {
                Caption = 'Send for Evaluation';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Send for Evaluation action';
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) then
                        ProcMgt.SendProspectiveSupplierForEvaluation(Rec);

                    CurrPage.Close();
                end;
            }
        }
    }

    var
        ProcMgt: Codeunit "Procurement Management";
}





