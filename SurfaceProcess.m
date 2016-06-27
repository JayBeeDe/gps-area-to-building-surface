
function SurfaceProcess()
%% global
clear all; clc;format long;
global API;
global templateXSLT;
global defaultLang;
global l;
global R;
global cropToWindow;
global settings;
global xsltContent;
global dispSurfaces;

%% options
API.begin = 'http://api.openstreetmap.org/api/0.6/map?bbox=';
%API.begin ='http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=';
API.sep = ',';
API.end = '';
%API.end = ']';
templateXSLT = 'transform.xsl';
defaultLang = 'EN';
R = 6371;
cropToWindow = true;
dispSurfaces = true;

%% main
if not(strcmp(defaultLang, 'EN'))
    Lang('EN');
end
Lang(defaultLang);
Starter();
disp(l.XSLT_PROC);
if strcmp(settings.import.val, '1')
    inXML = [API.begin settings.import.left API.sep settings.import.down API.sep settings.import.right API.sep settings.import.up API.end];
    disp([l.XSLT_DOWN ' : ' inXML]);
else
    inXML = settings.import.path;
    disp([l.XSLT_LOCA ' ' settings.import.path]);
end
try
    if strcmp(settings.xslt.val, '1')
        xsltContent = xslt(inXML, templateXSLT, '-tostring');
    else
        xslt(inXML, templateXSLT, settings.xslt.path);
    end
catch
    disp([l.STERRORF11 ' "' inXML '" ' l.STERRORF3]);
    if strcmp(settings.import.val, '1')
        disp([l.STERRORFI]);
    end
    clear all;
    return;
end
clc;
disp(l.XSLT_END);
disp(l.MAT_PROC);
ret.window = num2str(getFocus());
ret.aire = num2str(abs(loopWays()));
ret.perc = num2str(100*(str2num(ret.aire)/str2num(ret.window)));
displayResult(ret);
clear all;
end


function displayResult(ret)
global l;
global dispSurfaces;
clc;
disp(l.MAT_END);
if dispSurfaces == true
    disp(l.FINALBUILD);
    ajustResult(ret.aire, 1);
    disp(l.FINALWIN);
    ajustResult(ret.window, 1);
end
disp(l.FINALRES);
ajustResult(ret.perc);
end

function ajustResult(var, mod)
if ischar(var)
    var = str2num(var);
end
if nargin == 2
    if var < 1
        var = var*1000;
        lbl = 'm²';
    else
        lbl = 'Km²';
    end
else
    lbl = '%';
end
    disp([num2str(sprintf('%0.2f', var)) ' ' lbl]);
end

function ret = getFocus()
global window;
res = XML_Find('//result');

window.tl = DomPoint(res,0,'maxlat', 'minlon');
window.tr = DomPoint(res,0,'maxlat', 'maxlon');
window.br = DomPoint(res,0,'minlat', 'maxlon');
window.bl = DomPoint(res,0,'minlat', 'minlon');

ret = abs(processArea(window.tl, window.tr, window.br) + processArea(window.tl, window.br, window.bl));
end

function ret = loopWays()
global l;
global cropToWindow;

nodeList = XML_Find('//surface');

ret = 0;
imax = nodeList.getLength-1;
for i = 0:imax
    clc;
    disp(l.MAT_PROC);
    ajustResult(100*(i/(imax+1)));
    node = nodeList.item(i);
    role_way = node.getAttribute('role');
    
    subNodeList = node.getChildNodes;
    
    ini = DomPoint(subNodeList, 1);
    old = DomPoint(subNodeList, 3);
    
    way_aire = 0;
    j = 3;
    while j<(subNodeList.getLength-4)
        j = j+2;
        cur = DomPoint(subNodeList, j);
        if cropToWindow == true
            cur = checkOutWindow(cur);
        end
        way_aire = way_aire + processArea(ini,old,cur);
        old = cur;
    end
    if strcmp(role_way, 'inner') 
        ret = ret - abs(way_aire);
    else
        ret = ret + abs(way_aire);
    end
end
clc;
disp(l.MAT_PROC);
disp('100 %');
end

function area = processArea(iniSpher, oldSpher, curSpher)
global R;
iniCar = CartesianPoint(iniSpher);
oldCar = CartesianPoint(oldSpher);
curCar = CartesianPoint(curSpher);
% area = det([oldCar.x-iniCar.x curCar.x-iniCar.x; oldCar.y-iniCar.y curCar.y-iniCar.y])/2;
area = det([oldCar.x-iniCar.x curCar.x-iniCar.x; oldCar.y-iniCar.y curCar.y-iniCar.y]);
end

function nodeList = XML_Find(xpath_relation)
import javax.xml.xpath.*;
global xsltContent;
global settings;

if strcmp(settings.xslt.val,'1')
    str = java.lang.String(xsltContent);
    stream = java.io.StringBufferInputStream(str);
    factory = javaMethod('newInstance','javax.xml.parsers.DocumentBuilderFactory');
    builder = factory.newDocumentBuilder;
    doc = builder.parse(stream);
else
    doc = xmlread(settings.xslt.path);
end
factory = XPathFactory.newInstance;
xpath = factory.newXPath;

expression = xpath.compile(xpath_relation);
nodeList = expression.evaluate(doc,XPathConstants.NODESET);
end