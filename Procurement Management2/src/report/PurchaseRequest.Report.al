report 53018 "Purchase Request"
{
    DefaultLayout = RDLC;
    // RDLCLayout = './src/report_layout/PurchaseRequestAlternate.rdl';
    RDLCLayout = './src/report_layout/PurchaseRequestAlternatenew.rdl';

    dataset
    {
        dataitem("Internal Request Header"; "Internal Request Header")
        {
            column(No_InternalRequestHeader; "Internal Request Header"."No.")
            {
            }
            column(ReasonDescription_InternalRequestHeader; "Internal Request Header"."Item Description")
            {
            }
            column(DocumentDate_InternalRequestHeader; "Internal Request Header"."Document Date")
            {
            }
            column(ExpectedReceiptDate_InternalRequestHeader; "Internal Request Header"."Expected Receipt Date")
            {
            }
            column(LocationCode_InternalRequestHeader; "Internal Request Header"."Location Code")
            {
            }
            column(PostingDate_InternalRequestHeader; "Internal Request Header"."Posting Date")
            {
            }
            column(CollectedBy_InternalRequestHeader; "Internal Request Header"."Collected By")
            {
            }
            column(RequestedBy_InternalRequestHeader; "Internal Request Header"."Requested By")
            {
            }
            column(PostedBy_InternalRequestHeader; "Internal Request Header"."Posted By")
            {
            }
            column(OrderDate_InternalRequestHeader; "Internal Request Header"."Order Date")
            {
            }
            column(ProcurementPlan_InternalRequestHeader; "Internal Request Header"."Procurement Plan")
            {
            }
            column(EmployeeNo_InternalRequestHeader; "Internal Request Header"."Employee No.")
            {
            }
            column(EmployeeName_InternalRequestHeader; "Internal Request Header"."Employee Name")
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
            column(Dim1; GLSetup."Global Dimension 1 Code")
            {
            }
            column(Dim2; GLSetup."Global Dimension 2 Code")
            {
            }
            column(Dim3; GLSetup."Shortcut Dimension 3 Code")
            {
            }
            column(Dim4; GLSetup."Shortcut Dimension 4 Code")
            {
            }
            column(Dim5; GLSetup."Shortcut Dimension 5 Code")
            {
            }
            column(Dim6; GLSetup."Shortcut Dimension 6 Code")
            {
            }
            column(Dim7; GLSetup."Shortcut Dimension 7 Code")
            {
            }
            column(PaymentTxt; PaymentTxt)
            {
            }
            column(HeaderDimValueName_1; HeaderDimValueCode[1])
            {
            }
            column(HeaderDimValueName_2; HeaderDimValueCode[2])
            {
            }
            column(HeaderDimValueName_3; HeaderDimValueCode[3])
            {
            }
            column(HeaderDimValueName_4; HeaderDimValueCode[4])
            {
            }
            column(HeaderDimValueName_5; HeaderDimValueCode[5])
            {
            }
            column(HeaderDimValueName_6; HeaderDimValueCode[6])
            {
            }
            column(HeaderDimValueName_7; HeaderDimValueCode[7])
            {
            }
            column(HeaderDimValueName_8; HeaderDimValueCode[8])
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
            column(ISO; ISOCert)
            {
            }
            dataitem("Internal Request Line"; "Internal Request Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(No_InternalRequestLine; "Internal Request Line"."No.")
                {
                }
                column(Description_InternalRequestLine; "Internal Request Line".Description)
                {
                }
                column(UnitofMeasure_InternalRequestLine; "Internal Request Line"."Unit of Measure")
                {
                }
                column(Quantity_InternalRequestLine; "Internal Request Line".Quantity)
                {
                }
                column(QtytoIssue_InternalRequestLine; "Internal Request Line"."Qty. to Issue")
                {
                }
                column(DirectUnitCost_InternalRequestLine; "Internal Request Line"."Direct Unit Cost")
                {
                }
                column(Amount_InternalRequestLine; "Internal Request Line".Amount)
                {
                }
                column(LineAmount_InternalRequestLine; "Internal Request Line"."Line Amount")
                {
                }
                column(ProcurementPlanItem_InternalRequestLine; "Internal Request Line"."Procurement Plan Item")
                {
                }
                column(Type_InternalRequestLine; "Internal Request Line".Type)
                {
                }
                column(Specifications_InternalRequestLine; SpecificationsTxt)
                {
                }
                column(counrun; counrun) { }

                trigger OnAfterGetRecord()
                begin
                    counrun := counrun + 1;
                    CalcFields(Specification);
                    Specification.CreateInStream(Inst);
                    SpecificationsBigTxt.Read(Inst);
                    SpecificationsTxt := Format(SpecificationsBigTxt);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                //Prepared By
                Approver[1] := "Requested By";
                ApproverDate[1] := CreateDateTime("Order Date", Time);
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::"Internal Request Header");
                ApprovalEntries.SetRange("Document No.", "Internal Request Header"."No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                    begin
                        repeat
                            if ApprovalEntries."Sequence No." = 1 then begin
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

                /*//Approvals
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID",Database::"Internal Request Header");
                ApprovalEntries.SetRange("Document No.","Internal Request Header"."No.");
                //ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                   i:=0;
                 repeat
                 i:=i+1;
                if i=1 then begin
                  //Approver[1]:=ApprovalEntries."Sender ID";
                //ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
                 if UserSetup.Get(Approver[1]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup.CalcFields(Signature);
                 end;
                
                ApprovalEntries.SetRange(Status,ApprovalEntries.Status::Approved);
                Approver[2]:=ApprovalEntries."Approver ID";
                ApproverDate[2]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup1.Get(Approver[2]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup1.CalcFields(Signature);
                 end;
                end;
                
                if i=2 then
                begin
                Approver[3]:=ApprovalEntries."Approver ID";
                ApproverDate[3]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup2.Get(Approver[3]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup2.CalcFields(Signature);
                 end;
                end;
                
                if i=3 then
                begin
                Approver[4]:=ApprovalEntries."Approver ID";
                ApproverDate[4]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup3.Get(Approver[4]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup3.CalcFields(Signature);
                 end;
                end;
                until
                ApprovalEntries.Next()=0;
                
                end;*/

                //Get Header Dimensions
                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", "Internal Request Header"."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;

                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", "Internal Request Header"."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[2] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[2] := DimSetEntry."Dimension Value Name";
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

    trigger OnInitReport()
    begin
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        GLSetup.Get();
    end;

    var
        counrun: Integer;
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        SpecificationsBigTxt: BigText;
        HeaderDimValueCode: array[8] of Code[20];
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        Inst: InStream;
        ISOText: Label '';
        HeaderDimValueName: array[8] of Text;
        ISOCert: Text;
        PaymentTxt: Text;
        SpecificationsTxt: Text;

    local procedure GetUserName(UserCode: Code[50]): Text
    var
        Users: Record User;
    begin
        Users.Reset();
        Users.SetRange("User Name", UserCode);
        if Users.FindFirst() then
            exit(Users."Full Name");
    end;
}





