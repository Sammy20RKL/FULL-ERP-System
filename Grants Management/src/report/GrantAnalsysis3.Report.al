report 60010 "Grant Analsysis 3"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/GrantAnalsysis3.rdlc';

    dataset
    {
        dataitem(Jobs; Jobs)
        {
            DataItemTableView = where(Status = filter(Project));
            column(Project_Code; Jobs."No.")
            {
            }
            column(Project_Name; Jobs.Description)
            {
            }
            column(Budgetted_Cost; Jobs."Total Cost")
            {
            }
            column(Obligated_Amount; Jobs."Committed Amount")
            {
            }
            column(Actual; Jobs."Amount Invoiced")
            {
            }
            column(Balance; Balance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Jobs.CalcFields(Jobs."Total Cost");
                Jobs.CalcFields(Jobs."Amount Invoiced");
                Jobs.CalcFields(Jobs."Committed Amount");
                Balance := Jobs."Total Cost" - Jobs."Amount Invoiced" - Jobs."Committed Amount";
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

    var
        Balance: Decimal;
}

