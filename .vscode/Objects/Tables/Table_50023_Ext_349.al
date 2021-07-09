/// <summary>
/// TableExtension Extends Dimension Value (ID 50023) extends Record Dimension Value.
/// </summary>
tableextension 50023 "Extends Dimension Value" extends "Dimension Value"
{
    fields
    {
        field(50001; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            //DataClassification = ToBeClassified;
        }
        field(50002; "Budget Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
            //DataClassification = ToBeClassified;
        }
        field(50003; "Project Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            //DataClassification = ToBeClassified;
        }
        field(50006; "Donor Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            //DataClassification = ToBeClassified;
        }// Add 
        field(50010; "Activity Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //DataClassification = ToBeClassified;
        }// Add 
        field(50011; "DonorActivity Filter"; Code[100])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            //DataClassification = ToBeClassified;
        }// Add 
        field(50005; DonorCode; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

        }
        field(50007; DonorActivityCode; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

        }
        field(50008; ActivityCode; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
    }

    var
    //myInt: Integer;
}