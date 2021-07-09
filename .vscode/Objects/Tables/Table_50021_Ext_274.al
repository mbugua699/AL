tableextension 50021 "Extends Bank Acc. Rec Line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(64070; Include; Boolean)
        {
            DataClassification = ToBeClassified;
        } // Add changes to table fields here
    }

    var
        myInt: Integer;
}