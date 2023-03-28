function rotationMatrix = zRot(angle)
% rotation around z axis
% angle in radians

rotationMatrix = [cos(angle),-sin(angle),0;
                  sin(angle),cos(angle) ,0;
                   0,        0         ,1];
                  
end