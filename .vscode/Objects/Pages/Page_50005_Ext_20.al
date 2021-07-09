pageextension 50005 "Extend General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        modify("Global Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Global Dimension 2 Code")
        {
            Visible = true;
        }
        addafter("Global Dimension 2 Code")
        {

            field("ShortCut Dimension 3 code"; "ShortCut Dimension 3 code")
            {
                ApplicationArea = all;
                visible = true;
            }

            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                ApplicationArea = all;
                visible = true;
            }

            field("ShortCut Dimension 5 code"; "ShortCut Dimension 5 code")
            {
                ApplicationArea = all;
                visible = true;
            }


        }
    }

    // trigger OnAfterGetRecord()
    // var
    //     DimMgt: Codeunit DimensionManagement;
    //     ShortcutDimensionCode: array[8] of Code[20];
    // begin
    //     DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimensionCode);
    //     "ShortCut Dimension 3 code" := ShortcutDimensionCode[3];
    //     "ShortCut Dimension 4 code" := ShortcutDimensionCode[4];
    //     "ShortCut Dimension 5 code" := ShortcutDimensionCode[5];
    // end;

    // var
    //     ShortcutDimension3: Code[20];
    //     ShortcutDimension4: Code[20];
    //     ShortcutDimension5: Code[20];
}





