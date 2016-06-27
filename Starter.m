function Starter()
global l;
global settings;
maxAbsLat = 90;
maxAbsLon = 180;
clc;
disp(l.START);
disp('_______________________________________');
settings.import.val = getCoor(l.STPROP1, 1);
if strcmp(settings.import.val, '1')
        settings.import.up = getCoor(l.STSPROP11UP, 2, -maxAbsLat, maxAbsLat);
        settings.import.down = getCoor(l.STSPROP11DN, 2, -maxAbsLat, str2num(settings.import.up));
        settings.import.left = getCoor(l.STSPROP11LT, 2, -maxAbsLon, maxAbsLon);
        settings.import.right = getCoor(l.STSPROP11RT, 2,  str2num(settings.import.left), maxAbsLon);
else
    settings.import.path = getCoor(l.STSPROP12, 3);
end
settings.xslt.val = getCoor(l.STPROP2, 1);
if strcmp(settings.xslt.val, '2')
    settings.xslt.path = [getCoor(l.STSPROP21, 4) '.xml'];
end
clc;
end

function result = getCoor(str, mod, min, max)
global l;
clc;
while true
    if mod == 3 || mod == 4
        disp(l.STTIP);
        disp(pwd);
        result = input([str '\n'], 's');
    else
        result = input([str '\n'], 's');
    end
    clc;
    if mod == 1
        if strcmp(result,'') || strcmp(result,' ')
            result = '1';
        end
        if strcmp(result,'1') || strcmp(result,'2')
            break;
        end
    elseif mod == 2
        try
            if str2num(result) > min && str2num(result) < max
                break;
            end
        catch
        end
        disp([l.STERRORB ' ' num2str(min) ' ' l.STERRORS ' ' num2str(max) '  !']);
    elseif mod == 3
        if exist(result,'file')
            break;
        end
    elseif mod == 4
        if not(isempty(strfind(result,'/')))
            result = strsplit(result,'/');
            result = result(1:size(result, 2)-1);
            result = strjoin(result,'/');
            if exist(result,'dir')
                break;
            end
        end
        break;
    end
    disp(l.STERROR);
    if mod == 3
        disp([l.STERRORF11 ' "' result '" ' l.STERRORF2]);
    end
    if mod == 4
        disp([l.STERRORF12 ' "' result '" ' l.STERRORF2]);
    end
end
end