table 50003 "Posted Dimension Modify"
{


    Caption = 'Posted Dimension Modify';
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "Bank Account Ledger Entry" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rm,
                  TableData "Detailed Vendor Ledg. Entry" = rm;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(3; "Posting Date"; Date)
        {
            ClosingDates = true;
            Editable = false;
        }
        field(4; "Account No."; Code[20])
        {
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Editable = false;

            trigger OnValidate();
            begin

                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");

            end;
        }
        field(14; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Editable = false;
        }
        field(15; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Editable = false;
        }
        field(16; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Editable = false;
        }
        field(17; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Editable = false;
        }
        field(18; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Editable = false;
        }
        field(19; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension Set Id';
            Editable = false;
        }
        field(21; "New Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = 'New Activity Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "New Shortcut Dimension 1 Code");
            end;

        }
        field(22; "New Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = 'New Project Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "New Shortcut Dimension 2 Code");
            end;
        }
        field(23; "New Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = 'New DonorActivity Code';

            trigger OnValidate();
            begin

                ValidateShortcutDimCode(3, "New Shortcut Dimension 3 Code");

            end;
        }
        field(24; "New Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = 'New Donor Code';
        }
        field(25; "New Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = 'New Branch Code';
        }
        field(26; "New Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
        }
        field(27; "New Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
        }
        field(28; "New Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
        }
        field(29; "New Dimension Set Id"; Integer)
        {
            Caption = 'Dimension Set Id';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            MaintainSIFTIndex = false;
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;
        TEXT001: Label 'Please specify %1';
        TEXT002: Label 'Document %1 is already populated.  Refresh?';
        GLSetup: Record "General Ledger Setup";
        TEXT003: Label 'There is nothing to update.';
        TEXT004: Label 'Do you want to update document %1?';
        RecUpdated: Boolean;

        GLSetupShortcutDimCode: array[8] of code[20];

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
        //DimMgt.ShowJnlLineDim (DATABASE::"Gen. Journal Line","Journal Template Name",
        //                       "Journal Batch Name","Line No.",0,ShortcutDimCode);
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    procedure Populate(DocumentNo: Code[20]; Date: Date);
    var
        GLEntry: Record "G/L Entry";
        PostedDimensionModify: Record "Posted Dimension Modify";
        DimensionCode: array[8] of Code[20];
        DimensionValue: Code[20];
    begin
        if (DocumentNo = '') then
            ERROR(TEXT001, GLEntry.FIELDCAPTION("Document No."));

        //Check if Document already populated
        PostedDimensionModify.SETCURRENTKEY("Document No.", "Posting Date");
        PostedDimensionModify.SETRANGE("Document No.", DocumentNo);
        if (Date <> 0D) then
            PostedDimensionModify.SETRANGE("Posting Date", Date);
        if PostedDimensionModify.FINDFIRST then begin
            if not CONFIRM(TEXT002, false, DocumentNo) then
                exit;
            PostedDimensionModify.DELETEALL;
        end;
        PostedDimensionModify.RESET;

        CLEAR(DimensionCode);
        GLSetup.GET;
        if (GLSetup."Shortcut Dimension 1 Code" <> '') then
            DimensionCode[1] := GLSetup."Shortcut Dimension 1 Code";
        if (GLSetup."Shortcut Dimension 2 Code" <> '') then
            DimensionCode[2] := GLSetup."Shortcut Dimension 2 Code";
        if (GLSetup."Shortcut Dimension 3 Code" <> '') then
            DimensionCode[3] := GLSetup."Shortcut Dimension 3 Code";
        if (GLSetup."Shortcut Dimension 4 Code" <> '') then
            DimensionCode[4] := GLSetup."Shortcut Dimension 4 Code";
        if (GLSetup."Shortcut Dimension 5 Code" <> '') then
            DimensionCode[5] := GLSetup."Shortcut Dimension 5 Code";
        if (GLSetup."Shortcut Dimension 6 Code" <> '') then
            DimensionCode[6] := GLSetup."Shortcut Dimension 6 Code";
        if (GLSetup."Shortcut Dimension 7 Code" <> '') then
            DimensionCode[7] := GLSetup."Shortcut Dimension 7 Code";
        if (GLSetup."Shortcut Dimension 8 Code" <> '') then
            DimensionCode[8] := GLSetup."Shortcut Dimension 8 Code";

        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GLEntry.SETRANGE("Document No.", DocumentNo);
        if (Date <> 0D) then
            GLEntry.SETRANGE("Posting Date", Date);
        if GLEntry.FINDFIRST then
            repeat
                with PostedDimensionModify do begin
                    INIT;

                    "Entry No." := GLEntry."Entry No.";
                    "Document No." := GLEntry."Document No.";
                    "Posting Date" := GLEntry."Posting Date";
                    "Account No." := GLEntry."G/L Account No.";
                    Description := GLEntry.Description;
                    Amount := GLEntry.Amount;
                    "Shortcut Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                    "New Shortcut Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                    "New Shortcut Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
                    //ktm add shortcut dim 3 and 4
                    "Shortcut Dimension 3 Code" := GLEntry."ShortCut Dimension 3 code";
                    "New Shortcut Dimension 3 Code" := GLEntry."ShortCut Dimension 3 code";

                    "Shortcut Dimension 4 Code" := GLEntry."ShortCut Dimension 4 code";
                    "New Shortcut Dimension 4 Code" := GLEntry."ShortCut Dimension 4 code";

                    "Shortcut Dimension 5 Code" := GLEntry."ShortCut Dimension 5 code";
                    "New Shortcut Dimension 5 Code" := GLEntry."ShortCut Dimension 5 code";

                    "Dimension Set Id" := GLEntry."Dimension Set ID";
                    "New Dimension Set Id" := GLEntry."Dimension Set ID";


                    //End 

                    // if GetDimensionCode(GLEntry."Entry No.", DimensionCode[4], DimensionValue) then begin
                    //     "Shortcut Dimension 4 Code" := DimensionValue;
                    //     "New Shortcut Dimension 4 Code" := DimensionValue;
                    // end;
                    // if GetDimensionCode(GLEntry."Entry No.", DimensionCode[5], DimensionValue) then begin
                    //     "Shortcut Dimension 5 Code" := DimensionValue;
                    //     "New Shortcut Dimension 5 Code" := DimensionValue;
                    // end;
                    if GetDimensionCode(GLEntry."Entry No.", DimensionCode[6], DimensionValue) then begin
                        "Shortcut Dimension 6 Code" := DimensionValue;
                        "New Shortcut Dimension 6 Code" := DimensionValue;
                    end;
                    if GetDimensionCode(GLEntry."Entry No.", DimensionCode[7], DimensionValue) then begin
                        "Shortcut Dimension 7 Code" := DimensionValue;
                        "New Shortcut Dimension 7 Code" := DimensionValue;
                    end;
                    if GetDimensionCode(GLEntry."Entry No.", DimensionCode[8], DimensionValue) then begin
                        "Shortcut Dimension 8 Code" := DimensionValue;
                        "New Shortcut Dimension 8 Code" := DimensionValue;
                    end;
                    INSERT;
                end
            until GLEntry.NEXT = 0;

    end;

    procedure Update(DocumentNo: Code[20]; Date: Date);
    var
        GLEntry: Record "G/L Entry";
        PostedDimensionModify: Record "Posted Dimension Modify";
        DimensionCode: array[8] of Code[20];
        DimensionValue: Code[20];
    begin
        if (DocumentNo = '') then
            ERROR(TEXT001, GLEntry.FIELDCAPTION("Document No."));

        //Go through populated records
        PostedDimensionModify.SETCURRENTKEY("Document No.", "Posting Date");
        PostedDimensionModify.SETRANGE("Document No.", DocumentNo);
        if (Date <> 0D) then
            PostedDimensionModify.SETRANGE("Posting Date", Date);
        if not PostedDimensionModify.FINDFIRST then
            ERROR(TEXT003)
        else
            if not CONFIRM(TEXT004, false, DocumentNo) then
                exit;

        CLEAR(DimensionCode);
        GLSetup.GET;
        if (GLSetup."Shortcut Dimension 1 Code" <> '') then
            DimensionCode[1] := GLSetup."Shortcut Dimension 1 Code";
        if (GLSetup."Shortcut Dimension 2 Code" <> '') then
            DimensionCode[2] := GLSetup."Shortcut Dimension 2 Code";
        if (GLSetup."Shortcut Dimension 3 Code" <> '') then
            DimensionCode[3] := GLSetup."Shortcut Dimension 3 Code";
        if (GLSetup."Shortcut Dimension 4 Code" <> '') then
            DimensionCode[4] := GLSetup."Shortcut Dimension 4 Code";
        if (GLSetup."Shortcut Dimension 5 Code" <> '') then
            DimensionCode[5] := GLSetup."Shortcut Dimension 5 Code";
        if (GLSetup."Shortcut Dimension 6 Code" <> '') then
            DimensionCode[6] := GLSetup."Shortcut Dimension 6 Code";
        if (GLSetup."Shortcut Dimension 7 Code" <> '') then
            DimensionCode[7] := GLSetup."Shortcut Dimension 7 Code";
        if (GLSetup."Shortcut Dimension 8 Code" <> '') then
            DimensionCode[8] := GLSetup."Shortcut Dimension 8 Code";

        with PostedDimensionModify do begin
            repeat

                // if ("New Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code") then
                //     UpdateDimensionSetId(1, "New Shortcut Dimension 1 Code");
                // if ("New Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code") then
                //     UpdateDimensionSetId(2, "New Shortcut Dimension 2 Code");
                // if ("New Shortcut Dimension 3 Code" <> "Shortcut Dimension 3 Code") then
                //     UpdateDimensionSetId(3, "New Shortcut Dimension 3 Code");
                // if ("New Shortcut Dimension 4 Code" <> "Shortcut Dimension 4 Code") then
                //     UpdateDimensionSetId(4, "New Shortcut Dimension 4 Code");
                // if ("New Shortcut Dimension 5 Code" <> "Shortcut Dimension 5 Code") then
                //     UpdateDimensionSetId(5, "New Shortcut Dimension 5 Code");
                // if ("New Shortcut Dimension 6 Code" <> "Shortcut Dimension 6 Code") then
                //     UpdateDimensionSetId(6, "New Shortcut Dimension 6 Code");
                // if ("New Shortcut Dimension 7 Code" <> "Shortcut Dimension 7 Code") then
                //     UpdateDimensionSetId(7, "New Shortcut Dimension 7 Code");
                // if ("New Shortcut Dimension 8 Code" <> "Shortcut Dimension 8 Code") then
                //     UpdateDimensionSetId(8, "New Shortcut Dimension 8 Code");

                if ("New Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code")
                   or ("New Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code")
                   or ("New Shortcut Dimension 3 Code" <> "Shortcut Dimension 3 Code")
                   or ("New Shortcut Dimension 4 Code" <> "Shortcut Dimension 4 Code")
                   or ("New Shortcut Dimension 5 Code" <> "Shortcut Dimension 5 Code") then
                    UpdateGlobalDimension("Entry No.",
                                           "New Shortcut Dimension 1 Code",
                                           "New Shortcut Dimension 2 Code",
                                           "New Shortcut Dimension 3 Code",
                                           "New Shortcut Dimension 4 Code",
                                           "New Shortcut Dimension 5 Code",
                                           "New Dimension Set Id");


            //Ktm commented this - 
            /*
            if ("New Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code") then
                UpdateDimension("Entry No.", DimensionCode[1], "New Shortcut Dimension 1 Code");
            if ("New Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code") then
                UpdateDimension("Entry No.", DimensionCode[2], "New Shortcut Dimension 2 Code");
            if ("New Shortcut Dimension 3 Code" <> "Shortcut Dimension 3 Code") then
                UpdateDimension("Entry No.", DimensionCode[3], "New Shortcut Dimension 3 Code");
            if ("New Shortcut Dimension 4 Code" <> "Shortcut Dimension 4 Code") then
                UpdateDimension("Entry No.", DimensionCode[4], "New Shortcut Dimension 4 Code");
            if ("New Shortcut Dimension 5 Code" <> "Shortcut Dimension 5 Code") then
                UpdateDimension("Entry No.", DimensionCode[5], "New Shortcut Dimension 5 Code");
            if ("New Shortcut Dimension 6 Code" <> "Shortcut Dimension 6 Code") then
                UpdateDimension("Entry No.", DimensionCode[6], "New Shortcut Dimension 6 Code");
            if ("New Shortcut Dimension 7 Code" <> "Shortcut Dimension 7 Code") then
                UpdateDimension("Entry No.", DimensionCode[7], "New Shortcut Dimension 7 Code");
            if ("New Shortcut Dimension 8 Code" <> "Shortcut Dimension 8 Code") then
                UpdateDimension("Entry No.", DimensionCode[8], "New Shortcut Dimension 8 Code");
            */
            until NEXT = 0;


            DELETEALL;

        end;

    end;

    procedure GetDimensionCode(EntryNo: Integer; DimensionCode: Code[20]; var DimensionValue: Code[20]): Boolean;
    begin
        //IF NOT LedgerEntryDimension.GET (DATABASE::"G/L Entry", EntryNo, DimensionCode) THEN
        //  EXIT (FALSE);

        //DimensionValue := LedgerEntryDimension."Dimension Value Code";
        //EXIT (TRUE);
    end;

    //UpdateDimensionSetId
    procedure UpdateDimensionSetId(FieldNo: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
        DimSetID: Integer;
        DimVal: Record "Dimension Value";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        // OldDimSetID := "Dimension Set ID";
        // DimMgt.ValidateShortcutDimValues(FieldNo, ShortcutDimensionValueCode, "Dimension Set ID");
        // "New Dimension Set Id" := "Dimension Set Id";
        GLSetup.GET;
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";

        DimMgt.ValidateDimValueCode(FieldNo, ShortcutDimCode);
        //Message('GLSetupShortcutDimCode[FieldNo] %1', GLSetupShortcutDimCode[FieldNo]);
        DimVal."Dimension Code" := GLSetupShortcutDimCode[FieldNo];
        IF ShortcutDimCode <> '' THEN BEGIN
            DimVal.GET(DimVal."Dimension Code", ShortcutDimCode);
            IF NOT DimMgt.CheckDim(DimVal."Dimension Code") THEN
                ERROR(DimMgt.GetDimErr);
            IF NOT DimMgt.CheckDimValue(DimVal."Dimension Code", ShortcutDimCode) THEN
                ERROR(DimMgt.GetDimErr);
        END;
        DimMgt.GetDimensionSet(TempDimSetEntry, DimSetID);
        IF TempDimSetEntry.GET(TempDimSetEntry."Dimension Set ID", DimVal."Dimension Code") THEN
            IF TempDimSetEntry."Dimension Value Code" <> ShortcutDimCode THEN
                TempDimSetEntry.DELETE;
        IF ShortcutDimCode <> '' THEN BEGIN
            TempDimSetEntry."Dimension Code" := DimVal."Dimension Code";
            TempDimSetEntry."Dimension Value Code" := DimVal.Code;
            TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            IF TempDimSetEntry.INSERT THEN;
        END;
        DimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);

        OldDimSetID := "Dimension Set ID";
        "New Dimension Set Id" := DimSetID;


        MODIFY;
    end;



    procedure UpdateGlobalDimension(EntryNo: Integer; Dimension1Value: Code[20]; Dimension2Value: Code[20]; Dimension3Value: Code[20]; Dimension4Value: Code[20]; Dimension5Value: Code[20]; DimSetId: Integer);
    var
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        with GLEntry do begin
            GET(EntryNo);
            "Global Dimension 1 Code" := Dimension1Value;
            "Global Dimension 2 Code" := Dimension2Value;
            //ktm
            "ShortCut Dimension 3 code" := Dimension3Value;
            "ShortCut Dimension 4 code" := Dimension4Value;
            "ShortCut Dimension 5 code" := Dimension5Value;
            "Dimension Set ID" := DimSetId;

            MODIFY;
        end;

        with CustLedgerEntry do begin
            if GET(EntryNo) then begin
                "Global Dimension 1 Code" := Dimension1Value;
                "Global Dimension 2 Code" := Dimension2Value;
                //ktm
                "ShortCut Dimension 3 code" := Dimension3Value;
                "ShortCut Dimension 4 code" := Dimension4Value;
                "ShortCut Dimension 5 code" := Dimension5Value;
                "Dimension Set ID" := DimSetId;

                MODIFY;
            end;
        end;


        with DetailedCustLedgEntry do begin
            SETCURRENTKEY("Cust. Ledger Entry No.", "Posting Date");
            SETRANGE("Cust. Ledger Entry No.", EntryNo);
            if FIND('-') then
                repeat
                    "Initial Entry Global Dim. 1" := Dimension1Value;
                    "Initial Entry Global Dim. 2" := Dimension2Value;
                    "Dimension Set ID" := DimSetId;
                    //"Initial Entry Global Dim. 3" := Dimension3Value;
                    MODIFY;
                until NEXT = 0;
        end;


        with VendorLedgerEntry do begin
            if GET(EntryNo) then begin
                "Global Dimension 1 Code" := Dimension1Value;
                "Global Dimension 2 Code" := Dimension2Value;
                //ktm
                "ShortCut Dimension 3 code" := Dimension3Value;
                "ShortCut Dimension 4 code" := Dimension4Value;
                "ShortCut Dimension 5 code" := Dimension5Value;
                "Dimension Set ID" := DimSetId;

                MODIFY;
            end;
        end;


        with DetailedVendorLedgEntry do begin
            SETCURRENTKEY("Vendor Ledger Entry No.", "Posting Date");
            SETRANGE("Vendor Ledger Entry No.", EntryNo);
            if FIND('-') then
                repeat
                    "Initial Entry Global Dim. 1" := Dimension1Value;
                    "Initial Entry Global Dim. 2" := Dimension2Value;
                    "Dimension Set ID" := DimSetId;
                    //"Initial Entry Global Dim. 3" := Dimension3Value;
                    MODIFY;
                until NEXT = 0;
        end;


        with BankAccountLedgerEntry do begin
            if GET(EntryNo) then begin
                "Global Dimension 1 Code" := Dimension1Value;
                "Global Dimension 2 Code" := Dimension2Value;
                //ktm
                "ShortCut Dimension 3 code" := Dimension3Value;
                "ShortCut Dimension 4 code" := Dimension4Value;
                "ShortCut Dimension 5 code" := Dimension5Value;
                "Dimension Set ID" := DimSetId;

                MODIFY;
            end;
        end;
    end;

    procedure UpdateDimension(EntryNo: Integer; DimensionCode: Code[20]; DimensionValue: Code[20]);
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    begin
        UpdateOneTableDimension(DATABASE::"G/L Entry", EntryNo, DimensionCode, DimensionValue);

        if CustLedgerEntry.GET(EntryNo) then
            UpdateOneTableDimension(DATABASE::"Cust. Ledger Entry", EntryNo, DimensionCode, DimensionValue);

        if VendorLedgerEntry.GET(EntryNo) then
            UpdateOneTableDimension(DATABASE::"Vendor Ledger Entry", EntryNo, DimensionCode, DimensionValue);

        if BankAccountLedgerEntry.GET(EntryNo) then
            UpdateOneTableDimension(DATABASE::"Bank Account Ledger Entry", EntryNo, DimensionCode, DimensionValue);
    end;

    procedure UpdateOneTableDimension(TableID: Integer; EntryNo: Integer; DimensionCode: Code[20]; DimensionValue: Code[20]);
    var
        GLEntry: Record "G/L Entry";
    begin

        // WITH LedgerEntryDimension DO BEGIN

        //   IF GET (TableID, EntryNo, DimensionCode) THEN BEGIN
        //     IF (DimensionValue = '') THEN
        //       DELETE
        //     ELSE BEGIN
        //       "Dimension Value Code" := DimensionValue;
        //       MODIFY;
        //     END;
        //   END ELSE BEGIN
        //     "Table ID" := TableID;
        //     "Entry No." := EntryNo;
        //     "Dimension Code" := DimensionCode;
        //     "Dimension Value Code" := DimensionValue;
        //     LedgerEntryDimension.INSERT;
        //   END;

        //END;


    end;
}

