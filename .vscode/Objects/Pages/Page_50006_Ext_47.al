pageextension 50006 "Extends Sales Invoice Subform" extends "Sales Invoice Subform"
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
}