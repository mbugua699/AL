/// <summary>
/// TableExtension Extends Gen. Journal Line (ID 50015) extends Record Gen. Journal Line.
/// </summary>
tableextension 50015 "Extends Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {

        field(50000; Recipient; Text[80])
        {
            Caption = 'Recipient';
            DataClassification = ToBeClassified;
        }
        field(50001; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50002; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50010; "Import From Branches"; Boolean)
        {
            Caption = 'Import From Branches';
            DataClassification = ToBeClassified;
        }
        field(50011; "Import Error Description"; Text[50])
        {
            Caption = 'Error Description';
            DataClassification = ToBeClassified;
            Description = 'Import Branches error description';
        }
        field(64111; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Description = 'SSRC-D001 - used by Payroll import function for staff no';
        }
        field(64110; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = '';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), DonorCode = field("Shortcut Dimension 4 Code"));

            DataClassification = CustomerContent;

        }
        field(64114; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            DataClassification = CustomerContent;
        }
        field(64115; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = CustomerContent;
        }

    }
}
