classdef (Abstract) Obstacle
    properties (Abstract)
        center
        baseVertices
        rotationMatrix
    end
methods
    function vertices = getVertices(obj)
        vertices = obj.center + obj.rotationMatrix*obj.baseVertices;
    end
end
    methods (Abstract)
        getPlot(obj)
    end
end
