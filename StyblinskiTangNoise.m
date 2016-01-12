function f = StyblinskiTangNoise(x,alpha)
%  f = StyblinskiTangNoise(x,alpha)
%
% Compute the Styblinski-Tang(z) function, used for testing optimization
%
% Reference:
%   Wikipedia:  Test Functions for Optimization
%
% Global Minimum:
%   N = size(x,1);  %Dimension of search space
%   xStar = -2.903534027771178 * ones(N,1);
%   f(xStar) = -39.166165703771419 * N;
% 

[n,m] = size(x);
f = zeros(1,m);
for i=1:n
    f = f + x(i,:).^4 - 16*x(i,:).^2 + 5*x(i,:);
end
f = 0.5*f;

% Add some noise
f = f + 39.166165703771419*n*alpha*randn(size(f));

end