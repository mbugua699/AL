pageextension 50021 "Extend Bank Acc. Reconc Lines" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addafter("Applied Amount")
        {
            field(Include; Include)
            {
                ApplicationArea = all;
            }



        }

    }
}