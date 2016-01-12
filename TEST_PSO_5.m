% TEST  --  PSO  -- Particle Swarm Optimization
%
% Test 5:  Styblinski-Tang function (5-D)
%
% There are many local minimums to this problem, but only one global
% minimum. All are of similar value. 
%   >> help StyblinskiTang   % For more details
%

clc; clear; clear global; figure(200); clf;

%%%% Set up problem

objFun = @StyblinskiTang;   % Minimize this function

xLow = -5*ones(5,1); % lower bound on the search space
xUpp = 5*ones(5,1); % upper bound on the search space
x0 = zeros(5,1);  % initial guess

options.alpha = 0.6;  % weight on current search direction
options.beta = 1.4;   % weight on local best search direction
options.gamma = 1.4;  % weight on global best search direction

options.nPopulation = 100;
options.maxIter = 40;

%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(201); clf;
plotPsoHistory(info);


