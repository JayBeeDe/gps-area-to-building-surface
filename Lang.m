function Lang(lg)
global l;
switch lg
    case 'DE'
        %write here
    otherwise
        l.START='Welcome to Surface Process';
        l.STTIP='The working directory is :';
        l.STERROR='Error';
        l.STERRORB='Number must be bigger than';
        l.STERRORS='and smaller than';
        l.STERRORF11='The file';
        l.STERRORF12='The folder';
        l.STERRORF2='does not exist !';
        l.STERRORF3='is not reachable !';
        l.STERRORFI='The API or your internet connexion is not working.';
        l.STPROP1='Choose a way to import datas from Openstreetsmap :\n[[1]] Import Directly from Internet (Broad  Connexion required)\n [2]  Import from an .osm file on this computer or a local device';
        l.STSPROP11UP='Up Lat :';
        l.STSPROP11DN='Down Lat :';
        l.STSPROP11LT='Left Lon :';
        l.STSPROP11RT='Right Lon :';
        l.STSPROP12='Indicate the full path from the matlab working folder (ex: /sample/map.osm) :';
        l.STPROP2='Do you want to save the XML file after XLST processing ?\n[[1]] No\n [2]  Yes';
        l.STSPROP21='Indicate the full path from the matlab working directory of the XML file you wish to save without the file extension (ex: /work/save) :';
        l.XSLT_PROC='Processing xslt...';
        l.XSLT_LOCA='from local file';
        l.XSLT_DOWN='from url';
        l.XSLT_END='XSLT Processing finished !';
        l.MAT_PROC='Processing Surface Calculation...';
        l.MAT_END='Surface Calculated :';
        l.FINALBUILD='Surface of Building :';
        l.FINALWIN='Total Area :';
        l.FINALRES='Results :';
end
end