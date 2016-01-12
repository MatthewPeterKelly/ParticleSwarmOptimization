function f = Himmelblau(z)
% f = Himmelblau(z)
%
% Compute Himmelblau's function:
% f(x,y) = (x^2 + y - 11)^2 + (x+y^2-7)^2
%
% Used as a test function for optimization
%
% INPUTS:
%   z = [x;y] = [2,n] = evaluation poitn ion state space
%  
% OUTPUTS:
%   f = f(z) = f(x,y) = (x.^2 + y - 11).^2 + (x+y.^2-7).^2
%
% Local Maximum:
%   f(-0.270845, -0.923039) = 181.617
%
% Local Minima:
% f(3.0, 2.0) = 0.0
% f(-2.805118, 3.131312) = 0.0
% f(-3.779310, -3.283186) = 0.0
% f(3.584428, -1.848126) = 0.0
% 
% Reference:  
%   --> Wikipedia:  Himmelblau's Function
%
   
x = z(1,:);
y = z(2,:);
f = (x.^2 + y - 11).^2 + (x+y.^2-7).^2;

end