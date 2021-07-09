pageextension 50012 "Extend Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Enabled = false;
        }
        modify(ShortcutDimCode3)
        {
            Enabled = false;
        }
        modify(ShortcutDimCode4)
        {
            Enabled = false;
        }
        modify(ShortcutDimCode5)
        {
            Enabled = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}