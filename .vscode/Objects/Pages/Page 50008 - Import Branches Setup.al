/// <summary>
/// Page Import Branches Setup (ID 50008).
/// </summary>
page 50008 "Import Branches Setup"
{
    // version VEGA-ImportBranches14.02.01

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "General Ledger Setup";

    layout
    {
        area(content)
        {
            group("Import Format")
            {
                Caption = 'Import Format';
                field("Default Journal Template Name"; "Default Journal Template Name")
                {
                }
                field("Header Text 1 (Cell A1)"; "Header Text 1 (Cell A1)")
                {
                }
                field("Header Text 2 (Cell A2)"; "Header Text 2 (Cell A2)")
                {
                }
                field("Column Headers Row No."; "Column Headers Row No.")
                {
                }
                field("Column 1 Header"; "Column 1 Header")
                {
                }
                field("Column 2 Header"; "Column 2 Header")
                {
                }
                field("Column 3 Header"; "Column 3 Header")
                {
                }
                field("Column 4 Header"; "Column 4 Header")
                {
                }
                field("Column 5 Header"; "Column 5 Header")
                {
                }
                field("Column 6 Header"; "Column 6 Header")
                {
                }
                field("Column 7 Header"; "Column 7 Header")
                {
                }
                field("Column 8 Header"; "Column 8 Header")
                {
                }
                field("Column 9 Header"; "Column 9 Header")
                {
                }
                field("Column 10 Header"; "Column 10 Header")
                {
                }
                field("Column 11 Header"; "Column 11 Header")
                {
                }
                field("Column 12 Header"; "Column 12 Header")
                {
                }
                field("Data Start Row"; "Data Start Row")
                {
                }
                field("Column 1 Data Type"; "Column 1 Data Type")
                {
                    Caption = 'Data Type';
                }
                field("Column 1 Dimension"; "Column 1 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 2 Data Type"; "Column 2 Data Type")
                {
                }
                field("Column 2 Dimension"; "Column 2 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 3 Data Type"; "Column 3 Data Type")
                {
                }
                field("Column 3 Dimension"; "Column 3 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 4 Data Type"; "Column 4 Data Type")
                {
                }
                field("Column 4 Dimension"; "Column 4 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 5 Data Type"; "Column 5 Data Type")
                {
                }
                field("Column 5 Dimension"; "Column 5 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 6 Data Type"; "Column 6 Data Type")
                {
                }
                field("Column 6 Dimension"; "Column 6 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 7 Data Type"; "Column 7 Data Type")
                {
                }
                field("Column 7 Dimension"; "Column 7 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 8 Data Type"; "Column 8 Data Type")
                {
                }
                field("Column 8 Dimension"; "Column 8 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 9 Data Type"; "Column 9 Data Type")
                {
                }
                field("Column 9 Dimension"; "Column 9 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 10 Data Type"; "Column 10 Data Type")
                {
                }
                field("Column 10 Dimension"; "Column 10 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 11 Data Type"; "Column 11 Data Type")
                {
                }
                field("Column 11 Dimension"; "Column 11 Dimension")
                {
                    Caption = 'Dimension';
                }
                field("Column 12 Data Type"; "Column 12 Data Type")
                {
                }
                field("Column 12 Dimension"; "Column 12 Dimension")
                {
                    Caption = 'Dimension';
                }
            }
        }
    }

    actions
    {
    }
}

