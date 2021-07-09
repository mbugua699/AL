xmlport 50002 Table21
{

    schema
    {
        textelement(Root)
        {
            tableelement("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                AutoUpdate = true;
                XmlName = 'CustLedgerEntry';
                fieldelement(EntryNo; "Cust. Ledger Entry"."Entry No.")
                {
                }
                fieldelement(Dimension3; "Cust. Ledger Entry"."Global Dimension 1 Code")
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

