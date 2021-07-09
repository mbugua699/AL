codeunit 50009 MySubscriberCodeunit9
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnAfterValidateShortcutDimCode', '', true, true)]
    local procedure RetrieveShortCutDim(var GenJournalLine: Record "Gen. Journal Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    var
        Dim: Record "Dimension Value";
        GenJournPage: Page "General Journal";
    begin
        If DimIndex = 3 then begin
            GenJournalLine."Shortcut Dimension 3 Code" := ShortcutDimCode[3];
            If (GenJournalLine."Shortcut Dimension 1 Code" <> '') and (GenJournalLine."Shortcut Dimension 3 Code" <> '') then begin

                Dim.SetFilter(DonorCode, GenJournalLine."Shortcut Dimension 3 Code");
                Dim.SetFilter(ActivityCode, GenJournalLine."Shortcut Dimension 1 Code");
                IF Dim.Find('-') then Begin
                    GenJournalLine."Shortcut Dimension 4 Code" := Dim.Code;
                    GenJournalLine.ValidateShortcutDimCode(4, GenJournalLine."Shortcut Dimension 4 Code");
                    GenJournalLine.ShowShortcutDimCode(ShortcutDimCode);

                End;


            end;
        end else
            If DimIndex = 4 then begin
                //Message('DimIndex %1 ShortcutDimCode %2', DimIndex, ShortcutDimCode[4]);
                GenJournalLine."Shortcut Dimension 4 Code" := ShortcutDimCode[4];
            end else
                If DimIndex = 5 then begin
                    //Message('DimIndex %1 ShortcutDimCode %2', DimIndex, ShortcutDimCode[5]);
                    GenJournalLine."Shortcut Dimension 5 Code" := ShortcutDimCode[5];
                end;
        GenJournalLine.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnAfterValidateShortcutDimCode2', '', true, true)]
    local procedure RetrieveShortCutDim2(var GenJournalLine: Record "Gen. Journal Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    var
        Dim: Record "Dimension Value";
        GenJournPage: Page "General Journal";
    begin
        If DimIndex = 3 then begin
            GenJournalLine."Shortcut Dimension 3 Code" := ShortcutDimCode[3];
            If (GenJournalLine."Shortcut Dimension 1 Code" <> '') and (GenJournalLine."Shortcut Dimension 3 Code" <> '') then begin

                Dim.SetFilter(DonorCode, GenJournalLine."Shortcut Dimension 3 Code");
                Dim.SetFilter(ActivityCode, GenJournalLine."Shortcut Dimension 1 Code");
                IF Dim.Find('-') then Begin
                    GenJournalLine."Shortcut Dimension 4 Code" := Dim.Code;
                    GenJournalLine.ValidateShortcutDimCode(4, GenJournalLine."Shortcut Dimension 4 Code");
                    GenJournalLine.ShowShortcutDimCode(ShortcutDimCode);

                End;


            end;
        end else
            If DimIndex = 4 then begin
                //Message('DimIndex %1 ShortcutDimCode %2', DimIndex, ShortcutDimCode[4]);
                GenJournalLine."Shortcut Dimension 4 Code" := ShortcutDimCode[4];
            end else
                If DimIndex = 5 then begin
                    //Message('DimIndex %1 ShortcutDimCode %2', DimIndex, ShortcutDimCode[5]);
                    GenJournalLine."Shortcut Dimension 5 Code" := ShortcutDimCode[5];
                end;
        GenJournalLine.Modify();
    end;

}