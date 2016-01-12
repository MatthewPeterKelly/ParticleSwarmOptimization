function f = StyblinskiTang(x)
%  f = StyblinskiTang(x)
%
% Compute the Styblinski-Tang(z) function, used for testing optimization
%
% Reference:
%   Wikipedia:  Test Functions for Optimization
%
% Global Minimum:
%   n = size(x,1);  %Dimension of search space
%   xStar = -2.903534*ones(n,1);
%   -39.16617*n < f(xStar) < -39.16616*n  
% 

[n,m] = size(x);
f = zeros(1,m);
for i=1:n
    f = f + x(i,:).^4 - 16*x(i,:).^2 + 5*x(i,:);
end
f = 0.5*f;

end