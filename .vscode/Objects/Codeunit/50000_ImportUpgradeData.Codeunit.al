codeunit 50000 "Import Upgrade Data"
{
    trigger OnRun()
    begin

        Selection := STRMENU(Text000, 1);

        IF Selection = 0 THEN
            EXIT;

        //Table15
        // IF Selection = 2 THEN BEGIN
        //     _file.CREATE('C:\Data\table15.xml');
        //     _file.CREATEOUTSTREAM(_DatafileOutstream);
        //     XMLPORT.EXPORT(50001, _DatafileOutstream);
        //     _file.CLOSE;
        // END;

        // IF Selection = 1 THEN BEGIN
        //     _file.OPEN('C:\Data\table15.xml');
        //     _file.CREATEINSTREAM(_DatafileInstream);
        //     XMLPORT.IMPORT(50001, _DatafileInstream);
        //     _file.CLOSE;
        //     //MESSAGE('table 15 done...');
        // END;


        //Table17
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table17.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50000, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table17.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50000, _DatafileInstream);
            _file.CLOSE;
            //MESSAGE('table 17 done...');
        END;


        //Table21
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table21.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50002, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table21.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50002, _DatafileInstream);
            _file.CLOSE;
            //MESSAGE('table 21 done...');
        END;


        //Table25
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table25.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50003, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table25.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50003, _DatafileInstream);
            _file.CLOSE;
        END;


        //Table80
        // IF Selection = 2 THEN BEGIN
        //     _file.CREATE('C:\Data\table80.xml');
        //     _file.CREATEOUTSTREAM(_DatafileOutstream);
        //     XMLPORT.EXPORT(50004, _DatafileOutstream);
        //     _file.CLOSE;
        // END;

        // IF Selection = 1 THEN BEGIN
        //     _file.OPEN('C:\Data\table80.xml');
        //     _file.CREATEINSTREAM(_DatafileInstream);
        //     XMLPORT.IMPORT(50004, _DatafileInstream);
        //     _file.CLOSE;
        // END;


        //Table81
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table81.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50005, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table81.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50005, _DatafileInstream);
            _file.CLOSE;
        END;



        //Table96
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table96.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50006, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table96.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50006, _DatafileInstream);
            _file.CLOSE;
        END;


        //Table242
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table242.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50008, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table242.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50008, _DatafileInstream);
            _file.CLOSE;
        END;


        //Table273
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table273.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50009, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table273.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50009, _DatafileInstream);
            _file.CLOSE;
        END;

        //Table274
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table274.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50010, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table274.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50010, _DatafileInstream);
            _file.CLOSE;
        END;

        //Table271
        IF Selection = 2 THEN BEGIN
            _file.CREATE('C:\Data\table271.xml');
            _file.CREATEOUTSTREAM(_DatafileOutstream);
            XMLPORT.EXPORT(50011, _DatafileOutstream);
            _file.CLOSE;
        END;

        IF Selection = 1 THEN BEGIN
            _file.OPEN('C:\Data\table271.xml');
            _file.CREATEINSTREAM(_DatafileInstream);
            XMLPORT.IMPORT(50011, _DatafileInstream);
            _file.CLOSE;
        END;



        MESSAGE('The import from XML is complete.')

    end;

    var
        _file: File;
        FilePath: Text[250];
        Filename: Text[250];
        _DatafileOutstream: OutStream;
        XmlStream: InStream;
        Selection: Integer;
        FileMGMT: Codeunit "File Management";
        IsImported: Boolean;
        _DatafileInstream: InStream;
        Text000: Label 'import,export';
        //Tempblob: Record TempBlob;
        TargetXmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;





}