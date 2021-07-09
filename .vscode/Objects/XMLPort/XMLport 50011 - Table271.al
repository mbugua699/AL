xmlport 50011 Table271
{

    schema
    {
        textelement(Root)
        {
            tableelement("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                AutoUpdate = true;
                XmlName = 'BankAccLed';
                fieldelement(EntryNo; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                fieldelement(Dimension3; "Bank Account Ledger Entry"."Global Dimension 1 Code")
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

