xmlport 53000 "Import Procurement Plan"
{
    Format = VariableText;
    Direction = Both;
    Caption = 'Import Procurement Plan';

    schema
    {
        textelement(RootNodeName)
        {
            tableelement(ProcurementPlanItem; "Procurement Plan Item")
            {
                AutoUpdate = true;
                AutoReplace = false;

                fieldelement(Date; ProcurementPlanItem."Date")
                {
                }
                fieldelement(ShortcutDimension1Code; ProcurementPlanItem."Shortcut Dimension 1 Code")
                {
                }
                fieldelement(ShortcutDimension2Code; ProcurementPlanItem."Shortcut Dimension 2 Code")
                {
                }
                fieldelement(ProcurementType; ProcurementPlanItem."Procurement Type")
                {
                }
                fieldelement(No; ProcurementPlanItem."No.")
                {
                }
                fieldelement(Quantity; ProcurementPlanItem.Quantity)
                {
                }
                fieldelement(UnitPrice; ProcurementPlanItem."Unit Price")
                {
                }
                fieldelement(Justification; ProcurementPlanItem.Justification)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    ProcurementPlanItem."Plan Year" := BudgetCode;
                    ProcurementPlanItem."Plan Item No" := NoSeriesMgt.GetNextNo(PurchSetup."Procurement Plan Item Nos", 0D, true);
                    ProcurementPlanItem.Validate(Date, ProcurementPlanItem.Date);
                    ProcurementPlanItem.Validate("No.", ProcurementPlanItem."No.");
                    ProcurementPlanItem.Validate("Procurement Type", ProcurementPlanItem."Procurement Type");
                    ProcurementPlanItem.Validate("Unit Price", ProcurementPlanItem."Unit Price");
                    ProcurementPlanItem.Validate("Shortcut Dimension 1 Code", ProcurementPlanItem."Shortcut Dimension 1 Code");
                    ProcurementPlanItem.Validate("Shortcut Dimension 2 Code", ProcurementPlanItem."Shortcut Dimension 2 Code");
                end;
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        PurchSetup.Get();
        PurchSetup.TestField("Procurement Plan Item Nos");
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BudgetCode: Code[50];

    procedure GetBudgetCode(BudCode: Code[50])
    begin
        BudgetCode := BudCode;
    end;
}
