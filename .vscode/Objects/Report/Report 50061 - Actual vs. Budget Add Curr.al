report 50061 "Actual vs. Budget Add Curr"
{
    // version ktm

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Actual vs. Budget Add Curr.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            MaxIteration = 1;
            RequestFilterFields = "Date Filter", "Budget Filter", "Global Dimension 2 Filter";
            RequestFilterHeading = 'Filters';
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            column(DonorName; DonorName)
            {
            }
            column(FilterBudget; FilterBudget)
            {
            }
            column(ProjectName; ProjectName)
            {
            }
            column(FilterAccExpense; FilterAccExpense)
            {
            }
            column(FilterAccIncome; FilterAccIncome)
            {
            }
            column(GLSetup__LCY_Code_; GLSetup."LCY Code")
            {
            }
            column(FilterPeriod; FilterPeriod)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Donor_Caption; Donor_CaptionLbl)
            {
            }
            column(Project_Caption; Project_CaptionLbl)
            {
            }
            column(Budget_Caption; Budget_CaptionLbl)
            {
            }
            column(Currency_Code_Caption; Currency_Code_CaptionLbl)
            {
            }
            column(USDCaption; USDCaptionLbl)
            {
            }
            column(Income_GL_AC_sCaption; Income_GL_AC_sCaptionLbl)
            {
            }
            column(Expense_GL_AC_sCaption; Expense_GL_AC_sCaptionLbl)
            {
            }
            column(Currency_Code_Caption_Control1102750029; Currency_Code_Caption_Control1102750029Lbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {

            }

            dataitem(DimValueExpense; "Dimension Value")
            {
                DataItemTableView = SORTING("Dimension Code", Code) WHERE("Dimension Value Type" = CONST(Standard));
                column(GLSetup__Additional_Reporting_Currency_; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000029; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000034; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000035; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000036; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000037; GLSetup."Additional Reporting Currency")
                {
                }
                column(GLSetup__Additional_Reporting_Currency__Control1000000038; GLSetup."Additional Reporting Currency")
                {
                }
                column(Shortcut_Dimension_4_Code; DonorActivityCodeValue)
                {
                }

                column(DimValueExpense_Name; Name)
                {
                }
                column(DimValueExpense_Code; Code)
                {
                }

                column(ActivityCodeForDonorActivity; ActivityCodeForDonorActivity)
                {

                }
                column(ShowActivityCodeForDonorActivity; ShowActivityCodeForDonorActivity)
                {

                }
                column(ShowvarianceToDate; ShowvarianceToDate)
                {

                }
                column(Amt_Actual_Period; Amt_Actual_Period)
                {
                }
                column(Amt_Actual_YTD; Amt_Actual_YTD)
                {
                }
                column(BurnRatePerc__; BurnRatePerc)
                {

                }
                column(Amt_Budget_Annual; Amt_Budget_Annual)
                {
                }
                column(Amt_Variance_Period; Amt_Variance_Period)
                {
                }
                column(Amt_Variance_ToDate; Amt_Variance_ToDate)
                {
                }
                column(Amt_Budget_ToDate; Amt_Budget_ToDate)
                {
                }
                column(Amt_Actual_ToDate; Amt_Actual_ToDate)
                {
                }
                column(DimValueExpense_NameCaption; FIELDCAPTION(Name))
                {
                }
                column(DimValueExpense_CodeCaption; FIELDCAPTION(Code))
                {
                }
                column(Amt_Actual_PeriodCaption; Amt_Actual_PeriodCaptionLbl)
                {
                }
                column(Amt_Actual_YTDCaption; Amt_Actual_YTDCaptionLbl)
                {
                }
                column(Amt_Budget_AnnualCaption; Amt_Budget_AnnualCaptionLbl)
                {
                }
                column(Variance_YTDCaption; Variance_YTDCaptionLbl)
                {
                }
                column(Amt_Actual_ToDateCaption; Amt_Actual_ToDateCaptionLbl)
                {
                }
                column(Amt_Budget_ToDateCaption; Amt_Budget_ToDateCaptionLbl)
                {
                }
                column(Variance_To_DateCaption; Variance_To_DateCaptionLbl)
                {
                }
                column(DimValueExpense_Dimension_Code; "Dimension Code")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    //to exclude the revaluation gains/losses
                    if Code = 'AC0216' then
                        CurrReport.SKIP;

                    CalculateLine(Code);

                    ActivityCodeForDonorActivity := '';
                    ShowActivityCodeForDonorActivity := 0;
                    ShowvarianceToDate := 0;

                    //Get ACtivityCode For The DonorActivity
                    if DimensionCodeOption = DimensionCodeOption::DONORACTIVITY then Begin
                        DimensionValueRecord.SetFilter("Dimension Code", 'DONORACTIVITY');
                        DimensionValueRecord.SetFilter(Code, Code);
                        If DimensionValueRecord.FindFirst then
                            ActivityCodeForDonorActivity := DimensionValueRecord.ActivityCode;

                        ShowActivityCodeForDonorActivity := 1;
                        ShowvarianceToDate := 1;

                    END;

                    Total_Amt_Actual_Period += Amt_Actual_Period;
                    Total_Amt_Actual_YTD += Amt_Actual_YTD;
                    Total_Amt_Actual_ToDate += Amt_Actual_ToDate;
                    Total_Amt_Budget_Annual += Amt_Budget_Annual;
                    Total_Amt_Budget_ToDate += Amt_Budget_ToDate;
                    Total_Amt_Variance_Period += Amt_Variance_Period;
                    Total_Amt_Variance_ToDate += Amt_Variance_ToDate;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Dimension Code", DimensionCode);

                    with GLAccount do begin
                        SETFILTER("No.", FilterAccExpense);
                        SETFILTER("Account Type", 'Posting');
                        SETFILTER("Budget Filter", FilterBudget);
                        SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                        SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                    end;

                    with GLEntry do begin
                        SETCURRENTKEY("Global Dimension 1 Code", "Global Dimension 2 Code", "ShortCut Dimension 3 code", "G/L Account No.");
                        SETFILTER("G/L Account No.", FilterAccExpense);
                        SETFILTER("Global Dimension 1 Code", FilterGlobalDim1);
                        SETFILTER("Global Dimension 2 Code", FilterGlobalDim2);
                    end;

                    with GLBudgetEntry do begin
                        SETCURRENTKEY("Global Dimension 1 Code", "Global Dimension 2 Code", "ShortCut Dimension 3 code", "G/L Account No.");
                        SETFILTER("G/L Account No.", FilterAccExpense);
                        SETFILTER("Global Dimension 1 Code", FilterGlobalDim1);
                        SETFILTER("Global Dimension 2 Code", FilterGlobalDim2);
                    end;
                end;
            }
            dataitem(NoDimValue; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(No_code_; 'No code')
                {
                }
                column(Amt_Variance_Period_Control1000000018; Amt_Variance_Period)
                {
                }
                column(Amt_Budget_Annual_Control1000000019; Amt_Budget_Annual)
                {
                }
                column(Amt_Actual_YTD_Control1000000020; Amt_Actual_YTD)
                {
                }
                column(Amt_Actual_Period_Control1000000022; Amt_Actual_Period)
                {
                }
                column(Amt_Variance_ToDate_Control1000000026; Amt_Variance_ToDate)
                {
                }
                column(Amt_Budget_ToDate_Control1000000028; Amt_Budget_ToDate)
                {
                }
                column(Amt_Actual_ToDate_Control1000000030; Amt_Actual_ToDate)
                {
                }
                column(Total_Amt_Actual_Period; Total_Amt_Actual_Period)
                {
                }
                column(Total_Amt_Actual_YTD; Total_Amt_Actual_YTD)
                {
                }
                column(Total_Amt_Budget_Annual; Total_Amt_Budget_Annual)
                {
                }
                column(Total_Amt_Variance_Period; Total_Amt_Variance_Period)
                {
                }
                column(Total_Amt_Variance_ToDate; Total_Amt_Variance_ToDate)
                {
                }
                column(Total_Amt_Budget_ToDate; Total_Amt_Budget_ToDate)
                {
                }
                column(Total_Amt_Actual_ToDate; Total_Amt_Actual_ToDate)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(NoDimValue_Number; Number)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CalculateLine('');

                    Total_Amt_Actual_Period += Amt_Actual_Period;
                    Total_Amt_Actual_YTD += Amt_Actual_YTD;
                    Total_Amt_Actual_ToDate += Amt_Actual_ToDate;
                    Total_Amt_Budget_Annual += Amt_Budget_Annual;
                    Total_Amt_Budget_ToDate += Amt_Budget_ToDate;
                    Total_Amt_Variance_Period += Amt_Variance_Period;
                    Total_Amt_Variance_ToDate += Amt_Variance_ToDate;
                end;

                trigger OnPostDataItem();
                begin
                    //GLAccount.SETRANGE ("Global Dimension 3 Filter");

                    //New KTM
                    if DimensionCodeOption = DimensionCodeOption::ACTIVITY then
                        GLAccount.SETRANGE("Global Dimension 1 Filter");
                    if DimensionCodeOption = DimensionCodeOption::DONORACTIVITY then
                        GLAccount.SETRANGE("Shortcut Dimension 4 Filter");
                    //End KTM
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Amt_CashAtBank; Amt_CashAtBank)
                {
                }
                column(STRSUBSTNO___1___2__minDate_MaxDate_; STRSUBSTNO('%1..%2', minDate, MaxDate))
                {
                }
                column(STRSUBSTNO___1___2__FinStartDate_TODAY_; STRSUBSTNO('%1..%2', FinStartDate, TODAY))
                {
                }
                column(Amt_WorkingAdvance; Amt_WorkingAdvance)
                {
                }
                column(Amt_Others; Amt_Others)
                {
                }
                column(Amt_CashAtHand; Amt_CashAtHand)
                {
                }
                column(Amt_CashAtBank_Amt_CashAtHand_Amt_WorkingAdvance_Amt_Others___Amt_Payable__; Amt_CashAtBank + Amt_CashAtHand + Amt_WorkingAdvance + Amt_Others - (-Amt_Payable))
                {
                }
                column(Amt_OpeningBalance; -Amt_OpeningBalance)
                {
                }
                column(Amt_Income; -Amt_Income)
                {
                }
                column(Amt_OpeningBalance_Amt_Income_Amt_Transfers_Amt_PriorYear_Adj_; -(Amt_OpeningBalance + Amt_Income + Amt_Transfers + Amt_PriorYear_Adj))
                {
                }
                column(Amt_Expense; Amt_Expense)
                {
                }
                column(Amt_OpeningBalance_Amt_Income_Amt_Transfers_Amt_PriorYear_Adj_____Amt_Expense____Amt_Actual_PeriodGainLoss_; -(Amt_OpeningBalance + Amt_Income + Amt_Transfers + Amt_PriorYear_Adj) - (Amt_Expense) - (Amt_Actual_PeriodGainLoss))
                {
                }
                column(Amt_Payable; -Amt_Payable)
                {
                }
                column(Amt_Transfers; -Amt_Transfers)
                {
                }
                column(Amt_Actual_PeriodGainLoss_; (Amt_Actual_PeriodGainLoss))
                {
                }
                column(Amt_PriorYear_Adj_; -(Amt_PriorYear_Adj))
                {
                }
                column(Presented_By_Caption; Presented_By_CaptionLbl)
                {
                }
                column(Total_Funds_Available_Caption; Total_Funds_Available_CaptionLbl)
                {
                }
                column(Cash_at_BankCaption; Cash_at_BankCaptionLbl)
                {
                }
                column(Working_advance_Uncleared_balancesCaption; Working_advance_Uncleared_balancesCaptionLbl)
                {
                }
                column(Branch_Working_AdvanceCaption; Branch_Working_AdvanceCaptionLbl)
                {
                }
                column(Cash_at_HandCaption; Cash_at_HandCaptionLbl)
                {
                }
                column(TotalCaption_Control1102750043; TotalCaption_Control1102750043Lbl)
                {
                }
                column(Closing_BalanceCaption; Closing_BalanceCaptionLbl)
                {
                }
                column(Expenses_PeriodCaption; Expenses_PeriodCaptionLbl)
                {
                }
                column(Funds_AvailableCaption; Funds_AvailableCaptionLbl)
                {
                }
                column(Received_this_PeriodCaption; Received_this_PeriodCaptionLbl)
                {
                }
                column(Opening_BalanceCaption; Opening_BalanceCaptionLbl)
                {
                }
                column(PayablesCaption; PayablesCaptionLbl)
                {
                }
                column(TransfersCaption; TransfersCaptionLbl)
                {
                }
                column(Revaluation_Gains_LossesCaption; Revaluation_Gains_LossesCaptionLbl)
                {
                }
                column(Prior_Year_AdjustmentsCaption; Prior_Year_AdjustmentsCaptionLbl)
                {
                }
                column(The_undersigned_herby_certify_that_all_expenditures_are_correct_Caption; The_undersigned_herby_certify_that_all_expenditures_are_correct_CaptionLbl)
                {
                }
                column(Prepared_by_Caption; Prepared_by_CaptionLbl)
                {
                }
                column(Endorsed_By_Caption; Endorsed_By_CaptionLbl)
                {
                }
                column(Budget_Holder_Caption; Budget_Holder_CaptionLbl)
                {
                }
                column(Signed_Caption; Signed_CaptionLbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(Signed_Caption_Control1000000002; Signed_Caption_Control1000000002Lbl)
                {
                }
                column(Signed_Caption_Control1000000003; Signed_Caption_Control1000000003Lbl)
                {
                }
                column(Date_Caption_Control1000000023; Date_Caption_Control1000000023Lbl)
                {
                }
                column(Date_Caption_Control1000000027; Date_Caption_Control1000000027Lbl)
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnAfterGetRecord();
                var
                    FilterAccIncomeExpense: Text[50];
                begin
                    // ***********  Calculate Presented by Values  ***********************
                    with GLAccount do begin

                        Amt_CashAtBank := 0;
                        SETFILTER("No.", GLACCashatBank);
                        SETFILTER("Account Type", 'Posting');
                        if FIND('-') then
                            repeat
                                SETFILTER("Date Filter", FilterBalanceAtDate);
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                CALCFIELDS("Net Change.", "Additional-Currency Net Chang.");
                                Amt_CashAtBank += "Additional-Currency Net Chang.";
                            until NEXT = 0;

                        Amt_CashAtHand := 0;
                        SETFILTER("No.", GLACCashatHand);
                        if FIND('-') then
                            repeat
                                SETFILTER("Date Filter", FilterBalanceAtDate);
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                CALCFIELDS("Net Change.", "Additional-Currency Net Chang.");
                                Amt_CashAtHand += "Additional-Currency Net Chang.";
                            until NEXT = 0;

                        Amt_WorkingAdvance := 0;
                        SETFILTER("No.", GLACWorkingAdvance);
                        if FIND('-') then
                            repeat
                                SETFILTER("Date Filter", FilterBalanceAtDate);
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                CALCFIELDS("Balance at Date.", "Add.-Currency Balance at Date.");
                                Amt_WorkingAdvance += "Add.-Currency Balance at Date.";
                            until NEXT = 0;

                        Amt_Others := 0;
                        SETFILTER("No.", GLACOthers);
                        if FIND('-') then
                            repeat
                                SETFILTER("Date Filter", FilterBalanceAtDate);
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                CALCFIELDS("Balance at Date.", "Add.-Currency Balance at Date.");
                                Amt_Others += "Add.-Currency Balance at Date.";
                            until NEXT = 0;

                        Amt_Payable := 0;
                        SETFILTER("No.", FilterAccPayable);
                        if FIND('-') then
                            repeat
                                SETFILTER("Date Filter", FilterBalanceAtDate);
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                CALCFIELDS("Balance at Date.", "Add.-Currency Balance at Date.");
                                Amt_Payable += "Add.-Currency Balance at Date.";
                            until NEXT = 0;

                    end;

                    // ***********  Calculate Total Funds Available values ***********************
                    with GLAccount do begin
                        GLSetup.GET;
                        Amt_OpeningBalance := 0;
                        SETFILTER("No.", FilterAccOpBal + '|' + FilterAccIncome + '|' + FilterAccTransfers + '|' + FilterAccExpense + '|' +
                                   GLSetup."Prior Year Adjust. Filter" + '|' + GLSetup."Revaluation Gain/Loss Filter");
                        if FIND('-') then
                            repeat
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                Amt_OpeningBalance += CalcNetChange(GLAccount, 0D, PeriodStartDate - 1, true)
                            until NEXT = 0;

                        Amt_Income := 0;
                        SETFILTER("No.", FilterAccIncome);
                        if FIND('-') then
                            repeat
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                Amt_Income += CalcNetChange(GLAccount, PeriodStartDate, PeriodEndDate, true)
                            until NEXT = 0;

                        Amt_Transfers := 0;
                        SETFILTER("No.", FilterAccTransfers);
                        if FIND('-') then
                            repeat
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                Amt_Transfers += CalcNetChange(GLAccount, PeriodStartDate, PeriodEndDate, true)
                            until NEXT = 0;

                        Amt_Expense := 0;
                        SETFILTER("No.", FilterAccExpense);
                        if FIND('-') then
                            repeat
                                SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
                                SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
                                Amt_Expense += CalcNetChange(GLAccount, PeriodStartDate, PeriodEndDate, true)
                            until NEXT = 0;

                    end;
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
                        CaptionML = ENU = 'Financial Year Start Date';
                    }
                    field(DimensionCode; DimensionCodeOption)
                    {
                        CaptionML = ENU = 'Dimension',
                                FRA = 'La cote';
                    }
                    field(filteraccopbal; FilterAccOpBal)
                    {
                        CaptionML = ENU = 'Opening Balance A/C',
                                FRA = 'Compte de revenu';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(FilterAccIncome; FilterAccIncome)
                    {
                        Caption = 'Income A/C';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(FilterAccTransfers; FilterAccTransfers)
                    {
                        Caption = 'Transfer A/C Filter';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(FilterAccExpense; FilterAccExpense)
                    {
                        CaptionML = ENU = 'Expense A/C',
                                FRA = 'Compte de dépenses';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(GLACCashatBank; GLACCashatBank)
                    {
                        CaptionML = ENU = 'Cash at Bank GL AC''s',
                                FRA = 'La trésorerie en banque comptes du grand livre général';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(GLACCashatHand; GLACCashatHand)
                    {
                        CaptionML = ENU = 'Cash at Hand GL AC''s',
                                FRA = 'Espèces à part les comptes du grand livre général';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(GLACWorkingAdvance; GLACWorkingAdvance)
                    {
                        CaptionML = ENU = 'Working Advance GL AC''s',
                                FRA = 'L''avance de comptes du grand livre général';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(GLACOthers; GLACOthers)
                    {
                        Caption = 'Other GL AC''s';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(FilterAccPayable; FilterAccPayable)
                    {
                        Caption = 'Payable A/C Filter';
                        Editable = false;
                        TableRelation = "G/L Account";
                    }
                    field(ShowNonZeroOnly; ShowNonZeroOnly)
                    {
                        CaptionML = ENU = 'Show non-zero lines only',
                                FRA = 'Afficher uniquement les lignes non nulle';
                    }
                }

            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            GLSetup.GET;
            FilterAccOpBal := GLSetup."Opening Balance A/C Filter";
            FilterAccPayable := GLSetup."Payable A/C Filter";
            FilterAccTransfers := GLSetup."Transfers A/C Filter";
            FilterAccIncome := GLSetup."Income A/C Filter";
            FilterAccExpense := GLSetup."Expense A/C Filter";
            GLACCashatBank := GLSetup."Cash at Bank A/C Filter";
            GLACCashatHand := GLSetup."Cash at Hand A/C Filter";
            GLACWorkingAdvance := GLSetup."Working Advance A/C Filter";
            GLACOthers := GLSetup."Other A/C Filter";
            //DimensionCode := GLSetup."Activity Dimension";
            ShowNonZeroOnly := true;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
    begin

        minDate := "G/L Account".GETRANGEMIN("Date Filter");
        MaxDate := "G/L Account".GETRANGEMAX("Date Filter");

        FilterPeriod := "G/L Account".GETFILTER("Date Filter");
        if (FilterPeriod = '') then
            ERROR(ERR_FILTERPERIOD);
        if (GLSetup."Cutoff Date" = 0D) then begin
            GLSetup."Cutoff Date" := DMY2DATE(1, 1, 2000);
            if ("G/L Account".GETRANGEMIN("Date Filter") < GLSetup."Cutoff Date") then
                ERROR(ERR_CUTOFF, GLSetup."Cutoff Date");
        end;
        FilterBalanceAtDate := STRSUBSTNO('%1..%2', GLSetup."Cutoff Date", "G/L Account".GETRANGEMAX("Date Filter"));

        PeriodStartDate := "G/L Account".GETRANGEMIN("Date Filter");
        PeriodEndDate := "G/L Account".GETRANGEMAX("Date Filter");
        YTDStartDate := GetYTDStartDate(PeriodStartDate);
        PrevYearStartDate := CALCDATE('<-1Y>', YTDStartDate);
        PrevYearEndDate := YTDStartDate - 1;
        if (YTDStartDate = 0D) then
            ERROR(ERR_YTD, PeriodStartDate);

        FilterBudget := "G/L Account".GETFILTER("Budget Filter");
        if (FilterBudget = '') then
            ERROR(ERR_FILTERBUDGET);

        if (GLACCashatBank = '') or (GLACCashatHand = '') or (GLACWorkingAdvance = '') then
            ERROR('Please fill in all presented by GL AC Nos');

        FilterGlobalDim1 := "G/L Account".GETFILTER("Global Dimension 1 Filter");
        FilterGlobalDim2 := "G/L Account".GETFILTER("Global Dimension 2 Filter");
        //ktmFilterGlobalDim4 := "G/L Account".GETFILTER("Shortcut Dimension 4 Filter");

        DimensionCode := '';
        if DimensionCodeOption = DimensionCodeOption::ACTIVITY then
            DimensionCode := 'ACTIVITY'
        else
            DimensionCode := 'DONORACTIVITY';

        case DimensionCode of
            GLSetup."Global Dimension 1 Code",
            GLSetup."Global Dimension 2 Code",
            GLSetup."Shortcut Dimension 3 Code",
            GLSetup."Shortcut Dimension 4 Code":
                begin
                    Dimension.GET(DimensionCode);
                    ReportTitle := STRSUBSTNO(TXT_REPORTTITLE, Dimension.Name, FilterPeriod);
                end;
            else
                ERROR(ERR_DIMENSION, DimensionCode);
        end;

        with DimensionValue do begin
            if GET('DONOR', FilterGlobalDim4) then
                DonorName := Name;

            if GET('PROJECT', FilterGlobalDim2) then
                ProjectName := Name;
        end;
    end;

    var
        ProjectName: Text[30];
        DonorName: Text[30];
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        YTDStartDate: Date;
        FilterPeriod: Text[30];
        FilterBudget: Text[250];
        FilterGlobalDim1: Text[250];
        FilterGlobalDim2: Text[250];
        FilterGlobalDim4: Text[250];
        FilterAccIncome: Text[250];
        FilterAccOpBal: Text[250];
        BurnRatePerc: decimal;
        FilterAccExpense: Text[250];
        ActivityCodeForDonorActivity: Code[30];
        ShowActivityCodeForDonorActivity: Integer;
        ShowvarianceToDate: Integer;
        DimensionValueRecord: Record "Dimension Value";
        FilterAccPayable: Text[250];
        FilterAccTransfers: Text[250];
        FilterBalanceAtDate: Text[30];
        DimensionCodeOption: Option ACTIVITY,DONORACTIVITY;
        DimensionCode: Code[20];
        GLAccount: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        AnalysisViewEntry: Record "Analysis View Entry";
        GLBudgetEntry: Record "G/L Budget Entry";
        GLSetup: Record "General Ledger Setup";
        ERR_FILTERPERIOD: Label 'Date filter must be specified.';
        ERR_FILTERBUDGET: Label 'Budget filter must be specified.';
        ERR_DIMENSION: Label 'Dimension %1 is not supported by this report.';
        ReportTitle: Text[80];
        ERR_YTD: Label 'Financial year for %1 has not been defined.';
        ShowNonZeroOnly: Boolean;
        ERR_CUTOFF: Label 'You cannot select period before %1.';
        TXT_REPORTTITLE: Label '"Actual vs. budget per %1 for the Period %2 "';
        GLACCashatBank: Text[100];
        GLACCashatHand: Text[100];
        GLACWorkingAdvance: Text[100];
        GLACOthers: Text[100];
        Amt_Actual_Period: Decimal;
        Amt_Actual_YTD: Decimal;
        Amt_Actual_ToDate: Decimal;
        Amt_Budget_Annual: Decimal;
        Amt_Budget_ToDate: Decimal;
        Amt_Variance_Period: Decimal;
        Amt_Variance_ToDate: Decimal;
        Total_Amt_Actual_Period: Decimal;
        Total_Amt_Actual_YTD: Decimal;
        Total_Amt_Actual_ToDate: Decimal;
        Total_Amt_Budget_Annual: Decimal;
        Total_Amt_Budget_ToDate: Decimal;
        Total_Amt_Variance_Period: Decimal;
        Total_Amt_Variance_ToDate: Decimal;
        Amt_OpeningBalance: Decimal;
        Amt_Income: Decimal;
        Amt_Transfers: Decimal;
        Amt_Expense: Decimal;
        Amt_CashAtBank: Decimal;
        Amt_CashAtHand: Decimal;
        Amt_WorkingAdvance: Decimal;
        Amt_Others: Decimal;
        Amt_Payable: Decimal;
        Amt_Actual_PeriodGainLoss: Decimal;
        Amt_PriorYear_Adj: Decimal;
        GLAccount1: Record "G/L Account";
        GLAccount2: Record "G/L Account";
        StartDate: Date;
        PrevYearStartDate: Date;
        PrevYearEndDate: Date;
        FinStartDate: Date;
        MaxDate: Date;
        minDate: Date;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Donor_CaptionLbl: Label 'Donor:';
        Project_CaptionLbl: Label 'Project:';
        Budget_CaptionLbl: Label 'Budget:';
        Currency_Code_CaptionLbl: Label 'Currency Code:';
        USDCaptionLbl: Label 'USD';
        Income_GL_AC_sCaptionLbl: Label 'Income GL AC''s';
        Expense_GL_AC_sCaptionLbl: Label 'Expense GL AC''s';
        Currency_Code_Caption_Control1102750029Lbl: Label 'Currency Code:';
        PeriodCaptionLbl: Label 'Period';
        Amt_Actual_PeriodCaptionLbl: Label 'Expenses Period';
        Amt_Actual_YTDCaptionLbl: Label 'Expenses YTD';
        Amt_Budget_AnnualCaptionLbl: Label 'Budget YTD';
        Variance_YTDCaptionLbl: Label 'Variance YTD';
        Amt_Actual_ToDateCaptionLbl: Label 'Expenses To Date';
        Amt_Budget_ToDateCaptionLbl: Label 'Budget To Date';
        DonorActivityCodeValue: Code[30];
        Variance_To_DateCaptionLbl: Label 'Variance To Date';
        TotalCaptionLbl: Label 'Total';
        Presented_By_CaptionLbl: Label 'Presented By:';
        Total_Funds_Available_CaptionLbl: Label 'Total Funds Available:';
        Cash_at_BankCaptionLbl: Label 'Cash at Bank';
        Working_advance_Uncleared_balancesCaptionLbl: Label 'Working advance/Uncleared balances';
        Branch_Working_AdvanceCaptionLbl: Label 'Branch Working Advance';
        Cash_at_HandCaptionLbl: Label 'Cash at Hand';
        TotalCaption_Control1102750043Lbl: Label 'Total';
        Closing_BalanceCaptionLbl: Label 'Closing Balance';
        Expenses_PeriodCaptionLbl: Label 'Expenses Period';
        Funds_AvailableCaptionLbl: Label 'Funds Available';
        Received_this_PeriodCaptionLbl: Label 'Received this Period';
        Opening_BalanceCaptionLbl: Label 'Opening Balance';
        PayablesCaptionLbl: Label 'Payables';
        TransfersCaptionLbl: Label 'Transfers';
        Revaluation_Gains_LossesCaptionLbl: Label 'Revaluation Gains/Losses';
        Prior_Year_AdjustmentsCaptionLbl: Label 'Prior Year Adjustments';
        The_undersigned_herby_certify_that_all_expenditures_are_correct_CaptionLbl: Label 'The undersigned herby certify that all expenditures are correct.';
        Prepared_by_CaptionLbl: Label 'Prepared by:';
        Endorsed_By_CaptionLbl: Label 'Endorsed By:';
        Budget_Holder_CaptionLbl: Label 'Budget Holder:';
        Signed_CaptionLbl: Label 'Signed:';
        Date_CaptionLbl: Label 'Date:';
        Signed_Caption_Control1000000002Lbl: Label 'Signed:';
        Signed_Caption_Control1000000003Lbl: Label 'Signed:';
        Date_Caption_Control1000000023Lbl: Label 'Date:';
        Date_Caption_Control1000000027Lbl: Label 'Date:';


    procedure CalculateLine(DimensionValue: Code[20]);
    begin
        Amt_Actual_Period := 0;
        Amt_Actual_YTD := 0;
        BurnRatePerc := 0;
        Amt_Actual_ToDate := 0;
        Amt_Budget_Annual := 0;
        Amt_Budget_ToDate := 0;
        Amt_Variance_Period := 0;
        Amt_Variance_ToDate := 0;

        Amt_Actual_PeriodGainLoss := 0;
        Amt_PriorYear_Adj := 0;

        with GLAccount do begin

            // Calculate Net_Change *********************************
            SETFILTER("Date Filter", FilterPeriod);
            //SETFILTER ("Global Dimension 3 Filter", '%1', DimensionValue);
            //New KTM
            if DimensionCodeOption = DimensionCodeOption::ACTIVITY then
                SETFILTER("Global Dimension 1 Filter", '%1', DimensionValue);
            if DimensionCodeOption = DimensionCodeOption::DONORACTIVITY then
                SETFILTER("Shortcut Dimension 4 Filter", '%1', DimensionValue);


            IF FIND('-') THEN
                REPEAT
                    CALCFIELDS("Net Change.", "Additional-Currency Net Chang.");
                    //Amt_Actual_Period += "Net Change.";
                    Amt_Actual_Period += "Additional-Currency Net Chang.";
                UNTIL NEXT = 0;


            // Calculate YTD and Budget *********************************
            //KTM 11/06/21
            //EXPENSE YTD
            SETFILTER("Date Filter", '%1..%2', FinStartDate, TODAY);
            IF FIND('-') THEN
                REPEAT
                    CALCFIELDS("Additional-Currency Net Chang.", "Budgeted Amount Add. Curr");

                    Amt_Actual_YTD += "Additional-Currency Net Chang.";
                    Amt_Budget_Annual += "Budgeted Amount Add. Curr";

                UNTIL NEXT = 0;
            //KTM 11/06/21 END


            Amt_Variance_Period := Amt_Budget_Annual - Amt_Actual_YTD;

            If Amt_Budget_Annual <> 0 then
                BurnRatePerc := Round(Amt_Actual_Period / Amt_Budget_Annual * 100, 0.01);



            // Calculate Actual Project-to-date *********************************
            IF FIND('-') THEN
                REPEAT
                    //Amt_Actual_ToDate += CalcNetChange (GLAccount, 0D, PeriodEndDate, TRUE)
                    Amt_Actual_ToDate += CalcNetChange(GLAccount, 0D, PeriodEndDate, FALSE)
                UNTIL NEXT = 0;

            // Calculate Budget Project-to-date *********************************
            SETRANGE("Date Filter", 0D, PeriodEndDate);
            IF FIND('-') THEN
                REPEAT
                    CALCFIELDS("Budgeted Amount", "Budgeted Amount Add. Curr");
                    Amt_Budget_ToDate += "Budgeted Amount Add. Curr";
                UNTIL NEXT = 0;
            Amt_Variance_ToDate := Amt_Budget_ToDate - Amt_Actual_ToDate;

        END;

        WITH GLAccount1 DO BEGIN

            // Calculate total revaluation gains/losses *********************************
            SETFILTER("Date Filter", FilterPeriod);

            //SETFILTER ("No.", FilterAccExpense);
            SETFILTER("Account Type", 'Posting');
            SETFILTER("Budget Filter", FilterBudget);
            SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
            SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);
            IF GLSetup.GET THEN
                SETFILTER("No.", GLSetup."Revaluation Gain/Loss Filter");
            IF FIND('-') THEN
                REPEAT
                    CALCFIELDS("Net Change.", "Additional-Currency Net Chang.");
                    //Amt_Actual_PeriodGainLoss += "Net Change.";
                    Amt_Actual_PeriodGainLoss += "Additional-Currency Net Chang.";
                UNTIL NEXT = 0;
        END;


        WITH GLAccount2 DO BEGIN
            // Calculate prior year adjustments *********************************

            //SETFILTER ("Date Filter",'%1..%2',PrevYearStartDate,PrevYearEndDate);
            SETFILTER("Date Filter", '%1..%2', PeriodStartDate, PeriodEndDate);

            //SETFILTER ("No.", FilterAccExpense);
            SETFILTER("Account Type", 'Posting');
            SETFILTER("Budget Filter", FilterBudget);
            SETFILTER("Global Dimension 1 Filter", FilterGlobalDim1);
            SETFILTER("Global Dimension 2 Filter", FilterGlobalDim2);

            IF GLSetup.GET THEN
                SETFILTER("No.", GLSetup."Prior Year Adjust. Filter");
            IF FIND('-') THEN
                REPEAT
                    CALCFIELDS("Net Change.", "Additional-Currency Net Chang.");
                    //Amt_PriorYear_Adj += "Net Change.";
                    Amt_PriorYear_Adj += "Additional-Currency Net Chang.";
                UNTIL NEXT = 0;


        end;
    end;

    procedure ZeroLine(ActualPeriod: Decimal; ActualYTD: Decimal; Budget: Decimal): Boolean;
    begin
        //VEGA OVJ 03/10/12
        //EXIT ((Amt_Actual_Period = 0) AND (Amt_Actual_YTD = 0) AND (Amt_Budget_Annual = 0));
        exit((Amt_Actual_Period = 0) and (Amt_Actual_YTD = 0) and (Amt_Budget_Annual = 0)
              and (Amt_Actual_ToDate = 0) and (Amt_Budget_ToDate = 0));
        //VEGA OVJ 03/10/12 End
    end;

    procedure GetYTDStartDate(PeriodStartDate: Date): Date;
    var
        AccountingPeriod: Record "Accounting Period";
        FromDate: Date;
        ToDate: Date;
    begin
        with AccountingPeriod do begin
            SETRANGE("New Fiscal Year", true);
            SETFILTER("Starting Date", '<=%1', PeriodStartDate);
            if FINDLAST then
                exit("Starting Date");
        end;

        exit(0D);
    end;

    procedure CalcNetChange(var GLAccount: Record "G/L Account"; FromDate: Date; ToDate: Date; CalcLCY: Boolean): Decimal;
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        //Calculate total net change across financial years
        if (FromDate = 0D) then
            AccountingPeriod.SETRANGE("Starting Date", 0D, ToDate)
        else
            AccountingPeriod.SETRANGE("Starting Date", CALCDATE('+1D', FromDate), ToDate);
        AccountingPeriod.SETRANGE("New Fiscal Year", true);
        if (AccountingPeriod.FINDFIRST) then
            exit(CalcNetChange(GLAccount, FromDate, CALCDATE('-1D', AccountingPeriod."Starting Date"), CalcLCY)
                  + CalcNetChange(GLAccount, AccountingPeriod."Starting Date", ToDate, CalcLCY));

        with GLAccount do begin
            SETFILTER("Date Filter", '%1..%2', FromDate, ToDate);
            if CalcLCY then begin
                //    CALCFIELDS ("Net Change.")
                CALCFIELDS("Additional-Currency Net Chang.");
                "Net Change." := "Additional-Currency Net Chang.";
            end
            else begin
                CALCFIELDS("Additional-Currency Net Chang.");
                "Net Change." := "Additional-Currency Net Chang.";
            end;

            exit("Additional-Currency Net Chang.");
        end;
    end;
}

