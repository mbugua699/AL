pageextension 50018 "Extend General Journal Batches" extends "General Journal Batches"
{
    layout
    {
        addafter("Bank Statement Import Format")
        {
            field("Validate Batch"; "Validate Batch")
            {
                ApplicationArea = all;
            }



        }

    }
}