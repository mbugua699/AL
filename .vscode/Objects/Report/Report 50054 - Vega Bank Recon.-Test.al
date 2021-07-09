/// <summary>
/// Report Vega Bank Recon.-Test (ID 50054).
/// </summary>
report 50054 "Vega Bank Recon.-Test"
{

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/Objects/Report/Vega Bank Recon.-Test.rdl';
    Caption = 'Bank Recon.-Test';


    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            DataItemTableView = SORTING("Bank Account No.", "Statement No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Bank Account No.", "Statement No.", "Statement Type";
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
            column(Bank_Acc__Reconciliation__Bank_Account_No__; "Bank Account No.")
            {
            }
            column(Bank_Acc__Reconciliation__Bank_Acc__Reconciliation___Statement_Ending_Balance_; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankAcc_Name; BankAcc.Name)
            {
            }
            column(Bank_Acc__Reconciliation__Bank_Acc__Reconciliation___Statement_Date_; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(BankAcc__Bank_Account_No__; BankAcc."Bank Account No.")
            {
            }
            column(Bank_Acc__Reconciliation__Bank_Acc__Reconciliation___Statement_No__; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(BankAcc__Balance_at_Date_; BankAcc."Balance at Date")
            {
            }
            column(BankAcc__Balance_at_Date___Bank_Acc__Reconciliation___Statement_Ending_Balance_; BankAcc."Balance at Date" - "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BANK_ACCOUNT_RECONCILIATION_REPORTCaption; BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Account_CodeCaption; Bank_Account_CodeCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(Statement_DateCaption; Statement_DateCaptionLbl)
            {
            }
            column(Cash_book_balanceCaption; Cash_book_balanceCaptionLbl)
            {
            }
            column(Difference_to_be_explainedCaption; Difference_to_be_explainedCaptionLbl)
            {
            }
            column(Bank_Account_NoCaption; Bank_Account_NoCaptionLbl)
            {
            }
            column(Statement_No_Caption; Statement_No_CaptionLbl)
            {
            }
            column(Statement_balanceCaption; Statement_balanceCaptionLbl)
            {
            }
            column(Prepared_by_____________Date__________________Caption; Prepared_by_____________Date__________________Lbl)
            {
            }
            column(F_OCaption; F_OCaptionLbl)
            {
            }
            column(Approved_by_____________Date________________Caption; Approved_by___________Date__________________Lbl)
            {
            }
            column(F_A_MCaption; F_A_MCaptionLbl)
            {
            }
            dataitem("Bank Account Ledger Entry 2"; "Bank Account Ledger Entry")
            {

                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemLinkReference = "Bank Acc. Reconciliation";
                DataItemTableView = SORTING("Entry No.");
                column(Bank_Account_Ledger_Entry__Document_No__; DocumentNo)
                {
                }
                column(Bank_Account_Ledger_Entry__Posting_Date_; PostingDate)
                {
                }
                column(Bank_Account_Ledger_Entry_Description; Description_)
                {
                }
                column(Bank_Account_Ledger_Entry_Amount; Amount_)
                {
                }
                column(Bank_Account_Ledger_Entry_Amount_Control1102750034; Amount)
                {
                }

                column(AmountCaption; AmountCaptionLbl)
                {
                }

                column(Posting_DateCaption; Posting_DateCaptionLbl)
                {
                }
                column(Document_No_Caption; Document_No_CaptionLbl)
                {
                }

                column(Differences_explained_by_uncredited_and_unpresented_cheques_Caption; Differences_explained_by_uncredited_and_unpresented_cheques_CaptionLbl)
                {
                }
                column(TotalsCaption; TotalsCaptionLbl)
                {
                }
                column(DifferenceTotal; DifferenceTotalCaptionLbl)
                {

                }
                column(TotalActualBank; TotalActualBankCaptionLbl)
                {

                }
                column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Bank_Account_Ledger_Entry_Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Global_Dimension_2_CodeCaption_2; Global_Dimension_2_CodeCaptionLbl)
                {
                }

                column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code_2; GlobalDimension2Code)
                {
                }
                column(Project_Name_description_2; Project_Name)
                {
                }
                column(totalAmountPerDimension____2; totalAmountPerDimension)
                {

                }


                column(Bank_Account_Ledger_Entry_Global_Dimension_2_Code; GlobalDimension2Code2)
                {
                }
                column(Project_Name_description; Project_Name)
                {
                }
                column(totalAmountPerDimension____; totalAmountPerDimension)
                {

                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Global_Dimension_2_CodeCaption; Global_Dimension_2_CodeCaptionLbl)
                {
                }



                trigger OnAfterGetRecord()
                var
                    BankAccLegEntry: Record "Bank Account Ledger Entry";
                    BankAccLegEntry2: Record "Bank Account Ledger Entry";
                    Dim: Record "Dimension Value";
                    Applied: Boolean;
                begin
                    totalAmountPerDimension := 0;
                    Project_Name := '';


                    Description_ := '';
                    PostingDate := 0D;
                    DocumentNo := '';
                    GlobalDimension2Code := '';
                    Amount_ := 0;
                    Applied := false;

                    BankAccLegEntry.SetRange("Entry No.", "Bank Account Ledger Entry 2"."Entry No.");
                    BankAccLegEntry.SETFILTER("Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccLegEntry.SETFILTER("Statement Status", '%1', "Statement Status"::Open);
                    BankAccLegEntry.SETRANGE("Posting Date", BankAccReconciliationFilter."Start Date", BankAccReconciliationFilter."End Date");
                    BankAccLegEntry.SETFILTER("Source Code", '<>%1', 'EXCHRATADJ');
                    BankAccLegEntry.SetFilter("Global Dimension 2 Code", "Bank Account Ledger Entry 2"."Global Dimension 2 Code");
                    if BankAccLegEntry.Find('-') then begin

                        Description_ := BankAccLegEntry.Description;
                        PostingDate := BankAccLegEntry."Posting Date";
                        DocumentNo := BankAccLegEntry."Document No.";
                        GlobalDimension2Code := BankAccLegEntry."Global Dimension 2 Code";
                        Amount_ := BankAccLegEntry.Amount;
                    end;




                    BankAccLegEntry2.SetFilter("Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccLegEntry2.SetFilter("Posting Date", '<=%1', "Bank Acc. Reconciliation"."Statement Date");
                    BankAccLegEntry2.SetFilter("Global Dimension 2 Code", "Global Dimension 2 Code");
                    BankAccLegEntry2.SETFILTER("Statement No.", '');
                    if BankAccLegEntry2.Find('-') then begin
                        repeat
                            totalAmountPerDimension += BankAccLegEntry2.Amount
                        until BankAccLegEntry2.Next = 0;

                        GlobalDimension2Code2 := BankAccLegEntry2."Global Dimension 2 Code";

                        Dim.SetFilter(code, BankAccLegEntry2."Global Dimension 2 Code");
                        Dim.SetFilter("Dimension Code", 'PROJECT');
                        If dim.Find('-') Then
                            Project_Name := Dim.Name;

                    END;



                end;

            }


            trigger OnAfterGetRecord();
            begin
                BankAcc.GET("Bank Account No.");
                BankAcc.SETFILTER("Date Filter", '<=%1', "Statement Date");
                BankAcc.CALCFIELDS("Balance at Date");
                CalcReconciliationTotals;

                BankAccReconciliationFilter.GET("Statement Type", "Bank Account No.", "Statement No.");

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

    trigger OnInitReport();
    begin
        NotCalculated := -1;
    end;

    var
        BankAcc: Record "Bank Account";
        TotalPresented: Decimal;
        TotalUnpresentedDebit: Decimal;
        TotalUnpresentedCredit: Decimal;
        NotCalculated: Decimal;
        Project_Name: Code[50];
        totalAmountPerDimension: Decimal;
        BankAccReconciliationFilter: Record "Bank Acc. Reconciliation";
        BANK_ACCOUNT_RECONCILIATION_REPORTCaptionLbl: Label 'BANK ACCOUNT RECONCILIATION REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Bank_Account_CodeCaptionLbl: Label 'Bank Account Code';
        BankCaptionLbl: Label 'Bank';
        AmountCaption: Label 'Amount';
        Statement_DateCaptionLbl: Label 'Statement Date';
        Cash_book_balanceCaptionLbl: Label 'Cash book balance';
        Difference_to_be_explainedCaptionLbl: Label 'Difference to be explained';
        Bank_Account_NoCaptionLbl: Label 'Bank Account No';
        Statement_No_CaptionLbl: Label 'Statement No.';
        Statement_balanceCaptionLbl: Label 'Statement balance';
        Prepared_by_____________Date__________________Lbl: Label 'Prepared by:......................................................................                     Date...............................................';
        F_OCaptionLbl: Label 'F.O';
        Approved_by___________Date__________________Lbl: Label 'Approved by:......................................................................                     Date...............................................';
        F_A_MCaptionLbl: Label 'F.A.M';
        AmountCaptionLbl: Label 'Amount';
        DescriptionCaptionLbl: Label 'Description';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Document_No_CaptionLbl: Label 'Document No.';
        Global_Dimension_2_CodeCaptionLbl: Label 'Project Code';
        Differences_explained_by_uncredited_and_unpresented_cheques_CaptionLbl: Label '"Differences explained by uncredited and unpresented cheques "';
        TotalsCaptionLbl: Label 'Totals';
        DifferenceTotalCaptionLbl: Label 'Difference Total';
        TotalActualBankCaptionLbl: Label 'Total Actual Bank';
        GlobalDimension2Code: code[20];
        GlobalDimension2Code2: Code[20];
        DocumentNo: code[20];
        PostingDate: Date;
        Description_: Text[50];
        Amount_: Decimal;


    procedure CalcReconciliationTotals();
    var
        ReconciliationLine: Record "Bank Acc. Reconciliation Line";
    begin


        TotalPresented := 0;
        TotalUnpresentedDebit := 0;
        TotalUnpresentedCredit := 0;
        with ReconciliationLine do begin
            SETRANGE("Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
            SETRANGE("Statement No.", "Bank Acc. Reconciliation"."Statement No.");



            if FIND('-') then
                repeat
                    if Include then
                        TotalPresented += "Applied Amount"
                    else
                        if "Applied Amount" > 0 then
                            TotalUnpresentedDebit += "Applied Amount"
                        else
                            TotalUnpresentedCredit += "Applied Amount";
                until NEXT = 0;
        end;
    end;
}

