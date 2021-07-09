xmlport 50001 Table15
{

    schema
    {
        textelement(Root)
        {
            tableelement(glaccounttemp; "G/L Account")
            {
                AutoUpdate = true;
                XmlName = 'GLAccountTemp';
                fieldelement(Nos; GLAccountTemp."No.")
                {
                }
                fieldelement(Dimesnion3; GLAccountTemp."Global Dimension 1 Code")
                {
                }
                fieldelement(BudgetAMt; GLAccountTemp."Budgeted Amount Add. Curr")
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

    trigger OnPostXmlPort();
    begin
        if GLAccountTemp.FINDSET then
            repeat
                if GLAccount.GET(GLAccountTemp."No.") then begin
                    GLAccount.TRANSFERFIELDS(GLAccountTemp);
                    GLAccount.MODIFY;
                end else begin
                    GLAccount.COPY(GLAccountTemp);
                    GLAccount.INSERT;
                end;
            until GLAccountTemp.NEXT = 0;
    end;

    var
        GLAccount: Record "G/L Account";
}

