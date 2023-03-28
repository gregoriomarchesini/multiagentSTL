classdef Ellipsoid < Obstacle

    properties
        % basic box parameters
        scale
        spherePointsSize 
        baseVertices   
        center         
        rotationMatrix 
    end
    methods
        function obj = Ellipsoid(xDilation,yDilation,zDilation)
            
            % basic box parameters
            [X,Y,Z] = sphere(30);
            obj.spherePointsSize = size(X);
            obj.baseVertices   = [reshape(X,[],numel(X));reshape(Y,[],numel(Y));reshape(Z,[],numel(Z))];
            obj.center         = [0;0;0]
            obj.rotationMatrix = eye(3);

            if nargin == 0
                obj.scale = eye(3);
            else
                obj.scale  = diag([xDilation,yDilation,zDilation]);
            end

            obj.baseVertices   = obj.scale * obj.baseVertices;
        end
        function surface = getPlot(obj)
            X = reshape(obj.baseVertices(1,:),obj.spherePointsSize);
            Y = reshape(obj.baseVertices(2,:),obj.spherePointsSize);
            Z = reshape(obj.baseVertices(3,:),obj.spherePointsSize);
            
            figure("Visible",false)
            surface = surf(X,Y,Z);
            axis equal
        end
        function showMe(obj)
            vertices = obj.getVertices();
            X = reshape(vertices(1,:),obj.spherePointsSize);
            Y = reshape(vertices(2,:),obj.spherePointsSize);
            Z = reshape(vertices(3,:),obj.spherePointsSize);
            
            surf(X,Y,Z);
        end

        % setters and getters
        function obj = set.rotationMatrix(obj,val)
            if ~ismatrix(val)
                error("input must be a matrix")
            elseif abs(det(val)-1) >1e-6
                error("Matrix must be a rotation matrix. Determinant seems to be not 1")
            end
            obj.rotationMatrix = val;
        end

        function obj = set.center(obj,val)
            if isrow(val)
                error("center must be a column vector of dimension three")
            end
            obj.center = val;
        end
    end
end