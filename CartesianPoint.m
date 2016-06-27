classdef CartesianPoint
    properties
        x;
        y;
    end
    
    methods
        function obj = CartesianPoint(pointSpher)
            global R;
            obj.x = R*cos(degtorad(pointSpher.lon_node))*cos(degtorad(pointSpher.lat_node));
            obj.y = R*sin(degtorad(pointSpher.lon_node))*cos(degtorad(pointSpher.lat_node));
        end
        
        function b = degtorad(a)
            b = 2*a*pi/360;
        end
    end
end