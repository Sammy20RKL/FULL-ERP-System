pageextension 53014 "Vendor Card Procurement Ext" extends "Vendor Card"
{

    actions
    {
        addlast(processing)
        {
            action(Evaluate)
            {
                Visible = false;
                Caption = 'Send for Evaluation';
                Image = SendConfirmation;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Send for Evaluation action';

                trigger OnAction()
                begin
                    if Confirm('Are you sure?', false) = true then
                        ProcMgt.SendVendorForEvaluation(Rec);
                    CurrPage.Close();
                end;
            }

            action("Send To Prospective")
            {
                Caption = 'Send To Prospective Suppliers';
                Image = VendorContact;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ConfirmMsg: Label 'Are you sure you want to Send %1 to Prospective Suppliers?';
                    AlreadyExitsErr: Label '%1 already exits in Prospective Suppliers';
                begin
                    if Confirm(ConfirmMsg, false, Rec.Name) then begin
                        ProspectiveSuppliers.SetRange("Vendor No", Rec."No.");
                        if ProspectiveSuppliers.FindFirst() then
                            Error(AlreadyExitsErr, Rec.Name);

                        Vendor.SetRange("No.", Rec."No.");
                        UpdateProspectiveSuppliers.SetTableView(Vendor);
                        UpdateProspectiveSuppliers.RunModal();
                    end;
                end;
            }
        }
    }

    var
        ProcMgt: Codeunit "Procurement Management";
        UpdateProspectiveSuppliers: Report "Update Prospective Suppliers";
        Vendor: Record Vendor;
        ProspectiveSuppliers: Record "Prospective Suppliers";
}
