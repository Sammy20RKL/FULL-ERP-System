report 53014 "FA Disposal Quote Evaluation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/FADisposalQuoteEvaluation.rdl';

    dataset
    {
        dataitem("FA Disposal"; "FA Disposal")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(Companycity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            dataitem("FA Disposal Line"; "FA Disposal Line")
            {
                dataitem(Bids; "Procurement Request Lines")
                {
                    DataItemLink = "FA Disposal Doc No." = field("Document No."),
                                    No = field("FA No."),
                                    "Line No" = field("Line No.");
                    DataItemTableView = where("Bid Submitted" = const(true));

                    column(Staff_No_; "Staff No.")
                    {
                    }
                    column(StaffName; "Staff Name")
                    {
                    }
                    column(Type; Type)
                    {
                    }
                    column(FANo; No)
                    {
                    }
                    column(FADescription; Description)
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                    }
                    column(Amount; Amount)
                    {
                    }
                    column(HighestBidder; HighestBidder)
                    {
                    }
                    column(Suggested; Suggested)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        BidLines.Reset();
                        BidLines.SetRange("FA Disposal Doc No.", Bids."FA Disposal Doc No.");
                        BidLines.SetRange(No, Bids.No);
                        BidLines.SetRange(Amount, "FA Disposal Line"."Highest Bid");
                        if BidLines.FindFirst() then begin
                            HighestBidder := BidLines."Staff Name";
                            BidLines.Suggested := true;
                            BidLines.Awarded := true;
                            BidLines.Modify();
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields("Highest Bid");
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        BidLines: Record "Procurement Request Lines";
        HighestBidder: Text;
}





