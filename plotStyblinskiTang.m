function plotStyblinskiTang(dataLog, iter)
% plotStyblinskiTang(dataLog, iter)
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

global StyblinskiTangContourHandle StyblinskiTangPopulationHandle
global StyblinskiTangPopBestHandle StyblinskiTangGlobalHandle

figure(200); hold on;

%%%% Plot the function to be optimized
if isempty(StyblinskiTangContourHandle)
    x = linspace(-5,5,50);
    y = linspace(-5,5,50);
    [XX,YY] = meshgrid(x,y);
    xx = reshape(XX,1,numel(XX));
    yy = reshape(YY,1,numel(YY));
    zz = [xx;yy];
    ff = StyblinskiTang(zz);
    FF = reshape(ff,50,50);
    StyblinskiTangContourHandle = contour(XX,YY,FF,15);
    
    % Plot the solution:
    plot(-2.903534,-2.903534,'rx','LineWidth',3,'MarkerSize',20);
end

%%%% Plot current position
if isempty(StyblinskiTangPopulationHandle)
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    StyblinskiTangPopulationHandle = plot(x,y,'k.','MarkerSize',10);
else
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    set(StyblinskiTangPopulationHandle,...
        'xData',x, 'yData',y);
end


%%%% Plot best position for each particle
if isempty(StyblinskiTangPopBestHandle)
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    StyblinskiTangPopBestHandle = plot(x,y,'ko','MarkerSize',5,'LineWidth',1);
else
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    set(StyblinskiTangPopBestHandle,...
        'xData',x, 'yData',y);
end

%%%% Plot best ever position of the entire swarm
if isempty(StyblinskiTangGlobalHandle)
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    StyblinskiTangGlobalHandle = plot(x,y,'bo','MarkerSize',8,'LineWidth',2);
else
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    set(StyblinskiTangGlobalHandle,...
        'xData',x, 'yData',y);
end

%%%% Annotations
title(sprintf('Iteration: %d,  ObjVal: %6.3g', iter, dataLog.F_Global));
xlabel('x1');
ylabel('x2');

%%%% Format the axis so things look right:
axis equal; axis(5*[-1,1,-1,1]);

%%%% Push the draw commands through the plot buffer
drawnow;
pause(0.05);  %Slow down animation

end