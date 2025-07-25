report 65008 "Work Plan Matrix"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layouts/WorkPlanMatrix.rdlc';

    dataset
    {
        dataitem("Work Plan Header"; "Work Plan Header")
        {
            dataitem("WorkPlan Line Sub-Activities"; "WorkPlan Line Sub-Activities")
            {
                DataItemLink = Code = field(Code);
                column(Code_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities".Code)
                {
                }
                column(Description_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities".Description)
                {
                }
                column(ObjectiveCode_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Objective Code")
                {
                }
                column(ActivitiesCode_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Activities Code")
                {
                }
                column(ResponsiblePerson_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Responsible Person")
                {
                }
                column(Output_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities".Output)
                {
                }
                column(ApprovedBudget_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Approved Total Budget")
                {
                }
                column(FirstQuarter_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."First Quarter")
                {
                }
                column(SecondQuarter_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Second Quarter")
                {
                }
                column(ThirdQuarter_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Third Quarter")
                {
                }
                column(FourthQuarter_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Fourth Quarter")
                {
                }
                column(SubActivityCode_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Sub Activity Code")
                {
                }
                column(DescriptionActivities_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Description [Activities]")
                {
                }
                column(DescriptionSubActivities_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Description [Sub Activities]")
                {
                }
                column(KeyPerformanceIndicator_WorkPlanLineSubActivities; "WorkPlan Line Sub-Activities"."Key Performance Indicator")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Objt.Reset();
                    Objt.SetRange("No.", "WorkPlan Line Sub-Activities"."Objective Code");
                    if Objt.Find('-') then
                        "WorkPlan Line Sub-Activities".Description := Objt.Description
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

    var
        Objt: Record "Objective Codes";
}

