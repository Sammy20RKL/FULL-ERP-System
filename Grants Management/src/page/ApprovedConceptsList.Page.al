page 60042 "Approved Concepts List"
{
    ApplicationArea = All;
    CardPageId = "Approved Concepts";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Jobs;
    SourceTableView = where(Status = const("Concept Formulation"), "Approval Status" = filter(Approved));

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    Caption = 'Search Description';
                    ToolTip = 'Specifies the value of the Search Description field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Description 2';
                    ToolTip = 'Specifies the value of the Description 2 field.';
                }
                field("Bill-to Partner No."; Rec."Bill-to Partner No.")
                {
                    Caption = 'Bill-to Customer No.';
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Caption = 'Creation Date';
                    ToolTip = 'Specifies the value of the Creation Date field.';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Person Responsible"; Rec."Person Responsible")
                {
                    Caption = 'Person Responsible';
                    ToolTip = 'Specifies the value of the Person Responsible field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Job Posting Group"; Rec."Job Posting Group")
                {
                    Caption = 'Kind of Program';
                    ToolTip = 'Specifies the value of the Kind of Program field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(Comment; Rec.Comment)
                {
                    Caption = 'Comment';
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                    ToolTip = 'Specifies the value of the Customer Disc. Group field.';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                    ToolTip = 'Specifies the value of the Customer Price Group field.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    Caption = 'Language Code';
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field("Scheduled Res. Qty."; Rec."Scheduled Res. Qty.")
                {
                    Caption = 'Scheduled Res. Qty.';
                    ToolTip = 'Specifies the value of the Scheduled Res. Qty. field.';
                }
                field("Scheduled Res. Gr. Qty."; Rec."Scheduled Res. Gr. Qty.")
                {
                    Caption = 'Scheduled Res. Gr. Qty.';
                    ToolTip = 'Specifies the value of the Scheduled Res. Gr. Qty. field.';
                }
                field(Picture; Rec.Picture)
                {
                    Caption = 'Picture';
                    ToolTip = 'Specifies the value of the Picture field.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Caption = 'Bill-to Name';
                    ToolTip = 'Specifies the value of the Bill-to Name field.';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Caption = 'Address';
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    Caption = 'Bill-to City';
                    ToolTip = 'Specifies the value of the Bill-to City field.';
                }
                field(County; Rec.County)
                {
                    Caption = 'County';
                    ToolTip = 'Specifies the value of the County field.';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code';
                    ToolTip = 'Specifies the value of the Bill-to Post Code field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    Caption = 'No. Series';
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Caption = 'Bill-to Country/Region Code';
                    ToolTip = 'Specifies the value of the Bill-to Country/Region Code field.';
                }
                field(Contractor; Rec.Contractor)
                {
                    Caption = 'Contractor';
                    ToolTip = 'Specifies the value of the Contractor field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.';
                    ToolTip = 'Specifies the value of the Bill-to Contact No. field.';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Caption = 'Bill-to Contact';
                    ToolTip = 'Specifies the value of the Bill-to Contact field.';
                }
                field("Total WIP Cost Amount"; Rec."Total WIP Cost Amount")
                {
                    Caption = 'Total WIP Cost Amount';
                    ToolTip = 'Specifies the value of the Total WIP Cost Amount field.';
                }
                field("Total WIP Cost G/L Amount"; Rec."Total WIP Cost G/L Amount")
                {
                    Caption = 'Total WIP Cost G/L Amount';
                    ToolTip = 'Specifies the value of the Total WIP Cost G/L Amount field.';
                }
                field("WIP Posted To G/L"; Rec."WIP Posted To G/L")
                {
                    Caption = 'WIP Posted To G/L';
                    ToolTip = 'Specifies the value of the WIP Posted To G/L field.';
                }
                field("WIP Posting Date"; Rec."WIP Posting Date")
                {
                    Caption = 'WIP Posting Date';
                    ToolTip = 'Specifies the value of the WIP Posting Date field.';
                }
                field("WIP G/L Posting Date"; Rec."WIP G/L Posting Date")
                {
                    Caption = 'WIP G/L Posting Date';
                    ToolTip = 'Specifies the value of the WIP G/L Posting Date field.';
                }
                field("Posted WIP Method Used"; Rec."Posted WIP Method Used")
                {
                    Caption = 'Posted WIP Method Used';
                    ToolTip = 'Specifies the value of the Posted WIP Method Used field.';
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    Caption = 'Invoice Currency Code';
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
                }
                field("Exch. Calculation (Cost)"; Rec."Exch. Calculation (Cost)")
                {
                    Caption = 'Exch. Calculation (Cost)';
                    ToolTip = 'Specifies the value of the Exch. Calculation (Cost) field.';
                }
                field("Exch. Calculation (Price)"; Rec."Exch. Calculation (Price)")
                {
                    Caption = 'Exch. Calculation (Price)';
                    ToolTip = 'Specifies the value of the Exch. Calculation (Price) field.';
                }
                field("Allow Schedule/Contract Lines"; Rec."Allow Schedule/Contract Lines")
                {
                    Caption = 'Allow Schedule/Contract Lines';
                    ToolTip = 'Specifies the value of the Allow Schedule/Contract Lines field.';
                }
                field(Complete; Rec.Complete)
                {
                    Caption = 'Complete';
                    ToolTip = 'Specifies the value of the Complete field.';
                }
                field("Calc. WIP Method Used"; Rec."Calc. WIP Method Used")
                {
                    Caption = 'Calc. WIP Method Used';
                    ToolTip = 'Specifies the value of the Calc. WIP Method Used field.';
                }
                field("Amount Awarded"; Rec."Amount Awarded")
                {
                    Caption = 'Amount Awarded';
                    ToolTip = 'Specifies the value of the Amount Awarded field.';
                }
                field("Recog. Sales G/L Amount"; Rec."Recog. Sales G/L Amount")
                {
                    Caption = 'Recog. Sales G/L Amount';
                    ToolTip = 'Specifies the value of the Recog. Sales G/L Amount field.';
                }
                field("Recog. Costs Amount"; Rec."Recog. Costs Amount")
                {
                    Caption = 'Recog. Costs Amount';
                    ToolTip = 'Specifies the value of the Recog. Costs Amount field.';
                }
                field("Recog. Costs G/L Amount"; Rec."Recog. Costs G/L Amount")
                {
                    Caption = 'Recog. Costs G/L Amount';
                    ToolTip = 'Specifies the value of the Recog. Costs G/L Amount field.';
                }
                field("Total WIP Sales Amount"; Rec."Total WIP Sales Amount")
                {
                    Caption = 'Total WIP Sales Amount';
                    ToolTip = 'Specifies the value of the Total WIP Sales Amount field.';
                }
                field("Total WIP Sales G/L Amount"; Rec."Total WIP Sales G/L Amount")
                {
                    Caption = 'Total WIP Sales G/L Amount';
                    ToolTip = 'Specifies the value of the Total WIP Sales G/L Amount field.';
                }
                field("Completion Calculated"; Rec."Completion Calculated")
                {
                    Caption = 'Completion Calculated';
                    ToolTip = 'Specifies the value of the Completion Calculated field.';
                }
                field("Next Invoice Date"; Rec."Next Invoice Date")
                {
                    Caption = 'Next Invoice Date';
                    ToolTip = 'Specifies the value of the Next Invoice Date field.';
                }
                field("Grant Phases"; Rec."Grant Phases")
                {
                    Caption = 'Grant Phases';
                    ToolTip = 'Specifies the value of the Grant Phases field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    Caption = 'Total Cost';
                    ToolTip = 'Specifies the value of the Total Cost field.';
                }
                field("Total Cost(LCY)"; Rec."Total Cost(LCY)")
                {
                    Caption = 'Total Cost(LCY)';
                    ToolTip = 'Specifies the value of the Total Cost(LCY) field.';
                }
                field("Contract Description"; Rec."Contract Description")
                {
                    Caption = 'Contract Description';
                    ToolTip = 'Specifies the value of the Contract Description field.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    Caption = 'Contract Type';
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Disbursed Amount"; Rec."Disbursed Amount")
                {
                    Caption = 'Disbursed Amount';
                    ToolTip = 'Specifies the value of the Disbursed Amount field.';
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    Caption = 'Allow OverExpenditure';
                    ToolTip = 'Specifies the value of the Allow OverExpenditure field.';
                }
                field("Accounted Amount"; Rec."Accounted Amount")
                {
                    Caption = 'Accounted Amount';
                    ToolTip = 'Specifies the value of the Accounted Amount field.';
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    Caption = 'Received Amount';
                    ToolTip = 'Specifies the value of the Received Amount field.';
                }
                field("Proposal No"; Rec."Proposal No")
                {
                    Caption = 'Proposal No';
                    ToolTip = 'Specifies the value of the Proposal No field.';
                }
                field("Converted To Proposal"; Rec."Converted To Proposal")
                {
                    Caption = 'Converted To Proposal';
                    ToolTip = 'Specifies the value of the Converted To Proposal field.';
                }
                field("Project No"; Rec."Project No")
                {
                    Caption = 'Project No';
                    ToolTip = 'Specifies the value of the Project No field.';
                }
                field("Converted To Project"; Rec."Converted To Project")
                {
                    Caption = 'Converted To Project';
                    ToolTip = 'Specifies the value of the Converted To Project field.';
                }
                field("Concept Number"; Rec."Concept Number")
                {
                    Caption = 'Concept Number';
                    ToolTip = 'Specifies the value of the Concept Number field.';
                }
                field(Objective; Rec.Objective)
                {
                    Caption = 'Objective';
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field("Contract No"; Rec."Contract No")
                {
                    Caption = 'Contract No';
                    ToolTip = 'Specifies the value of the Contract No field.';
                }
                field("Reporting dates generated"; Rec."Reporting dates generated")
                {
                    Caption = 'Reporting dates generated';
                    ToolTip = 'Specifies the value of the Reporting dates generated field.';
                }
                field("Condition for budget realloca"; Rec."Condition for budget realloca")
                {
                    Caption = 'Condition for budget realloca';
                    ToolTip = 'Specifies the value of the Condition for budget realloca field.';
                }
                field("Principal Investigator"; Rec."Principal Investigator")
                {
                    Caption = 'Principal Investigator';
                    ToolTip = 'Specifies the value of the Principal Investigator field.';
                }
                field("Expected Receipt Amount"; Rec."Expected Receipt Amount")
                {
                    Caption = 'Expected Receipt Amount';
                    ToolTip = 'Specifies the value of the Expected Receipt Amount field.';
                }
                field(Partners; Rec.Partners)
                {
                    Caption = 'Collaborative Grants';
                    ToolTip = 'Specifies the value of the Collaborative Grants field.';
                }
                field("Project Location"; Rec."Project Location")
                {
                    Caption = 'Project Location';
                    ToolTip = 'Specifies the value of the Project Location field.';
                }
                field("Income Account"; Rec."Income Account")
                {
                    Caption = 'Income Account';
                    ToolTip = 'Specifies the value of the Income Account field.';
                }
                field("Concept Approval Date"; Rec."Concept Approval Date")
                {
                    Caption = 'Concept Approval Date';
                    ToolTip = 'Specifies the value of the Concept Approval Date field.';
                }
                field("Project Filter"; Rec."Project Filter")
                {
                    Caption = 'Project Filter';
                    ToolTip = 'Specifies the value of the Project Filter field.';
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field("Project Coordinator"; Rec."Project Coordinator")
                {
                    Caption = 'Project Coordinator';
                    ToolTip = 'Specifies the value of the Project Coordinator field.';
                }
                field(Task; Rec.Task)
                {
                    Caption = 'Task';
                    ToolTip = 'Specifies the value of the Task field.';
                }
                field("Project Status"; Rec."Project Status")
                {
                    Caption = 'Project Status';
                    ToolTip = 'Specifies the value of the Project Status field.';
                }
                field("Audit Indicator"; Rec."Audit Indicator")
                {
                    Caption = 'Audit Indicator';
                    ToolTip = 'Specifies the value of the Audit Indicator field.';
                }
                field("Approved Funding Start Date"; Rec."Approved Funding Start Date")
                {
                    Caption = 'Approved Funding Start Date';
                    ToolTip = 'Specifies the value of the Approved Funding Start Date field.';
                }
                field("Approved Funding End Date"; Rec."Approved Funding End Date")
                {
                    Caption = 'Approved Funding End Date';
                    ToolTip = 'Specifies the value of the Approved Funding End Date field.';
                }
                field("Justification Narration"; Rec."Justification Narration")
                {
                    Caption = 'Justification Narration';
                    ToolTip = 'Specifies the value of the Justification Narration field.';
                }
                field("Amount Invoiced"; Rec."Amount Invoiced")
                {
                    Caption = 'Amount Invoiced';
                    ToolTip = 'Specifies the value of the Amount Invoiced field.';
                }
                field("Grant Level"; Rec."Grant Level")
                {
                    Caption = 'Grant Level';
                    ToolTip = 'Specifies the value of the Grant Level field.';
                }
                field("RSPO No."; Rec."RSPO No.")
                {
                    Caption = 'RSPO No.';
                    ToolTip = 'Specifies the value of the RSPO No. field.';
                }
                field("Alert sent"; Rec."Alert sent")
                {
                    Caption = 'Alert sent';
                    ToolTip = 'Specifies the value of the Alert sent field.';
                }
            }
        }
    }

    actions
    {
    }
}

