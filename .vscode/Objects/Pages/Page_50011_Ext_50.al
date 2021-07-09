pageextension 50011 "Extend Purchase Order" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shortcut Dimension 2 Code")
        {
            field("ShortCut Dimension 3 code"; "ShortCut Dimension 3 code")
            {
                Visible = false;
                trigger OnValidate()
                begin
                    PurchaseLine3.SetRange("Document No.", "No.");
                    if PurchaseLine3.Find('-') Then begin
                        repeat
                            PurchaseLine3."ShortCut Dimension 3 code" := "ShortCut Dimension 3 code";
                            PurchaseLine3.Modify();
                        until PurchaseLine3.Next() = 0;
                    end;

                    CurrPage.UPDATE;
                end;
            }
            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                trigger OnValidate()
                begin
                    PurchaseLine3.SetRange("Document No.", "No.");
                    if PurchaseLine3.Find('-') Then begin
                        repeat
                            PurchaseLine3."ShortCut Dimension 4 code" := "ShortCut Dimension 4 code";
                            PurchaseLine3.Modify();
                        until PurchaseLine3.Next() = 0;
                    end;
                    CurrPage.UPDATE;
                end;
            }
            field("ShortCut Dimension 5 code"; "ShortCut Dimension 5 code")
            {
                trigger OnValidate()
                begin
                    PurchaseLine3.SetRange("Document No.", "No.");
                    if PurchaseLine3.Find('-') Then begin
                        repeat
                            PurchaseLine3."ShortCut Dimension 5 code" := "ShortCut Dimension 5 code";
                            PurchaseLine3.Modify();
                        until PurchaseLine3.Next() = 0;
                    end;
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

        PurchaseLine3: Record "Purchase Line";

}