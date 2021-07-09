table 50002 "Currency Dim Buffer"
{

    fields
    {
        field(1;"G/L Account No.";Code[20])
        {
        }
        field(2;"Document No";Code[20])
        {
        }
        field(3;"Posting Date";Date)
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;"Dimension 1 Code";Code[20])
        {
        }
        field(6;"Dimension 2 Code";Code[20])
        {
        }
        field(7;"Dimension 3 Code";Code[20])
        {
        }
        field(8;BalTotal;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"G/L Account No.","Dimension 1 Code","Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }
}

