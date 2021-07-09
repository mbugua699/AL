report 50056 "Trial Balance Movements"
{

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Trial Balance Movements.rdl';
    CaptionML = ENU = 'Trial Balance Movements',
                FRA = 'Balance';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; "G/L Account".TABLECAPTION + ': ' + GLFilter)
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
            column(Trial_Balance_MovementsCaption; Trial_Balance_MovementsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FIELDCAPTION("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
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
            column(G_L_Account_No_; "No.")
            {
            }
            dataitem(BlankLineCounter; "Integer")
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem();
                begin
                    SETRANGE(Number, 1, "G/L Account"."No. of Blank Lines");
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
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
                column(G_L_Account___No___Control25; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2_____G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(ClosingBalance_Control1000000004; ClosingBalance)
                {
                }
                column(NetChange_Control1000000005; NetChange)
                {
                }
                column(OpeningBalance_Control1000000006; OpeningBalance)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                CALCFIELDS("Net Change", "Balance at Date");
                NetChange := "Net Change";
                ClosingBalance := "Balance at Date";

                OpeningGLAccount."No." := "No.";
                OpeningGLAccount.Totaling := Totaling;
                OpeningGLAccount.CALCFIELDS("Balance at Date");
                OpeningBalance := OpeningGLAccount."Balance at Date";

                if PrintToExcel then
                    MakeExcelDataBody;
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

    trigger OnPostReport();
    begin
        if PrintToExcel then
            CreateExcelbook;
    end;

    trigger OnPreReport();
    begin
        GLFilter := "G/L Account".GETFILTERS;
        PeriodText := "G/L Account".GETFILTER("Date Filter");
        if (PeriodText = '') then
            ERROR(TEXT100);

        OpeningBalanceDate := CALCDATE('-1D', "G/L Account".GETRANGEMIN("Date Filter"));
        ClosingBalanceDate := "G/L Account".GETRANGEMAX("Date Filter");

        OpeningGLAccount.COPY("G/L Account");
        OpeningGLAccount.SETFILTER("Date Filter", '%1', OpeningBalanceDate);

        if PrintToExcel then
            MakeExcelInfo;
    end;

    var
        xText000: TextConst ENU = 'Period: %1', FRA = 'P´Š¢riode : %1';
        ExcelBuf: Record "Excel Buffer" temporary;
        GLFilter: Text[250];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        Text001: TextConst ENU = 'Trial Balance', FRA = 'Balance';
        Text002: TextConst ENU = 'Data', FRA = 'Donn´Š¢es';
        Text003: TextConst ENU = 'Debit', FRA = 'D´Š¢bit';
        Text004: TextConst ENU = 'Credit', FRA = 'Cr´Š¢dit';
        Text005: TextConst ENU = 'Company Name', FRA = 'Nom de la soci´Š¢t´Š¢';
        Text006: TextConst ENU = 'Report No.', FRA = 'N´Š¢ ´Š¢tat';
        Text007: TextConst ENU = 'Report Name', FRA = 'Nom ´Š¢tat';
        Text008: TextConst ENU = 'User ID', FRA = 'Code utilisateur';
        Text009: TextConst ENU = 'Date', FRA = 'Date';
        Text010: TextConst ENU = 'G/L Filter', FRA = 'Filtre comptabilit´Š¢';
        CurrFormat: Text[30];
        Text011: TextConst ENU = 'Period Filter', FRA = 'Filtre p´Š¢riode';
        OpeningBalance: Decimal;
        NetChange: Decimal;
        ClosingBalance: Decimal;
        OpeningGLAccount: Record "G/L Account";
        OpeningBalanceDate: Date;
        TEXT100: Label 'Please enter Date Filter';
        ClosingBalanceDate: Date;
        Trial_Balance_MovementsCaptionLbl: TextConst ENU = 'Trial Balance Movements', FRA = 'Balance';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: TextConst ENU = 'Name', FRA = 'Nom';
        OpeningBalanceCaptionLbl: TextConst ENU = 'Opening Balance', FRA = 'D´Š¢bit';
        NetChangeCaptionLbl: TextConst ENU = 'Period', FRA = 'D´Š¢bit';
        ClosingBalanceCaptionLbl: TextConst ENU = 'Closing Balance', FRA = 'D´Š¢bit';

    procedure MakeExcelInfo();
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyName, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Company Name
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Report Name
        ExcelBuf.AddInfoColumn(FORMAT(Text001), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number); //Title
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //UserID
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date); //Date

        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."), false, false, false, false, '', ExcelBuf."Cell Type"::Text); //Filterstring
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //Text109 = 'Aged by'
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"), false, false, false, false, '', ExcelBuf."Cell Type"::Text); //Date Title
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    Local procedure MakeExcelDataHeader();
    begin
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Opening Balance', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Period', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Closing Balance', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody();
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          "G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
          false, false, '', ExcelBuf."Cell Type"::Text);
        if "G/L Account".Indentation = 0 then
            ExcelBuf.AddColumn(
            "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
            false, false, '@', ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn(
                   COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
              false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '@', ExcelBuf."Cell Type"::Text);





    end;

    procedure CreateExcelbook();
    begin
        // ExcelBuf.CreateBook;
        // ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        // ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

