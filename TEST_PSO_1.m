% TEST  --  PSO  -- Particle Swarm Optimization
%
% First test, simple quadratic bowl

clc; clear;

%%%% Set up problem

objFun = @(x)( sum(x.^2,1) );

xLow = -ones(2,1);
xUpp = ones(2,1);
x0 = -ones(2,1) + 2*rand(2,1);

options.alpha = 0.6;
options.beta = 0.9;
options.gamma = 1.2;

options.nPopulation = 10;
options.maxIter = 50;

% options.plotFun = @plotBowl;  % Plots progress


%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(2); clf;

%Plot the function value over time:
subplot(2,2,1); hold on;
plot(info.iter, info.F_Best_Mean);
plot(info.iter, info.F_Mean);
plot(info.iter, info.F_Global);
xlabel('iteration')
ylabel('objective')
title('Objective Value')
legend('mean(F\_best)','mean(F)','Global Best')
set(gca,'YScale','log');

%Plot the variance in the function value over time:
subplot(2,2,3); hold on;
plot(info.iter, info.F_Best_Var);
plot(info.iter, info.F_Var);
xlabel('iteration')
ylabel('objective')
title('Objective Value Variance')
legend('var(F\_best)','var(F)')
set(gca,'YScale','log');


%Plot the search variance along each dimension:
subplot(2,2,2); hold on;
colorMap = getDefaultPlotColors();
for i=1:2
   plot(info.iter, info.X_Mean(i,:), 'Color',colorMap(i,:), 'LineWidth', 1);
   plot(info.iter, info.X_Best_Mean(i,:), 'Color',colorMap(i,:), 'LineWidth', 2);
   plot(info.iter, info.X_Global(i,:), 'Color',colorMap(i,:), 'LineWidth', 4); 
end
xlabel('iteration')
ylabel('variance')
title('search position')

%Plot the search variance along each dimension:
subplot(2,2,4); hold on;
colorMap = getDefaultPlotColors();
for i=1:2
   plot(info.iter, info.X_Var(i,:), 'Color',colorMap(i,:), 'LineWidth', 1);
   plot(info.iter, info.X_Best_Var(i,:), 'Color',colorMap(i,:), 'LineWidth', 2); 
end
xlabel('iteration')
ylabel('variance')
title('search variance')


