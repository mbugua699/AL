tableextension 50028 "Extends Sales Inv Header" extends "Sales Invoice Header"
{
    fields
    {

        field(64110; "ShortCut Dimension 3 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 3 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = CustomerContent;
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
    }
}