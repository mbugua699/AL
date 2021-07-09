report 50052 "Financial Report - Activity"
{
    // version ktm

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Financial Report - Activity.rdl';
    CaptionML = ENU = 'Financial Report - Activity',
                FRA = 'Rapport financier - Activité';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING(Code, "Global Dimension No.") ORDER(Ascending) WHERE("Global Dimension No." = FILTER(1));
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
            column(Mycurrency_; Mycurrency)
            {
            }
            column(STRSUBSTNO___1___2__minDate_MaxDate_; STRSUBSTNO('%1..%2', minDate, MaxDate))
            {
            }
            column(STRSUBSTNO___1___2__FinStartDate_TODAY_; STRSUBSTNO('%1..%2', FinStartDate, TODAY))
            {
            }
            column(Dimension_Value_Code; Code)
            {
            }
            column(Dimension_Value_Name; Name)
            {
            }
            column(Budget_1___Actual_1; Budget_1 - Actual_1)
            {
            }
            column(Budget_2; Budget_2)
            {
            }
            column(Actual_2; Actual_2)
            {
            }
            column(Budget_2___Actual_2; Budget_2 - Actual_2)
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
            column(PERIOD_______________________________________Caption; PERIOD_______________________________________CaptionLbl)
            {
            }
            column(YEAR_TO_DATE_____________________________Caption; YEAR_TO_DATE_____________________________CaptionLbl)
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
                DataItemLink = "Global Dimension 1 Filter" = FIELD(Code);
                DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Account Type" = CONST(Posting));
                RequestFilterFields = "Budget Filter";
                column(DonorActivity_Code; GL."ShortCut Dimension 3 code")
                {
                }
                column(G_L_Account__No__; "No.")
                {
                }
                column(G_L_Account_Name; Name)
                {
                }
                column(G_L_Account__Budgeted_Amount_; BudgetedAmount)
                {
                }
                column(G_L_Account__Net_Change_; NetChange)
                {
                }
                column(Budgeted_Amount___Net_Change_; BudgetAmtMinusNet)
                {
                }
                column(amount; amount)
                {
                }
                column(BudgetYTD; BudgetYTD)
                {
                }
                column(ActualYTD; ActualYTD)
                {
                }
                column(VarianceYTD; VarianceYTD)
                {
                }
                column(PercentVarianceYTD; PercentVarianceYTD)
                {
                }
                column(PercentYTD; PercentYTD)
                {
                }
                column(Percen; Percen)
                {
                }
                column(Budget_1; Budget_1)
                {
                }
                column(Actual_1; Actual_1)
                {
                }
                column(Variance_1; Variance_1)
                {
                }
                column(G_L_Account__Budgeted_Amount__Control1000000029; BudgetedAmount)
                {
                }
                column(G_L_Account__Net_Change__Control1000000030; NetChange)
                {
                }
                column(Budgeted_Amount___Net_Change__Control1000000031; BudgetAmtMinusNet)
                {
                }
                column(T_BudgetYTD; T_BudgetYTD)
                {
                }
                column(T_ActualYTD; T_ActualYTD)
                {
                }
                column(Total_for_____Dimension_Value__Name; 'Total for ' + "Dimension Value".Name)
                {
                }
                column(T_BudgetYTD___T_ActualYTD; T_BudgetYTD - T_ActualYTD)
                {
                }
                column(TotalAct; TotalAct)
                {
                }
                column(TotalActYTD; TotalActYTD)
                {
                }
                column(TotalVar1; TotalVar1)
                {
                }
                column(TotalVar2; TotalVar2)
                {
                }
                column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
                {
                }
                column(DonorActivity__; DonorActivityCode)
                {
                }
                column(ShowSummary; ShowSummary)
                {

                }

                trigger OnAfterGetRecord();
                var
                    CurrencyExchangeRate: Record "Currency Exchange Rate";
                begin
                    BudgetYTD := 0;
                    ActualYTD := 0;
                    NetChange := 0;
                    VarianceYTD := 0;
                    VariancePTD := 0;
                    PercentVarianceYTD := 0;
                    PercentVariancePTD := 0;
                    PercentVariancePTD := 0;
                    Show := false;
                    ShowSummary := 0;

                    if summary Then
                        ShowSummary := 1;

                    FilterActivity := "Dimension Value".Code;


                    GlACCCopy.COPY("G/L Account");



                    CALCFIELDS("G/L Account"."Budgeted Amount.", "G/L Account"."Additional-Currency Net Chang.", "G/L Account"."Net Change.");

                    VariancePTD := "G/L Account"."Budgeted Amount." - "G/L Account"."Net Change.";

                    if "G/L Account"."Budgeted Amount." <> 0 then
                        PercentVariancePTD := ("G/L Account"."Budgeted Amount." - "G/L Account"."Net Change.") / "G/L Account"."Budgeted Amount." * 100;


                    if ShowAdditionalCurrency and (CurrencySelected = '') then begin

                        NetChange := "Additional-Currency Net Chang.";
                        BudgetedAmount := "Budgeted Amount.";
                        BudgetAmtMinusNet := BudgetedAmount - NetChange;

                        if BudgetedAmount <> 0 then
                            Percen := ROUND((Variance_1 / BudgetedAmount) * 100, 0.1)
                        else
                            Percen := 0;

                        if ("Budgeted Amount." <> 0) then
                            Show := true;

                        if NetChange <> 0 then
                            Show := true;

                        //END;
                    end else
                        If (NOT ShowAdditionalCurrency) and (CurrencySelected = '') THEN BEGIN
                            //************
                            BudgetedAmount := "Budgeted Amount.";
                            NetChange := "Net Change.";
                            BudgetAmtMinusNet := "Budgeted Amount." - "Net Change.";
                            //************
                            if BudgetedAmount <> 0 then
                                Percen := ROUND((Variance_1 / BudgetedAmount) * 100, 0.1)
                            else
                                Percen := 0;

                            if "Budgeted Amount." <> 0 then
                                Show := true;

                            if "Net Change." <> 0 then
                                Show := true;
                        end else begin
                            CurrencyRec.Get(CurrencySelected);
                            CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencySelected);
                            CurrencyExchangeRate.GetLastestExchangeRate(CurrencySelected, ExchangeRateDate, ExchangeRateAmt);

                            BudgetedAmount := "Budgeted Amount." / ExchangeRateAmt;
                            NetChange := "Net Change." / ExchangeRateAmt;
                            BudgetAmtMinusNet := BudgetedAmount - NetChange;
                            //************
                            if BudgetedAmount <> 0 then
                                Percen := ROUND((Variance_1 / BudgetedAmount) * 100, 0.1)
                            else
                                Percen := 0;

                            if "Budgeted Amount." <> 0 then
                                Show := true;

                            if "Net Change." <> 0 then
                                Show := true;
                        END;


                    //year to date
                    //*************
                    GLaccRec.RESET;
                    GLaccRec.COPY(GlACCCopy);
                    GLaccRec.SETRANGE("Global Dimension 1 Filter", "Dimension Value".Code);
                    GLaccRec.SETFILTER("Global Dimension 2 Filter", FilterProject);
                    GLaccRec.SETFILTER("Budget Filter", FilterBudget);
                    GLaccRec.SETFILTER("Date Filter", '%1..%2', FinStartDate, TODAY);
                    GLaccRec.SETFILTER("Shortcut Dimension 4 Filter", FilterDonor);
                    GLaccRec.CALCFIELDS("Budgeted Amount.", "Additional-Currency Net Chang.", "Net Change.");



                    if ShowAdditionalCurrency and (CurrencySelected = '') then begin

                        ActualYTD := GLaccRec."Additional-Currency Net Chang.";

                        BudgetYTD += ABS(GLaccRec."Budgeted Amount.");
                        VarianceYTD += GLaccRec."Budgeted Amount." - ABS(NetChangeYTD);

                        if (BudgetYTD <> 0) then
                            PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1)
                        else
                            PercentVarianceYTD := 0;

                        if (GLaccRec."Budgeted Amount." = 0) and (ActualYTD = 0) and
                          ("Budgeted Amount." = 0) and (NetChange = 0) then
                            CurrReport.SKIP

                        //END;
                    end else
                        If (NOT ShowAdditionalCurrency) and (CurrencySelected = '') THEN BEGIN

                            BudgetYTD += ABS(GLaccRec."Budgeted Amount.");
                            ActualYTD += GLaccRec."Net Change.";
                            VarianceYTD += GLaccRec."Budgeted Amount." - ABS(GLaccRec."Net Change.");


                            if (BudgetYTD <> 0) then
                                PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1)
                            else
                                PercentVarianceYTD := 0;



                            if (GLaccRec."Budgeted Amount." = 0) and (GLaccRec."Net Change." = 0) and
                              ("Budgeted Amount." = 0) and ("Net Change." = 0) then
                                CurrReport.SKIP

                        end else begin
                            CurrencyRec.Get(CurrencySelected);
                            CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencySelected);
                            CurrencyExchangeRate.GetLastestExchangeRate(CurrencySelected, ExchangeRateDate, ExchangeRateAmt);


                            BudgetYTD += ABS(GLaccRec."Budgeted Amount.") / ExchangeRateAmt;
                            ActualYTD += GLaccRec."Net Change." / ExchangeRateAmt;
                            VarianceYTD += (GLaccRec."Budgeted Amount." / ExchangeRateAmt) - (ABS(GLaccRec."Net Change.") / ExchangeRateAmt);


                            if (BudgetYTD <> 0) then
                                PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1)
                            else
                                PercentVarianceYTD := 0;



                            if (GLaccRec."Budgeted Amount." = 0) and (GLaccRec."Net Change." = 0) and
                              ("Budgeted Amount." = 0) and ("Net Change." = 0) then
                                CurrReport.SKIP


                        END;
                end;

                trigger OnPreDataItem();
                begin
                    CurrReport.CREATETOTALS("Budgeted Amount.", "Net Change.", BudgetYTD, ActualYTD, VarianceYTD, "Additional-Currency Net Chang.");
                    //Ktm dim
                    //SETRANGE ("Global Dimension 3 Filter", "Dimension Value".Code);
                    SETRANGE("Global Dimension 1 Filter", "Dimension Value".Code);
                    SETFILTER("No.", ExpenseACFilter);
                    SETFILTER("Date Filter", '%1..%2', minDate, MaxDate);
                    SETFILTER("Budget Filter", FilterBudget);
                    SETFILTER("Global Dimension 2 Filter", FilterProject);
                    SETFILTER("Shortcut Dimension 4 Filter", FilterDonor);


                    //ktm DIM
                end;
            }

            trigger OnAfterGetRecord();
            begin
                GL.RESET;
                GL.SETCURRENTKEY("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code",
                                "ShortCut Dimension 3 code", "Close Income Statement Dim. ID", "Posting Date", "ShortCut Dimension 4 code");
                GL.SETFILTER("G/L Account No.", ExpenseACFilter);
                //ktm dim
                //GL.SETFILTER ("Global Dimension 1 Code",FilterDonor);
                GL.SETFILTER("ShortCut Dimension 4 code", FilterDonor);
                //ktm dim
                GL.SETFILTER("Global Dimension 2 Code", FilterProject);
                GL.CALCSUMS(Amount);


                GLBudgetEntry.RESET;
                GLBudgetEntry.SETCURRENTKEY("Budget Name", "G/L Account No.", "Business Unit Code",
                                            "Global Dimension 1 Code", "Global Dimension 2 Code",
                                            "ShortCut Dimension 3 code",
                                            "Budget Dimension 1 Code", "Budget Dimension 2 Code",
                                            "Budget Dimension 3 Code", "Budget Dimension 4 Code",
                                            Date, "ShortCut Dimension 4 code");
                GLBudgetEntry.SETFILTER("G/L Account No.", ExpenseACFilter);
                GLBudgetEntry.SETRANGE("Global Dimension 2 Code", FilterProject);
                GLBudgetEntry.SETRANGE("ShortCut Dimension 4 code", FilterDonor);
                //ktm dim
                GLBudgetEntry.SETFILTER("Budget Name", FilterBudget);
                GLBudgetEntry.SETRANGE("Budget Dimension 1 Code", Code);
                GLBudgetEntry.CALCSUMS(Amount);

                if (GL.Amount = 0) and (GLBudgetEntry.Amount = 0) then
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {

            area(content)
            {

                group(Option)
                {
                    Caption = 'Option';

                    field(FinStartDate; FinStartDate)
                    {
                        Caption = 'Financial Year Start Date';
                    }
                    field(summary; summary)
                    {
                        Caption = 'Summary';
                    }
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
            summary := false;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        minDate := "Dimension Value".GETRANGEMIN("Date Filter");
        MaxDate := "Dimension Value".GETRANGEMAX("Date Filter");

        FilterDonor := "Dimension Value".GETFILTER("Dimension Value"."Donor Filter");
        FilterProject := "Dimension Value".GETFILTER("Dimension Value"."Project Filter");
        FilterActivity := "Dimension Value".GETFILTER("Dimension Value"."Activity Filter");
        FilterBudget := "Dimension Value".GETFILTER("Dimension Value"."Budget Filter");

        FilterDate := "Dimension Value".GETFILTER("Dimension Value"."Date Filter");

        if DimVal.GET('DONOR', FilterDonor) then
            DonorName := DimVal.Name;

        if DimVal.GET('PROJECT', FilterProject) then
            ProjectName := DimVal.Name;


        GLSetup.GET();
        ExpenseACFilter := GLSetup."Expense A/C Filter";

        //CurrencyCode
        //KTM

        if ShowAdditionalCurrency then
            //Mycurrency := 'USD'
            Mycurrency := GLSetup."Additional Reporting Currency"
        else
            Mycurrency := GLSetup."LCY Code";

        if CurrencySelected <> '' then
            Mycurrency := CurrencySelected;
        //Mycurrency := 'SSP';

        if FinStartDate = 0D then
            ERROR('Please specify Financial year Start date');
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Mycurrency: Code[10];
        ExpenseACFilter: Text[100];
        BudgetedAmount: Decimal;
        NetChange: Decimal;
        BudgetAmtMinusNet: Decimal;
        PercentYTD: Decimal;
        Percen: Decimal;
        BudgetYTD: Decimal;
        ActualYTD: Decimal;
        VarianceYTD: Decimal;
        PercentVarianceYTD: Decimal;
        PercentVariancePTD: Decimal;
        Show: Boolean;
        GLaccRec: Record "G/L Account";
        FinStartDate: Date;
        MaxDate: Date;
        minDate: Date;
        VariancePTD: Decimal;
        T_ActualYTD: Decimal;
        T_BudgetYTD: Decimal;
        Budget_1: Decimal;
        Budget_2: Decimal;
        Actual_1: Decimal;
        Actual_2: Decimal;
        Variance_1: Decimal;
        Variance_2: Decimal;
        Variance_Per_1: Decimal;
        Variance_Per_2: Decimal;
        PercentVarianceYTD_ST: Decimal;
        PercentVarianceYTD_STT: Decimal;
        FilterDonor: Text[50];
        FilterProject: Text[50];
        FilterActivity: Text[50];
        FilterBudget: Text[50];
        FilterDate: Text[50];
        DonorName: Text[50];
        ProjectName: Text[50];
        DimVal: Record "Dimension Value";
        FINANCIAL_REPORTCaptionLbl: Label 'FINANCIAL REPORT - Activity';
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
        PERIOD_______________________________________CaptionLbl: Label '-------------------PERIOD---------------------------------------';
        YEAR_TO_DATE_____________________________CaptionLbl: Label '-------------------YEAR TO DATE-----------------------------';
        GRAND_TOTALSCaptionLbl: Label 'GRAND TOTALS';
        summary: Boolean;
        GL: Record "G/L Entry";
        GL2: Record "G/L Entry";
        DonorFilter: Code[100];
        ProjectFilter: Code[100];
        GLBudgetEntry: Record "G/L Budget Entry";
        BudgetFilter: Text[100];
        TotalAct: Decimal;
        TotalActYTD: Decimal;
        TotalBudget1: Decimal;
        TotalBudgetYTD: Decimal;
        TotalVar1: Decimal;
        TotalVar2: Decimal;
        amount: Decimal;
        ShowAdditionalCurrency: Boolean;
        GlACC: Record "G/L Account";
        DonorActivityCode: Code[50];
        GLEntry: Record "G/L Entry";
        NetChangeSum: Decimal;
        NetChangeYTD: Decimal;
        GlACCCopy: Record "G/L Account";
        CurrencyFactor: Decimal;
        ExchangerateAmt: Decimal;
        ExchangerateDate: Date;
        CurrencySelected: Code[20];
        CurrencyRec: Record Currency;
        ShowSummary: Integer;
}

