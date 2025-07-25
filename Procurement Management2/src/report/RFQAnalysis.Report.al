report 53019 "RFQ Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/RFQAnalysis.rdl';

    dataset
    {
        dataitem("Quote Evaluation Header"; "Procurement Evaluation Header")
        {
            RequestFilterFields = "No.";
            CalcFields = "Least Amount";

            column(QuoteNo_QuoteEvaluationHeader; "Quote Evaluation Header"."No.")
            {
            }
            column(Title_QuoteEvaluationHeader; "Quote Evaluation Header".Title)
            {
            }
            column(RequisitionNo_QuoteEvaluationHeader; "Quote Evaluation Header"."Requisition No")
            {
            }
            column(QuoteGenerated_QuoteEvaluationHeader; "Quote Evaluation Header"."LPO/Contract Generated")
            {
            }
            column(Minutes_QuoteEvaluationHeader; "Quote Evaluation Header".Minutes)
            {
            }
            column(AwardingCommittee_QuoteEvaluationHeader; "Quote Evaluation Header"."Awarding Committee")
            {
            }
            column(DateofAward_QuoteEvaluationHeader; "Quote Evaluation Header"."Date of Award")
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
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
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(AwardComment; CommentsTxt)
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
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
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
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            column(TotalSuppliers; TotalSuppliers)
            {
            }
            column(SupplierCount; SupplierCount)
            {
            }
            column(LeastVendorName; LeastVendorName)
            {
            }
            column(LeastAmount; LeastAmount)
            {
            }
            column(ProfileTxt; ProfileTxt)
            {
            }
            dataitem("Quote Evaluation"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Unit Amount" = filter(> 0), Amount = filter(> 0));

                column(QuoteNo_QuoteEvaluation; "Quote Evaluation"."Document No.")
                {
                }
                column(VendorNo_QuoteEvaluation; "Quote Evaluation"."Vendor No")
                {
                }
                column(Type_QuoteEvaluation; "Quote Evaluation".Type)
                {
                }
                column(No_QuoteEvaluation; "Quote Evaluation"."No.")
                {
                }
                column(Description_QuoteEvaluation; "Quote Evaluation".Description)
                {
                }
                column(Quantity_QuoteEvaluation; "Quote Evaluation".Quantity)
                {
                }
                column(UnitAmount_QuoteEvaluation; "Quote Evaluation"."Unit Amount")
                {
                }
                column(Amount_QuoteEvaluation; "Quote Evaluation".Amount)
                {
                }
                column(Awarded_QuoteEvaluation; "Quote Evaluation".Awarded)
                {
                }
                column(UnitofMeasure_QuoteEvaluation; "Quote Evaluation"."Unit of Measure")
                {
                }
                column(LineNo_QuoteEvaluation; "Quote Evaluation"."Line No")
                {
                }
                column(QuoteGenerated_QuoteEvaluation; "Quote Evaluation"."Quote Generated")
                {
                }
                column(VendorName_QuoteEvaluation; "Quote Evaluation"."Vendor Name")
                {
                }
                column(Title_QuoteEvaluation; "Quote Evaluation".Title)
                {
                }
                column(ShortcutDimension1Code_QuoteEvaluation; "Quote Evaluation"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_QuoteEvaluation; "Quote Evaluation"."Shortcut Dimension 2 Code")
                {
                }
                column(DimensionSetID_QuoteEvaluation; "Quote Evaluation"."Dimension Set ID")
                {
                }
                column(Committed_QuoteEvaluation; "Quote Evaluation".Committed)
                {
                }
                column(QuantityReceived_QuoteEvaluation; "Quote Evaluation"."Quantity Received")
                {
                }
                column(ProcurementPlan_QuoteEvaluation; "Quote Evaluation"."Procurement Plan")
                {
                }
                column(ProcurementPlanItem_QuoteEvaluation; "Quote Evaluation"."Procurement Plan Item")
                {
                }
                column(BudgetLine_QuoteEvaluation; "Quote Evaluation"."Budget Line")
                {
                }
                column(RequestDate_QuoteEvaluation; "Quote Evaluation"."Request Date")
                {
                }
                column(ExpectedReceiptDate_QuoteEvaluation; "Quote Evaluation"."Expected Receipt Date")
                {
                }
                column(Suggested_QuoteEvaluation; "Quote Evaluation".Suggested)
                {
                }
                column(AmountInclusiveVAT_QuoteEvaluation; "Quote Evaluation"."Amount Inclusive VAT")
                {
                }
                column(Comments; Comments)
                {
                }

                trigger OnPreDataItem()
                begin
                    SupplierCount := Count; //responded suppliers
                end;

                trigger OnAfterGetRecord()
                begin
                    if "Quote Evaluation"."Unit Amount" = 0 then
                        CurrReport.Skip();

                    LeastAmount := "Quote Evaluation Header"."Least Amount";

                    /*  QuoteLines.Reset();
                     QuoteLines.SetRange(QuoteLines."Quote No", "Quote Evaluation"."Quote No");
                     QuoteLines.SetFilter(QuoteLines.Amount, '>%1', 0);
                     QuoteLines.SetRange(Amount, LeastAmount);
                     if QuoteLines.FindSet() then begin
                         repeat
                             LeastVendorName := LeastVendorName + ' ' + QuoteLines."Vendor Name";
                             QuoteLines.Suggested := true;
                             QuoteLines.Modify();
                         until QuoteLines.Next() = 0;
                     end; */

                    /* LeastAmount := 0;

                    QuoteLines.Reset();
                    QuoteLines.SetRange(QuoteLines."Quote No", "Quote Evaluation"."Quote No");
                    QuoteLines.SetRange(QuoteLines.Type, "Quote Evaluation".Type);
                    QuoteLines.SetRange(QuoteLines."No.", "Quote Evaluation"."No.");
                    QuoteLines.SetFilter(QuoteLines.Amount, '>%1', 0);
                    if QuoteLines.Find('-') then begin
                        repeat
                            LeastAmount := QuoteLines.GetRangeMin(Amount);

                            QuoteLines2.Reset();
                            QuoteLines2.SetRange("Quote No", QuoteLines."Quote No");
                            QuoteLines2.SetRange(Type, QuoteLines.Type);
                            QuoteLines2.SetRange("No.", QuoteLines."No.");
                            QuoteLines2.SetRange(Amount, LeastAmount);
                            if QuoteLines2.FindFirst() then begin
                                QuoteLines.Suggested := true;
                                QuoteLines.Modify();
                            end;
                        until QuoteLines.Next() = 0;
                    end; */
                end;
            }

            trigger OnAfterGetRecord()
            begin
                QuoteEvalHeader.Copy("Quote Evaluation Header");
                QuoteLines.Reset();
                QuoteLines.SetRange("Document No.", QuoteEvalHeader."No.");
                TotalSuppliers := QuoteLines.Count;

                CalcFields(Comments);
                Comments.CreateInStream(InStrm);
                CommentsBigTxt.Read(InStrm);
                CommentsTxt := Format(CommentsBigTxt);

                CalcFields("Background Profile");
                "Background Profile".CreateInStream(InStrm);
                ProfileBigTxt.Read(InStrm);
                ProfileTxt := Format(ProfileBigTxt);

                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID", Database::"Procurement Evaluation Header");
                ApprovalEntries.SetRange("Document No.", "No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[1] := ApprovalEntries."Sender ID";
                            ApproverDate[1] := ApprovalEntries."Date-Time Sent for Approval";
                            if UserSetup.Get(Approver[1]) then
                                UserSetup.CalcFields(Signature);
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 3 then begin
                            Approver[4] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup3.Get(Approver[4]) then
                                UserSetup3.CalcFields(Signature);
                        end;
                    until ApprovalEntries.Next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        QuoteLines: Record "Procurement Evaluation Line";
        QuoteEvalHeader: Record "Procurement Evaluation Header";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        CommentsBigTxt: BigText;
        ProfileBigTxt: BigText;
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        LeastAmount: Decimal;
        InStrm: InStream;
        SupplierCount: Integer;
        TotalSuppliers: Integer;
        CommentsTxt: Text;
        LeastVendorName: Text;
        ProfileTxt: Text;

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;
}





