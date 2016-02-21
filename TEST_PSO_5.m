% TEST  --  PSO  -- Particle Swarm Optimization
%
% Test 5:  Styblinski-Tang function (5-D)
%
% There are many local minimums to this problem, but only one global
% minimum. All are of similar value. 
%   >> help StyblinskiTang   % For more details
%

clc; clear; 

%%%% Set up problem

objFun = @StyblinskiTang;   % Minimize this function

xLow = -5*ones(5,1); % lower bound on the search space
xUpp = 5*ones(5,1); % upper bound on the search space
x0 = -2*ones(5,1);  % initial guess

options.alpha = 0.5;  % weight on current search direction
options.beta = 1.0;   % weight on local best search direction
options.gamma = 1.0;  % weight on global best search direction

options.nPopulation = 15;
options.maxIter = 25;

options.flagVectorize = true;  % Use vectorized objective function
options.flagWarmStart = true;  % Include x0 in first generation

%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(501); clf;
plotPsoHistory(info);


