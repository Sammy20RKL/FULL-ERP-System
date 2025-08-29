page 52929 "Board Member Appl."
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Employee Temp. Board";
    layout
    {

        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin

                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = FALSE;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                    Visible = FALSE;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                    Visible = FALSE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field';
                    Visible = FALSE;
                }
                field("BOSA Member No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the BOSA Member No. field.';
                    Visible = FALSE;
                }
                field("FOSA Account No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the FOSA Account No. field.';
                    Visible = FALSE;
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field';

                    trigger OnValidate()
                    begin

                        if Rec.Disabled = Rec.Disabled::No then
                            DisabilityView := false
                        else
                            DisabilityView := true;
                    end;
                }
                group(Control197)
                {
                    ShowCaption = false;
                    Visible = DisabilityView;

                    field("Disability Certificate"; Rec."Disability Certificate")
                    {
                        Caption = 'Disability Certificate No.';
                        ToolTip = 'Specifies the value of the Disability Certificate No. field';
                    }
                }
                field("Date of Birth"; Rec."Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Standard;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Date of Birth - Age"; Rec."Date of Birth - Age")
                {
                    Caption = ' Age';
                    Importance = Standard;
                    ToolTip = 'Specifies the value of the  Age field';
                }
                field("ID No."; Rec."ID No.")
                {
                    ToolTip = 'Specifies the value of the ID No. field';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ToolTip = 'Specifies the value of the Marital Status field';
                }
                field(Religion; Rec.Religion)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Religion field';
                }
                field("Ethnic Origin"; Rec."Ethnic Origin")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ethnic Origin field';
                }
                field("Ethnic Community"; Rec."Ethnic Community")
                {
                    Caption = 'Ethnic Code';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ethnic Code field';
                }
                field("Ethnic Name"; Rec."Ethnic Name")
                {
                    Visible = false;
                    Caption = 'Ethnic Community';
                    ToolTip = 'Specifies the value of the Ethnic Community field';
                }
                field("Home District"; Rec."Home District")
                {
                    ToolTip = 'Specifies the value of the Home District field';
                    Caption = 'Country of Origin';
                }
                field("First Language"; Rec."First Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the First Language field';
                }
                field("Second Language"; Rec."Second Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Second Language field';
                }
                field("Other Language"; Rec."Other Language")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Other Language field';
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';

                group(Control13)
                {
                    ShowCaption = false;

                    field(Address; Rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;

                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = true;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            //  Rec.DisplayMap();
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;

                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; Rec.Pager)
                    {
                        ToolTip = 'Specifies the employee''s pager number.';
                        Visible = FALSE;
                    }
                    field(Extension; Rec.Extension)
                    {
                        Visible = FALSE;
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                        Visible = FALSE;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = ' Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; Rec."Alt. Address Code")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field("Alt. Address End Date"; Rec."Alt. Address End Date")
                    {
                        Visible = FALSE;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group("Employment Information")
            {
                Caption = 'Board Member Information';

                field("Job Position"; Rec."Job Position")
                {
                    ToolTip = 'Specifies the value of the Job Position field';
                    Caption = 'Board Position';
                }
                field("Job Title"; Rec."Job Title")
                {
                    Editable = false;
                    Caption = 'Board Title';
                    ToolTip = 'Specifies the value of the Job Title field';
                }
                field("Period"; Rec."Contract Length")
                {
                    ToolTip = 'Specifies the value of the Contract Length field';
                }
                field("Start_Date"; Rec."Contract Start Date")
                {
                    ToolTip = 'Specifies the value of the Contract Start Date field';
                }
                field("End_Date"; Rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field';
                }
                field("Employment Type"; Rec."Employment Type")
                {
                    Caption = 'Employment Type';
                    ToolTip = 'Specifies the value of the Employment Type field';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        SetContractView();
                        ContractFields();
                    end;
                }
                group("Contract Information")
                {
                    Caption = 'Contract Information';
                    Editable = false;
                    Visible = Rec."Employment Type" = Rec."Employment Type"::Contract;

                    field("Contract Type"; Rec."Contract Type")
                    {
                        ToolTip = 'Specifies the value of the Contract Type field';
                    }
                    field("Contract Number"; Rec."Contract Number")
                    {
                        ToolTip = 'Specifies the value of the Contract Number field';
                    }
                    field("Contract Length"; Rec."Contract Length")
                    {
                        ToolTip = 'Specifies the value of the Contract Length field';
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ToolTip = 'Specifies the value of the Contract Start Date field';
                    }
                    field("Contract End Date"; Rec."Contract End Date")
                    {
                        ToolTip = 'Specifies the value of the Contract End Date field';
                    }
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ToolTip = 'Specifies the value of the Employment Date field';
                    Visible = false;
                }
            }

            group(Payments)
            {
                Caption = 'Payments';



                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                    Visible = false;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                    Visible = false;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                    Visible = FALSE;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    Visible = FALSE;
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }



            }
            group("Important Dates")
            {
                Caption = 'Important Dates';
                Visible = false;
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field';

                    trigger OnValidate()
                    begin

                        //"End Of Probation Date":= CALCDATE(HRSetup."Probation Period","Date Of Join");
                    end;
                }
                field("Probation Period"; ProbationPeriod)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the ProbationPeriod field';
                }
                field("End Of Probation Date"; Rec."End Of Probation Date")
                {
                    Caption = 'Probation End Date';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Probation End Date field';
                }

            }
            group(Separation)
            {
                Caption = 'Separation';
                Visible = false;
                field("Notice Period"; Rec."Notice Period")
                {
                    ToolTip = 'Specifies the value of the Notice Period field';
                }

                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ToolTip = 'Specifies the value of the Grounds for Term. Code field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }

            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(5200),
                              "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Create)
            {

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Addmit Board Member account?', false) = true then begin
                        ObjMemberNoseries.Get();
                        if ObjMemberNoseries.FindSet then begin
                            VarNewMembNo := ObjMemberNoseries."Trustee Nos";
                        end;

                        EmployeeRec."No." := Rec."No.";
                        EmployeeRec."First Name" := Rec."First Name";
                        EmployeeRec."Middle Name" := Rec."Middle Name";
                        EmployeeRec."Last Name" := Rec."Last Name";
                        EmployeeRec.Name := Rec.Name;

                        EmployeeRec.Insert(true);


                    end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ContractView := false;
        DisabilityView := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        Employee: Record Employee;
        EmployeeTemplMgt: Codeunit "Employee Templ. Mgt.";
    begin
        if not NewMode then
            exit;
        NewMode := false;

        if EmployeeTemplMgt.InsertEmployeeFromTemplate(Employee) then begin
            //Copy(Employee);
            CurrPage.Update();
        end else
            if EmployeeTemplMgt.TemplatesAreNotEmpty() then
                CurrPage.Close();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
        Rec."Secondary Employee" := true;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Employee Type" := Rec."Employee Type"::"Board Member";
        Rec."Employment Type" := Rec."Employment Type"::Trustee;
        Rec."Secondary Employee" := true;

    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");

        SetContractView();
        DisabilityView := false;

    end;

    var

        VarNewMembNo: Code[300];
        ObjMemberNoseries: Record "Human Resources Setup";
        NewMode: Boolean;

        Banks: Record Banks;
        EmployeeRec: Record Employee;
        EmployeeChange: Record "Employee Change Request";
        PayPeriod: Record "Payroll Period Trustees";
        FormatAddress: Codeunit "Format Address";
        HRMgt: Codeunit "HR Management";
        Payroll: Codeunit Payroll;
        EmployeeXML: XMLport "Employee Change";
        ProbationPeriod: DateFormula;
        ContractView: Boolean;
        DisabilityView: Boolean;
        IsCountyVisible: Boolean;
        NoFieldVisible: Boolean;
        Numb: Code[20];
        CurrentMonth: Date;
        ShowMapLbl: Label 'Show on Map';
        Text0001: Label 'Do you want to send the payslip?';
        BankName: Text;

    local procedure ContractFields()
    begin
        /*//"Contract Type":='';
        "Contract Number":=0;
        "Contract Start Date":=0D;
        "Contract End Date":=0D;
        "Send Alert to":='';
        Modify();
        */

    end;

    local procedure Disability()
    begin
        if Rec."No." <> '' then
            if Rec.Disabled = Rec.Disabled::No then
                DisabilityView := false
            else
                DisabilityView := true;
    end;

    local procedure DisabilityField()
    begin

    end;

    local procedure GetCurrentPayPeriod(): Date
    begin
        PayPeriod.Reset();
        PayPeriod.SetRange(Closed, false);
        if PayPeriod.FindFirst() then
            exit(PayPeriod."Starting Date");
    end;

    local procedure SetContractView()
    begin

    end;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}





