pageextension 50016 "Extend G/L Budget Entries" extends "G/L Budget Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field("ShortCut Dimension 3 code"; "ShortCut Dimension 3 code")
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    If ("Global Dimension 1 Code" <> '') and ("Shortcut Dimension 3 Code" <> '') then begin
                        Dim.SetFilter(DonorCode, "Shortcut Dimension 3 Code");
                        Dim.SetFilter(ActivityCode, "Global Dimension 1 Code");
                        IF Dim.Find('-') then Begin
                            "Shortcut Dimension 4 Code" := Dim.Code;
                        End;
                    end;
                end;



            }
            field("ShortCut Dimension 4 code"; "ShortCut Dimension 4 code")
            {
                ApplicationArea = all;
                Editable = false;

            }
        }
        addafter(Amount)
        {
            field("Currency Code"; "Currency Code")
            {
                ApplicationArea = all;
            }
            field("Amount Add. Curr"; "Amount Add. Curr")
            {
                ApplicationArea = all;
            }

        }
    }

    var

        Dim: Record "Dimension Value";
}


