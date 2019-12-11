function f = Truss25objfun(x)
%
% Objective function for the 25-bar truss optimization problem.
% 
% Syntax
%     #f# = Truss25objfun(#x#);
%
% Description
%     This function calculates the total wieght of the 25-bar truss. This
%     weight is to be minimized by the optimization algorithm.
%     
% Input parameters
%     #x# ([8 x 1]) is the vector containing the 8 design variables of
%         the 25-bar truss model.
% 
% Output parameters
%     #f# ([1 x 1]) is the weight of the truss based on the values of the
%         design variables as specified in #x#.
%
% _________________________________________________________________________
% Abaqus2Matlab - www.abaqus2matlab.com
% Copyright (c) 2019 by George Papazafeiropoulos
%
% If using this toolbox for research or industrial purposes, please cite:
% G. Papazafeiropoulos, M. Muniz-Calvente, E. Martinez-Paneda.
% Abaqus2Matlab: a suitable tool for finite element post-processing.
% Advances in Engineering Software. Vol 105. March 2017. Pages 9-16. (2017) 
% DOI:10.1016/j.advengsoft.2017.01.006
%


f = 0.1*x'*1.0e+002*[0.750000000000000;
    4*1.305038313613819;
    4*1.068000468164691;
    2*0.750000000000000;
    2*0.750000000000000;
    4*1.811422093273680;
    4*1.811422093273680;
    4*1.334634781503914];
disp(x)
disp(f)
end
