function plotBowl(dataLog, iter)
% plotBowl(dataLog, iter)
%
% Used to display progress as the optimization progresses
%
% dataLog(iter) = struct array with data from each iteration
%   .X = [n,m] = current position of each particle
%   .V = [n,m] = current "velocity" of each particle
%   .F = [1,m] = value of each particle
%   .X_Best = [n,m] = best point for each particle
%   .F_Best = [1,m] = value of the best point for each particle
%   .X_Global = [n,1] = best point ever (over all particles)
%   .F_Global = [1,1] = value of the best point ever
%   .I_Global = [1,1] = index of the best point ever
%

figure(100); clf; hold on;
axis([-1,1,-1,1]); axis equal;

%%%% Draw contour lines:
rectangle('Position',[-1,-1,2,2],'Curvature',[1,1],'LineWidth',1);
rectangle('Position',0.8^2*[-1,-1,2,2],'Curvature',[1,1],'LineWidth',1);
rectangle('Position',0.6^2*[-1,-1,2,2],'Curvature',[1,1],'LineWidth',1);
rectangle('Position',0.4^2*[-1,-1,2,2],'Curvature',[1,1],'LineWidth',1);
rectangle('Position',0.2^2*[-1,-1,2,2],'Curvature',[1,1],'LineWidth',1);

%%%% Plot current position
x = dataLog.X(1,:);   %First dimension
y = dataLog.X(2,:);   %Second dimension
plot(x,y,'k.','MarkerSize',10);  

%%%% Plot the local best
x = dataLog.X_Best(1,:);   %First dimension
y = dataLog.X_Best(2,:);   %Second dimension
plot(x,y,'ko','MarkerSize',5,'LineWidth',1);  

%%%% Plot the global best
x = dataLog.X_Global(1,:);   %First dimension
y = dataLog.X_Global(2,:);   %Second dimension
plot(x,y,'bo','MarkerSize',8,'LineWidth',2);  

%%%% Annotations
title(sprintf('Iteration: %d,  ObjVal: %6.3g', iter, dataLog.F_Global));
xlabel('x1')
ylabel('x2');

%%%% Force drawing:
drawnow;
pause(0.02);  %Make it possible to see updates

end