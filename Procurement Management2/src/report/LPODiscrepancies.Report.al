report 53044 "LPO Discrepancies"
{
    ApplicationArea = All;
    Caption = 'LPO Discrepancies';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/LPODiscrepancies.rdl';
    dataset
    {
        dataitem(PurchaseLine; "Purchase Line")
        {
            column(DocumentType; "Document Type")
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(Type; "Type")
            {
            }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(QuantityReceived; "Quantity Received")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompanyCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(SpecificationsTxt; SpecificationsTxt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Specification);
                Specification.CreateInStream(Instr);
                SpecificationsBigTxt.Read(Instr);
                SpecificationsTxt := Format(SpecificationsBigTxt);
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        SpecificationsBigTxt: BigText;
        SpecificationsTxt: Text;
}






