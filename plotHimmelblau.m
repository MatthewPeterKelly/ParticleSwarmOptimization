function plotHimmelblau(dataLog, iter)
% plotHimmelblau(dataLog, iter)
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

global HimmelblauContourHandle HimmelblauPopulationHandle
global HimmelblauPopBestHandle HimmelblauGlobalHandle
global HimmelblauSaveAnimation HimmelblauFrameId

figure(200); hold on;

%%%% Plot the function to be optimized
if isempty(HimmelblauContourHandle)
    x = linspace(-5,5,50);
    y = linspace(-5,5,50);
    [XX,YY] = meshgrid(x,y);
    xx = reshape(XX,1,numel(XX));
    yy = reshape(YY,1,numel(YY));
    zz = [xx;yy];
    ff = Himmelblau(zz);
    FF = reshape(ff,50,50);
    HimmelblauContourHandle = contour(XX,YY,FF,15);
    
    % Plot the solution:
    plot(3.0, 2.0,'rx','LineWidth',3,'MarkerSize',20);
    plot(-2.805118, 3.131312,'rx','LineWidth',3,'MarkerSize',20);
    plot(-3.779310, -3.283186,'rx','LineWidth',3,'MarkerSize',20);
    plot(3.584428, -1.848126,'rx','LineWidth',3,'MarkerSize',20);
end

%%%% Plot current position
if isempty(HimmelblauPopulationHandle)
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    HimmelblauPopulationHandle = plot(x,y,'k.','MarkerSize',10);
else
    x = dataLog.X(1,:);   %First dimension
    y = dataLog.X(2,:);   %Second dimension
    set(HimmelblauPopulationHandle,...
        'xData',x, 'yData',y);
end


%%%% Plot best position for each particle
if isempty(HimmelblauPopBestHandle)
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    HimmelblauPopBestHandle = plot(x,y,'ko','MarkerSize',5,'LineWidth',1);
else
    x = dataLog.X_Best(1,:);   %First dimension
    y = dataLog.X_Best(2,:);   %Second dimension
    set(HimmelblauPopBestHandle,...
        'xData',x, 'yData',y);
end

%%%% Plot best ever position of the entire swarm
if isempty(HimmelblauGlobalHandle)
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    HimmelblauGlobalHandle = plot(x,y,'bo','MarkerSize',8,'LineWidth',2);
else
    x = dataLog.X_Global(1,:);   %First dimension
    y = dataLog.X_Global(2,:);   %Second dimension
    set(HimmelblauGlobalHandle,...
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

%%%% Save animation if desired:
animationFileName = 'PSO_Himmelblau_Animation.gif';
if isempty(HimmelblauFrameId)
    HimmelblauFrameId = 1;
else
    HimmelblauFrameId = HimmelblauFrameId + 1;
end
if isempty(HimmelblauSaveAnimation)
    HimmelblauSaveAnimation = false;
else
    if HimmelblauSaveAnimation
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if HimmelblauFrameId == 1;
            imwrite(imind,cm,animationFileName,'gif', 'Loopcount',inf);
        else
            imwrite(imind,cm,animationFileName,'gif','WriteMode','append');
        end
    end
end

end