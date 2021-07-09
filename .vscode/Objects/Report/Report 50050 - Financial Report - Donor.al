report 50050 "Financial Report - Donor"
{
    // version ktm

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Financial Report - Donor.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING(Code, "Global Dimension No.") ORDER(Ascending) WHERE("Global Dimension No." = CONST(3));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Date Filter", "Donor Filter", "Project Filter", "Budget Filter";
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
            column(DonorName; DonorName)
            {
            }
            column(FilterDate; FilterDate)
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(MyCurrency_; MyCurrency)
            {
            }
            column(STRSUBSTNO___1___2__PeriodStartDate_PeriodEndDate_; STRSUBSTNO('%1..%2', PeriodStartDate, PeriodEndDate))
            {
            }
            column(STRSUBSTNO___1___2__FinYearStartDate_PeriodEndDate_; STRSUBSTNO('%1..%2', FinYearStartDate, PeriodEndDate))
            {
            }
            column(Dimension_Value_Code; Code)
            {
            }
            column(Dimension_Value_Name; Name)
            {
            }
            column(PercentYTD; PercentYTD)
            {
            }
            column(GT_BudgetYTD___GT_ActualYTD; GT_BudgetYTD - GT_ActualYTD)
            {
            }
            column(GT_ActualYTD; GT_ActualYTD)
            {
            }
            column(GT_BudgetYTD; GT_BudgetYTD)
            {
            }
            column(TotalPercentPeriodTotal; PercentPeriodTotal)
            {
            }
            column(TotalPercentYTDGL; PercentYTDTotal)
            {
            }
            column(GT_BudgetPeriod_GT_ActualPeriod; GT_BudgetPeriod - GT_ActualPeriod)
            {
            }
            column(GT_ActualPeriod; GT_ActualPeriod)
            {
            }
            column(GT_BudgetPeriod; GT_BudgetPeriod)
            {
            }
            column(FINANCIAL_REPORTCaption; FINANCIAL_REPORTCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Donor_Filter__Caption; Donor_Filter__CaptionLbl)
            {
            }
            column(Project_Filter__Caption; Project_Filter__CaptionLbl)
            {
            }
            column(Date_Filter__Caption; Date_Filter__CaptionLbl)
            {
            }
            column(Currency_Code_Caption; Currency_Code_CaptionLbl)
            {
            }
            column(Dimension_Value_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(G_L_Account__No__Caption; "G/L Account".FIELDCAPTION("No."))
            {
            }
            column(Budget_Caption; Budget_CaptionLbl)
            {
            }
            column(ActualCaption; ActualCaptionLbl)
            {
            }
            column(VarianceCaption; VarianceCaptionLbl)
            {
            }
            column(Budget_Caption_Control1000000009; Budget_Caption_Control1000000009Lbl)
            {
            }
            column(Actual_Caption; Actual_CaptionLbl)
            {
            }
            column(Var__Caption; Var__CaptionLbl)
            {
            }
            column(VarianceCaption_Control1000000027; VarianceCaption_Control1000000027Lbl)
            {
            }
            column(Var__Caption_Control1000000028; Var__Caption_Control1000000028Lbl)
            {
            }
            column(PERIOD__________________________________________Caption; PERIOD__________________________________________CaptionLbl)
            {
            }
            column(YEAR_TO_DATE_______________________________________Caption; YEAR_TO_DATE_______________________________________CaptionLbl)
            {
            }
            column(GRAND_TOTALSCaption; GRAND_TOTALSCaptionLbl)
            {
            }
            column(Dimension_Value_Dimension_Code; "Dimension Code")
            {
            }
            dataitem("G/L Account"; "G/L Account")
            {
                DataItemLink = "Shortcut Dimension 4 Filter" = FIELD(Code);
                DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Account Type" = CONST(Posting));
                column(G_L_Account__No__; "No.")
                {
                }
                column(G_L_Account_Name; Name)
                {
                }
                column(G_L_Account__Budgeted_Amount_; "Budgeted Amount." / ExchangeRateAmt)
                {
                }
                column(G_L_Account__Net_Change_; "Net Change." / ExchangeRateAmt)
                {
                }
                column(Budgeted_Amount___Net_Change_; ("Budgeted Amount." - "Net Change.") / ExchangeRateAmt)
                {
                }
                column(BudgetYTD; BudgetYTD)
                {
                }
                column(ActualYTD; ActualYTD)
                {
                }
                column(BudgetYTD_ActualYTD; BudgetYTD - ActualYTD)
                {
                }
                column(PercentYTD_Control1000000024; PercentYTDGL)
                {
                }
                column(PercentPeriod_Control1000000025; PercentPeriodGL)
                {
                }
                column(T_BudgetPeriod; T_BudgetPeriod)
                {
                }
                column(T_ActualPeriod; T_ActualPeriod)
                {
                }
                column(T_BudgetPeriod_T_ActualPeriod; T_BudgetPeriod - T_ActualPeriod)
                {
                }
                column(T_BudgetYTD; T_BudgetYTD)
                {
                }
                column(T_ActualYTD; T_ActualYTD)
                {
                }
                column(Total_____Dimension_Value__Name; 'Total ' + "Dimension Value".Name)
                {
                }
                column(T_BudgetYTD___T_ActualYTD; T_BudgetYTD - T_ActualYTD)
                {
                }
                column(PercentPeriod_Control1000000032; PercentPeriodGL)
                {
                }
                column(PercentYTD_Control1000000035; PercentYTDGL)
                {
                }
                column(G_L_Account_Global_Dimension_1_Filter; "Shortcut Dimension 4 Filter")
                {
                }

                trigger OnAfterGetRecord();
                var
                    CurrencyExchangeRate: Record "Currency Exchange Rate";
                begin

                    SETFILTER("Budget Filter", FilterBudget);
                    SETFILTER("Date Filter", '%1..%2', PeriodStartDate, PeriodEndDate);
                    SETFILTER("Shortcut Dimension 4 Filter", FilterDonor);
                    SETFILTER("Global Dimension 2 Filter", FilterProject);
                    CALCFIELDS("G/L Account"."Budgeted Amount.", "G/L Account"."Net Change.", "G/L Account"."Budgeted Amount Add. Curr", "G/L Account"."Additional-Currency Net Chang.");

                    // if ShowAdditionalCurrency and (CurrencySelected = '') then begin
                    //     GLAccRec.COPY("G/L Account");
                    //     GLAccRec.SETFILTER("Date Filter", '%1..%2', FinYearStartDate, PeriodEndDate);
                    //     GLAccRec.CALCFIELDS("Budgeted Amount Add. Curr", "Additional-Currency Net Chang.");
                    //     BudgetYTD := GLAccRec."Budgeted Amount Add. Curr";
                    //     ActualYTD := GLAccRec."Additional-Currency Net Chang.";

                    //     Error('Here 1');

                    //     Show := ("G/L Account"."Budgeted Amount Add. Curr" <> 0)
                    //             or ("G/L Account"."Additional-Currency Net Chang." <> 0)
                    //             or (BudgetYTD <> 0)
                    //             or (ActualYTD <> 0);
                    //     if not Show then
                    //         CurrReport.SKIP;

                    //     T_ActualPeriod += "Additional-Currency Net Chang.";
                    //     T_BudgetPeriod += "Budgeted Amount Add. Curr";
                    //     T_ActualYTD += ActualYTD;
                    //     T_BudgetYTD += BudgetYTD;

                    //     PercentPeriodGL := CalcVariancePct("Additional-Currency Net Chang.", "Budgeted Amount Add. Curr");
                    //     PercentYTDGL := CalcVariancePct(ActualYTD, BudgetYTD);

                    // end else
                    //     If (NOT ShowAdditionalCurrency) and (CurrencySelected = '') THEN BEGIN
                    //Error('Here 2');
                    GLAccRec.COPY("G/L Account");
                    GLAccRec.SETFILTER("Date Filter", '%1..%2', FinYearStartDate, PeriodEndDate);
                    GLAccRec.CALCFIELDS("Budgeted Amount", "Net Change");
                    BudgetYTD := GLAccRec."Budgeted Amount";
                    ActualYTD := GLAccRec."Net Change";
                    Error('BudgetYTD %1', BudgetYTD);

                    Show := ("G/L Account"."Budgeted Amount" <> 0)
                            OR ("G/L Account"."Net Change" <> 0)
                            OR (BudgetYTD <> 0)
                            OR (ActualYTD <> 0);
                    IF NOT Show THEN
                        CurrReport.SKIP;

                    T_ActualPeriod += "Net Change";
                    T_BudgetPeriod += "Budgeted Amount";
                    T_ActualYTD += ActualYTD;
                    T_BudgetYTD += BudgetYTD;

                    // end else begin
                    //     //divide currencies
                    //     CurrencyRec.Get(CurrencySelected);
                    //     CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencySelected);
                    //     CurrencyExchangeRate.GetLastestExchangeRate(CurrencySelected, ExchangeRateDate, ExchangeRateAmt);

                    //     Error('Here 3');
                    //     GLAccRec.COPY("G/L Account");
                    //     GLAccRec.SETFILTER("Date Filter", '%1..%2', FinYearStartDate, PeriodEndDate);
                    //     GLAccRec.CALCFIELDS("Budgeted Amount.", "Net Change.");
                    //     BudgetYTD := GLAccRec."Budgeted Amount." / ExchangeRateAmt;
                    //     ActualYTD := GLAccRec."Net Change." / ExchangeRateAmt;

                    //     Show := ("G/L Account"."Budgeted Amount." <> 0)
                    //             or ("G/L Account"."Net Change." <> 0)
                    //             or (BudgetYTD <> 0)
                    //             or (ActualYTD <> 0);
                    //     if not Show then
                    //         CurrReport.SKIP;

                    //     T_ActualPeriod += "Net Change." / ExchangeRateAmt;
                    //     T_BudgetPeriod += "Budgeted Amount." / ExchangeRateAmt;
                    //     T_ActualYTD += ActualYTD;
                    //     T_BudgetYTD += BudgetYTD;

                    //     PercentPeriodGL := CalcVariancePct("Net Change.", "Budgeted Amount.");
                    //     PercentYTDGL := CalcVariancePct(ActualYTD, BudgetYTD);

                    // end;

                end;

                trigger OnPostDataItem();
                begin
                    GT_ActualPeriod += T_ActualPeriod;
                    GT_BudgetPeriod += T_BudgetPeriod;
                    GT_ActualYTD += T_ActualYTD;
                    GT_BudgetYTD += T_BudgetYTD;
                end;

                trigger OnPreDataItem();
                begin
                    SETFILTER("No.", ExpenseACFilter);
                    T_ActualPeriod := 0;
                    T_BudgetPeriod := 0;
                    T_ActualYTD := 0;
                    T_BudgetYTD := 0;
                    CountRec := 0;
                end;
            }


        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)

                {
                    Caption = 'Options';

                    field(ShowAdditionalCurrency; ShowAdditionalCurrency)
                    {
                        Caption = 'Show Additional Currency';
                    }
                    field(CurrencySelected; CurrencySelected)
                    {
                        Caption = 'Currency';
                        TableRelation = Currency.Code;

                    }

                }
            }


        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ShowAdditionalCurrency := false;
            CurrencySelected := '';
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        FilterDate := "Dimension Value".GETFILTER("Dimension Value"."Date Filter");
        FilterDonor := "Dimension Value".GETFILTER("Dimension Value"."Donor Filter");
        FilterProject := "Dimension Value".GETFILTER("Dimension Value"."Project Filter");
        FilterBudget := "Dimension Value".GETFILTER("Dimension Value"."Budget Filter");

        if (FilterDate = '') then
            ERROR(ERR_FILTER_DATE);
        PeriodStartDate := "Dimension Value".GETRANGEMIN("Date Filter");
        PeriodEndDate := "Dimension Value".GETRANGEMAX("Date Filter");
        FinYearStartDate := GetFinYearStartDate(PeriodStartDate);

        if DimVal.GET('DONOR', FilterDonor) then
            DonorName := DimVal.Name;

        if DimVal.GET('PROJECT', FilterProject) then
            ProjectName := DimVal.Name;

        GLSetup.GET();
        MyCurrency := GLSetup."LCY Code";
        ExpenseACFilter := GLSetup."Expense A/C Filter";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShowAdditionalCurrency: Boolean;
        MyCurrency: Code[10];
        CurrencyFactor: Decimal;
        ExchangerateAmt: Decimal;
        ExchangerateDate: Date;
        ExpenseACFilter: Text[100];
        PercentYTD: Decimal;

        CurrencyRec: Record Currency;
        PercentPeriod: Decimal;
        BudgetYTD: Decimal;
        ActualYTD: Decimal;
        Show: Boolean;
        GLAccRec: Record "G/L Account";
        FinYearStartDate: Date;
        PeriodEndDate: Date;
        PeriodStartDate: Date;
        T_ActualPeriod: Decimal;
        T_BudgetPeriod: Decimal;
        T_ActualYTD: Decimal;
        T_BudgetYTD: Decimal;
        GT_ActualPeriod: Decimal;
        GT_BudgetPeriod: Decimal;
        GT_ActualYTD: Decimal;
        GT_BudgetYTD: Decimal;
        FilterDonor: Text[30];
        FilterProject: Text[30];
        FilterActivity: Text[30];
        FilterBudget: Text[30];
        FilterDate: Text[30];
        DonorName: Text[50];
        ProjectName: Text[50];
        DimVal: Record "Dimension Value";
        ERR_FILTER_DATE: Label 'Please specify Date Filter.';
        ERR_FIN_YEAR: Label 'There is no financial year defined for %1.';
        FINANCIAL_REPORTCaptionLbl: Label 'FINANCIAL REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Donor_Filter__CaptionLbl: Label 'Donor Filter :';
        Project_Filter__CaptionLbl: Label 'Project Filter :';
        Date_Filter__CaptionLbl: Label 'Date Filter :';
        Currency_Code_CaptionLbl: Label 'Currency Code:';
        Budget_CaptionLbl: Label '"Budget "';
        ActualCaptionLbl: Label 'Actual';
        VarianceCaptionLbl: Label 'Variance';
        Budget_Caption_Control1000000009Lbl: Label '"Budget "';
        Actual_CaptionLbl: Label '"Actual "';
        Var__CaptionLbl: Label 'Var %';
        VarianceCaption_Control1000000027Lbl: Label 'Variance';
        Var__Caption_Control1000000028Lbl: Label 'Var %';
        PERIOD__________________________________________CaptionLbl: Label '------------------------------------------PERIOD------------------------------------------';
        YEAR_TO_DATE_______________________________________CaptionLbl: Label '---------------------------------------YEAR TO DATE---------------------------------------';
        GRAND_TOTALSCaptionLbl: Label 'GRAND TOTALS';
        PercentPeriodTotal: Decimal;
        PercentYTDTotal: Decimal;
        PercentYTDGL: Decimal;
        PercentPeriodGL: Decimal;
        CountRec: Integer;
        GLAccRec2: Record "G/L Account";

        CurrencySelected: Code[20];

    procedure GetFinYearStartDate(PeriodStartDate: Date): Date;
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.SETFILTER("Starting Date", '<=%1', PeriodStartDate);
        AccountingPeriod.SETRANGE("New Fiscal Year", true);
        if not AccountingPeriod.FINDLAST then
            ERROR(ERR_FIN_YEAR, PeriodStartDate);
        exit(AccountingPeriod."Starting Date");
    end;

    procedure CalcVariancePct(ActualAmount: Decimal; BudgetAmount: Decimal): Decimal;
    begin
        if (BudgetAmount <> 0) then
            exit(ROUND(ActualAmount / BudgetAmount * 100, 0.01))
        else
            exit(-1);
    end;
}

