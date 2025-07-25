table 60002 "Grant Receipt and Payment Type"
{
    //DrillDownPageID = "Receipts and Payment Types Lis";
    //LookupPageID = "Receipts and Payment Types Lis";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Receipt,Payment;
        }
        field(5; "VAT Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(6; "Withholding Tax Chargeable"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(7; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(8; "Withholding Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(9; "Default Grouping"; Code[20])
        {
            TableRelation = "Customer Posting Group".Code;
        }
        field(10; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50000; "Policy No. Mandatory"; Boolean)
        {
        }
        field(50001; "Claim No. Mandatory"; Boolean)
        {
        }
        field(50002; "Loan No. Mandatory"; Boolean)
        {
        }
        field(50003; "Split Principal and Interest"; Boolean)
        {
        }
        field(50004; "Insurance Trans Type"; Option)
        {
            OptionCaption = ' ,Premium,Commission,Tax,Wht,Excess,Claim Reserve,Claim Payment,Reinsurance Premium,Reinsurance Commission,Reinsurance Premium Taxes,Reinsurance Commission Taxes,Net Premium,Claim Recovery,Salvage,Reinsurance Claim Reserve,Reinsurance Recovery Payment ,Accrued Reinsurance Premium,Deposit Premium,XOL Adjustment Premium,UPR,IBNR,DAC,Re-UPR,Loan Deposit';
            OptionMembers = " ",Premium,Commission,Tax,Wht,Excess,"Claim Reserve","Claim Payment","Reinsurance Premium","Reinsurance Commission","Reinsurance Premium Taxes","Reinsurance Commission Taxes","Net Premium","Claim Recovery",Salvage,"Reinsurance Claim Reserve","Reinsurance Recovery Payment ","Accrued Reinsurance Premium","Deposit Premium","XOL Adjustment Premium",UPR,IBNR,DAC,"Re-UPR","Loan Deposit";
        }
        field(50005; "Investment Transaction Type"; Option)
        {
            OptionCaption = ' ,Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,Share-split,Premium,Discounts,Other Income,Expenses,Principal';
            OptionMembers = " ",Acquisition,Disposal,Interest,Dividend,Bonus,Revaluation,"Share-split",Premium,Discounts,"Other Income",Expenses,Principal;
        }
        field(50006; "Investment Type"; Option)
        {
            OptionMembers = " ","Money Market",Property,Equity,Mortgage,"Unit Trust",Forex;

            trigger OnValidate()
            begin
                //IF AssetTypesRec.GET("Investment Type") THEN
                //"Investment Type Name" := AssetTypesRec.Description;
            end;
        }
        field(50007; "Investment Type Name"; Text[30])
        {
        }
        field(50008; "No. Of Units Mandatory"; Boolean)
        {
        }
        field(50009; "Payment Schedule Link"; Boolean)
        {
        }
        field(50010; "Claimant ID. Mandatory"; Boolean)
        {
        }
        field(50011; "Debit Note Mandatory"; Boolean)
        {
        }
        field(50012; "Default Customer Posting Group"; Code[20])
        {
            TableRelation = "Customer Posting Group";
        }
        field(50013; "Default Vendor Posting Group"; Code[20])
        {
            TableRelation = "Vendor Posting Group";
        }
        field(50014; "Treaty Code Mandatory"; Boolean)
        {
        }
        field(50015; "Treaty Addendum Code Mandatory"; Boolean)
        {
        }
        field(50016; "Treaty Layer Mandatory"; Boolean)
        {
        }
        field(50017; "Investment Code Mandatory"; Boolean)
        {
        }
        field(50018; "FA Posting Type"; Option)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
        }
        field(50019; "No. Of Units Required"; Boolean)
        {
        }
        field(50020; "Calculate Interest"; Boolean)
        {
        }
        field(50021; "Schedule Mandatory"; Boolean)
        {
        }
        field(50022; "Calculate Broker Commission"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

