xmlport 50005 Table81
{

    schema
    {
        textelement(Root)
        {
            tableelement(genjnllinetemp; "Gen. Journal Line")
            {
                XmlName = 'GenJnlLineTemp';
                UseTemporary = true;
                fieldelement(JTemplateName; GenJnlLineTemp."Journal Template Name")
                {
                }
                fieldelement(JBatchName; GenJnlLineTemp."Journal Batch Name")
                {
                }
                fieldelement(LineNo; GenJnlLineTemp."Line No.")
                {
                }
                fieldelement(Recipient; GenJnlLineTemp.Recipient)
                {
                }
                fieldelement(NoOfUnit; GenJnlLineTemp."No. of Units")
                {
                }
                fieldelement(UnitOfMe; GenJnlLineTemp."Unit of Measure")
                {
                }
                fieldelement(Importfrmb; GenJnlLineTemp."Import From Branches")
                {
                }
                fieldelement(ImportErrDes; GenJnlLineTemp."Import Error Description")
                {
                }
                fieldelement(EmployeNos; GenJnlLineTemp."Employee No")
                {
                }
                fieldelement(Dimens3; GenJnlLineTemp."Shortcut Dimension 1 Code")
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
        if GenJnlLineTemp.FINDSET then
            repeat
                if GenJnlLine.GET(GenJnlLineTemp."Journal Template Name", GenJnlLineTemp."Journal Batch Name", GenJnlLineTemp."Line No.") then begin
                    GenJnlLine.TRANSFERFIELDS(GenJnlLineTemp);
                    GenJnlLine.MODIFY;
                end else begin
                    GenJnlLine.COPY(GenJnlLineTemp);
                    GenJnlLine.INSERT;
                end;
            until GenJnlLineTemp.NEXT = 0;
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
}

