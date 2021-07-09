xmlport 50008 Table242
{

    schema
    {
        textelement(Root)
        {
            tableelement("Source Code Setup";"Source Code Setup")
            {
                AutoUpdate = true;
                XmlName = 'SrcCodeSetup';
                fieldelement(PrimaryKey;"Source Code Setup"."Primary Key")
                {
                }
                fieldelement(BranchJnl;"Source Code Setup"."Branch Journal")
                {
                }
                fieldelement(PayrollJnl;"Source Code Setup"."Payroll Journal")
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

