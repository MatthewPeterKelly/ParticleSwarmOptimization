% TEST  --  PSO  -- Particle Swarm Optimization
%
% Test 6:  Styblinski-Tang function (5-D)
%
% There are many local minimums to this problem, but only one global
% minimum. All are of similar value.
%   >> help StyblinskiTang   % For more details
%
% This script is a meta-optimization, running a simple grid search to
% determine which set of paramters will cause the optimization to most
% rapidly converge to a local minimum.
%
% Note - the resulting set of parameters are not good in general, since
% they will always find the closest local minimum.
%
% This script will take some time to execute, since it runs many
% optimizations one after the other.
%

clc; clear;

%%%% Set up problem

objFun = @StyblinskiTang;   % Minimize this function

xLow = -5*ones(5,1); % lower bound on the search space
xUpp = 5*ones(5,1); % upper bound on the search space
x0 = zeros(5,1);  % initial guess

options.maxIter = 100;
options.tolFun = 1e-6;
options.tolX = 1e-6;
options.flagVectorize = false;
options.guessWeight = 0.11;
options.display = 'off';

%%%% Select the grid search parameters:
Z_alpha = linspace(0.1, 0.7, 9);
Z_betaGamma = linspace(0.7, 1.6, 9);
Z_nPopulation = [8, 12, 16, 20, 24];

N_REPEAT = 5;  %Run optimization this many times for each set of params

nAlpha = length(Z_alpha);
nBetaGamma = length(Z_betaGamma);
nPopIter = length(Z_nPopulation);

nTrial = nAlpha*nBetaGamma*nPopIter;
Alpha = zeros(nTrial,1);
BetaGamma = zeros(nTrial,1);
Pop = zeros(nTrial,1);

F_Eval_Count = zeros(nTrial,1);
F_Best = zeros(nTrial,1);


nEval = zeros(1,N_REPEAT);
fVal = zeros(1,N_REPEAT);

idx = 0;
for i=1:nAlpha
    for j=1:nBetaGamma
        for k=1:nPopIter
            idx = idx + 1;
            
            %%%% Unpack parameters:
            options.alpha = Z_alpha(i);
            options.beta = Z_betaGamma(j);
            options.gamma = Z_betaGamma(j);
            options.nPopulation = Z_nPopulation(k);
            
            %%%% Log parameters (lazy way)
            Alpha(idx) = Z_alpha(i);
            BetaGamma(idx) = Z_betaGamma(j);
            Pop(idx) = Z_nPopulation(k);
            
            %%%% Solve
            for rr = 1:N_REPEAT
                [~, fBest, info] = PSO(objFun, x0, xLow, xUpp, options);
                nEval(rr) = info.fEvalCount;
                fVal(rr) = fBest;
            end
            F_Eval_Count(idx) = mean(nEval(rr));
            F_Best(idx) = mean(fVal);
            
            %%%% User Read-Out:
            fprintf('Iter:  %d / %d \n', idx, nTrial);
            
        end
    end
end

%%%% Data Analysis

FF = [F_Eval_Count, F_Best];

[~,IDX] = sortrows(FF,[-1,-2]);   %[worst --> best]

% for i=1:nTrial
%     fprintf('nEval: %4d,  fVal: %6.3e,  Alpha: %4.2f, Beta:  %4.2f,  nPop: %d  \n',...
%         F_Eval_Count(IDX(i)),  F_Best(IDX(i)),  Alpha(IDX(i)), BetaGamma(IDX(i)), Pop(IDX(i)));
% end


%%%% Agregate the top N parameter runs:
N = 10; ii = length(IDX) + 1 - (1:N);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
for i=1:N
    fprintf('nEval: %4d,  fVal: %6.3e,  Alpha: %4.2f, Beta:  %4.2f,  nPop: %d  \n',...
        F_Eval_Count(IDX(ii(i))),  F_Best(IDX(ii(i))),  Alpha(IDX(ii(i))), BetaGamma(IDX(ii(i))), Pop(IDX(ii(i))));
end
fprintf('nEval:  mean = %6.1f,  median = %6.1f, range = %6.1f \n', mean(F_Eval_Count(IDX(ii))), median(F_Eval_Count(IDX(ii))),range(F_Eval_Count(IDX(ii))));
fprintf('fVal:   mean = %6.1f,  median = %6.1f, range = %6.1f \n', mean(F_Best(IDX(ii))), median(F_Best(IDX(ii))),range(F_Best(IDX(ii))));
fprintf('Alpha:  mean = %6.1f,  median = %6.1f, range = %6.1f \n', mean(Alpha(IDX(ii))), median(Alpha(IDX(ii))), range(Alpha(IDX(ii))));
fprintf('Beta:   mean = %6.1f,  median = %6.1f, range = %6.1f \n', mean(BetaGamma(IDX(ii))), median(BetaGamma(IDX(ii))), range(BetaGamma(IDX(ii))));
fprintf('Pop:    mean = %6.1f,  median = %6.1f, range = %6.1f \n', mean(Pop(IDX(ii))), median(Pop(IDX(ii))), range(Pop(IDX(ii))));
