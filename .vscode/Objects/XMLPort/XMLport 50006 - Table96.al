xmlport 50006 Table96
{

    schema
    {
        textelement(Root)
        {
            tableelement(glbudgentrytemp; "G/L Budget Entry")
            {
                XmlName = 'GlBudgentryTemp';
                UseTemporary = true;
                fieldelement(EntryNo; GlBudgentryTemp."Entry No.")
                {
                }
                fieldelement(BudgetName; GlBudgentryTemp."Budget Name")
                {
                }
                fieldelement(GLAccNo; GlBudgentryTemp."G/L Account No.")
                {
                }
                fieldelement(Date; GlBudgentryTemp.Date)
                {
                }
                fieldelement(GlobalDIM1; GlBudgentryTemp."Global Dimension 1 Code")
                {
                }
                fieldelement(GlobalDIM2; GlBudgentryTemp."Global Dimension 2 Code")
                {
                }
                fieldelement(GlobalDIM3; GlBudgentryTemp."ShortCut Dimension 3 code")
                {
                }
                fieldelement(Amounts; GlBudgentryTemp.Amount)
                {
                }
                fieldelement(Desc; GlBudgentryTemp.Description)
                {
                }

                fieldelement(BusUnit; GlBudgentryTemp."Business Unit Code")
                {
                }
                fieldelement(UserID; GlBudgentryTemp."User ID")
                {
                }
                fieldelement(BDimension1; GlBudgentryTemp."Budget Dimension 1 Code")
                {
                }
                fieldelement(BDimension2; GlBudgentryTemp."Budget Dimension 2 Code")
                {
                }
                fieldelement(BDimension3; GlBudgentryTemp."Budget Dimension 3 Code")
                {
                }
                fieldelement(BDimension4; GlBudgentryTemp."Budget Dimension 4 Code")
                {
                }
                fieldelement(AmtAddCurr; GlBudgentryTemp."Amount Add. Curr")
                {
                }
                fieldelement(CurrCode; GlBudgentryTemp."Currency Code")
                {
                }
                fieldelement(CurrFactor; GlBudgentryTemp."Currency Factor")
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

        if GlBudgentryTemp.FINDSET then
            repeat
                if GlBudgentry.GET(GlBudgentryTemp."Entry No.") then begin
                    GlBudgentry.TRANSFERFIELDS(GlBudgentryTemp);
                    GlBudgentry.MODIFY;
                end else begin
                    GlBudgentry.COPY(GlBudgentryTemp);
                    GlBudgentry.INSERT;
                end;
            until GlBudgentryTemp.NEXT = 0;
    end;

    var
        GlBudgentry: Record "G/L Budget Entry";
}

