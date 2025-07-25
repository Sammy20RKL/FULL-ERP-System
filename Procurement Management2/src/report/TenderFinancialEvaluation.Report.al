report 53037 "Tender Financial Evaluation"
{
    Caption = 'Tender Financial Evaluation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TenderFinancialEvaluation.rdl';
    dataset
    {
        dataitem(TenderEvaluationHeader; "Procurement Evaluation Header")
        {
            column(QuoteNo; "No.")
            {
            }
            column(RefNo; "Ref No.")
            {
            }
            column(Title; Title)
            {
            }
            column(RequisitionNo; "Requisition No")
            {
            }
            column(CreationDate; "Creation Date")
            {
            }
            column(CalculationType; "Calculation Type")
            {
            }
            column(EvaluationCriteria; "Evaluation Criteria")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            /* column(PreparedBy; "Prepared By")
            {
            } */
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
            column(RemarksTxt; RemarksTxt)
            {
            }
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(PreparedByTitle; Designation[1])
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(ExaminedByTitle; Designation[2])
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(VBCTitle; Designation[3])
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(AuthorizedTitle; Designation[4])
            {
            }
            column(ResponsibilityCentre; "Responsibility Centre")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }

            dataitem(TenderEvaluationLine; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.");

                column(VendorNo_TenderEvaluationLine; "Vendor No")
                {
                }
                column(VendorName_TenderEvaluationLine; "Vendor Name")
                {
                }
                column(Type_TenderEvaluationLine; "Type")
                {
                }
                column(No_TenderEvaluationLine; "No.")
                {
                }
                column(Description_TenderEvaluationLine; Description)
                {
                }
                column(LineNo_TenderEvaluationLine; "Line No")
                {
                }
                column(QuoteNo_TenderEvaluationLine; "Document No.")
                {
                }
                column(Quantity_TenderEvaluationLine; Quantity)
                {
                }
                column(UnitofMeasure_TenderEvaluationLine; "Unit of Measure")
                {
                }
                column(UnitAmount_TenderEvaluationLine; "Unit Amount")
                {
                }
                column(Amount_TenderEvaluationLine; Amount)
                {
                }
                column(AmountInclusiveVAT_TenderEvaluationLine; "Amount Inclusive VAT")
                {
                }
                column(NegotiatedUnitAmount_TenderEvaluationLine; "Negotiated Unit Amount")
                {
                }
                column(VATAmount_TenderEvaluationLine; "VAT Amount")
                {
                }
                column(VATAmountLCY_TenderEvaluationLine; "VAT Amount (LCY)")
                {
                }
                column(FinancialScore_TenderEvaluationLine; "Financial Score")
                {
                }
                column(Awarded_TenderEvaluationLine; Awarded)
                {
                }
                /* column(Suggested_TenderEvaluationLine; Suggested)
                {
                } */

                //Changed field to Awarded for highlighting in case user overides system's suggestion
                column(Suggested_TenderEvaluationLine; Awarded)
                {
                }
                column(Specifications; SpecificationsTxt)
                {
                }
                column(TotalAmountPerVendor; "Total Amount Per Vendor")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields(Specification);
                    Specification.CreateInStream(Inst);
                    SpecificationsBigTxt.Read(Inst);
                    SpecificationsTxt := Format(SpecificationsBigTxt);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Remarks);
                Remarks.CreateInStream(Inst);
                RemarksBigTxt.Read(Inst);
                RemarksTxt := Format(RemarksBigTxt);
                Clear(Approver);
                Clear(ApproverDate);

                //Get sender ID even before approval sent
                Approver[1] := ProcurementMgt.GetUserIDFromSystemGuid(SystemCreatedBy);
                ApproverDate[1] := SystemCreatedAt;
                if UserSetup.Get(Approver[1]) then begin
                    UserSetup.CalcFields(Signature);
                    Designation[1] := GetJobTitle(Approver[1]);
                end;

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::"Procurement Evaluation Header");
                ApprovalEntries.SetRange("Document Type", ApprovalEntries."Document Type"::"Procurement Evaluation");
                ApprovalEntries.SetRange("Document No.", "No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.FindSet() then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            Designation[2] := GetJobTitle(Approver[2]);
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            Designation[3] := GetJobTitle(Approver[3]);
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            Designation[4] := GetJobTitle(Approver[4]);
                            if UserSetup3.Get(Approver[4]) then
                                UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next() = 0;
                end;
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
        SpecificationsBigTxt, RemarksBigTxt : BigText;
        SpecificationsTxt, RemarksTxt : Text;
        Inst: InStream;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        Designation: array[10] of Text;
        ApprovalEntries: Record "Approval Entry";
        ProcurementMgt: Codeunit "Procurement Management";
        Employee: Record Employee;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        Users.Reset();
        Users.setrange("User Name", UserCode);
        if Users.FindFirst() THEN
            exit(Users."Full Name")
        else
            exit(UserCode);
    end;

    local procedure GetJobTitle(UserCode: Code[50]): Text
    var
        Employee: Record Employee;
    begin
        Employee.SetRange("User ID", UserCode);
        if Employee.FindFirst() then begin
            exit(Employee."Job Title");
        end else
            exit('');
    end;

}






