/// <summary>
/// Page Modify Posted Dimension (ID 50006).
/// </summary>
page 50006 "Modify Posted Dimension"
{


    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = Document;
    SaveValues = true;
    SourceTable = "Posted Dimension Modify";

    layout
    {
        area(content)
        {
            field(DocumentNo; DocumentNo)
            {
                Caption = 'Document No.';
            }
            field(PostingDate; PostingDate)
            {
                Caption = 'Posting Date';
            }
            repeater(Control1)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Account No."; "Account No.")
                {
                }
                field(Amount; Amount)
                {
                }
                field(Description; Description)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = ShortcutDimension1CodeVisible;
                }
                field("New Shortcut Dimension 1 Code"; "New Shortcut Dimension 1 Code")
                {
                    Visible = NewShortcutDimension1CodeVisib;
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(1, "New Shortcut Dimension 1 Code");
                        UpdateDimensionSetId(1, "New Shortcut Dimension 1 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(1, "New Shortcut Dimension 1 Code");
                        UpdateDimensionSetId(1, "New Shortcut Dimension 1 Code");
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = ShortcutDimension2CodeVisible;
                }
                field("New Shortcut Dimension 2 Code"; "New Shortcut Dimension 2 Code")
                {
                    Visible = NewShortcutDimension2CodeVisib;
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(2, "New Shortcut Dimension 2 Code");
                        UpdateDimensionSetId(2, "New Shortcut Dimension 2 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(2, "New Shortcut Dimension 2 Code");
                        UpdateDimensionSetId(2, "New Shortcut Dimension 2 Code");
                    end;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    Visible = ShortcutDimension3CodeVisible;
                }
                field("New Shortcut Dimension 3 Code"; "New Shortcut Dimension 3 Code")
                {
                    Lookup = true;
                    Visible = NewShortcutDimension3CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(3, "New Shortcut Dimension 3 Code");
                        UpdateDimensionSetId(3, "New Shortcut Dimension 3 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(3, "New Shortcut Dimension 3 Code");
                        UpdateDimensionSetId(3, "New Shortcut Dimension 3 Code");
                    end;
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    CaptionClass = '1,2,4';
                    Visible = ShortcutDimension4CodeVisible;
                }
                field("New Shortcut Dimension 4 Code"; "New Shortcut Dimension 4 Code")
                {
                    CaptionClass = '1,7,4';
                    Caption = 'New Code 4';
                    Lookup = true;
                    Visible = NewShortcutDimension4CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(4, "New Shortcut Dimension 4 Code");
                        UpdateDimensionSetId(4, "New Shortcut Dimension 4 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(4, "New Shortcut Dimension 4 Code");
                        UpdateDimensionSetId(4, "New Shortcut Dimension 4 Code");

                    end;
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 5 Code")
                {
                    CaptionClass = '1,2,5';
                    Visible = ShortcutDimension5CodeVisible;
                }
                field("New Shortcut Dimension 5 Code"; "New Shortcut Dimension 5 Code")
                {
                    CaptionClass = '1,7,5';
                    Caption = 'New Code 5';
                    Lookup = true;
                    Visible = NewShortcutDimension5CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(5, "New Shortcut Dimension 5 Code");
                        UpdateDimensionSetId(5, "New Shortcut Dimension 5 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(5, "New Shortcut Dimension 5 Code");
                        UpdateDimensionSetId(5, "New Shortcut Dimension 5 Code");
                    end;
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 6 Code")
                {
                    CaptionClass = '1,2,6';
                    Visible = ShortcutDimension6CodeVisible;
                }
                field("New Shortcut Dimension 6 Code"; "New Shortcut Dimension 6 Code")
                {
                    CaptionClass = '1,7,6';
                    Caption = 'New Code 6';
                    Lookup = true;
                    Visible = NewShortcutDimension6CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(6, "New Shortcut Dimension 6 Code");
                        UpdateDimensionSetId(6, "New Shortcut Dimension 6 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(6, "New Shortcut Dimension 6 Code");
                        UpdateDimensionSetId(6, "New Shortcut Dimension 6 Code");
                    end;
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    CaptionClass = '1,2,7';
                    Visible = ShortcutDimension7CodeVisible;
                }
                field("New Shortcut Dimension 7 Code"; "New Shortcut Dimension 7 Code")
                {
                    CaptionClass = '1,7,7';
                    Caption = 'New Code 7';
                    Lookup = true;
                    Visible = NewShortcutDimension7CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(7, "New Shortcut Dimension 7 Code");
                        UpdateDimensionSetId(7, "New Shortcut Dimension 7 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(7, "New Shortcut Dimension 7 Code");
                        UpdateDimensionSetId(7, "New Shortcut Dimension 7 Code");
                    end;
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 8 Code")
                {
                    CaptionClass = '1,2,8';
                    Visible = ShortcutDimension8CodeVisible;
                }
                field("New Shortcut Dimension 8 Code"; "New Shortcut Dimension 8 Code")
                {
                    CaptionClass = '1,7,8';
                    Caption = 'New Code 8';
                    Lookup = true;
                    Visible = NewShortcutDimension8CodeVisib;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        LookupShortcutDimCode(8, "New Shortcut Dimension 8 Code");
                        UpdateDimensionSetId(8, "New Shortcut Dimension 8 Code");
                    end;

                    trigger OnValidate();
                    begin
                        ValidateShortcutDimCode(8, "New Shortcut Dimension 8 Code");
                        UpdateDimensionSetId(8, "New Shortcut Dimension 8 Code");
                    end;
                }
                field("Dimension Set Id"; "Dimension Set Id")
                {

                }
                field("New Dimension Set Id"; "New Dimension Set Id")
                {

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Find)
            {
                Caption = 'Find';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Populate(DocumentNo, PostingDate);
                    SETRANGE("Document No.", DocumentNo);
                    if (PostingDate = 0D) then
                        SETRANGE("Posting Date")
                    else
                        SETRANGE("Posting Date", PostingDate);
                end;
            }
            action(Update)
            {
                Caption = 'Update';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Update(DocumentNo, PostingDate);
                    DocumentNo := '';
                    PostingDate := 0D;
                end;
            }
        }
    }

    trigger OnInit();
    begin
        NewShortcutDimension8CodeVisib := true;
        NewShortcutDimension7CodeVisib := true;
        NewShortcutDimension6CodeVisib := true;
        NewShortcutDimension5CodeVisib := true;
        NewShortcutDimension4CodeVisib := true;
        NewShortcutDimension3CodeVisib := true;
        NewShortcutDimension2CodeVisib := true;
        NewShortcutDimension1CodeVisib := true;
        ShortcutDimension8CodeVisible := true;
        ShortcutDimension7CodeVisible := true;
        ShortcutDimension6CodeVisible := true;
        ShortcutDimension5CodeVisible := true;
        ShortcutDimension4CodeVisible := true;
        ShortcutDimension3CodeVisible := true;
        ShortcutDimension2CodeVisible := true;
        ShortcutDimension1CodeVisible := true;
    end;

    trigger OnOpenPage();
    var
        JnlSelected: Boolean;
    begin
        with GLSetup do begin
            GET;
            ShortcutDimension1CodeVisible := ("Shortcut Dimension 1 Code" <> '');
            ShortcutDimension2CodeVisible := ("Shortcut Dimension 2 Code" <> '');
            ShortcutDimension3CodeVisible := ("Shortcut Dimension 3 Code" <> '');
            ShortcutDimension4CodeVisible := ("Shortcut Dimension 4 Code" <> '');
            ShortcutDimension5CodeVisible := ("Shortcut Dimension 5 Code" <> '');
            ShortcutDimension6CodeVisible := ("Shortcut Dimension 6 Code" <> '');
            ShortcutDimension7CodeVisible := ("Shortcut Dimension 7 Code" <> '');
            ShortcutDimension8CodeVisible := ("Shortcut Dimension 8 Code" <> '');
            NewShortcutDimension1CodeVisib := ("Shortcut Dimension 1 Code" <> '');
            NewShortcutDimension2CodeVisib := ("Shortcut Dimension 2 Code" <> '');
            NewShortcutDimension3CodeVisib := ("Shortcut Dimension 3 Code" <> '');
            NewShortcutDimension4CodeVisib := ("Shortcut Dimension 4 Code" <> '');
            NewShortcutDimension5CodeVisib := ("Shortcut Dimension 5 Code" <> '');
            NewShortcutDimension6CodeVisib := ("Shortcut Dimension 6 Code" <> '');
            NewShortcutDimension7CodeVisib := ("Shortcut Dimension 7 Code" <> '');
            NewShortcutDimension8CodeVisib := ("Shortcut Dimension 8 Code" <> '');
        end;

        if (DocumentNo = '') then
            SETFILTER("Posting Date", '<%1', 0D)
        else begin
            SETRANGE("Document No.", DocumentNo);
            if (PostingDate = 0D) then
                SETRANGE("Posting Date")
            else
                SETRANGE("Posting Date", PostingDate);
        end;
    end;

    var
        DocumentNo: Code[20];
        PostingDate: Date;
        GLSetup: Record "General Ledger Setup";
        [InDataSet]
        ShortcutDimension1CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension2CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension3CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension4CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension5CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension6CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension7CodeVisible: Boolean;
        [InDataSet]
        ShortcutDimension8CodeVisible: Boolean;
        [InDataSet]
        NewShortcutDimension1CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension2CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension3CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension4CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension5CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension6CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension7CodeVisib: Boolean;
        [InDataSet]
        NewShortcutDimension8CodeVisib: Boolean;
}

