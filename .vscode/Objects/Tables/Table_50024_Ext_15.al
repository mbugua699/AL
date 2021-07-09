/// <summary>
/// TableExtension Extends G/l Account (ID 50024) extends Record G/L Account.
/// </summary>
tableextension 50024 "Extends G/l Account" extends "G/L Account"
{
    fields
    {

        field(64112; "Budgeted Amount Add. Curr"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry"."Amount Add. Curr" WHERE("G/L Account No." = FIELD("No."),
                                                                           "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                           "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                           "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                           "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                           Date = FIELD("Date Filter"),
                                                                           "Budget Name" = FIELD("Budget Filter"),
                                                                           "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                                            "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                            ));
        }
        field(64113; "Shortcut Dimension 3 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 code");
            end;

        }
        field(64114; "Shortcut Dimension 3 Filter"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Filter';
            CaptionClass = '1,4,3';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

        }
        field(64115; "Shortcut Dimension 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(64116; "Shortcut Dimension 4 Filter"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Filter';
            CaptionClass = '1,4,4';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

        }

        field(64120; "Balance at Date."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                        "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")));
            Caption = 'Balance at Date.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64121; "Net Change."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Posting Date" = FIELD("Date Filter"),
                                                        "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                        ));
            Caption = 'Net Change.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64122; "Balance."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                        "G/L Account No." = FIELD(FILTER(Totaling)),
                                                        "Business Unit Code" = FIELD("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                        "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                        "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")));
            Caption = 'Balance.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64123; "Budget at Date."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                               "G/L Account No." = FIELD(FILTER(Totaling)),
                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD(UPPERLIMIT("Date Filter")),
                                                               "Budget Name" = FIELD("Budget Filter"),
                                                               "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                               "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                ));
            Caption = 'Budget at Date.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64124; "Debit Amount."; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Debit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                "Posting Date" = FIELD("Date Filter"),
                                                                "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                                "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                 ));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64125; "Credit Amount."; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("G/L Entry"."Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                 "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                 "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                 "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                 "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                                 "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                  ));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64126; "Additional-Currency Net Chang."; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                               ));
            Caption = 'Additional-Currency Net Chang.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64127; "Add.-Currency Balance at Date."; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                              "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                               ));
            Caption = 'Add.-Currency Balance at Date.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64128; "Additional-Currency Balance."; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Additional-Currency Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                               ));
            Caption = 'Additional-Currency Balance.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64129; "Add.-Currency Debit Amount."; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Debit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                              "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                              "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Posting Date" = FIELD("Date Filter"),
                                                                              "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                               ));
            Caption = 'Add.-Currency Debit Amount.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64130; "Add.-Currency Credit Amount."; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry"."Add.-Currency Credit Amount" WHERE("G/L Account No." = FIELD("No."),
                                                                               "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Posting Date" = FIELD("Date Filter"),
                                                                               "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                                ));
            Caption = 'Add.-Currency Credit Amount.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64131; "Budgeted Debit Amount."; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                               "G/L Account No." = FIELD(FILTER(Totaling)),
                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD("Date Filter"),
                                                               "Budget Name" = FIELD("Budget Filter"),
                                                               "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                               "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                ));
            Caption = 'Budgeted Debit Amount';
            FieldClass = FlowField;
        }
        field(64132; "Budgeted Credit Amount."; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = - Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                                "G/L Account No." = FIELD(FILTER(Totaling)),
                                                                "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                Date = FIELD("Date Filter"),
                                                                "Budget Name" = FIELD("Budget Filter"),
                                                                "Dimension Set ID" = FIELD("Dimension Set ID Filter"),
                                                                "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                 ));
            Caption = 'Budgeted Credit Amount';
            FieldClass = FlowField;
        }
        field(64133; "Budgeted Amount."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("G/L Account No." = FIELD("No."),
                                                               "G/L Account No." = FIELD(FILTER(Totaling)),
                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                               Date = FIELD("Date Filter"),
                                                               "Budget Name" = FIELD("Budget Filter"),
                                                               "ShortCut Dimension 3 code" = FIELD("Shortcut Dimension 3 Filter"),
                                                        "ShortCut Dimension 4 code" = FIELD("Shortcut Dimension 4 Filter")
                                                                ));
            Caption = 'Budgeted Amount.';
            FieldClass = FlowField;
        }

        // Add changes to table fields here

    }



    var
    // myInt: Integer;
}