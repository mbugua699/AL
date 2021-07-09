report 50055 "Bank Balances At Date"
{
    // version NRCS12.01

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Bank Balances At Date.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            DataItemTableView = SORTING("Bank Acc. Posting Group");
            RequestFilterFields = "Bank Acc. Posting Group", "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(OpeningBalanceDate; OpeningBalanceDate)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(ClosingBalanceDate; ClosingBalanceDate)
            {
            }
            column(Bank_Account__Bank_Acc__Posting_Group_; "Bank Acc. Posting Group")
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account_Name; Name)
            {
            }
            column(Bank_Account__Currency_Code_; "Currency Code")
            {
            }
            column(OpeningBalance; OpeningBalance)
            {
            }
            column(NetChange; NetChange)
            {
            }
            column(ClosingBalance; ClosingBalance)
            {
            }
            column(ClosingBalance_Control1102750011; ClosingBalance)
            {
            }
            column(NetChange_Control1102750012; NetChange)
            {
            }
            column(OpeningBalance_Control1102750013; OpeningBalance)
            {
            }
            column(Bank_Account_Name_Control1102750015; Name)
            {
            }
            column(Bank_Account__No___Control1102750016; "No.")
            {
            }
            column(TotalFor___FIELDCAPTION__Bank_Acc__Posting_Group__; TotalFor + FIELDCAPTION("Bank Acc. Posting Group"))
            {
            }
            column(OpeningBalanceGroupTotal; OpeningBalanceGroupTotal)
            {
            }
            column(NetChangeGroupTotal; NetChangeGroupTotal)
            {
            }
            column(ClosingBalanceGroupTotal; ClosingBalanceGroupTotal)
            {
            }
            column(TotalAll; TotalAll)
            {
            }
            column(ClosingBalanceTotal; ClosingBalanceTotal)
            {
            }
            column(NetChangeTotal; NetChangeTotal)
            {
            }
            column(OpeningBalanceTotal; OpeningBalanceTotal)
            {
            }
            column(Bank_Account_BalancesCaption; Bank_Account_BalancesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Bank_Account_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Bank_Account__Currency_Code_Caption; FIELDCAPTION("Currency Code"))
            {
            }
            column(OpeningBalanceCaption; OpeningBalanceCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(ClosingBalanceCaption; ClosingBalanceCaptionLbl)
            {
            }
            column(Bank_Account__Bank_Acc__Posting_Group_Caption; FIELDCAPTION("Bank Acc. Posting Group"))
            {
            }

            trigger OnAfterGetRecord();
            begin
                if ("Bank Acc. Posting Group" <> PrvGroup) then begin
                    OpeningBalanceGroupTotal := 0;
                    NetChangeGroupTotal := 0;
                    ClosingBalanceGroupTotal := 0;
                    PrvGroup := "Bank Acc. Posting Group";
                end;

                if ShowLCY then begin
                    CALCFIELDS("Net Change (LCY)", "Balance at Date (LCY)");
                    NetChange := "Net Change (LCY)";
                    ClosingBalance := "Balance at Date (LCY)"
                end else begin
                    CALCFIELDS("Net Change", "Balance at Date");
                    NetChange := "Net Change";
                    ClosingBalance := "Balance at Date"
                end;

                OpeningBankAccount."No." := "No.";
                if ShowLCY then begin
                    OpeningBankAccount.CALCFIELDS("Balance at Date (LCY)");
                    OpeningBalance := OpeningBankAccount."Balance at Date (LCY)";
                end else begin
                    OpeningBankAccount.CALCFIELDS("Balance at Date");
                    OpeningBalance := OpeningBankAccount."Balance at Date";
                end;

                OpeningBalanceGroupTotal += OpeningBalance;
                NetChangeGroupTotal += NetChange;
                ClosingBalanceGroupTotal += ClosingBalance;
                OpeningBalanceTotal += OpeningBalance;
                NetChangeTotal += NetChange;
                ClosingBalanceTotal += ClosingBalance;
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("Bank Acc. Posting Group");
            end;
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

    labels
    {
    }

    trigger OnPreReport();
    begin
        BankAccountFilter := "Bank Account".GETFILTERS;
        PeriodText := "Bank Account".GETFILTER("Date Filter");
        if (PeriodText = '') then
            ERROR(TEXT100);

        OpeningBalanceDate := CALCDATE('-1D', "Bank Account".GETRANGEMIN("Date Filter"));
        ClosingBalanceDate := "Bank Account".GETRANGEMAX("Date Filter");

        OpeningBankAccount.COPY("Bank Account");
        OpeningBankAccount.SETFILTER("Date Filter", '%1', OpeningBalanceDate);
    end;

    var
        TotalFor: Label '"Total for "';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        OpeningBalanceDate: Date;
        ClosingBalanceDate: Date;
        PeriodText: Text[50];
        TotalAll: Label 'Total all accounts';
        TEXT001: Label 'Bank Account balances as per %1';
        TEXT100: Label 'Please enter Date Filter';
        BankAccountFilter: Text[250];
        OpeningBankAccount: Record "Bank Account";
        OpeningBalance: Decimal;
        OpeningBalanceGroupTotal: Decimal;
        OpeningBalanceTotal: Decimal;
        NetChange: Decimal;
        NetChangeGroupTotal: Decimal;
        NetChangeTotal: Decimal;
        ClosingBalance: Decimal;
        ClosingBalanceGroupTotal: Decimal;
        ClosingBalanceTotal: Decimal;
        ShowLCY: Boolean;
        PrvGroup: Code[10];
        Bank_Account_BalancesCaptionLbl: TextConst ENU = 'Bank Account Balances', FRA = 'Compte bancaire';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        OpeningBalanceCaptionLbl: Label 'Opening Balance';
        NetChangeCaptionLbl: Label 'Period';
        ClosingBalanceCaptionLbl: TextConst ENU = 'Closing Balance', FRA = 'Solde au (DS)';
}

