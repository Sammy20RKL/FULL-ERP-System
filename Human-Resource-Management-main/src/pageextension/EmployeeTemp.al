pageextension 52009 "EMployee Tamp" extends "Employee Templ. Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("Employee Type"; Rec."Employee Type")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}