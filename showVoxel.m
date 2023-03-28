clear all
close all

centers = rand(3,20)*100;
figure
ax = gca();
hold on
grid on

for jj = 1:20
  box = Box(20,3,4)
  rotationM = yRot(deg2rad(30))*zRot((deg2rad(30)));
  box.rotationMatrix = rotationM;
  box.center = centers(:,jj);
  s = box.getPlot();
  s.Parent = ax;
end



