function [rotationMatrix] = xRot(angle)
% rotation around x axis
% angle in radians

rotationMatrix = [1,    0     ,0;
                  0,cos(angle),-sin(angle);
                  0,sin(angle),cos(angle)];

end

