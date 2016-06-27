classdef DomPoint
    properties
        dom_node;
        lat_node;
        lon_node;
    end
    
    methods
        function obj = DomPoint(elem, position, attr_lat, attr_lon)
            obj.dom_node = elem.item(position);
            if nargin < 3
                obj.lat_node = str2num(obj.dom_node.getAttribute('lat'));
                obj.lon_node = str2num(obj.dom_node.getAttribute('lon'));
            else
                obj.lat_node = str2num(obj.dom_node.getAttribute(attr_lat));
                obj.lon_node = str2num(obj.dom_node.getAttribute(attr_lon));
            end
        end
        
        function setPoint()
            
        end
        
        function cur = checkOutWindow(cur)
            global window;
            if cur.lat_node > window.tl.lat_node
                cur.lat_node = window.tl.lat_node;
            else
                if cur.lat_node < window.bl.lat_node
                    cur.lat_node = window.bl.lat_node;
                end
            end
            if cur.lon_node > window.tr.lon_node
                cur.lon_node = window.tr.lon_node;
            else
                if cur.lon_node < window.tl.lon_node
                    cur.lon_node = window.tl.lon_node;
                end
            end
        end
    end
end
