tableextension 50020 "Extends Bank Acc. Rec" extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(50000; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }// Add changes to table fields here
    }

    var
        myInt: Integer;
}