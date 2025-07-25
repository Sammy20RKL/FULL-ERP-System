codeunit 53004 "Workflow Responses Procurement"
{
    procedure ReleaseReq(Req: Record "Internal Request Header")
    var
        ReqRec: Record "Internal Request Header";
    begin
        if ReqRec.Get(Req."No.") then begin
            ReqRec."Status" := ReqRec."Status"::Released;
            ReqRec.Modify();
        end;
    end;

    procedure ReopenReq(Req: Record "Internal Request Header")
    var
        ReqRec: Record "Internal Request Header";
    begin
        if ReqRec.Get(Req."No.") then begin
            ReqRec."Status" := ReqRec."Status"::Open;
            ReqRec.Modify();
        end;
    end;

    //Tender Evaluation
    procedure ReleaseTenderEval(var TenderEvaluation: Record "Procurement Evaluation Header")
    var
        TenderEval: Record "Procurement Evaluation Header";
    begin
        TenderEval.Reset();
        TenderEval.SetRange("No.", TenderEvaluation."No.");
        if TenderEval.FindFirst() then begin
            TenderEval.Status := TenderEval.Status::Approved;
            TenderEval.Modify(true);
        end;
    end;

    procedure ReopenTenderEval(var TenderEvaluation: Record "Procurement Evaluation Header")
    var
        TenderEval: Record "Procurement Evaluation Header";
    begin
        TenderEval.Reset();
        TenderEval.SetRange("No.", TenderEvaluation."No.");
        if TenderEval.FindFirst() then begin
            TenderEval.Status := TenderEval.Status::New;
            TenderEval.Modify(true);
        end;
    end;

    procedure ReleaseSupplierEval(var SupplierEvaluation: Record "Supplier Evaluation Header")
    var
        SupplierEval: Record "Supplier Evaluation Header";
    begin
        SupplierEval.Reset();
        SupplierEval.SetRange("Quote No", SupplierEvaluation."Quote No");
        if SupplierEval.FindFirst() then begin
            SupplierEval.Status := SupplierEval.Status::Approved;
            SupplierEval.Modify(true);
        end;
    end;

    procedure ReopenSupplierEval(var SupplierEvaluation: Record "Supplier Evaluation Header")
    var
        SupplierEval: Record "Supplier Evaluation Header";
    begin
        SupplierEval.Reset();
        SupplierEval.SetRange("Quote No", SupplierEvaluation."Quote No");
        if SupplierEval.FindFirst() then begin
            SupplierEval.Status := SupplierEval.Status::New;
            SupplierEval.Modify(true);
        end;
    end;

    //FA Disposal
    procedure ReleaseFADisposal(var FADisposal: Record "FA Disposal")
    var
        FADisposalRec: Record "FA Disposal";
        FADispLines: Record "FA Disposal Line";
        FA: Record "Fixed Asset";
    begin
        if FADisposalRec.Get(FADisposal."No.") then begin
            FADisposalRec.Status := FADisposalRec.Status::Approved;
            FADisposalRec.Modify(true);

            //Approve Lines
            FADispLines.Reset();
            FADispLines.SetRange("Document No.", FADisposalRec."No.");
            if FADispLines.Find('-') then begin
                repeat
                    FA.Get(FADispLines."FA No.");
                    FA."Marked For Disposal" := true;
                    FA.Modify();
                until FADispLines.Next() = 0;
            end;
        end;
    end;

    procedure ReopenFADisposal(var FADisposal: Record "FA Disposal")
    var
        FADisposalRec: Record "FA Disposal";
    begin
        if FADisposalRec.Get(FADisposal."No.") then begin
            FADisposalRec.Status := FADisposalRec.Status::Open;
            FADisposalRec.Modify(true);
        end;
    end;

    //Tender Committee
    procedure ReleaseTenderCommittee(var TenderCommittee: Record "Tender Committees")
    var
        TenderCom: Record "Tender Committees";
        ProcMgt: Codeunit "Procurement Management";
        ApprovalConfirm: Label 'Are you sure you want to Approve this committee?\ Respective members shall be notified via mail';
    begin
        if TenderCom.Get(TenderCommittee."Appointment No") then begin
            if Confirm(ApprovalConfirm, false) then begin
                ProcMgt.NotifyTenderCommitteeMembers(TenderCom);
                TenderCom.Validate(Status, TenderCom.Status::Released);
                TenderCom.Modify();
            end;
        end;
    end;

    procedure ReOpenTenderCommittee(var TenderCommittee: Record "Tender Committees")
    var
        TenderCom: Record "Tender Committees";
    begin
        if TenderCom.Get(TenderCommittee."Appointment No") then begin
            TenderCom.Validate(Status, TenderCom.Status::Open);
            TenderCom.Modify();
        end;
    end;

    //Tenders
    procedure ReleaseProcurementRequest(var ProcRequest: Record "Procurement Request")
    var
        ProcRec: Record "Procurement Request";
        BidderSelection: Record "Supplier Selection";
        ProspectiveSuppliers: Record "Prospective Suppliers";
    begin
        if ProcRec.Get(ProcRequest."No.") then begin
            ProcRec.Validate(Status, ProcRec.Status::Approved);
            ProcRec.Modify();

            //Mark as prequalified
            if ProcRec."Process Type" = ProcRec."Process Type"::"Supplier Prequalification" then begin
                BidderSelection.Reset();
                BidderSelection.SetRange("Reference No.", ProcRec."No.");
                if BidderSelection.FindSet() then
                    repeat
                        ProspectiveSuppliers.Get(BidderSelection."Supplier Code");
                        ProspectiveSuppliers.Validate("Pre Qualified", true);
                        ProspectiveSuppliers.Modify();
                    until BidderSelection.Next() = 0;
            end;
        end;
    end;

    procedure ReopenProcurementRequest(var ProcRequest: Record "Procurement Request")
    var
        ProcRec: Record "Procurement Request";
        BidderSelection: Record "Supplier Selection";
        ProspectiveSuppliers: Record "Prospective Suppliers";
    begin
        if ProcRec.Get(ProcRequest."No.") then begin
            ProcRec.Validate(Status, ProcRec.Status::New);
            ProcRec.Modify();

            //Mark as prequalified
            if ProcRec."Process Type" = ProcRec."Process Type"::"Supplier Prequalification" then begin
                BidderSelection.Reset();
                BidderSelection.SetRange("Reference No.", ProcRec."No.");
                if BidderSelection.FindSet() then
                    repeat
                        ProspectiveSuppliers.Get(BidderSelection."Supplier Code");
                        ProspectiveSuppliers.Validate("Pre Qualified", false);
                        ProspectiveSuppliers.Modify();
                    until BidderSelection.Next() = 0;
            end;
        end;
    end;

    procedure ReleaseProcurementPlan(var ProcurementPlan: Record "Procurement Plan")
    var
        ProcurementPlanRec: Record "Procurement Plan";
    begin
        if ProcurementPlanRec.Get(ProcurementPlan.Name) then begin
            ProcurementPlanRec.Validate(Status, ProcurementPlanRec.Status::Approved);
            ProcurementPlanRec.Modify();
        end;
    end;

    procedure ReOpenProcurementPlan(var ProcurementPlan: Record "Procurement Plan")
    var
        ProcurementPlanRec: Record "Procurement Plan";
    begin
        if ProcurementPlanRec.Get(ProcurementPlan.Name) then begin
            ProcurementPlanRec.Validate(Status, ProcurementPlanRec.Status::Open);
            ProcurementPlanRec.Modify();
        end;
    end;

    procedure ReleaseBudget(var BudgetRec: Record "Budget Approval Header")
    var
        Budget: Record "Budget Approval Header";
        BudgetApprovalLines: Record "Budget Approval Lines";
        ProcPlanApprovalLines: Record "Procurement Plan Approval Line";
        ProcPlanItems: Record "Procurement Plan Item";
        GLBudgetEntry: Record "G/L Budget Entry";
    begin
        if Budget.Get(BudgetRec."Document No.") then begin
            case Budget."Budget Type" of
                Budget."Budget Type"::"Procurement Plan":
                    begin
                        case Budget."Budget Option" of
                            Budget."Budget Option"::"Procurement Plan":
                                begin
                                    ProcPlanApprovalLines.Reset();
                                    ProcPlanApprovalLines.SetRange("Document No.", Budget."Document No.");
                                    if ProcPlanApprovalLines.FindSet() then
                                        repeat
                                            ProcPlanItems.Init();
                                            ProcPlanItems.TransferFields(ProcPlanApprovalLines);
                                            ProcPlanItems."Plan Year" := Budget."Budget Name";
                                            ProcPlanItems."Plan Item No" := '';
                                            ProcPlanItems."User ID" := Budget."User ID";
                                            ProcPlanItems.Insert(true);
                                        until ProcPlanApprovalLines.Next() = 0;
                                end;
                            Budget."Budget Option"::"Procurement Plan Review":
                                begin
                                    ProcPlanItems.SetRange("Plan Year", Budget."Budget Name");
                                    ProcPlanItems.DeleteAll();

                                    ProcPlanApprovalLines.Reset();
                                    ProcPlanApprovalLines.SetRange("Document No.", Budget."Document No.");
                                    if ProcPlanApprovalLines.FindSet() then
                                        repeat
                                            ProcPlanItems.Init();
                                            ProcPlanItems.TransferFields(ProcPlanApprovalLines);
                                            ProcPlanItems."Plan Year" := Budget."Budget Name";
                                            ProcPlanItems."Plan Item No" := '';
                                            ProcPlanItems."User ID" := ProcPlanApprovalLines."User ID";
                                            ProcPlanItems.Insert(true);
                                        until ProcPlanApprovalLines.Next() = 0;
                                end;
                        end;

                        Budget.Status := Budget.Status::Approved;
                        Budget.Modify();
                    end;
            end;

            Budget.Status := Budget.Status::Approved;
            Budget.Modify();
        end;
    end;
}
