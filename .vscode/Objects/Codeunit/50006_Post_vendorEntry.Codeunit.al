codeunit 50006 MySubscriberCodeunit6
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."ShortCut Dimension 3 code" := GenJournalLine."Shortcut Dimension 3 Code";
        VendorLedgerEntry."ShortCut Dimension 4 code" := GenJournalLine."Shortcut Dimension 4 Code";
        VendorLedgerEntry."Dimension Set ID" := GenJournalLine."Dimension Set ID";

    end;



}