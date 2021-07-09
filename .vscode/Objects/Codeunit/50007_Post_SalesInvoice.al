codeunit 50007 MySubscriberCodeunit7
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR GenJnlLine: Record "Gen. Journal Line"; VAR SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line"; VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        GenJnlLine."ShortCut Dimension 3 code" := SalesHeader."Shortcut Dimension 3 Code";
        GenJnlLine."ShortCut Dimension 4 code" := SalesHeader."Shortcut Dimension 4 Code";
        GenJnlLine."ShortCut Dimension 5 code" := SalesHeader."Shortcut Dimension 5 Code";

        GenJnlLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforePostInvPostBuffer', '', true, true)]
    local procedure AddShortCutDimGlEntry2(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean)
    begin
        GenJnlLine."ShortCut Dimension 3 code" := SalesHeader."Shortcut Dimension 3 Code";
        GenJnlLine."ShortCut Dimension 4 code" := SalesHeader."Shortcut Dimension 4 Code";
        GenJnlLine."ShortCut Dimension 5 code" := SalesHeader."Shortcut Dimension 5 Code";



        GenJnlLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
    end;


}