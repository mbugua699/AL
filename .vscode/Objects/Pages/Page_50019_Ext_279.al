pageextension 50019 "Extend Source Code Setup" extends "Source Code Setup"
{
    layout
    {
        addafter("Payment Reconciliation Journal")
        {
            field("Branch Journal"; "Branch Journal")
            {
                ApplicationArea = all;
            }

            field("Payroll Journal"; "Payroll Journal")
            {
                ApplicationArea = all;
            }

        }

    }
}