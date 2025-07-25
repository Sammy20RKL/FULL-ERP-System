report 53030 "EOI Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EOIAnalysis.rdl';

    dataset
    {
        dataitem("EOI Evaluation Header"; "Procurement Evaluation Header")
        {
            RequestFilterFields = "No.";

            column(Quote_No; "No.")
            {
            }
            column(Title; Title)
            {
            }
            column(Requisition_No; "Requisition No")
            {
            }
            column(EOI_Generated; "LPO/Contract Generated")
            {
            }
            column(Minutes; Minutes)
            {
            }
            column(Awarding_Committee; "Awarding Committee")
            {
            }
            column(Date_of_Award; "Date of Award")
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
            dataitem("EOI Evaluation Line"; "Procurement Evaluation Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Quote_No1; "Document No.")
                {
                }
                column(Vendor_No; "Vendor No")
                {
                }
                column(Type; Type)
                {
                }
                column(No_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_Amount; "Unit Amount")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Awarded; Awarded)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Line_No; "Line No")
                {
                }
                column(Quote_Generated; "Quote Generated")
                {
                }
                column(Vendor_Name; "Vendor Name")
                {
                }
                column(Title1; Title)
                {
                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {
                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {
                }
                column(Dimension_Set_ID; "Dimension Set ID")
                {
                }
                column(Committed; Committed)
                {
                }
                column(Quantity_Received; "Quantity Received")
                {
                }
                column(Procurement_Plan; "Procurement Plan")
                {
                }
                column(Procurement_Plan_Item; "Procurement Plan Item")
                {
                }
                column(Budget_Line; "Budget Line")
                {
                }
                column(Request_Date; "Request Date")
                {
                }
                column(Expected_Receipt_Date; "Expected Receipt Date")
                {
                }
                column(Suggested; Suggested)
                {
                }
                column(Amount_Inclusive_VAT; "Amount Inclusive VAT")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LeastAmount := 0;

                    QuoteLines.Reset();
                    QuoteLines.SetRange(QuoteLines."Document No.", "EOI Evaluation Line"."Document No.");
                    QuoteLines.SetRange(QuoteLines.Type, "EOI Evaluation Line".Type);
                    QuoteLines.SetRange(QuoteLines."No.", "EOI Evaluation Line"."No.");
                    QuoteLines.SetFilter(QuoteLines.Amount, '>%1', 0);
                    if QuoteLines.Find('-') then begin
                        repeat
                            LeastAmount := QuoteLines.GetRangeMin(Amount);

                            QuoteLines2.Reset();
                            QuoteLines2.SetRange("Document No.", QuoteLines."Document No.");
                            QuoteLines2.SetRange(Type, QuoteLines.Type);
                            QuoteLines2.SetRange("No.", QuoteLines."No.");
                            QuoteLines2.SetRange(Amount, LeastAmount);
                            if QuoteLines2.FindFirst() then begin
                                QuoteLines.Suggested := true;
                                QuoteLines.Modify();
                            end;
                        until QuoteLines.Next() = 0;
                    end;
                end;
            }
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        QuoteLines: Record "Procurement Evaluation Line";
        QuoteLines2: Record "Procurement Evaluation Line";
        LeastAmount: Decimal;
}





