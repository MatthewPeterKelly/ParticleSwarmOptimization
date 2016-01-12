# Particle Swarm Optimization

This directory contains a simple implementation of particle swarm optimization (PSO.m), as well as scripts that use it to solve standard optimization test problems (TEST_PSO_*.m).

This implementation of PSO is designed for solving a bounded non-linear paramter optimization problem, with an initial guess. It is fully vectorized.

There are a variety of options that can be set by the user, but will be initialized to a default value if ommitted.

The output of the solver contains a full history of the optimization, which can be plotted using plotPsoHistory.m. Additionally, the user can define a plotting function to be called on each iteration. Both of these features are demonstrated in the TEST_PSO_*.m scripts.

## Test Functions:

- TEST_PSO_1.m  -->  2-D Sphere Function
- TEST_PSO_2.m  -->  Himmelblau's function
- TEST_PSO_3.m  -->  Goldstein-Price function 
- TEST_PSO_4.m  -->  2-D Styblinski-Tang function 
- TEST_PSO_5.m  -->  N-D Styblinski-Tang function

## Help file for PSO.m

% [xBest, fBest, info, dataLog] = PSO(objFun, x0, xLow, xUpp, options)
%
% Particle Swarm Optimization
%
% This function minimizes OBJFUN using a variant of particle swarm
% optimization. The optimization uses an initial guess X0, and searches
% over a search space bounded by XLOW and XUPP.
%
% INPUTS:
%   objFun = objective function handle:
%       f = objFun(x)
%           x = [n, m] = search point in n-dimensional space (for m points)
%           f = [1, m] = objective function value, for each of m points
%   x0 = [n, 1] = initial search location
%   xLow = [n, 1] = lower bounds on search space
%   xUpp = [n, 1] = upper bounds on search space
%   options = option struct. All fields are optional, with defaults:
%       .alpha = 0.6 = search weight on current search direction
%       .beta = 0.9 = search weight on global best
%       .gamma = 0.9 = search weight on local best
%       .nPopulation = m = 3*n = population count
%       .maxIter = 100 = maximum number of generations
%       .flagMinimize = true = minimize objective
%           --> Set to false to maximize objective
%       .guessWeight = 0.5;  trade-off for initialization; range (0.1,0.9)
%           --> 0.1  heavy weight on initial guess (x0)
%           --> 0.9  heavy weight on random initialization [xLow, xUpp]
%       .plotFun = function handle for plotting progress
%           plotFun( dataLog(iter), iter )
%           --> See OUTPUTS for details about dataLog
%           --> Leave empty to omit plotting (faster)
%
% OUTPUTS:
%   xBest = [n, 1] = best point ever found
%   fBest = [1, 1] = value of best point found
%
%   info = output struct with solver info
%       .input = copy of solver inputs:
%           .objFun
%           .x0
%           .xLow
%           .xUpp
%           .options
%       .exitFlag = how did optimization finish
%           1 = reached max iteration count
%       .X_Global = [n,iter] = best point in each generation
%       .F_Global = [1,iter] = value of the best point ever
%       .I_Global = [1,iter] = index of the best point ever
%       .X_Best_Var = [n,iter] = variance in best point along each dim
%       .X_Var = [n,iter] = variance in current search along each dim
%       .X_Best_Mean = [n,iter] = mean in best point along each dim
%       .X_Mean = [n,iter] = mean in current search along each dim
%       .F_Best_Var = [1,iter] = variance in the best val at each gen
%       .F_Var = [1,iter] = variance in the current val at each gen
%       .F_Best_Mean = [1,iter] = mean of the population best value
%       .F_Mean = [1,iter] = mean of the current population value
%
%   dataLog(iter) = struct array with data from each iteration
%       .X = [n,m] = current position of each particle
%       .V = [n,m] = current "velocity" of each particle
%       .F = [1,m] = value of each particle
%       .X_Best = [n,m] = best point for each particle
%       .F_Best = [1,m] = value of the best point for each particle
%       .X_Global = [n,1] = best point ever (over all particles)
%       .F_Global = [1,1] = value of the best point ever
%       .I_Global = [1,1] = index of the best point ever
%