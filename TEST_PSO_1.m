% TEST  --  PSO  -- Particle Swarm Optimization
%
% First test, simple quadratic bowl

clc; clear;

%%%% Set up problem

objFun = @(x)( sum(x.^2,1) );

xLow = -ones(2,1);
xUpp = ones(2,1);
x0 = -ones(2,1) + 2*rand(2,1);

options.alpha = 0.4;
options.beta = 0.9;
options.gamma = 0.9;

options.nPopulation = 10;
options.maxIter = 50;

% options.plotFun = @plotBowl;  % Plots progress


%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(2); clf;
plotPsoHistory(info);


