xmlport 50009 Table273
{

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Acc. Reconciliation";"Bank Acc. Reconciliation")
            {
                AutoUpdate = true;
                XmlName = 'BankAccRecon';
                fieldelement(BankAccNo;"Bank Acc. Reconciliation"."Bank Account No.")
                {
                }
                fieldelement(StatementNo;"Bank Acc. Reconciliation"."Statement No.")
                {
                }
                fieldelement(StartDate;"Bank Acc. Reconciliation"."Start Date")
                {
                }
                fieldelement(EndDate;"Bank Acc. Reconciliation"."End Date")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

