xmlport 50000 Table17
{

    schema
    {
        textelement(Root)
        {
            tableelement(glentrytemp; "G/L Entry")
            {
                AutoUpdate = true;
                Autosave = true;
                XmlName = 'GLEntry';
                fieldelement(EntryNo; GLEntryTemp."Entry No.")
                {
                }
                fieldelement(GLAccNo; GLEntryTemp."G/L Account No.")
                {
                }
                fieldelement(Recipient; GLEntryTemp.Recipient)
                {
                }
                fieldelement(NoOfunit; GLEntryTemp."No. of Units")
                {
                }
                fieldelement(Unitofmeasure; GLEntryTemp."Unit of Measure")
                {
                }
                fieldelement(Amtcorrected; GLEntryTemp."Add.-Curr. Amount Corrected")
                {
                }
                fieldelement(Dimension3; GLEntryTemp."Global Dimension 1 Code")
                {
                }
                fieldelement(Dimension4; GLEntryTemp."ShortCut Dimension 3 code")
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

    var
        GLEntry: Record "G/L Entry";
}

