report 65005 "Monitoring & Evalution"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    RDLCLayout = './src/layouts/MonitoringEvalution.rdlc';

    dataset
    {
        dataitem(MonitoringEvaluation; "Monitoring & Evaluation")
        {
            RequestFilterFields = "No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(No_MonitoringEvaluation; MonitoringEvaluation."No.")
            {
            }
            column(Description_MonitoringEvaluation; MonitoringEvaluation.Description)
            {
            }
            column(StartDate_MonitoringEvaluation; MonitoringEvaluation."Start Date")
            {
            }
            column(EndDate_MonitoringEvaluation; MonitoringEvaluation."End Date")
            {
            }
            column(Mission_MonitoringEvaluation; MonitoringEvaluation.Mission)
            {
            }
            column(Vision_MonitoringEvaluation; MonitoringEvaluation.Vision)
            {
            }
            column(Closed_MonitoringEvaluation; MonitoringEvaluation.Closed)
            {
            }
            column(ClosedBY_MonitoringEvaluation; MonitoringEvaluation."Closed BY")
            {
            }
            column(DateClosed_MonitoringEvaluation; MonitoringEvaluation."Date Closed")
            {
            }
            column(TimeClosed_MonitoringEvaluation; MonitoringEvaluation."Time Closed")
            {
            }
            dataitem(MonitoringEvaluationLines; "WorkPlan Line Objectives")
            {
                DataItemLink = "Strategic No." = field("No.");
                DataItemTableView = sorting(Code, "Objective Code") where(Source = filter(<> ' '));
                column(Code_MonitoringEvaluationLines; MonitoringEvaluationLines.Code)
                {
                }
                column(Description_MonitoringEvaluationLines; MonitoringEvaluationLines.Description)
                {
                }
                column(StartDate_MonitoringEvaluationLines; MonitoringEvaluationLines."Start Date")
                {
                }
                column(EndDate_MonitoringEvaluationLines; MonitoringEvaluationLines."End Date")
                {
                }
                column(ObjectiveCode_MonitoringEvaluationLines; MonitoringEvaluationLines."Objective Code")
                {
                }
                column(MonitoringEvaluation_MonitoringEvaluationLines; MonitoringEvaluationLines."Monitoring & Evaluation")
                {
                }
                column(EvaluationComments_MonitoringEvaluationLines; MonitoringEvaluationLines."Evaluation Comments")
                {
                }
                column(StrategicNo_MonitoringEvaluationLines; MonitoringEvaluationLines."Strategic No.")
                {
                }
                column(Source_MonitoringEvaluationLines; MonitoringEvaluationLines.Source)
                {
                }
                column(PerformanceContractingNo_MonitoringEvaluationLines; MonitoringEvaluationLines."Performance Contracting No.")
                {
                }
                column(AttachmentLink_MonitoringEvaluationLines; MonitoringEvaluationLines."Attachment Link")
                {
                }
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
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
}

