report 50051 "Financial Report - Project"
{
    // version ktm

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Financial Report - Project.rdl';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING(Code, "Global Dimension No.") ORDER(Ascending) WHERE("Global Dimension No." = CONST(2));
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
            column(Grand1; Grand1)
            {
            }
            column(Grand2; Grand2)
            {
            }
            column(PercentVarianceYTD; PercentVarianceYTD)
            {
            }
            column(PercentVarianceYTD_Control1102750005; PercentVarianceYTD)
            {
            }
            column(Grand_1; Grand_1)
            {
            }
            column(Grand_2; Grand_2)
            {
            }
            column(Grand_1___Grand_2; Grand_1 - Grand_2)
            {
            }
            column(Grand1__Grand2; Grand1 - Grand2)
            {
            }
            column(FINANCIAL_REPORT___PROJECTCaption; FINANCIAL_REPORT___PROJECTCaptionLbl)
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
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(YEAR_TO_DATECaption; YEAR_TO_DATECaptionLbl)
            {
            }
            column(GRAND_TOTALS__Caption; GRAND_TOTALS__CaptionLbl)
            {
            }
            column(Dimension_Value_Dimension_Code; "Dimension Code")
            {
            }

            dataitem("G/L Account"; "G/L Account")
            {
                DataItemLink = "Global Dimension 2 Filter" = FIELD(Code);
                DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Account Type" = CONST(Posting));
                column(G_L_Account__No__; "No.")
                {
                }
                column(G_L_Account_Name; Name)
                {
                }
                column(G_L_Account__Budgeted_Amount_; BudgetAmount)
                {
                }
                column(G_L_Account__Net_Change_; Netchange)
                {
                }
                column(Budgeted_Amount___Net_Change_; (BudgetAmount - Netchange))
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
                column(PercentVarianceYTD_Control1000000024; PercentVarianceYTD)
                {
                }
                column(PercentVarianceYTD_Control1000000025; PercentVarianceYTD)
                {
                }
                column(G_L_Account__Budgeted_Amount__Control1000000029; "Budgeted Amount.")
                {
                }
                column(G_L_Account__Net_Change__Control1000000030; "Net Change.")
                {
                }
                column(Budgeted_Amount___Net_Change__Control1000000031; "Budgeted Amount." - "Net Change.")
                {
                }
                column(PercentVarianceYTD_Control1000000032; PercentVarianceYTD)
                {
                }
                column(PercentVarianceYTD_Control1000000036; PercentVarianceYTD)
                {
                }
                column(T_BudgetYTD; T_BudgetYTD)
                {
                }
                column(T_ActualYTD; T_ActualYTD)
                {
                }
                column(STRSUBSTNO__Total_for__1__Name_; STRSUBSTNO('Total for %1', Name))
                {
                }
                column(T_BudgetYTD___T_ActualYTD; T_BudgetYTD - T_ActualYTD)
                {
                }
                column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
                {
                }

                trigger OnAfterGetRecord();
                var
                    CurrencyExchangeRate: Record "Currency Exchange Rate";
                begin
                    BudgetYTD := 0;
                    ActualYTD := 0;
                    VarianceYTD := 0;
                    PercentVarianceYTD := 0;
                    PercentVariancePTD := 0;
                    PercentVariancePTD := 0;
                    Netchange := 0;
                    BudgetAmount := 0;



                    if ShowAdditionalCurrency and (CurrencySelected = '') then begin
                        if "G/L Account"."Budgeted Amount Add. Curr" <> 0 then
                            PercentVariancePTD := VariancePTD / "G/L Account"."Budgeted Amount Add. Curr" * 100;
                        VariancePTD := "G/L Account"."Budgeted Amount Add. Curr" - "G/L Account"."Additional-Currency Net Chang.";

                        GLaccRec.COPY("G/L Account");
                        GLaccRec.SETFILTER(GLaccRec."Date Filter", '%1..%2', FinStartDate, Today);



                        GLaccRec.CALCFIELDS(GLaccRec."Budgeted Amount Add. Curr", GLaccRec."Additional-Currency Net Chang.");
                        BudgetYTD := GLaccRec."Budgeted Amount Add. Curr";
                        ActualYTD := GLaccRec."Additional-Currency Net Chang.";
                        VarianceYTD := GLaccRec."Budgeted Amount Add. Curr" - GLaccRec."Additional-Currency Net Chang.";

                        "G/L Account"."Budgeted Amount." := GLaccRec."Budgeted Amount Add. Curr";
                        "G/L Account"."Net Change." := GLaccRec."Additional-Currency Net Chang.";

                        BudgetAmount := "G/L Account"."Budgeted Amount Add. Curr";
                        Netchange := "G/L Account"."Additional-Currency Net Chang.";

                        if BudgetYTD <> 0 then
                            PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1);
                        Show := false;

                        if "G/L Account"."Budgeted Amount Add. Curr" <> 0 then
                            Show := true;

                        if "G/L Account"."Additional-Currency Net Chang." <> 0 then
                            Show := true;
                        if BudgetYTD <> 0 then
                            Show := true;
                        if ActualYTD <> 0 then
                            Show := true;
                        if not Show then
                            CurrReport.SKIP;

                    end else
                        If (NOT ShowAdditionalCurrency) and (CurrencySelected = '') THEN BEGIN

                            if "G/L Account"."Budgeted Amount." <> 0 then
                                PercentVariancePTD := VariancePTD / "G/L Account"."Budgeted Amount." * 100;
                            VariancePTD := "G/L Account"."Budgeted Amount." - "G/L Account"."Net Change.";

                            GLaccRec.COPY("G/L Account");
                            GLaccRec.SETFILTER(GLaccRec."Date Filter", '%1..%2', FinStartDate, Today);
                            GLaccRec.CALCFIELDS(GLaccRec."Budgeted Amount.", GLaccRec."Net Change.", GLaccRec."Budgeted Amount Add. Curr", GLaccRec."Additional-Currency Net Chang.");
                            BudgetYTD := GLaccRec."Budgeted Amount.";
                            ActualYTD := GLaccRec."Net Change.";
                            VarianceYTD := GLaccRec."Budgeted Amount." - GLaccRec."Net Change.";

                            BudgetAmount := "G/L Account"."Budgeted Amount.";
                            Netchange := "G/L Account"."Net Change.";

                            if BudgetYTD <> 0 then
                                PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1);
                            Show := false;

                            if "G/L Account"."Budgeted Amount." <> 0 then
                                Show := true;

                            if "G/L Account"."Net Change." <> 0 then
                                Show := true;
                            if BudgetYTD <> 0 then
                                Show := true;
                            if ActualYTD <> 0 then
                                Show := true;
                            if not Show then
                                CurrReport.SKIP;
                        end else
                            if (CurrencySelected <> '') Then begin
                                CurrencyRec.Get(CurrencySelected);
                                CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor(CurrencySelected);
                                CurrencyExchangeRate.GetLastestExchangeRate(CurrencySelected, ExchangeRateDate, ExchangeRateAmt);

                                if "G/L Account"."Budgeted Amount." <> 0 then
                                    PercentVariancePTD := VariancePTD / "G/L Account"."Budgeted Amount." * 100;
                                VariancePTD := ("G/L Account"."Budgeted Amount." / ExchangeRateAmt) - ("G/L Account"."Net Change." / ExchangeRateAmt);

                                GLaccRec.COPY("G/L Account");
                                GLaccRec.SETFILTER(GLaccRec."Date Filter", '%1..%2', FinStartDate, Today);
                                GLaccRec.CALCFIELDS(GLaccRec."Budgeted Amount.", GLaccRec."Net Change.", GLaccRec."Budgeted Amount Add. Curr", GLaccRec."Additional-Currency Net Chang.");
                                BudgetYTD := GLaccRec."Budgeted Amount." / ExchangeRateAmt;
                                ActualYTD := GLaccRec."Net Change." / ExchangeRateAmt;
                                //VarianceYTD := GLaccRec."Budgeted Amount." - GLaccRec."Net Change.";
                                VarianceYTD := BudgetYTD - ActualYTD;

                                BudgetAmount := "G/L Account"."Budgeted Amount." / ExchangeRateAmt;
                                Netchange := "G/L Account"."Net Change." / ExchangeRateAmt;

                                if BudgetYTD <> 0 then
                                    PercentVarianceYTD := ROUND(VarianceYTD / BudgetYTD * 100, 0.1);
                                Show := false;

                                if "G/L Account"."Budgeted Amount." <> 0 then
                                    Show := true;

                                if "G/L Account"."Net Change." <> 0 then
                                    Show := true;
                                if BudgetYTD <> 0 then
                                    Show := true;
                                if ActualYTD <> 0 then
                                    Show := true;
                                if not Show then
                                    CurrReport.SKIP;

                            END;

                END;

                trigger OnPostDataItem();
                begin
                    T_BudgetYTD := 0;
                    T_ActualYTD := 0;
                end;

                trigger OnPreDataItem();
                begin
                    SETFILTER("No.", ExpenseACFilter);
                    //SETFILTER ("Global Dimension 1 Filter", FilterDonor);
                    //ktm
                    SETFILTER("Shortcut Dimension 4 Filter", FilterDonor);
                    //ktm end
                    SETFILTER("Global Dimension 2 Filter", FilterProject);
                    SETFILTER("Budget Filter", FilterBudget);
                    SETRANGE("Date Filter", minDate, MaxDate);
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;


        layout
        {

            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FinStartDate; FinStartDate)
                    {
                        Caption = 'Financial Year Start date';
                    }
                    //ij
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

        trigger OnInit();
        begin
            EVALUATE(FinStartDate, '0101' + FORMAT(DATE2DMY(WORKDATE, 3)));
        end;

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
        minDate := "Dimension Value".GETRANGEMIN("Dimension Value"."Date Filter");
        MaxDate := "Dimension Value".GETRANGEMAX("Dimension Value"."Date Filter");

        FilterDonor := "Dimension Value".GETFILTER("Dimension Value"."Donor Filter");
        FilterProject := "Dimension Value".GETFILTER("Dimension Value"."Project Filter");
        FilterBudget := "Dimension Value".GETFILTER("Dimension Value"."Budget Filter");

        FilterDate := "Dimension Value".GETFILTER("Dimension Value"."Date Filter");

        if DimVal.GET('DONOR', FilterDonor) then
            DonorName := DimVal.Name;

        if DimVal.GET('PROJECT', FilterProject) then
            ProjectName := DimVal.Name;

        GLSetup.GET();
        MyCurrency := GLSetup."LCY Code";
        ExpenseACFilter := GLSetup."Expense A/C Filter";
        //ij
        if ShowAdditionalCurrency then
            //Mycurrency := 'USD'
            Mycurrency := GLSetup."Additional Reporting Currency"
        else
            Mycurrency := GLSetup."LCY Code";

        if CurrencySelected <> '' then
            Mycurrency := CurrencySelected;
        //Mycurrency := 'SSP';
        //ij
    end;

    var
        //je
        ShowAdditionalCurrency: Boolean;

        BudgetYTD: Decimal;
        ActualYTD: Decimal;
        VarianceYTD: Decimal;
        PercentVarianceYTD: Decimal;
        PercentVariancePTD: Decimal;
        Show: Boolean;
        ExpenseACFilter: Text[100];
        GLaccRec: Record "G/L Account";
        FinStartDate: Date;
        MaxDate: Date;
        minDate: Date;
        VariancePTD: Decimal;
        T_BudgetYTD: Decimal;
        T_ActualYTD: Decimal;
        Grand1: Decimal;
        Grand2: Decimal;
        Grand_1: Decimal;
        Grand_2: Decimal;
        FilterProject: Text[100];
        FilterDonor: Text[100];
        FilterBudget: Text[100];
        FilterDate: Text[30];
        DonorName: Text[100];
        ProjectName: Text[100];
        DimVal: Record "Dimension Value";
        MyCurrency: Code[10];
        GLSetup: Record "General Ledger Setup";
        FINANCIAL_REPORT___PROJECTCaptionLbl: Label 'FINANCIAL REPORT - PROJECT';
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
        PERIODCaptionLbl: Label 'PERIOD';
        YEAR_TO_DATECaptionLbl: Label 'YEAR TO DATE';
        GRAND_TOTALS__CaptionLbl: Label 'GRAND TOTALS :';
        CurrencyFactor: Decimal;
        ExchangerateAmt: Decimal;
        ExchangerateDate: Date;
        CurrencySelected: Code[20];
        CurrencyRec: Record Currency;
        BudgetAmount: Decimal;

        Netchange: Decimal;


}

