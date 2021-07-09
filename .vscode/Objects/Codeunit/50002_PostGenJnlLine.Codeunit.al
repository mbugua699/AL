codeunit 50002 MySubscriberCodeunit
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR GLEntry: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."ShortCut Dimension 3 code" := GenJournalLine."Shortcut Dimension 3 Code";
        GLEntry."ShortCut Dimension 4 code" := GenJournalLine."Shortcut Dimension 4 Code";
        GLEntry."ShortCut Dimension 5 code" := GenJournalLine."Shortcut Dimension 5 Code";

    end;

}