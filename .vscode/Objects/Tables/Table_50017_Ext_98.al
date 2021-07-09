/// <summary>
/// TableExtension Extends General Ledger Setup (ID 50017) extends Record General Ledger Setup.
/// </summary>
tableextension 50017 "Extends General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Income A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50001; "Expense A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50002; "Cash at Bank A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50003; "Cash at Hand A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50004; "Working Advance A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50005; "Other A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50006; "Cutoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "No Incr. Batch Name"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Donor Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(50011; "Project Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(50012; "Activity Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(50013; "Opening Balance A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50014; "Payable A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50015; "Transfers A/C Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50016; "Prior Year Adjust. Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(50017; "Revaluation Gain/Loss Filter"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
        }
        field(64112; "Required Bal. a/c (Dim1)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64113; "Required Bal. a/c (Dim2)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64114; "Required Bal. a/c (Dim3)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64115; "Required Exp. a/c (Dim1)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64116; "Required Exp. a/c (Dim2)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64117; "Required Exp. a/c (Dim3)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64202; "Header Text 1 (Cell A1)"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Import from branches....';
        }
        field(64203; "Header Text 2 (Cell A2)"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64210; "Column Headers Row No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(64211; "Column 1 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64212; "Column 2 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64213; "Column 3 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64214; "Column 4 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64215; "Column 5 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64216; "Column 6 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64217; "Column 7 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64218; "Column 8 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64219; "Column 9 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64220; "Column 10 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64221; "Column 11 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64222; "Column 12 Header"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(64230; "Data Start Row"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(64231; "Column 1 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64232; "Column 2 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64233; "Column 3 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64234; "Column 4 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64235; "Column 5 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64236; "Column 6 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64237; "Column 7 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64238; "Column 8 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64239; "Column 9 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64240; "Column 10 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64241; "Column 11 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64242; "Column 12 Data Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Date,Description,"G/L Acc. No.","Debit Amount","Credit Amount",Dimension,Recipient;
        }
        field(64251; "Column 1 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64252; "Column 2 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64253; "Column 3 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64254; "Column 4 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64255; "Column 5 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64256; "Column 6 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64257; "Column 7 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64258; "Column 8 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64259; "Column 9 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64260; "Column 10 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64261; "Column 11 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64262; "Column 12 Dimension"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Dimension;
        }
        field(64270; "Default Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template".Name WHERE(Type = CONST(General));
        } // Add changes to table fields here
        field(50018; ActivityShowDonorCode; Boolean)
        {

        }
        field(50019; DonorActivityShowActivityCode; Boolean)
        {

        }
        field(50020; DonorActivityShowDonorCode; Boolean)
        {

        }
        field(50021; ProjectShowDonorCode; Boolean)
        {

        }
        field(50022; ActivityShowDonorActivity; Boolean)
        {

        }

    }

    var
        myInt: Integer;
}