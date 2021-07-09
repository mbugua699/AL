/// <summary>
/// Report Import Branch Journal (ID 50010).
/// </summary>
report 50010 "Import Branch Journal"
{
    // version VEGA-ImportBranches14.02.01

    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    group("Import from :")
                    {
                        field("Workbook File Name"; FileName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Workbook File Name';

                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';

                            Trigger OnLookup(VAR Text: Text): Boolean
                            begin
                                //FileName := CommonDialogMgt.OpenFile(Text006,FileName,2,'',0);
                                //FileName := FileMgmt.OpenFileDialog(Text006, '', 'Word Files (*.XML)|*.XML|All Files (*.*)|*.*');
                                FileUploaded := UploadIntoStream(Text006, '', '', FileName, Instr);
                                //Message('File name %1', FileName);

                            end;
                        }
                        field("Worksheet Name"; SheetName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Worksheet Name';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                            Trigger OnLookup(VAR Text: Text): Boolean
                            begin
                                //FileName := CommonDialogMgt.OpenFile(Text006,FileName,2,'',0);
                                SheetName := ExcelBuf.SelectSheetsNameStream(Instr);

                            end;
                        }

                    }

                    group("Import to :")
                    {
                        field("Journal template Name"; ReqJnlTemplateName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Journal template Name';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                LookupTemplateName(ReqJnlTemplateName);
                                ShowDocumentNo;
                            end;
                        }
                        field("Journal Batch Name"; ReqJnlBatchName)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Journal Batch Name';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                            trigger OnLookup(var Text: Text): Boolean
                            begin

                                LookupBatchName(ReqJnlBatchName);
                                ShowDocumentNo;
                            end;
                        }
                        field("Document No."; ReqDocumentNo)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Document No.';
                            Enabled = ReqDocumentNoEnable;
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                        }
                        field("Bal. Acc. Type"; ReqBalAccType)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Acc. Type';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                        }
                        field("Bal. Acc. No."; ReqBalAccNo)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Acc. No.';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                LookupBalAccNo(ReqBalAccNo);
                            end;
                        }
                        field("Skip Credits?"; SkipCredits)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Skip Credits?';
                            //ToolTip = 'Specifies the posting date for the invoice(s) that the batch job creates. This field must be filled in.';
                        }
                    }

                }
            }
        }
        trigger OnOpenPage()
        begin

            ShowDocumentNo;
            SkipCredits := TRUE;
        end;

        // actions
        // {

        // }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        ExcelBuf.DELETEALL;

        if RecordCount = 0 then
            MESSAGE(TEXT_NO_LINES_IMPORTED, ReqJnlBatchName)
        else
            MESSAGE(TEXT_LINES_IMPORTED, RecordCount, ReqJnlBatchName);
    end;

    trigger OnPreReport();
    begin
        if not CheckJournal(ReqJnlTemplateName, ReqJnlBatchName) then
            ERROR(Text003);

        if (GenJournalBatch."No. Series" = '') and (ReqDocumentNo = '') then
            ERROR(ERR_DOCUMENT_NO);

        if GenJournalBatch."No. Series" <> '' then begin
            NextDocumentNo := NoSeriesMgt.TryGetNextNo(GenJournalBatch."No. Series", WORKDATE);
            CLEAR(NoSeriesMgt);
        end;

        if ReqBalAccNo = '' then
            ERROR(ERR_BAL_ACC_NO);

        ExcelBuf.LOCKTABLE;

        InitImport;
        ReadExcelSheet;
        ProcessImportData;
    end;

    var
        Text006: Label 'Import Excel File';
        Text007: Label 'Processing Data...\\';
        ErrImport001: Label 'You can only import Excel worksheet with %1 columns.';
        ErrImport002: Label 'Row %1, Column %2: Header must be ''%3''.';
        ErrImport003: Label 'Row %1, Column %2: %3 cannot exceed %4 characters.';
        ErrImport004: Label 'Row %1, Column %2: %3 invalid %4.';
        ReqJnlTemplateName: Code[10];
        ReqJnlBatchName: Code[10];
        ReqDocumentNo: Code[20];
        ReqDocumentNoEnable: Boolean;
        ReqBalAccType: Option Debtor,"Bank Account";
        ReqBalAccNo: Code[20];
        GenJournalBatch: Record "Gen. Journal Batch";
        ImportBranchesSetup: Record "General Ledger Setup";
        GLSetup: Record "General Ledger Setup";
        ExcelBuf: Record "Excel Buffer";
        ExcelHeaderRow: array[13] of Text[250];
        ExcelDataRow: array[13] of Text[250];
        ColumnDataType: array[13] of Option " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        HeaderRowNo: Integer;
        FirstLineRowNo: Integer;
        NoOfColumns: Integer;
        DebitColumn: Integer;
        CreditColumn: Integer;
        ColumnDimension: array[13] of Integer;
        FileName: Text[250];
        FileMgmt: Codeunit "File Management";
        Instr: InStream;
        FileUploaded: Boolean;
        SheetName: Text[250];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        ErrRequest001: Label 'You must specify a journal batch to import into.';
        ErrRequest002: Label 'Journal batch %1 does not exist.';
        LineNo: Integer;
        ReportingDate: Date;
        ErrRequest003: Label 'Please select Journal Template Name.';
        ErrRequest004: Label 'Batch %1 contains entries.';
        ERR_DOCUMENT_NO: Label 'Please specify Document No.';
        ERR_BAL_ACC_NO: Label 'Please specify Bal. Acc. No.';
        Text001: Label 'Batch %1 already has %2 journal lines.\Do you want to append lines imported?';
        Text002: Label 'Do you want to delete existing journal lines?';
        Text003: Label 'Import cancelled by user.';
        InpDate: Date;
        InpEntryNo: Integer;
        InpDescription: Text[50];
        InpRecipient: Text[80];
        InpGLAccNo: Code[20];
        InpDebitAmount: Decimal;
        InpCreditAmount: Decimal;
        InpBalance: Decimal;
        InpDimensionValue: array[8] of Code[20];
        RecordCount: Integer;
        TEXT_NO_LINES_IMPORTED: Label 'No lines were imported into batch %1.';
        TEXT_LINES_IMPORTED: Label '%1 lines were imported into batch %2.';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextDocumentNo: Code[20];
        SkipCredits: Boolean;

    procedure CheckJournal(JnlTemplateName: Code[10]; JnlBatchName: Code[10]): Boolean;
    var
        GenJournalLine: Record "Gen. Journal Line";
        NoOfLines: Integer;
    begin
        if JnlTemplateName = '' then
            ERROR(ErrRequest003);

        if JnlBatchName = '' then
            ERROR(ErrRequest001);

        with GenJournalLine do begin
            SETRANGE("Journal Template Name", JnlTemplateName);
            SETRANGE("Journal Batch Name", JnlBatchName);
            NoOfLines := COUNT;
            if (NoOfLines <> 0) then begin
                if CONFIRM(Text001, false, JnlBatchName, NoOfLines) then begin     // Confirm append
                    FINDLAST;
                    LineNo := "Line No.";
                end else
                    if CONFIRM(Text002, false, JnlBatchName, NoOfLines) then  // Confirm delete
                        DELETEALL
                    else
                        exit(false);
            end;
        end;

        exit(true);
    end;

    procedure InitImport();
    var
        ColumnNo: Integer;
    begin
        GLSetup.GET;
        WITH ImportBranchesSetup DO BEGIN
            GET;
            FirstLineRowNo := "Data Start Row";

            //KTM DIM
            NoOfColumns := 13;

            ExcelHeaderRow[1] := "Column 1 Header";
            ExcelHeaderRow[2] := "Column 2 Header";
            ExcelHeaderRow[3] := "Column 3 Header";
            ExcelHeaderRow[4] := "Column 4 Header";
            ExcelHeaderRow[5] := "Column 5 Header";
            ExcelHeaderRow[6] := "Column 6 Header";
            ExcelHeaderRow[7] := "Column 7 Header";
            ExcelHeaderRow[8] := "Column 8 Header";
            ExcelHeaderRow[9] := "Column 9 Header";
            ExcelHeaderRow[10] := 'DonorActivity';
            ExcelHeaderRow[11] := "Column 10 Header";
            ExcelHeaderRow[12] := "Column 11 Header";
            ExcelHeaderRow[13] := "Column 12 Header";

            ColumnDataType[1] := "Column 1 Data Type";
            ColumnDataType[2] := "Column 2 Data Type";
            ColumnDataType[3] := "Column 3 Data Type";
            ColumnDataType[4] := "Column 4 Data Type";
            ColumnDataType[5] := "Column 5 Data Type";
            ColumnDataType[6] := "Column 6 Data Type";
            ColumnDataType[7] := "Column 7 Data Type";
            ColumnDataType[8] := "Column 8 Data Type";
            ColumnDataType[9] := "Column 9 Data Type";
            ColumnDataType[10] := "Column 9 Data Type";
            ColumnDataType[11] := "Column 10 Data Type";
            ColumnDataType[12] := "Column 11 Data Type";
            ColumnDataType[13] := "Column 12 Data Type";

            FOR ColumnNo := 1 TO 13 DO

                IF ColumnDataType[ColumnNo] = ColumnDataType[ColumnNo] ::"Debit Amount" THEN
                    DebitColumn := ColumnNo
                ELSE
                    IF ColumnDataType[ColumnNo] = ColumnDataType[ColumnNo] ::"Credit Amount" THEN
                        CreditColumn := ColumnNo
                    ELSE
                        IF ColumnDataType[ColumnNo] = ColumnDataType[ColumnNo] ::Dimension THEN
                            InitDimensionColumn(ColumnNo);
        END;

        //KTM DIM
    end;

    procedure InitDimensionColumn(ColumnNo: Integer);
    var
        DimensionCode: Code[20];
    begin
        //KTM DIM
        WITH ImportBranchesSetup DO
            CASE ColumnNo OF
                1:
                    DimensionCode := "Column 1 Dimension";
                2:
                    DimensionCode := "Column 2 Dimension";
                3:
                    DimensionCode := "Column 3 Dimension";
                4:
                    DimensionCode := "Column 4 Dimension";
                5:
                    DimensionCode := "Column 5 Dimension";
                6:
                    DimensionCode := "Column 6 Dimension";
                7:
                    DimensionCode := "Column 7 Dimension";
                8:
                    DimensionCode := "Column 8 Dimension";
                9:
                    DimensionCode := "Column 9 Dimension";
                10:
                    DimensionCode := 'DONORACTIVITY';
                11:
                    DimensionCode := "Column 10 Dimension";
                12:
                    DimensionCode := "Column 11 Dimension";
                13:
                    DimensionCode := "Column 12 Dimension";
            END;

        //KTM DIM

        if DimensionCode = '' then
            exit;

        with GLSetup do
            case DimensionCode of
                "Shortcut Dimension 1 Code":
                    ColumnDimension[ColumnNo] := 1;
                "Shortcut Dimension 2 Code":
                    ColumnDimension[ColumnNo] := 2;
                "Shortcut Dimension 3 Code":
                    ColumnDimension[ColumnNo] := 3;
                "Shortcut Dimension 4 Code":
                    ColumnDimension[ColumnNo] := 4;
                "Shortcut Dimension 5 Code":
                    ColumnDimension[ColumnNo] := 5;
                "Shortcut Dimension 6 Code":
                    ColumnDimension[ColumnNo] := 6;
                "Shortcut Dimension 7 Code":
                    ColumnDimension[ColumnNo] := 7;
                "Shortcut Dimension 8 Code":
                    ColumnDimension[ColumnNo] := 8;
            end;
    end;

    local procedure ReadExcelSheet();
    begin

        ExcelBuf.Reset();
        ExcelBuf.OpenBookStream(InStr, SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure ProcessImportData();
    var
        PrvRowNo: Integer;
    begin
        Window.OPEN(Text007 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 0;
        PrvRowNo := ImportBranchesSetup."Data Start Row";

        if ExcelBuf.FINDFIRST then
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                case true of
                    ExcelBuf."Column No." > NoOfColumns:
                        ERROR(ErrImport001, NoOfColumns);

                    (ExcelBuf."Row No." = HeaderRowNo)
                  and (UPPERCASE(DELCHR(ExcelBuf."Cell Value as Text", '<>', ' ')) <> ExcelHeaderRow[ExcelBuf."Column No."]):
                        ERROR(ErrImport002, ExcelBuf."Row No.", ExcelColumnID(ExcelBuf."Column No."), ExcelHeaderRow[ExcelBuf."Column No."]);

                    (ExcelBuf."Row No." >= FirstLineRowNo):
                        begin
                            if (ExcelBuf."Row No." > PrvRowNo) then begin
                                ProcessRowData(PrvRowNo);
                                PrvRowNo := ExcelBuf."Row No.";
                            end;
                            ExcelDataRow[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
                        end;
                end;
            until ExcelBuf.NEXT = 0;

        // Process last row - if any rows
        if (PrvRowNo >= FirstLineRowNo) then
            ProcessRowData(PrvRowNo);

        Window.CLOSE;
    end;

    procedure ProcessRowData(RowNo: Integer);
    var
        GenJournalLine: Record "Gen. Journal Line";
        DimensionNo: Integer;
    begin
        // Account data input from one row is converted to a Journal Line

        if ConvertRowData(RowNo) then
            with GenJournalLine do begin
                INIT;
                "Journal Template Name" := ReqJnlTemplateName;
                "Journal Batch Name" := ReqJnlBatchName;
                LineNo += 10000;
                "Line No." := LineNo;
                VALIDATE("Posting Date", InpDate);
                if GenJournalBatch."No. Series" = '' then
                    "Document No." := ReqDocumentNo
                else begin
                    "Document No." := NextDocumentNo;
                    NextDocumentNo := INCSTR(NextDocumentNo);
                end;
                "Account No." := CheckAccNo("Account Type"::"G/L Account", InpGLAccNo);
                Description := InpDescription;
                Recipient := InpRecipient;
                if InpDebitAmount > 0 then
                    VALIDATE("Debit Amount", InpDebitAmount)
                else
                    VALIDATE("Credit Amount", InpCreditAmount);
                case ReqBalAccType of
                    ReqBalAccType::Debtor:
                        VALIDATE("Bal. Account Type", "Bal. Account Type"::Customer);
                    ReqBalAccType::"Bank Account":
                        VALIDATE("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                end;
                VALIDATE("Bal. Account No.", ReqBalAccNo);
                // Global dimensions
                for DimensionNo := 1 to 8 do
                    if InpDimensionValue[DimensionNo] <> '' then begin
                        if CheckDimensionValue(DimensionNo, InpDimensionValue[DimensionNo]) then begin
                            case DimensionNo of
                                1:
                                    VALIDATE("Shortcut Dimension 1 Code", InpDimensionValue[DimensionNo]);
                                2:
                                    VALIDATE("Shortcut Dimension 2 Code", InpDimensionValue[DimensionNo]);
                                3:
                                    VALIDATE("Shortcut Dimension 3 Code", InpDimensionValue[DimensionNo]);
                                //KTM DIM
                                4:
                                    VALIDATE("Shortcut Dimension 4 Code", InpDimensionValue[DimensionNo]);
                                5:
                                    VALIDATE("Shortcut Dimension 5 Code", InpDimensionValue[DimensionNo]);
                                //KTM DIM
                                else
                                    ValidateShortcutDimCode(DimensionNo, InpDimensionValue[DimensionNo])
                            end;
                        end else
                            ;  // Error
                    end;
                "Import From Branches" := true;
                // Insert Journal Line
                INSERT;
                RecordCount += 1;
            end;

        CLEAR(ExcelDataRow);
    end;

    procedure ConvertRowData(RowNo: Integer): Boolean;
    var
        ColumnNo: Integer;
    begin
        // Skip if not a journal line
        if not RowIsJournalLine then
            exit(false);

        // Skip if Transfer and Transfers are to be skipped
        if SkipCredits and IsCredit then
            exit(false);

        // Validate data input on row RowNo
        ClearInput;

        for ColumnNo := 1 to NoOfColumns do
            ConvertColumnData(RowNo, ColumnNo);

        exit(true);
    end;

    procedure ConvertColumnData(RowNo: Integer; ColumnNo: Integer);
    begin
        if ExcelDataRow[ColumnNo] = '' then
            exit;

        //TEMPORARY SOLUTION
        //1000 seperators added to account no.  Should be fixed in ExcelBuf.ReadSheet;
        if ColumnDataType[ColumnNo] = ColumnDataType[ColumnNo] ::"G/L Acc. No." then
            ExcelDataRow[ColumnNo] := DELCHR(ExcelDataRow[ColumnNo], '=', ',.');
        //TEMPORARY SOLUTION End

        //Cut strings if too long
        case ColumnDataType[ColumnNo] of
            ColumnDataType[ColumnNo] ::Description:
                if STRLEN(ExcelDataRow[ColumnNo]) > MAXSTRLEN(InpDescription) then
                    ExcelDataRow[ColumnNo] := COPYSTR(ExcelDataRow[ColumnNo], 1, MAXSTRLEN(InpDescription));
            ColumnDataType[ColumnNo] ::Recipient:
                if STRLEN(ExcelDataRow[ColumnNo]) > MAXSTRLEN(InpRecipient) then
                    ExcelDataRow[ColumnNo] := COPYSTR(ExcelDataRow[ColumnNo], 1, MAXSTRLEN(InpRecipient));
            ColumnDataType[ColumnNo] ::Dimension:
                if STRLEN(ExcelDataRow[ColumnNo]) > MAXSTRLEN(InpDimensionValue[1]) then
                    ExcelDataRow[ColumnNo] := COPYSTR(ExcelDataRow[ColumnNo], 1, MAXSTRLEN(InpDimensionValue[1]));
            ColumnDataType[ColumnNo] ::"G/L Acc. No.":
                if STRLEN(ExcelDataRow[ColumnNo]) > MAXSTRLEN(InpGLAccNo) then
                    ExcelDataRow[ColumnNo] := COPYSTR(ExcelDataRow[ColumnNo], 1, MAXSTRLEN(InpGLAccNo));
        end;

        // Initialise input variables
        case ColumnDataType[ColumnNo] of
            ColumnDataType[ColumnNo] ::Date:
                if not EVALUATE(InpDate, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'date');
            ColumnDataType[ColumnNo] ::Description:
                if not EVALUATE(InpDescription, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'text');
            ColumnDataType[ColumnNo] ::Recipient:
                if not EVALUATE(InpRecipient, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'text');
            ColumnDataType[ColumnNo] ::"G/L Acc. No.":
                if not EVALUATE(InpGLAccNo, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'text');
            ColumnDataType[ColumnNo] ::Dimension:
                if not EVALUATE(InpDimensionValue[ColumnDimension[ColumnNo]], ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'text');
            ColumnDataType[ColumnNo] ::"Debit Amount":
                if not EVALUATE(InpDebitAmount, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'decimal');
            ColumnDataType[ColumnNo] ::"Credit Amount":
                if not EVALUATE(InpCreditAmount, ExcelDataRow[ColumnNo]) then
                    ERROR(ErrImport004, RowNo, ExcelColumnID(ColumnNo), ExcelDataRow[ColumnNo], 'decimal');
        end;
    end;

    procedure RowIsJournalLine(): Boolean;
    begin
        // Exit true if debit or credit amount are specified
        exit((ExcelDataRow[DebitColumn] <> '') or (ExcelDataRow[CreditColumn] <> ''));
    end;

    procedure IsCredit(): Boolean;
    begin
        // Exit true if credit amount
        exit(ExcelDataRow[CreditColumn] <> '');
    end;

    procedure CheckAccNo(AccType: Integer; AccNo: Code[20]): Code[20];
    var
        GenJnlLine: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
    begin
        if AccNo <> '' then
            case AccType of
                GenJnlLine."Account Type"::"G/L Account":
                    if not GLAccount.GET(AccNo) then
                        exit(COPYSTR('ERR: ' + AccNo, 1, MAXSTRLEN(AccNo)));
            end;
        exit(AccNo);
    end;

    procedure CheckDimensionValue(DimensionNo: Integer; DimensionValue: Code[20]): Boolean;
    var
        DimensionCode: Code[20];
        DimVal: Record "Dimension Value";
    begin
        case DimensionNo of
            1:
                DimensionCode := GLSetup."Shortcut Dimension 1 Code";
            2:
                DimensionCode := GLSetup."Shortcut Dimension 2 Code";
            3:
                DimensionCode := GLSetup."Shortcut Dimension 3 Code";
            4:
                DimensionCode := GLSetup."Shortcut Dimension 4 Code";
            5:
                DimensionCode := GLSetup."Shortcut Dimension 5 Code";
            6:
                DimensionCode := GLSetup."Shortcut Dimension 6 Code";
            7:
                DimensionCode := GLSetup."Shortcut Dimension 7 Code";
            8:
                DimensionCode := GLSetup."Shortcut Dimension 8 Code";
        end;

        DimVal.SETRANGE("Dimension Code", DimensionCode);
        DimVal.SETRANGE(Code, DimensionValue);
        exit(DimVal.FINDFIRST);
    end;

    procedure ClearInput();
    begin
        InpDate := 0D;
        InpEntryNo := 0;
        InpDescription := '';
        InpRecipient := '';
        InpGLAccNo := '';
        InpDebitAmount := 0;
        InpCreditAmount := 0;
        InpBalance := 0;
        InpDimensionValue[1] := '';
        InpDimensionValue[2] := '';
        InpDimensionValue[3] := '';
        InpDimensionValue[4] := '';
        InpDimensionValue[5] := '';
        InpDimensionValue[6] := '';
        InpDimensionValue[7] := '';
        InpDimensionValue[8] := '';
    end;

    procedure ExcelColumnID(ColumnNo: Integer): Char;
    begin
        case ColumnNo of
            1:
                exit('A');
            2:
                exit('B');
            3:
                exit('C');
            4:
                exit('D');
            5:
                exit('E');
            6:
                exit('F');
            7:
                exit('G');
            8:
                exit('H');
            9:
                exit('I');
            10:
                exit('J');
            11:
                exit('K');
            12:
                exit('L');
            13:
                exit('M');
            14:
                exit('N');
            15:
                exit('O');
            16:
                exit('P');
            17:
                exit('Q');
            18:
                exit('R');
            19:
                exit('S');
            20:
                exit('T');
            21:
                exit('U');
            22:
                exit('V');
            23:
                exit('W');
            24:
                exit('X');
            25:
                exit('Y');
            26:
                exit('Z');
        end;
        exit('?');
    end;

    procedure LookupTemplateName(var JnlTemplateName: Code[10]);
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::General);
        if PAGE.RUNMODAL(0, GenJournalTemplate) = ACTION::LookupOK then
            JnlTemplateName := GenJournalTemplate.Name;
    end;

    procedure LookupBatchName(var JnlBatchName: Code[10]);
    var
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        if ReqJnlTemplateName = '' then
            ERROR(ErrRequest003);
        GenJnlBatch.SETRANGE("Journal Template Name", ReqJnlTemplateName);
        if PAGE.RUNMODAL(0, GenJnlBatch) = ACTION::LookupOK then
            JnlBatchName := GenJnlBatch.Name;
    end;

    procedure LookupBalAccNo(var BalAccNo: Code[20]);
    var
        Customer: Record Customer;
        BankAccount: Record "Bank Account";
    begin
        case ReqBalAccType of
            ReqBalAccType::Debtor:
                if PAGE.RUNMODAL(0, Customer) = ACTION::LookupOK then
                    BalAccNo := Customer."No.";
            ReqBalAccType::"Bank Account":
                if PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK then
                    BalAccNo := BankAccount."No.";
        end;
    end;

    procedure ShowDocumentNo();
    begin

        ReqDocumentNoEnable := TRUE;
        IF (ReqJnlTemplateName <> '') AND (ReqJnlBatchName <> '') THEN
            IF GenJournalBatch.GET(ReqJnlTemplateName, ReqJnlBatchName) THEN
                ReqDocumentNoEnable := GenJournalBatch."No. Series" = '';

    end;
}

