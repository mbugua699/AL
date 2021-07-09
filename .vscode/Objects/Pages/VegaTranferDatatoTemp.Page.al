page 50000 "Vega Tranfer Data to Temp"
{

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(InfoHead; InfoHead)
                {
                    Caption = 'Version Information';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Transfer Data")
            {

                action(TransferData)
                {
                    Caption = 'Transfer GL setup Field Data';
                    Image = TransferToGeneralJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text000) THEN
                            CODEUNIT.RUN(CODEUNIT::"Vega Tranfer Field data");
                    end;
                }
                action(ImportXmlData)
                {
                    Caption = 'Import XML Data';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text002) THEN
                            CODEUNIT.RUN(CODEUNIT::"Import Upgrade Data");
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Companyinfo.GET;

        InfoHead := STRSUBSTNO(Text001, Companyinfo.Name, ApplicationMgt.ApplicationVersion);
    end;

    var
        InfoHead: Text[250];
        Text000: Label 'Are you sure that you want to transfer GL Setup data?';
        Text002: Label 'Are you sure you import data from XML?';
        Text001: Label 'Updating %1 version %2';
        Companyinfo: Record "Company Information";
        ApplicationMgt: Codeunit "Application System Constants";
}

