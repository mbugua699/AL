pageextension 50020 "Extend Bank Acc. Reconc List" extends "Bank Acc. Reconciliation List"
{
    layout
    {
        addafter(StatementEndingBalance)
        {
            field("Start Date"; "Start Date")
            {
                ApplicationArea = all;
            }

            field("End Date"; "End Date")
            {
                ApplicationArea = all;
            }

        }

    }
}