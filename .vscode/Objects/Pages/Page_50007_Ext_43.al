pageextension 50007 "Extends Sales Invoice" extends "Sales Invoice"
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

                trigger OnValidate()
                begin
                    ShortcutDim3 := "ShortCut Dimension 3 code";

                    SalesLine3.SetRange("Document No.", "No.");
                    If SalesLine3.Find('-') Then begin
                        repeat
                            SalesLine3."ShortCut Dimension 3 code" := ShortcutDim3;
                            SalesLine3.Modify();
                        until SalesLine3.Next() = 0;
                    end;

                    ValidateShortcutDimCode(3, ShortcutDim3);

                    CurrPage.UPDATE;
                end;
            }
            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                CaptionClass = '1,2,4';


                trigger OnValidate()
                begin
                    ShortcutDim4 := "ShortCut Dimension 4 code";

                    SalesLine3.SetRange("Document No.", "No.");
                    If SalesLine3.Find('-') Then begin
                        repeat
                            SalesLine3."ShortCut Dimension 4 code" := ShortcutDim4;
                            SalesLine3.Modify();
                        until SalesLine3.Next() = 0;
                    end;


                    ValidateShortcutDimCode(4, ShortcutDim4);

                    CurrPage.UPDATE;
                end;
            }
            field("ShortCut Dimension 5 code"; "ShortCut Dimension 5 code")
            {
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                CaptionClass = '1,2,5';

                trigger OnValidate()
                begin
                    ShortcutDim5 := "ShortCut Dimension 5 code";

                    SalesLine3.SetRange("Document No.", "No.");
                    If SalesLine3.Find('-') Then begin
                        repeat
                            SalesLine3."ShortCut Dimension 5 code" := ShortcutDim5;
                            SalesLine3.Modify();
                        until SalesLine3.Next() = 0;
                    end;
                    ValidateShortcutDimCode(5, ShortcutDim5);

                    CurrPage.UPDATE;
                end;
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