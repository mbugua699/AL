codeunit 50001 "Vega Tranfer Field data"
{

    trigger OnRun()
    begin

        //Write to tables.


        //General Ledger Setup
        WITH To_TempTB_98 DO BEGIN
            if Find('-') then begin
                //Fields to transfer.
                // "Global Dimension 1 Code" := 'ACTIVITY';
                // "Global Dimension 2 Code" := 'PROJECT';
                // "Shortcut Dimension 1 Code" := 'ACTIVITY';
                // "Shortcut Dimension 2 Code" := 'PROJECT';
                // "Shortcut Dimension 3 Code" := 'DONORACTIVITY';
                // "Shortcut Dimension 4 Code" := 'DONOR';
                // "Shortcut Dimension 5 Code" := 'BRANCH';

                "Income A/C Filter" := '4000..4599';
                "Expense A/C Filter" := '5000..8205|8301|1000..1199';
                "Cash at Bank A/C Filter" := '1212';
                "Cash at Hand A/C Filter" := '1211';
                "Working Advance A/C Filter" := '1400..1499';
                "Other A/C Filter" := '1500..1599';
                "Cutoff Date" := 0D;
                "No Incr. Batch Name" := false;


                "Donor Dimension" := 'DONOR';
                "Project Dimension" := 'PROJECT';
                "Activity Dimension" := 'ACTIVITY';
                "Opening Balance A/C Filter" := '3006';
                "Payable A/C Filter" := '2000..2999';
                "Transfers A/C Filter" := '4610';
                "Prior Year Adjust. Filter" := '3008';
                "Revaluation Gain/Loss Filter" := '8206..8208|3004';
                //"Global Dimension 3 Code" := 'ACTIVITY';
                "Required Bal. a/c (Dim1)" := false;
                "Required Bal. a/c (Dim2)" := false;
                "Required Bal. a/c (Dim3)" := false;
                "Required Exp. a/c (Dim1)" := false;
                "Required Exp. a/c (Dim2)" := false;
                "Required Exp. a/c (Dim3)" := false;

                "Header Text 1 (Cell A1)" := 'South Sudan Red Cross Society';
                "Header Text 2 (Cell A2)" := 'Navision Excel';
                "Column Headers Row No." := 9;
                "Column 1 Header" := 'Date';
                "Column 2 Header" := '';
                "Column 3 Header" := 'Description';
                "Column 4 Header" := 'Recepient';
                "Column 5 Header" := 'Code Branch';
                "Column 6 Header" := 'G/L Account No';
                "Column 7 Header" := 'Code Project';
                "Column 8 Header" := 'Code Activity';
                "Column 9 Header" := 'Code Donor';
                "Column 10 Header" := 'Credit Amount';
                "Column 11 Header" := 'Debit Amount';
                "Column 12 Header" := '';

                "Data Start Row" := 11;
                "Column 1 Data Type" := "Column 1 Data Type"::Date;
                "Column 2 Data Type" := "Column 2 Data Type"::" ";
                "Column 3 Data Type" := "Column 1 Data Type"::Description;
                "Column 4 Data Type" := "Column 1 Data Type"::Recipient;
                "Column 5 Data Type" := "Column 1 Data Type"::Dimension;
                "Column 6 Data Type" := "Column 1 Data Type"::"G/L Acc. No.";
                "Column 7 Data Type" := "Column 1 Data Type"::Dimension;
                "Column 8 Data Type" := "Column 1 Data Type"::Dimension;
                "Column 9 Data Type" := "Column 1 Data Type"::Dimension;
                "Column 10 Data Type" := "Column 1 Data Type"::"Credit Amount";
                "Column 11 Data Type" := "Column 1 Data Type"::"Debit Amount";
                "Column 12 Data Type" := "Column 12 Data Type"::" ";

                "Column 1 Dimension" := '';
                "Column 2 Dimension" := '';
                "Column 3 Dimension" := '';
                "Column 4 Dimension" := '';
                "Column 5 Dimension" := 'BRANCH';
                "Column 6 Dimension" := '';
                "Column 7 Dimension" := 'PROJECT';
                "Column 8 Dimension" := 'ACTIVITY';
                "Column 9 Dimension" := 'DONOR';
                "Column 10 Dimension" := '';
                "Column 11 Dimension" := '';
                "Column 12 Dimension" := '';

                "Default Journal Template Name" := 'GENERAL';
                //**************
                To_TempTB_98.Modify;
            end;

        END;



        //After data has been copied
        MESSAGE(TransferFielddataMSG);
    end;

    var
        TransferFielddataMSG: Label 'General Ledger Setup has been Copied.';


        To_TempTB_81: Record "Gen. Journal Line";
        To_TempTB_96: Record "G/L Budget Entry";
        To_TempTB_98: Record "General Ledger Setup";
        To_TempTB_232: Record "Gen. Journal Batch";
        To_TempTB_242: Record "Source Code Setup";
        To_TempTB_273: Record "Bank Acc. Reconciliation";
        To_TempTB_274: Record "Bank Acc. Reconciliation Line";



}

