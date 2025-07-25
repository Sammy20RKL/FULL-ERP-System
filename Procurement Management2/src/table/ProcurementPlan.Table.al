table 53023 "Procurement Plan"
{
    Caption = 'Procurement Plan';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(4; "Total Budget Allocation"; Decimal)
        {
            CalcFormula = sum("Procurement Plan Item"."Estimated Cost" where("Plan Year" = field(Name)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Budget Allocation';
        }
        field(5; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
            Caption = 'Status';
            Editable = false;
        }
        field(6; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(7; "Budget Option"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Budgeting,ReAllocation';
            OptionMembers = " ",Budgeting,ReAllocation;
            Caption = 'Budget Option';
        }
        field(8; "Plan Submission Cut-off"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Plan Submission Cut-off Date';
        }
        field(9; "Current Budget"; Code[10])
        {
            TableRelation = "G/L Budget Name".Name;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(10; "Current Plan"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Purchases & Payables Setup" where("Effective Procurement Plan" = field(Name)));
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Name, Description)
        {
        }
    }

    trigger OnInsert()
    var
        ProcPlanAlreadyExistsErr: Label 'A procurement plan %1 under budget %2 already exists';
    begin
        if "Document No." = '' then begin
            CashSetup.Get();
            CashSetup.TestField("Proposed Budget Approval Nos");
            "Document No." := NoSeriesMgt.GetNextNo(CashSetup."Proposed Budget Approval Nos", 0D, true);
        end;

        GLSetup.Get();
        GLSetup.TestField("Current Budget");

        ProcurementPlan.SetRange("Current Budget", GLSetup."Current Budget");
        if not ProcurementPlan.FindFirst() then
            Validate("Current Budget", GLSetup."Current Budget");
        //else
        //Error(ProcPlanAlreadyExistsErr, ProcurementPlan.Name, GLSetup."Current Budget");
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CashSetup: Record "Cash Management Setups";
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        ProcurementPlan: Record "Procurement Plan";
}






