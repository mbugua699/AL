tableextension 50016 "Extends G/L Budget Entry" extends "G/L Budget Entry"
{
    fields
    {
        field(64111; "Amount Add. Curr"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Currency Code" = '' THEN BEGIN
                    Amount := "Amount Add. Curr";
                    VALIDATE(Amount);
                END ELSE BEGIN
                    IF CheckFixedCurrency THEN BEGIN
                        GetCurrency;
                        Amount := ROUND(
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            Date, "Currency Code",
                            "Amount Add. Curr", "Currency Factor"),
                            Currency."Amount Rounding Precision")
                    END ELSE BEGIN
                        TESTFIELD("Amount Add. Curr");
                        TESTFIELD(Amount);

                        //"Currency Factor" := Amount / "Amount Add. Curr";
                        "Currency Factor" := "Amount Add. Curr" / Amount;
                    END;
                END;
            end;
        }
        field(64112; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       (Date <> xRec.Date) OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate(Date, "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(64113; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE(Amount);

            end;
        }
        // Add changes to table fields here
        field(64110; "ShortCut Dimension 3 code"; Code[20])
        {
            Caption = 'ShortCut Dimension 3 code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            DataClassification = CustomerContent;
        }
        field(64114; "ShortCut Dimension 4 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            DataClassification = CustomerContent;
        }
        field(64115; "ShortCut Dimension 5 code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
            DataClassification = CustomerContent;
        }
        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                //ktm


                GetCurrency;
                IF "Currency Code" = '' THEN
                    "Amount Add. Curr" := Amount
                ELSE
                    "Amount Add. Curr" := ROUND(
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        Date, "Currency Code",
                        Amount, "Currency Factor"),
                        Currency."Amount Rounding Precision");

                //ktm
            end;
        }
    }

    procedure GetCurrency();
    begin
        CurrencyCode := "Currency Code";

        IF CurrencyCode = '' THEN BEGIN
            CLEAR(Currency);
            Currency.InitRoundingPrecision
        END ELSE
            IF CurrencyCode <> Currency.Code THEN BEGIN
                Currency.GET(CurrencyCode);
                Currency.TESTFIELD("Amount Rounding Precision");
            END;

    end;

    procedure CheckFixedCurrency(): Boolean;

    var
        CurrExchRate: Record "Currency Exchange Rate";

    begin

        CurrExchRate.SETRANGE("Currency Code", "Currency Code");
        CurrExchRate.SETRANGE("Starting Date", 0D, Date);

        IF NOT CurrExchRate.FIND('+') THEN
            EXIT(FALSE);

        IF CurrExchRate."Relational Currency Code" = '' THEN
            EXIT(CurrExchRate."Fix Exchange Rate Amount" = CurrExchRate."Fix Exchange Rate Amount"::Both);

        IF CurrExchRate."Fix Exchange Rate Amount" <>
          CurrExchRate."Fix Exchange Rate Amount"::Both
        THEN
            EXIT(FALSE);

        CurrExchRate.SETRANGE("Currency Code", CurrExchRate."Relational Currency Code");
        IF CurrExchRate.FIND('+') THEN
            EXIT(CurrExchRate."Fix Exchange Rate Amount" = CurrExchRate."Fix Exchange Rate Amount"::Both);

        EXIT(FALSE);

    end;

    var
        myInt: Integer;
        CurrencyCode: Code[20];
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: Label '1,5,,Budget Dimension 2 Code';
}