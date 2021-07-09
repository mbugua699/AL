codeunit 50004 MySubscriberCodeunit4
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        BankAccountLedgerEntry."ShortCut Dimension 3 code" := GenJournalLine."Shortcut Dimension 3 Code";
        BankAccountLedgerEntry."ShortCut Dimension 4 code" := GenJournalLine."Shortcut Dimension 4 Code";
        BankAccountLedgerEntry."Dimension Set ID" := GenJournalLine."Dimension Set ID";

    end;

}