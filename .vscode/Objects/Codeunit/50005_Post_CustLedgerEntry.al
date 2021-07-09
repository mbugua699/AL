codeunit 50005 MySubscriberCodeunit5
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."ShortCut Dimension 3 code" := GenJournalLine."Shortcut Dimension 3 Code";
        CustLedgerEntry."ShortCut Dimension 4 code" := GenJournalLine."Shortcut Dimension 4 Code";
        CustLedgerEntry."Dimension Set ID" := GenJournalLine."Dimension Set ID";

    end;

}