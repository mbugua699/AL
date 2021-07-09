pageextension 50015 "Extend Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {

        addafter("Global Dimension 2 Code")
        {
            field("ShortCut Dimension 3 code"; "ShortCut Dimension 3 code")
            {
                ApplicationArea = all;
            }

            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                ApplicationArea = all;
                visible = true;
            }
        }
    }
}