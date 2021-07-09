/// <summary>
/// PageExtension Extends Bank Acc Recon (ID 50025) extends Record Bank Acc. Reconciliation.
/// </summary>
pageextension 50025 "Extends Bank Acc Recon" extends "Bank Acc. Reconciliation"

{
    layout
    {
        modify(StatementNo)
        {
            Editable = true;
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(SuggestLines2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Suggest  Lines';
                Ellipsis = true;
                Image = SuggestLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create bank account ledger entries suggestions and enter them automatically.';

                trigger OnAction();
                begin

                    SuggestBankAccStatement2.SetStmt(Rec);
                    SuggestBankAccStatement2.RUNMODAL;
                    CLEAR(SuggestBankAccStatement2);
                end;
            }
            action("Bank Recon.-Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Recon.-Report';
                Ellipsis = true;
                Image = Report;
                Promoted = true;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(REC);
                    REPORT.RUNMODAL(REPORT::"Vega Bank Recon.-Test", TRUE, FALSE, Rec);
                end;

            }

        }

        addbefore(PostAndPrint)
        {
            action(Post2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                trigger OnAction()
                begin
                    IF NOT CONFIRM(ConfirmQuestion, FALSE) THEN
                        EXIT;

                    Bankaccpost.Run(Rec);
                    //"Bank Acc. Recon. Post (Yes/No)"
                end;
            }
            action("Vega bank")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Test Report';
                Promoted = true;
                Ellipsis = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Image = "Report";
                // RunObject = report "Vega Bank Recon.-Test";
                ToolTip = 'Preview the resulting bank account reconciliations to see the consequences before you perform the actual posting.';

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(REC);
                    REPORT.RUNMODAL(REPORT::"Vega Bank Recon.-Test", TRUE, FALSE, Rec);
                end;
            }
            action(PostAndPrint2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post and &Print';
                Image = PostPrint;
                Visible = false;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    IF NOT CONFIRM(ConfirmQuestion, FALSE) THEN
                        EXIT;
                    Backaccpostprint.Run(Rec);
                    //"Bank Acc. Recon. Post+Print"    
                end;
            }
        }

        modify(SuggestLines)

        {
            Visible = false;
            Enabled = false;
        }
        modify(Post)
        {
            Visible = false;
            Enabled = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
            Enabled = false;
        }
        modify("&Test Report")
        {
            Visible = false;
            Enabled = false;
        }


    }
    var
        SuggestBankAccStatement2: Report "Vega Suggest Bank Acc Lines";
        ConfirmQuestion: Label 'Have you printed Back Acc. Recon. report ?';
        Backaccpostprint: Codeunit "Bank Acc. Recon. Post+Print";
        Bankaccpost: Codeunit "Bank Acc. Recon. Post (Yes/No)";
}