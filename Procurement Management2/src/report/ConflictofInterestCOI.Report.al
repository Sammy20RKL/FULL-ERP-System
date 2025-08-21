report 50005 "Conflict of Interest(COI)"
{
    Caption = 'Conflict of Interest(COI)';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/COI.rdl';
    dataset
    {
        dataitem(TenderCommittees; "Tender Committees")
        {
            column(Creation_Date; "Creation Date")
            { }
            column(Committee_Name; "Committee Name")
            { }
            column(Appointment_No; "Appointment No")
            { }
            column(DeclarationLabel; DeclarationLabel)
            { }
            column(CertifyLabel; CertifyLabel)
            { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo_FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem("Committee Member"; "Committee Member")
            {
                DataItemLink = "Appointment No" = field("Appointment No");
                column(Member_Name; Name)
                { }
                column(Committee_Member_No; "Committee Member No")
                { }
                column(Role; Role)
                { }
                column(commitee_member_signature; UserSetup.Signature)
                {

                }
                //  trigger OnAfterGetRecord()
                // begin
                //     if UserSetup.Get("Committee Member No") then begin
                //         UserSetup.CalcFields(Signature);
                //     end;
                // end;
            }
            dataitem("Prospective Suppliers"; "Prospective Suppliers")
            {
                DataItemLink = "Tender No." = field("Tender/Quotation No");
                column(Supplier_Name; Name)
                { }

            }
            dataitem("Procurement Evaluation Line"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("Tender/Quotation No");
                column(Vendor_Name; "Vendor Name")
                { }
                column(Vendor_No; "Vendor No")
                { }
                column(Amount; Amount)
                { }
            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

        // Counter := 0;
    end;


    var
        CompanyInfo: Record "Company Information";
        DeclarationLabel: Label 'By signing this document, I confirm that I have NO Conflict Of Interest with a person, firm, corporation of other business that is competing for the above contract/(s) with Coalition for Humanity (CH). I have not participated, directly or indirectly, by committee or as an advisor, consultant, employee, agent, trustee, or otherwise, in the development of a proposal for any individual or business entity that is competing for the above contract(s).';
        CertifyLabel: Label 'I certify that I have read, have understood, and agree to be bound by the Coalition for Humanity (CH) policies on procurement conflicts of interest';
        CommitteeMember: Record "Committee Member";
        UserSetup: Record "User Setup";
        Employee: Record "Employee";
}
