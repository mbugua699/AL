/// <summary>
/// Report Import Payroll to Gen Journal (ID 50014).
/// </summary>
report 50014 "Import Payroll to Gen Journal"
{
    // version SSRC-D001

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

                            end;
                        }
                    }

                }
            }
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
        ExcelBuf.DELETEALL;
    end;

    trigger OnPreReport();
    begin
        //ReqJnlTemplateName := 'PAYROLL';
        //ReqJnlBatchName := 'DEFAULT';

        if not CheckJournal(ReqJnlTemplateName, ReqJnlBatchName) then
            ERROR(Text003);

        //ktm 06/11/2020
        //Use No series
        GenJournalBatch.SETRANGE("Journal Template Name", ReqJnlTemplateName);
        GenJournalBatch.SETRANGE(Name, ReqJnlBatchName);
        if GenJournalBatch.FIND('-') then begin
            if GenJournalBatch."No. Series" = '' then begin
                ERROR(ERR_DOCUMENT_NO, ReqJnlBatchName);
            end else
                if (GenJournalBatch."No. Series" <> '') then begin
                    NextDocumentNo := NoSeriesMgt.TryGetNextNo(GenJournalBatch."No. Series", WORKDATE);
                    //MESSAGE('Next Doc No %1', NextDocumentNo);
                    CLEAR(NoSeriesMgt);
                end;
        end;

        //ktm end

        if not InitImport() then
            exit;
        ExcelBuf.LOCKTABLE;

        ReadSheet;
        ProcessSheet;
    end;

    var
        ERR_HeaderRow: Label 'Row with column headers not found. Column headers must be:\%1';
        ERR_CellNotBlank: Label 'Row %1, column %2: Cell must be blank';
        TXT_IdentifyColumnHeaders: Label 'Identify column headers in Excel file';
        TXT_CheckTotalLine: Label 'TOTAL';
        Text006: Label 'Import Excel File';
        Text007: Label 'Processing Data...\\';
        ErrImport003: Label 'Row %1, Column %2: %3 cannot exceed %4 characters';
        ErrImport004: Label 'Row %1, Column %2: %3 invalid %4';
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextDocumentNo: Code[20];
        ReqJnlTemplateName: Code[50];
        ReqJnlBatchName: Code[50];
        FileName: Text[250];
        FileNameServer: Text[250];
        FileMgmt: Codeunit "File Management";
        Instr: InStream;
        FileUploaded: Boolean;
        SheetName: Text[250];
        ExcelBuf: Record "Excel Buffer";
        ExcelHeaderRow: array[19] of Text[1024];
        ExcelDataRow: array[19] of Text[1024];
        HeaderRowNo: Integer;
        HeaderColumnNo: Integer;
        AllHeaders: Text[1024];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        NextLineNo: Integer;
        ImpText: array[19] of Text[250];
        ImpDecimal: array[19] of Decimal;
        ImpInteger: array[19] of Integer;
        ImpCode: array[19] of Code[50];
        ImpDate: array[19] of Date;
        ImpOption: array[19] of Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        ImpOption2: array[19] of Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        ImpOption3: array[19] of Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        LineNo: Integer;
        Text001: Label 'Batch %1 already has %2 journal lines.\Do you want to append lines imported?';
        Text002: Label 'Do you want to delete existing journal lines?';
        Text003: Label 'Import cancelled by user.';
        ErrRequest001: Label 'You must specify a journal batch to import into.';
        ErrRequest002: Label 'Journal batch %1 does not exist.';
        ErrRequest003: Label 'Please select Journal Template Name.';
        ErrRequest004: Label 'Batch %1 contains entries.';
        ERR_DOCUMENT_NO: Label 'Please Specify No. Series in Batch %1';

    local procedure InitImport(): Boolean;
    var
        Idx: Integer;
    begin

        //excel header names
        ExcelHeaderRow[1] := 'POSTING DATE';
        ExcelHeaderRow[2] := 'DOCUMENT DATE';
        ExcelHeaderRow[3] := 'DOCUMENT TYPE';
        ExcelHeaderRow[4] := 'DOCUMENT NO.';
        ExcelHeaderRow[5] := 'ACCOUNT TYPE';
        ExcelHeaderRow[6] := 'ACCOUNT NO.';
        ExcelHeaderRow[7] := 'EMPLOYEE ID NUMBER'; //link to external doc no
        ExcelHeaderRow[8] := 'DESCRIPTION';
        ExcelHeaderRow[9] := 'CURRENCY CODE';
        ExcelHeaderRow[10] := 'AMOUNT';
        ExcelHeaderRow[11] := 'AMOUNT (LCY)';
        ExcelHeaderRow[12] := 'BAL. ACCOUNT TYPE';
        ExcelHeaderRow[13] := 'BAL. ACCOUNT NO.';
        ExcelHeaderRow[14] := 'DONOR CODE';
        ExcelHeaderRow[15] := 'PROJECT CODE';
        ExcelHeaderRow[16] := 'ACTIVITY CODE';
        ExcelHeaderRow[17] := 'BRANCH CODE';

        //KTM DIM
        ExcelHeaderRow[18] := 'DONORACTIVITY CODE';
        ExcelHeaderRow[19] := 'APPLIES-TO DOC. NO.';

        //KTM DIM


        AllHeaders := ExcelHeaderRow[1];
        for Idx := 2 to ARRAYLEN(ExcelHeaderRow) do
            AllHeaders := STRSUBSTNO('%1, %2', AllHeaders, ExcelHeaderRow[Idx]);
        NextLineNo := 0;
        exit(true);
    end;

    local procedure ReadSheet();
    begin
        ExcelBuf.Reset();
        ExcelBuf.OpenBookStream(InStr, SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure ProcessSheet();
    var
        PrvRowNo: Integer;
    begin
        if not FindHeaderRow(HeaderRowNo, HeaderColumnNo) then
            ERROR(ERR_HeaderRow, AllHeaders);

        Window.OPEN(Text007 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        TotalRecNo := ExcelBuf.COUNT;
        RecNo := 0;
        PrvRowNo := HeaderRowNo + 1;

        if ExcelBuf.FINDFIRST then
            repeat
                RecNo := RecNo + 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                if ExcelBuf."Row No." > HeaderRowNo then begin
                    if (ExcelBuf."Column No." < HeaderColumnNo) or (ExcelBuf."Column No." >= HeaderColumnNo + ARRAYLEN(ExcelDataRow)) then
                        ERROR(ERR_CellNotBlank, ExcelBuf."Row No.", ExcelBuf."Column No.");
                    if (ExcelBuf."Row No." > PrvRowNo) then begin
                        ProcessRow(PrvRowNo);
                        PrvRowNo := ExcelBuf."Row No.";
                    end;
                    ExcelDataRow[ExcelBuf."Column No." - HeaderColumnNo + 1] := FormatData(ExcelBuf."Cell Value as Text", ExcelBuf."Column No.");
                end;
            until ExcelBuf.NEXT = 0;

        // Process last row - if any rows
        if (PrvRowNo > HeaderRowNo) then
            ProcessRow(PrvRowNo);

        Window.CLOSE;
    end;

    local procedure FindHeaderRow(var RowNo: Integer; var ColumnNo: Integer): Boolean;
    var
        HeaderRow: array[15] of Text;
        CurrRowNo: Integer;
        CurrColumnNo: Integer;
        SkipRow: Boolean;
        ColIdx: Integer;
    begin
        //Identify row and columns with column headers.  There must be no cells on the same row with values before or after the header cells
        Window.OPEN(TXT_IdentifyColumnHeaders);
        CurrRowNo := 0;
        with ExcelBuf do begin
            if FINDFIRST then
                repeat
                    // Find header row
                    if "Row No." <> CurrRowNo then begin                        // New row
                        if (ColIdx = ARRAYLEN(ExcelHeaderRow) + 1) then begin    // All headers found
                            RowNo := CurrRowNo;
                            ColumnNo := CurrColumnNo;

                            exit(true);
                        end;
                        CurrRowNo := "Row No.";
                        CurrColumnNo := "Column No.";
                        ColIdx := 1;
                        SkipRow := false;
                    end;

                    // Skip row if it differs from any header value
                    if not SkipRow then begin
                        SkipRow := (ColIdx > ARRAYLEN(ExcelHeaderRow));
                        if not SkipRow then
                            SkipRow := (UPPERCASE("Cell Value as Text") <> ExcelHeaderRow[ColIdx]);
                        ColIdx += 1;
                    end;
                until NEXT = 0;
        end;
        Window.CLOSE;
        exit(false);
    end;

    local procedure ProcessRow(RowNo: Integer);
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        // Data imported from one row is converted to a Gen Journal Line record

        ConvertRow(RowNo);

        if STRPOS(ImpText[1], TXT_CheckTotalLine) = 0 then     // Skip Total / Sub-total lines
            with GenJournalLine do begin
                SETRANGE("Journal Template Name", ReqJnlTemplateName);
                SETRANGE("Journal Batch Name", ReqJnlBatchName);

                // Insert GenJournalLine record
                INIT;
                //template
                //batch
                //LineNo += 70000;
                "Line No." := GetNextLineNo();

                "Journal Template Name" := ReqJnlTemplateName;
                "Journal Batch Name" := ReqJnlBatchName;//CODE


                "Posting Date" := ImpDate[1]; //Date
                "Document Date" := ImpDate[2]; //Date
                "Document Type" := ImpOption[3]; //Option
                                                 //KTM 06/12/2020
                                                 //Use no series
                                                 // "Document No." := ImpCode[4];//Code
                if ImpCode[4] = '' then begin
                    "Document No." := NextDocumentNo;
                    NextDocumentNo := INCSTR(NextDocumentNo);
                end else
                    "Document No." := ImpCode[4];//Code
                                                 //ktm end
                "Account Type" := ImpOption2[5];//Option
                "Account No." := ImpCode[6];//code
                "Employee No" := ImpCode[7];//code
                Description := ImpText[8];//Text
                "Currency Code" := ImpCode[9];//Code
                Amount := ImpDecimal[10];//Decimal

                //get currency factor
                if "Currency Code" <> '' then
                    "Currency Factor" := CurrExchRate.ExchangeRate("Posting Date", "Currency Code");

                //End of currency factor

                //Convert amt lcy to correct currency
                if Amount <> 0 then begin
                    //GetCurrency;
                    if "Currency Code" = '' then
                        "Amount (LCY)" := Amount
                    else
                        "Amount (LCY)" := ROUND(
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            "Posting Date", "Currency Code",
                            Amount, "Currency Factor"));

                    Amount := ROUND(Amount, Currency."Amount Rounding Precision");
                end;
                // "Amount (LCY)" :=  ImpDecimal[11];//Decimal
                //end of convertion

                "Bal. Account Type" := ImpOption3[12];//Option
                "Bal. Account No." := ImpCode[13];//code


                //KTM DIM
                "Shortcut Dimension 1 Code" := ImpCode[16];//code -Activity
                "Shortcut Dimension 2 Code" := ImpCode[15];//code -Project
                "Shortcut Dimension 3 Code" := ImpCode[18];//code -DonorActivity
                "Shortcut Dimension 4 Code" := ImpCode[14];//code -Donor
                "ShortCut Dimension 5 code" := ImpCode[17];//code -Branch

                "Applies-to Doc. No." := ImpCode[19];//code

                //KTM DIM 


                "External Document No." := ImpCode[7];//code



                INSERT;
            end;

        CLEAR(ExcelDataRow);
    end;

    local procedure ConvertRow(RowNo: Integer);
    var
        GenJournLine: Record "Gen. Journal Line";
    begin
        // Validate data input from row RowNo
        ClearImport;

        // 1 Posting Date         // Date
        if not EVALUATE(ImpDate[1], ExcelDataRow[1]) then
            ERROR(ErrImport004, RowNo, GetColumnId(1), ExcelDataRow[1], 'Date');

        // 2 Document date         // Date
        if not EVALUATE(ImpDate[2], ExcelDataRow[2]) then
            ERROR(ErrImport004, RowNo, GetColumnId(2), ExcelDataRow[2], 'Date');


        // 3 "Document Type"   //Option
        if not EVALUATE(ImpOption[3], ExcelDataRow[3]) then
            ERROR(ErrImport004, RowNo, GetColumnId(3), ExcelDataRow[3], 'option');

        // 4 "Document No." // Code
        if not EVALUATE(ImpCode[4], ExcelDataRow[4]) then
            ERROR(ErrImport004, RowNo, GetColumnId(4), ExcelDataRow[4], 'code');

        // 5 "Account Type" //Option
        if not EVALUATE(ImpOption2[5], ExcelDataRow[5]) then
            ERROR(ErrImport004, RowNo, GetColumnId(5), ExcelDataRow[5], 'Option');

        // 6 "Account No."    // code
        if not EVALUATE(ImpCode[6], ExcelDataRow[6]) then
            ERROR(ErrImport004, RowNo, GetColumnId(6), ExcelDataRow[6], 'code');

        // 7 Employee No"    // code
        if not EVALUATE(ImpCode[7], ExcelDataRow[7]) then
            ERROR(ErrImport004, RowNo, GetColumnId(7), ExcelDataRow[7], 'code');

        // 8 Description        // Text
        if (STRLEN(ExcelDataRow[8]) > MAXSTRLEN(GenJournLine.Description)) then
            ERROR(ErrImport003, RowNo, GetColumnId(8), ExcelDataRow[8], MAXSTRLEN(GenJournLine.Description));
        if not EVALUATE(ImpText[8], ExcelDataRow[8]) then
            ERROR(ErrImport004, RowNo, GetColumnId(8), ExcelDataRow[8], 'text');

        // 9 "Currency Code"          // code
        if not EVALUATE(ImpCode[9], ExcelDataRow[9]) then
            ERROR(ErrImport004, RowNo, GetColumnId(9), ExcelDataRow[9], 'code');

        // 10 Amount              // Decimal
        if not EVALUATE(ImpDecimal[10], ExcelDataRow[10]) then
            ERROR(ErrImport004, RowNo, GetColumnId(10), ExcelDataRow[10], 'Decimal');


        // 11   Amount (LCY)           // Decimal
        if not EVALUATE(ImpDecimal[11], ExcelDataRow[11]) then
            ERROR(ErrImport004, RowNo, GetColumnId(11), ExcelDataRow[11], 'Decimal');



        // 12 "Bal. Account Type" //Option
        if not EVALUATE(ImpOption2[12], ExcelDataRow[12]) then
            ERROR(ErrImport004, RowNo, GetColumnId(12), ExcelDataRow[12], 'Option');

        // 13 " Bal. Account No."      //code
        if not EVALUATE(ImpCode[13], ExcelDataRow[13]) then
            ERROR(ErrImport004, RowNo, GetColumnId(13), ExcelDataRow[13], 'Code');

        //KTM DIM
        //Activity
        // 14  Shortcut Dimension 1          // Code
        IF NOT EVALUATE(ImpCode[16], ExcelDataRow[16]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(16), ExcelDataRow[16], 'code');

        //Project
        // 15  "Shortcut Dimension 2 Code"              // Code
        IF NOT EVALUATE(ImpCode[15], ExcelDataRow[15]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(15), ExcelDataRow[15], 'Code');

        //DONORActivity
        // 16 "Shortcut Dimension 3 Code"               // code
        IF NOT EVALUATE(ImpCode[18], ExcelDataRow[18]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(18), ExcelDataRow[18], 'code');

        //Donor
        // 17 "Shortcut Dimension 4 Code"               // code
        IF NOT EVALUATE(ImpCode[14], ExcelDataRow[14]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(14), ExcelDataRow[14], 'code');

        //Branch
        // 17 B "Shortcut Dimension 5 Code"               // code
        IF NOT EVALUATE(ImpCode[17], ExcelDataRow[17]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(17), ExcelDataRow[17], 'code');

        // 18 "Applies-to Doc. No."      //code
        IF NOT EVALUATE(ImpCode[19], ExcelDataRow[19]) THEN
            ERROR(ErrImport004, RowNo, GetColumnId(19), ExcelDataRow[19], 'Code');

        //KTM DIM



    end;

    local procedure ClearImport();
    begin
        CLEAR(ImpText);
        CLEAR(ImpDecimal);
        CLEAR(ImpInteger);
        CLEAR(ImpCode);
        CLEAR(ImpDate);
        CLEAR(ImpOption);
        CLEAR(ImpOption2);
        CLEAR(ImpOption3);
    end;

    procedure GetColumnId(ColumnNo: Integer): Code[2];
    var
        AInt: Integer;
        ColumnRange: Integer;
        ColumnIdx: Integer;
        AChar: Char;
        Char1: Char;
        Char2: Char;
    begin
        //Returns column id A, B, C...., AA, AB, AC, ... for import column ColumnNo
        AChar := 'A';
        AInt := AChar;
        ColumnNo := HeaderColumnNo + ColumnNo - 2;    // ColumnNo 0, 1, 2, ......
        ColumnRange := ColumnNo div 26;
        ColumnIdx := ColumnNo mod 26;
        if ColumnRange = 0 then begin
            Char1 := AInt + ColumnIdx;
            exit(STRSUBSTNO('%1', Char1))
        end else begin
            Char1 := AInt + ColumnRange - 1;
            Char2 := AInt + ColumnIdx;
            exit(STRSUBSTNO('%1%2', Char1, Char2));
        end;
    end;

    procedure FormatData(TextToFormat: Text[250]; ColumnNo: Integer): Text[250];
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Date;
    begin
        if (HeaderColumnNo > 1) then
            ColumnNo -= (HeaderColumnNo - 1);
        case ColumnNo of
            4, 6, 7, 9, 13, 14, 15, 16, 17, 18, 19:                       // Code
                exit(UPPERCASE(Remove1000Sep(TextToFormat)));
            8:                                       // Text to uppercase
                exit(UPPERCASE(TextToFormat));
            0:                                        // Text     Not used
                exit(TextToFormat);
            3, 5, 12:                                      // Option
                exit(TextToFormat);
            //  1:                                      // Integer
            //    BEGIN
            //      EVALUATE (FormatInteger,TextToFormat);
            //      EXIT (FORMAT(FormatInteger));
            //    END;
            10, 11:                                          // Decimal
                begin
                    EVALUATE(FormatDecimal, TextToFormat);
                    exit(FORMAT(ROUND(FormatDecimal, 0.01)));
                end;
            1, 2:                                          // Date
                begin
                    EVALUATE(FormatDate, TextToFormat);
                    exit(FORMAT(FormatDate));
                end;
        end;
    end;

    procedure Remove1000Sep(Str: Text[250]): Text[250];
    begin
        exit(DELCHR(Str, '=', ','));
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

    procedure CheckJournal(JnlTemplateName: Code[10]; JnlBatchName: Code[10]): Boolean;
    var
        GenJournalLine: Record "Gen. Journal Line";
        NoOfLines: Integer;
    begin

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

    procedure GetNextLineNo(): Integer;
    var
        GenJnLine: Record "Gen. Journal Line";
    begin
        if NextLineNo = 0 then begin
            GenJnLine.RESET;
            GenJnLine.SETRANGE("Journal Template Name", ReqJnlTemplateName);
            GenJnLine.SETRANGE("Journal Batch Name", ReqJnlBatchName);
            if GenJnLine.FINDLAST then
                NextLineNo := GenJnLine."Line No." + 1
            else
                NextLineNo := 1;
        end else
            NextLineNo := NextLineNo + 1;
        exit(NextLineNo);
    end;

    procedure LookupTemplateName(var JnlTemplateName: Code[10]);
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        GenJournalTemplate.SETRANGE(Type, GenJournalTemplate.Type::Payroll);
        if PAGE.RUNMODAL(0, GenJournalTemplate) = ACTION::LookupOK then
            JnlTemplateName := GenJournalTemplate.Name;
    end;
}

