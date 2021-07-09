pageextension 50001 "Extend General Journal" extends "General Journal"
{
    layout

    {


        MODIFY(ShortcutDimCode4)
        {
            //ApplicationArea = all;
            // Visible = true;
            trigger OnLookup(var Text: Text): Boolean
            begin
                DimValueRec.RESET;
                DimValueRec.SETRANGE(ActivityCode, "Shortcut Dimension 1 Code");
                DimValueRec.SETRANGE(DonorCode, "Shortcut Dimension 3 Code");
                DimValueRec.SetFilter("Global Dimension No.", '4');
                DimValueRec.SetFilter("Dimension Value Type", 'Standard');
                DimValueRec.SetFilter(Blocked, 'No');
                IF PAGE.RUNMODAL(PAGE::"Dimension Value List", DimValueRec) = ACTION::LookupOK THEN begin
                    ShortcutDimCode[4] := DimValueRec.Code;
                    ShortcutDimCode4 := DimValueRec.Code;
                    ValidateShortcutDimCode(4, DimValueRec.Code);
                    OnAfterValidateShortcutDimCode2(Rec, ShortcutDimCode, 4);
                    ShowShortcutDimCode(ShortcutDimCode);
                    CurrPage.Update();

                end;



            end;


        }



        addafter("Shortcut Dimension 2 Code")
        {

            field(Recipient; Recipient)
            {
                ApplicationArea = all;
            }
            field("No. of Units"; "No. of Units")
            {
                ApplicationArea = all;
            }
            field("Unit of Measure"; "Unit of Measure")
            {
                ApplicationArea = all;
            }
            field("Import From Branches"; "Import From Branches")
            {
                ApplicationArea = all;
            }
            field("Import Error Description"; "Import Error Description")
            {
                ApplicationArea = all;
            }
            field("Employee No"; "Employee No")
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(Preview)
        {
            Visible = false;
        }
        addafter("Test Report")
        {

            action("Post.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    dim: Record "Dimension Value";
                    glsetup: Record "General Ledger Setup";
                    GenJnLnCopy: Record "Gen. Journal Line";
                    GenJnLnCopy2: Record "Gen. Journal Line";
                    BalAccNoInExpenseAccRange: Boolean;
                    AccNoInExpenseAccRange: Boolean;

                begin



                    BalAccNoInExpenseAccRange := false;
                    AccNoInExpenseAccRange := false;

                    GenJnLnCopy.Copy(Rec);
                    GenJnLnCopy2.copy(Rec);
                    glsetup.Get();

                    GenJnLnCopy2.setfilter("Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy2.Find('-') then
                        AccNoInExpenseAccRange := true;


                    GenJnLnCopy.SetFilter("Bal. Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy.Find('-') then
                        BalAccNoInExpenseAccRange := true;

                    //Message('AccNoInExpenseAccRange %1 BalAccNoInExpenseAccRange %2', AccNoInExpenseAccRange, BalAccNoInExpenseAccRange);

                    if ("Shortcut Dimension 4 Code" <> '') and ("Shortcut Dimension 3 Code" = '') then begin
                        if BalAccNoInExpenseAccRange or AccNoInExpenseAccRange then begin
                            dim.SetFilter(DonorCode, "Shortcut Dimension 4 Code");
                            IF dim.Find('-') then
                                Error('%1 must have a value', FieldCaption("Shortcut Dimension 3 Code"));
                        end;

                    end;
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    CurrentJnlBatchName := GetRangeMax("Journal Batch Name");
                    if IsSimplePage then
                        if GeneralLedgerSetup."Post with Job Queue" then
                            NewDocumentNo()
                        else
                            SetDataForSimpleModeOnPost;
                    SetJobQueueVisibility();
                    CurrPage.Update(false);
                end;
            }
            action("Preview.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    dim: Record "Dimension Value";
                    GenJnlPost: Codeunit "Gen. Jnl.-Post";
                    glsetup: Record "General Ledger Setup";
                    GenJnLnCopy: Record "Gen. Journal Line";
                    GenJnLnCopy2: Record "Gen. Journal Line";
                    BalAccNoInExpenseAccRange: Boolean;
                    AccNoInExpenseAccRange: Boolean;

                begin


                    BalAccNoInExpenseAccRange := false;
                    AccNoInExpenseAccRange := false;

                    GenJnLnCopy.Copy(Rec);
                    GenJnLnCopy2.copy(Rec);
                    glsetup.Get();

                    GenJnLnCopy2.setfilter("Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy2.Find('-') then
                        AccNoInExpenseAccRange := true;


                    GenJnLnCopy.SetFilter("Bal. Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy.Find('-') then
                        BalAccNoInExpenseAccRange := true;

                    //Message('AccNoInExpenseAccRange %1 BalAccNoInExpenseAccRange %2', AccNoInExpenseAccRange, BalAccNoInExpenseAccRange);

                    if ("Shortcut Dimension 4 Code" <> '') and ("Shortcut Dimension 3 Code" = '') then begin
                        if BalAccNoInExpenseAccRange or AccNoInExpenseAccRange then begin
                            dim.SetFilter(DonorCode, "Shortcut Dimension 4 Code");
                            IF dim.Find('-') then
                                Error('%1 must have a value', FieldCaption("Shortcut Dimension 3 Code"));
                        end;


                    end;
                    GenJnlPost.Preview(Rec);

                end;

            }
            action("PostAndPrint.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post and &Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    dim: Record "Dimension Value";
                    glsetup: Record "General Ledger Setup";
                    GenJnLnCopy: Record "Gen. Journal Line";
                    GenJnLnCopy2: Record "Gen. Journal Line";
                    BalAccNoInExpenseAccRange: Boolean;
                    AccNoInExpenseAccRange: Boolean;

                begin

                    BalAccNoInExpenseAccRange := false;
                    AccNoInExpenseAccRange := false;

                    GenJnLnCopy.Copy(Rec);
                    GenJnLnCopy2.copy(Rec);
                    glsetup.Get();

                    GenJnLnCopy2.setfilter("Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy2.Find('-') then
                        AccNoInExpenseAccRange := true;


                    GenJnLnCopy.SetFilter("Bal. Account No.", glsetup."Expense A/C Filter");
                    if GenJnLnCopy.Find('-') then
                        BalAccNoInExpenseAccRange := true;

                    //Message('AccNoInExpenseAccRange %1 BalAccNoInExpenseAccRange %2', AccNoInExpenseAccRange, BalAccNoInExpenseAccRange);

                    if ("Shortcut Dimension 4 Code" <> '') and ("Shortcut Dimension 3 Code" = '') then begin
                        if BalAccNoInExpenseAccRange or AccNoInExpenseAccRange then begin
                            dim.SetFilter(DonorCode, "Shortcut Dimension 4 Code");
                            IF dim.Find('-') then
                                Error('%1 must have a value', FieldCaption("Shortcut Dimension 3 Code"));
                        end;

                    end;
                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post+Print", Rec);
                    CurrentJnlBatchName := GetRangeMax("Journal Batch Name");
                    if GeneralLedgerSetup."Post & Print with Job Queue" then
                        NewDocumentNo()
                    else
                        SetDataForSimpleModeOnPost;
                    SetJobQueueVisibility();
                    CurrPage.Update(false);

                end;
            }
        }



    }
    // Trigger OnOpenPage()
    // begin
    //     ShowDonorActivity := FALSE;
    //     IF "Shortcut Dimension 4 Code" <> '' then
    //         ShowDonorActivity := TRUE;
    // END;

    var
        ShortcutDimCode: array[8] of Code[20];
        //ShortcutDimCode3: Code[20];
        ShortcutDimCode4: Code[20];
        //ShortcutDimCode5: Code[20];
        ShowDonorActivity: Boolean;

        GeneralLedgerSetup: Record "General Ledger Setup";
        GenJnlManagement: Codeunit GenJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        PayrollManagement: Codeunit "Payroll Management";
        ClientTypeManagement: Codeunit "Client Type Management";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ChangeExchangeRate: Page "Change Exchange Rate";
        GLReconcile: Page Reconciliation;
        CurrentJnlBatchName: Code[10];
        AccName: Text[100];
        BalAccName: Text[100];
        DimValueRec: Record "Dimension Value";
        Balance: Decimal;
        TotalBalance: Decimal;
        NumberOfRecords: Integer;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        HasIncomingDocument: Boolean;
        ApplyEntriesActionEnabled: Boolean;
        [InDataSet]
        BalanceVisible: Boolean;
        [InDataSet]
        TotalBalanceVisible: Boolean;
        StyleTxt: Text;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        CanCancelApprovalForJnlBatch: Boolean;
        CanCancelApprovalForJnlLine: Boolean;
        ImportPayrollTransactionsAvailable: Boolean;
        IsSaaSExcelAddinEnabled: Boolean;
        CanRequestFlowApprovalForBatch: Boolean;
        CanRequestFlowApprovalForBatchAndAllLines: Boolean;
        CanRequestFlowApprovalForBatchAndCurrentLine: Boolean;
        CanCancelFlowApprovalForBatch: Boolean;
        CanCancelFlowApprovalForLine: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        IsSaaS: Boolean;
        IsSimplePage: Boolean;
        JobQueuesUsed: Boolean;
        JobQueueVisible: Boolean;
        CurrentDocNo: Code[20];
        CurrentPostingDate: Date;
        CurrentCurrencyCode: Code[10];
        IsChangingDocNo: Boolean;
        MissingExchangeRatesQst: Label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        PostedFromSimplePage: Boolean;
        DocumentNumberMsg: Label 'Document No. must have a value in Gen. Journal Line.';

        Genjnl: Record "Gen. Journal Line";

    //////Modify page action end
    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode2(var GenJournalLine: Record "Gen. Journal Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin

    end;


    local procedure SetJobQueueVisibility()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        JobQueuesUsed := GeneralLedgerSetup.JobQueueActive;
    end;

    local procedure SetDataForSimpleModeOnPost()
    begin
        PostedFromSimplePage := true;
        SetCurrentKey("Document No.", "Line No.");
        if FindFirst then
            SetDataForSimpleMode(Rec)
    end;

    local procedure SetDataForSimpleMode(GenJournalLine1: Record "Gen. Journal Line")
    begin
        CurrentDocNo := GenJournalLine1."Document No.";
        CurrentPostingDate := GenJournalLine1."Posting Date";
        CurrentCurrencyCode := GenJournalLine1."Currency Code";
        SetDocumentNumberFilter(CurrentDocNo);
    end;

    local procedure SetDocumentNumberFilter(DocNoToSet: Code[20])
    var
        OriginalFilterGroup: Integer;
    begin
        OriginalFilterGroup := FilterGroup;
        FilterGroup := 25;
        SetFilter("Document No.", DocNoToSet);
        FilterGroup := OriginalFilterGroup;
    end;

}


