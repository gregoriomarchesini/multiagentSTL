classdef Box < Obstacle

    properties(Access=private,Constant)
        % define 8 vertices of a cube
        v1 = [-0.5000   -0.5000   -0.5000]'
        v2 = [    0.5000   -0.5000   -0.5000]'
        v3 = [    0.5000    0.5000   -0.5000]'
        v4 = [   -0.5000    0.5000   -0.5000]'
        v5 = [   -0.5000   -0.5000    0.5000]'
        v6 = [    0.5000   -0.5000    0.5000]'
        v7 = [    0.5000    0.5000    0.5000]'
        v8 = [   -0.5000    0.5000    0.5000]'
    end

    properties
        % basic box parameters
        height =1% z-axis
        width  =1 % x-axis
        depth  =1% y-axis
        scale  =eye(3)
        baseVertices   = [Box.v1,Box.v2,Box.v3,Box.v4,Box.v5,Box.v6,Box.v7,Box.v8];
        center         = [0;0;0]
        rotationMatrix = eye(3);
        connectivityMatrix =[1 2 3 4 1;5 6 7 8 5;1 2 6 5 1;2 6 7 3 2;3 7 8 4 3;1 5 8 4 1;]; % for drawing the patch
    end
    methods
        function obj = Box(height,width,depth)
            if nargin == 0
                obj.height = 1;
                obj.width  = 1;
                obj.depth  = 1;
            else

                obj.height = height;
                obj.width = width;
                obj.depth = depth;
            end

            obj.scale  = diag([obj.width,obj.depth,obj.height]);
            obj.baseVertices   = obj.scale * [Box.v1,Box.v2,Box.v3,Box.v4,Box.v5,Box.v6,Box.v7,Box.v8];
        end
        function showMe(obj)
            figure;
            grid on
            hold on
            
            patch('Vertices',obj.getVertices()', 'Faces',obj.connectivityMatrix,'FaceColor','r','facealpha', 0.5);
            view(3);
            axis equal
            xlabel("x")
            ylabel("y")
            zlabel("z")
        end
        function surface = getPlot(obj)
            figure("Visible",false)
            surface = patch('Vertices',obj.getVertices()', 'Faces',obj.connectivityMatrix,'FaceColor','r','facealpha', 0.5);
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
