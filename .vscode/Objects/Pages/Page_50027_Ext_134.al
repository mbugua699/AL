pageextension 50027 "Extends Postd Sales Credit Mem" extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shortcut Dimension 2 Code")
        {
            field("ShortCut Dimension 3 code"; "ShortCut Dimension 3 code")
            {
                Visible = false;

                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                CaptionClass = '1,2,3';
                Editable = false;
            }
            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                CaptionClass = '1,2,4';
                Editable = false;

            }
            field("ShortCut Dimension 5 code"; "ShortCut Dimension 5 code")
            {
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                CaptionClass = '1,2,5';
                Editable = false;


            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ShortcutDim3: Code[20];
        ShortcutDim4: Code[20];
        ShortcutDim5: Code[20];

        SalesLine3: Record "Sales Line";

}