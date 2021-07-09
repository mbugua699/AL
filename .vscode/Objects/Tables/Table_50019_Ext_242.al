/// <summary>
/// TableExtension Extends Source Code Setup (ID 50019) extends Record Source Code Setup.
/// </summary>
tableextension 50019 "Extends Source Code Setup" extends "Source Code Setup"
{
    fields
    {
        field(50000; "Branch Journal"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(50001; "Payroll Journal"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }  // Add changes to table fields here
    }

    var
        myInt: Integer;
}