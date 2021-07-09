codeunit 50008 MySubscriberCodeunit8
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', true, true)]
    local procedure AddShortCutDimGlEntry(VAR GenJnlLine: Record "Gen. Journal Line"; VAR PurchHeader: Record "Purchase Header"; VAR TotalPurchLine: Record "Purchase Line"; VAR TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        GenJnlLine."ShortCut Dimension 3 code" := PurchHeader."Shortcut Dimension 3 Code";
        GenJnlLine."ShortCut Dimension 4 code" := PurchHeader."Shortcut Dimension 4 Code";
        GenJnlLine."ShortCut Dimension 5 code" := PurchHeader."Shortcut Dimension 5 Code";

        GenJnlLine."Dimension Set ID" := PurchHeader."Dimension Set ID";

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnBeforePostInvPostBuffer', '', true, true)]
    local procedure AddShortCutDimGlEntry2(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR PurchHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        GenJnlLine."ShortCut Dimension 3 code" := PurchHeader."Shortcut Dimension 3 Code";
        GenJnlLine."ShortCut Dimension 4 code" := PurchHeader."Shortcut Dimension 4 Code";
        GenJnlLine."ShortCut Dimension 5 code" := PurchHeader."Shortcut Dimension 5 Code";

        GenJnlLine."Dimension Set ID" := PurchHeader."Dimension Set ID";

    end;



}