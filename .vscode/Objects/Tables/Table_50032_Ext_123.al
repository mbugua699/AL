tableextension 50032 "Extends Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "ShortCut Dimension 3 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 3 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = CustomerContent;

        }

        field(50002; "ShortCut Dimension 4 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            DataClassification = CustomerContent;

        }
        field(50003; "ShortCut Dimension 5 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = CustomerContent;

        }

    }

    var
        myInt: Integer;
}