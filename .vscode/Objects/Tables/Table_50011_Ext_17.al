tableextension 50011 MyExtension extends "G/L Entry"
{
    fields
    {

        field(64110; "ShortCut Dimension 3 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 3 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

        }

        field(64114; "ShortCut Dimension 4 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            DataClassification = CustomerContent;
        }
        field(64115; "ShortCut Dimension 5 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = CustomerContent;
        }

        field(50000; Recipient; Text[80])
        {
            Caption = 'Recipient';
            DataClassification = ToBeClassified;

        }
        field(50001; "No. of Units"; Decimal)
        {
            Caption = 'No. of Units';
            DataClassification = ToBeClassified;
        }
        field(50002; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }
        field(50100; "Add.-Curr. Amount Corrected"; Boolean)
        {
            Caption = 'Add.-Curr. Amount Corrected';
            DataClassification = ToBeClassified;
        }

    }



    var
        myInt: Integer;
}