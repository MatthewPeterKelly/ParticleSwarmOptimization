function plotGoldsteinPrice(dataLog, iter)
% plotGoldsteinPrice(dataLog, iter)
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

global GoldsteinPriceContourHandle GoldsteinPricePopulationHandle
global GoldsteinPricePopBestHandle GoldsteinPriceGlobalHandle

figure(300); hold on;

%%%% Plot the function to be optimized
if isempty(GoldsteinPriceContourHandle)
    x = linspace(-2,2,50);
    y = linspace(-2,2,50);
    [XX,YY] = meshgrid(x,y);
    xx = reshape(XX,1,numel(XX));
    yy = reshape(YY,1,numel(YY));
    zz = [xx;yy];
    ff = GoldsteinPrice(zz);
    FF = reshape(ff,50,50);
    GoldsteinPriceContourHandle = contour(XX,YY,sqrt(FF),15);
    
    % Plot the solution:
    plot(0,-1,'rx','LineWidth',3,'MarkerSize',20);
end

%%%% Plot current position
if isempty(GoldsteinPricePopulationHandle)
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    GoldsteinPricePopulationHandle = plot(x,y,'k.','MarkerSize',10);
else
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    set(GoldsteinPricePopulationHandle,...
        'xData',x, 'yData',y);
end


%%%% Plot best position for each particle
if isempty(GoldsteinPricePopBestHandle)
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    GoldsteinPricePopBestHandle = plot(x,y,'ko','MarkerSize',5,'LineWidth',1);
else
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    set(GoldsteinPricePopBestHandle,...
        'xData',x, 'yData',y);
end

%%%% Plot best ever position of the entire swarm
if isempty(GoldsteinPriceGlobalHandle)
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    GoldsteinPriceGlobalHandle = plot(x,y,'bo','MarkerSize',8,'LineWidth',2);
else
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    set(GoldsteinPriceGlobalHandle,...
        'xData',x, 'yData',y);
end

%%%% Annotations
title(sprintf('Iteration: %d,  ObjVal: %6.3g', iter, dataLog.F_Global));
xlabel('x1');
ylabel('x2');

%%%% Format the axis so things look right:
axis equal; axis(2*[-1,1,-1,1]);

%%%% Push the draw commands through the plot buffer
drawnow;
pause(0.05);  %Slow down animation

end