page 65016 "Performance Contracting Line"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Performance Contracting Per Responsible Person';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Performance Contracting Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Financial Year"; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Row No."; Rec."Row No.")
                {
                    Caption = 'Row No.';
                    ToolTip = 'Specifies the value of the Row No. field.';
                }
                field("Row Text"; Rec."Row Text")
                {
                    Caption = 'Row Text';
                    ToolTip = 'Specifies the value of the Row Text field.';
                }
                field("Item/Activity"; Rec."Item/Activity")
                {
                    Caption = 'Item/Activity';
                    ToolTip = 'Specifies the value of the Item/Activity field.';
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    ToolTip = 'Specifies the value of the Weight field.';
                }
                field(Measure; Rec.Measure)
                {
                    Caption = 'Measure';
                    ToolTip = 'Specifies the value of the Measure field.';
                }
                field("Annual Target"; Rec."Annual Target")
                {
                    Caption = 'Annual Target';
                    ToolTip = 'Specifies the value of the Annual Target field.';
                }
                field("Specific Indicator Components"; Rec."Specific Indicator Components")
                {
                    Caption = 'Specific Indicator Components';
                    ToolTip = 'Specifies the value of the Specific Indicator Components field.';
                }
                field(Evidence; Rec.Evidence)
                {
                    Caption = 'Evidence';
                    ToolTip = 'Specifies the value of the Evidence field.';
                }
                field(Department; Rec.Department)
                {
                    Caption = 'Department';
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Resource; Rec.Resource)
                {
                    Caption = 'Resource';
                    ToolTip = 'Specifies the value of the Resource field.';
                }
                field("Quarter 1 Target"; Rec."Quarter 1 Target")
                {
                    Caption = 'Quarter 1 Target';
                    ToolTip = 'Specifies the value of the Quarter 1 Target field.';
                }
                field("Quarter 1 Actual"; Rec."Quarter 1 Actual")
                {
                    Caption = 'Quarter 1 Actual';
                    ToolTip = 'Specifies the value of the Quarter 1 Actual field.';
                }
                field("Quarter 2 Target"; Rec."Quarter 2 Target")
                {
                    Caption = 'Quarter 2 Target';
                    ToolTip = 'Specifies the value of the Quarter 2 Target field.';
                }
                field("Quarter 2 Actual"; Rec."Quarter 2 Actual")
                {
                    Caption = 'Quarter 2 Actual';
                    ToolTip = 'Specifies the value of the Quarter 2 Actual field.';
                }
                field("Quarter 3 Target"; Rec."Quarter 3 Target")
                {
                    Caption = 'Quarter 3 Target';
                    ToolTip = 'Specifies the value of the Quarter 3 Target field.';
                }
                field("Quarter 3 Actual"; Rec."Quarter 3 Actual")
                {
                    Caption = 'Quarter 3 Actual';
                    ToolTip = 'Specifies the value of the Quarter 3 Actual field.';
                }
                field("Quarter 4 Target"; Rec."Quarter 4 Target")
                {
                    Caption = 'Quarter 4 Target';
                    ToolTip = 'Specifies the value of the Quarter 4 Target field.';
                }
                field("Quarter 4 Actual"; Rec."Quarter 4 Actual")
                {
                    Caption = 'Quarter 4 Actual';
                    ToolTip = 'Specifies the value of the Quarter 4 Actual field.';
                }
                field("Total Quarter Target"; Rec."Total Quarter Target")
                {
                    Caption = 'Total Quarter Target';
                    ToolTip = 'Specifies the value of the Total Quarter Target field.';
                }
                field("Total Quarter Actual"; Rec."Total Quarter Actual")
                {
                    Caption = 'Total Quarter Actual';
                    ToolTip = 'Specifies the value of the Total Quarter Actual field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Remarks';
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(Submitted; Rec.Submitted)
                {
                    Caption = 'Submitted';
                    ToolTip = 'Specifies the value of the Submitted field.';
                }
                field(Heading; Rec.Heading)
                {
                    Caption = 'Heading';
                    ToolTip = 'Specifies the value of the Heading field.';
                }
                field(Class; Rec.Class)
                {
                    Caption = 'Class';
                    ToolTip = 'Specifies the value of the Class field.';
                }
                field("Totaling Type"; Rec."Totaling Type")
                {
                    Caption = 'Totaling Type';
                    ToolTip = 'Specifies the value of the Totaling Type field.';
                }
                field(Totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                    ToolTip = 'Specifies the value of the Totaling field.';
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
                Caption = 'Action18';
                action("Perfm. Contracting Comment")
                {
                    Caption = 'Perfm. Contracting Comment';
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

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        Rec.SetFilter("User ID", UserId);
        /*FILTERGROUP(2);
        SETFILTER("User ID Filter", USERID);*/

    end;
}

