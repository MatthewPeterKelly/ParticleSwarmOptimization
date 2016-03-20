% TEST  --  PSO  -- Particle Swarm Optimization
%
% Test 2:  Himmelblau's function 
%
% 

clc; clear; clear global; figure(200); clf;
global HimmelblauSaveAnimation    %Set to true to save the animation

%%%% Set up problem

objFun = @Himmelblau;   % Minimize this function

xLow = -5*ones(2,1); % lower bound on the search space
xUpp = 5*ones(2,1); % upper bound on the search space
x0 = [0;0];  % initial guess

% options.alpha = 0.4;  % weight on current search direction
% options.beta = 0.9;   % weight on local best search direction
% options.gamma = 0.9;  % weight on global best search direction

options.nPopulation = 15;
options.maxIter = 50;

options.plotFun = @plotHimmelblau;  % Plots progress
HimmelblauSaveAnimation = false;   %Save an animation


%%%% Solve
[xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options);

%%%% Analysis
figure(201); clf;
plotPsoHistory(info);


