table 50004 "G/L Dimension Balances"
{

    fields
    {
        field(1;"Dimension 1 Code";Code[20])
        {
        }
        field(2;"Dimension 2 Code";Code[20])
        {
        }
        field(3;"Dimension 3 Code";Code[20])
        {
        }
        field(4;Balance;Decimal)
        {
        }
        field(5;"G/L Account No";Code[20])
        {
        }
        field(6;"Net Change";Decimal)
        {
        }
        field(7;"Add. Currency Balance";Decimal)
        {
        }
        field(8;"Posting Date";Date)
        {
        }
        field(9;"Opening Bal Acc";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Dimension 1 Code","Dimension 2 Code","Dimension 3 Code","G/L Account No")
        {
        }
        key(Key2;"G/L Account No","Posting Date","Dimension 1 Code","Dimension 2 Code","Dimension 3 Code")
        {
            SumIndexFields = Balance;
        }
    }

    fieldgroups
    {
    }
}

