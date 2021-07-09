pageextension 50009 ExtensionName extends "dimension values"//OriginalId
{
    layout
    {
        addafter(Totaling)
        {
            field(DonorCode; DonorCode)
            {
                Visible = ShowDonorCode;
                //ApplicationArea = All;
            }
            field(DonorActivityCode; DonorActivityCode)
            {
                Visible = ShowDonorActivity;
                //ApplicationArea = All;
            }
            field(ActivityCode; ActivityCode)
            {
                Visible = ShowActivity;
                //ApplicationArea = All;
            }


        }

    }
    actions
    {

    }
    trigger OnAfterGetRecord();
    begin
        NameIndent := 0;
        FormatLine;
    end;

    trigger OnOpenPage()
    var
        DimensionCode: Code[20];
    begin

        ShowDonorCode := FALSE;
        ShowDonorActivity := false;

        GLSetup.GET;
        IF GLSetup.ActivityShowDonorCode AND ("Dimension Code" = 'ACTIVITY') and GLSetup.ActivityShowDonorActivity THEN Begin

            ShowDonorCode := TRUE;
            ShowDonorActivity := TRUE;

        END ELSE
            IF GLSetup.DonorActivityShowActivityCode AND ("Dimension Code" = 'DONORACTIVITY') and GLSetup.DonorActivityShowDonorCode THEN begin

                ShowDonorCode := TRUE;
                ShowActivity := TRUE;

            end ELSE
                IF GLSetup.ProjectShowDonorCode AND ("Dimension Code" = 'PROJECT') THEN begin
                    ShowDonorCode := TRUE;

                end ELSE
                    IF (GLSetup.ActivityShowDonorCode) AND ("Dimension Code" = 'ACTIVITY') THEN begin
                        ShowDonorCode := TRUE;
                    end ELSE
                        IF GLSetup.DonorActivityShowActivityCode AND ("Dimension Code" = 'DONORACTIVITY') THEN begin
                            ShowActivity := TRUE;
                        end ELSE
                            IF GLSetup.DonorActivityShowDonorCode AND ("Dimension Code" = 'DONORACTIVITY') THEN begin
                                ShowDonorCode := TRUE;
                            end ELSE
                                IF GLSetup.ProjectShowDonorCode AND ("Dimension Code" = 'PROJECT') THEN begin
                                    ShowDonorCode := TRUE;
                                end ELSE
                                    IF GLSetup.ActivityShowDonorActivity AND ("Dimension Code" = 'ACTIVITY') THEN
                                        ShowDonorActivity := TRUE;


    end;

    var
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        [InDataSet]
        ShowDonorCode: Boolean;
        [InDataSet]
        ShowDonorActivity: Boolean;
        [InDataSet]
        ShowActivity: Boolean;

        GLSetup: Record "General Ledger Setup";

    local procedure FormatLine();
    begin
        Emphasize := "Dimension Value Type" <> "Dimension Value Type"::Standard;
        NameIndent := Indentation;
    end;

}