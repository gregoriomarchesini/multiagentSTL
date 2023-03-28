function rotationMatrix = yRot(angle)
% rotation around y axis
% angle in radians
rotationMatrix = [cos(angle),    0   , sin(angle);
                  0         ,    1   ,    0      ;
                 -sin(angle),    0   ,cos(angle)];
end