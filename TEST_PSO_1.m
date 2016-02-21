% TEST  --  PSO  -- Particle Swarm Optimization
%
% First test, simple quadratic bowl

clc; clear;

%%%% Set up problem

objFun = @(x)( sum(x.^2,1) );   % Minimize this function

xLow = -ones(2,1); % lower bound on the search space
xUpp = ones(2,1); % upper bound on the search space
x0 = [];  % No initial guess

options.alpha = 0.4;  % weight on current search direction
options.beta = 0.9;   % weight on local best search direction
options.gamma = 0.9;  % weight on global best search direction

options.nPopulation = 10;
options.maxIter = 20;

options.plotFun = @plotBowl;  % Plots progress


%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(101); clf;
plotPsoHistory(info);


