page 53066 "Procurement Plans"
{
    Caption = 'G/L Budget Names';
    CardPageID = "Procurement Plan";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Procurement Plan";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the general ledger budget.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a description of the general ledger budget name.';
                }
                field("Plan Submission Cut-off"; Rec."Plan Submission Cut-off")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Plan Submission Cut-off Date field.';
                }
                field("Total Budget Allocation"; Rec."Total Budget Allocation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Budget Allocation field';
                }
                field("Current Plan"; Rec."Current Plan")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current Plan field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        GLSetup.Get();
    end;

    var
        GLSetup: Record "General Ledger Setup";

    procedure GetSelectionFilter(): Text
    var
        GLBudgetName: Record "G/L Budget Name";
    //SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(GLBudgetName);
        //exit(SelectionFilterManagement.GetSelectionFilterForGLBudgetName(GLBudgetName));
    end;
}





