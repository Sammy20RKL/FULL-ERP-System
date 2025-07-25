page 65013 "Performance Contracting Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Performance Contracting Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Row No."; Rec."Row No.")
                {
                    ToolTip = 'Specifies the value of the Row No. field.';
                }
                field("Group Order"; Rec."Group Order")
                {
                    ToolTip = 'Specifies the value of the Group Order field.';
                }
                field("Item/Activity"; Rec."Item/Activity")
                {
                    ToolTip = 'Specifies the value of the Item/Activity field.';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field(Measure; Rec.Measure)
                {
                    ToolTip = 'Specifies the value of the Measure field.';
                }
                field("Row Text"; Rec."Row Text")
                {
                    ToolTip = 'Specifies the value of the Row Text field.';
                }
                field("Annual Target"; Rec."Annual Target")
                {
                    ToolTip = 'Specifies the value of the Annual Target field.';
                }
                field(Heading; Rec.Heading)
                {
                    ToolTip = 'Specifies the value of the Heading field.';
                }
                field("Totaling Type"; Rec."Totaling Type")
                {
                    ToolTip = 'Specifies the value of the Totaling Type field.';
                }
                field(Totaling; Rec.Totaling)
                {
                    ToolTip = 'Specifies the value of the Totaling field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the value of the Class field.';
                }
                field("Specific Indicator Components"; Rec."Specific Indicator Components")
                {
                    ToolTip = 'Specifies the value of the Specific Indicator Components field.';
                }
                field(Evidence; Rec.Evidence)
                {
                    ToolTip = 'Specifies the value of the Evidence field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Resource; Rec.Resource)
                {
                    ToolTip = 'Specifies the value of the Resource field.';
                }
                field("Quarter 1 Target"; Rec."Quarter 1 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 1 Target field.';
                }
                field("Quarter 1 Actual"; Rec."Quarter 1 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 1 Actual field.';
                }
                field("Quarter 2 Target"; Rec."Quarter 2 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 2 Target field.';
                }
                field("Quarter 2 Actual"; Rec."Quarter 2 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 2 Actual field.';
                }
                field("Quarter 3 Target"; Rec."Quarter 3 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 3 Target field.';
                }
                field("Quarter 3 Actual"; Rec."Quarter 3 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 3 Actual field.';
                }
                field("Quarter 4 Target"; Rec."Quarter 4 Target")
                {
                    ToolTip = 'Specifies the value of the Quarter 4 Target field.';
                }
                field("Quarter 4 Actual"; Rec."Quarter 4 Actual")
                {
                    ToolTip = 'Specifies the value of the Quarter 4 Actual field.';
                }
                field("Total Quarter Target"; Rec."Total Quarter Target")
                {
                    ToolTip = 'Specifies the value of the Total Quarter Target field.';
                }
                field("Total Quarter Actual"; Rec."Total Quarter Actual")
                {
                    ToolTip = 'Specifies the value of the Total Quarter Actual field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Remarks Q1';
                    ToolTip = 'Specifies the value of the Remarks Q1 field.';
                }
                field("Remarks Q2"; Rec."Remarks Q2")
                {
                    ToolTip = 'Specifies the value of the Remarks Q2 field.';
                }
                field("Remarks Q3"; Rec."Remarks Q3")
                {
                    ToolTip = 'Specifies the value of the Remarks Q3 field.';
                }
                field("Remarks Q4"; Rec."Remarks Q4")
                {
                    ToolTip = 'Specifies the value of the Remarks Q4 field.';
                }
                field(Submitted; Rec.Submitted)
                {
                    ToolTip = 'Specifies the value of the Submitted field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Action18)
            {
                action("Perfm. Contracting Comment")
                {
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Perfm. Contracting Comment";
                    RunPageLink = "Document No." = field("Document No."), "Line No." = field("Line No.");
                    ToolTip = 'Executes the Perfm. Contracting Comment action.';
                }
            }
        }
    }
}

