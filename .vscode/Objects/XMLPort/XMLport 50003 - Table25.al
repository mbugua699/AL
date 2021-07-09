xmlport 50003 Table25
{

    schema
    {
        textelement(Root)
        {
            tableelement("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                AutoUpdate = true;
                XmlName = 'VendLedgEntry';
                fieldelement(EntryNo; "Vendor Ledger Entry"."Entry No.")
                {
                }
                fieldelement(Dimension3; "Vendor Ledger Entry"."Global Dimension 1 Code")
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

