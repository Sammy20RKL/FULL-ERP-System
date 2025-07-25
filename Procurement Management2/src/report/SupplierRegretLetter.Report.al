report 53013 "Supplier Regret Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/SupplierRegretLetterUNSacco.rdl';

    dataset
    {
        dataitem(TenderEvaluationHeader; "Procurement Evaluation Header")
        {
            column(QuoteNo; "No.")
            {
            }
            column(AwardingCommittee; "Awarding Committee")
            {
            }
            column(RequisitionNo; "Requisition No")
            {
            }
            column(Title; Title)
            {
            }
            column(DateofAward; "Date of Award")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(Ref_No_; "Ref No.")
            {
            }
            column(ContactJobPosition; "Contact Job Position")
            {
            }
            column(ContactJobPositionTitle; "Contact Job Position Title")
            {
            }
            column(ContractDate; "Contract Date")
            {
            }
            column(PaymentTerms; "Payment Terms")
            {
            }
            column(SignOffEmployee; "Sign-Off Employee")
            {
            }
            column(SignOffEmployeeName; "Sign-Off Employee Name")
            {
            }
            column(SignOffEmployeeTitle; "Sign-Off Employee Title")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            dataitem("Tender Evaluation Line"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Awarded = const(false));

                column(Vendor_No; "Vendor No")
                {
                }
                column(Vendor_Name; "Vendor Name")
                {
                }
                column(ContPersonTitle; Prospective.Title)
                {
                }
                column(ContPersonName; Prospective."Contact Person Name")
                {
                }
                column(ContPersonJobTitle; Prospective."Job Title")
                {
                }
                column(ContPersonPhysicalAddress; Prospective."Physical Address")
                {
                }
                column(ContPersonAddress; Prospective."Postal Address")
                {
                }
                column(ContPersonCity; Prospective.City)
                {
                }
                column(ContPersonCountry; Prospective."Country/Region Code")
                {
                }
                column(ContPersonPhone; Prospective."Contact Phone No.")
                {
                }
                column(Awarded_TenderEvaluationLine; Awarded)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Prospective.Get("Vendor No");
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Prospective: Record "Prospective Suppliers";
}





