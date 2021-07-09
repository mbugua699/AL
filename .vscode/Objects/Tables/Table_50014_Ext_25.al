tableextension 50014 "Extends Vend Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "ShortCut Dimension 3 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 4 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            DataClassification = CustomerContent;

        }
        field(50001; "ShortCut Dimension 4 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 4 code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            DataClassification = CustomerContent;

        }

    }

}