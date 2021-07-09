tableextension 50018 "Extends Gen. Journal Batch" extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; "Validate Batch"; Boolean)
        {
            DataClassification = ToBeClassified;
        } // Add changes to table fields here
    }

    var
        myInt: Integer;
}