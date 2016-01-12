% TEST  --  PSO  -- Particle Swarm Optimization
%
% Test 3:  Goldstein-Price function 
%
% 

clc; clear; clear global; figure(200); clf;

%%%% Set up problem

objFun = @GoldsteinPrice;   % Minimize this function

xLow = -2*ones(2,1); % lower bound on the search space
xUpp = 2*ones(2,1); % upper bound on the search space
x0 = [-1;1];  % initial guess

% options.alpha = 0.4;  % weight on current search direction
% options.beta = 0.9;   % weight on local best search direction
% options.gamma = 0.9;  % weight on global best search direction

options.nPopulation = 15;
options.maxIter = 50;

options.plotFun = @plotGoldsteinPrice;  % Plots progress


%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(201); clf;
plotPsoHistory(info);


