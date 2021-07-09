xmlport 50010 Table274
{

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Acc. Reconciliation Line";"Bank Acc. Reconciliation Line")
            {
                AutoUpdate = true;
                XmlName = 'BankAccRecLine';
                fieldelement(BankaccNo;"Bank Acc. Reconciliation Line"."Bank Account No.")
                {
                }
                fieldelement(StatementNo;"Bank Acc. Reconciliation Line"."Statement No.")
                {
                }
                fieldelement(StatementLineno;"Bank Acc. Reconciliation Line"."Statement Line No.")
                {
                }
                fieldelement(Include;"Bank Acc. Reconciliation Line".Include)
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

