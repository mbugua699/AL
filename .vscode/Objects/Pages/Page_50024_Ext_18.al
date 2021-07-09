pageextension 50022 "Extend G/L Account List" extends "G/L Account List"
{
    layout
    {
        addafter("Reconciliation Account")
        {
            field("Budgeted Amount Add. Curr"; "Budgeted Amount Add. Curr")
            {
                ApplicationArea = all;
            }



        }

    }
}