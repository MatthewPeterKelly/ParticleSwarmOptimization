function f = GoldsteinPrice(z)
%  f = GoldsteinPrice(z)
%
% Compute the Goldstein-Price function, used for testing optimization
%
% Reference:
%   Wikipedia:  Test Functions for Optimization
%
% Global Minimum:
%   f(0, -1) = 0;  
% 
% NOTES:
%   The true GoldsteinPrice function has a global minimum of f(0,-1) = 3,
%   but I've shifted the entire function by 3 to make the plotting nice.
% 

x = z(1,:);
y = z(2,:);

f = (1+((x+y+1).^2).*(19-14*x+3*x.^2-14*y+6*x.*y + 3*y.^2)).*...
    (30+((2*x-3*y).^2).*(18-32*x+12*x.^2+48*y-36*x.*y+27*y.^2));

f = f - 3;   % Shift objective to have optimal value of 0.0

end