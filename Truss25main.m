%% Matlab_Abaqus_25_Bar_Truss
% Find the cross-sections of the members of the 25-bar truss so that its
% weight is minimized and the constraints are satisfied. For more
% information please see the <Documentation.html Documentation of
% Matlab_Abaqus_25_Bar_Truss package>.

%%
% Initialize variables
format long
global m j f
f=1;
m = zeros( 1, 0 );
j=1;
%%
% Make a starting guess for the solution.
x0 = 10*ones(8,1);
%%
% Set the lower limit of the cross section areas of the members of the
% truss.
AreaMin=0.01;
lb=AreaMin*ones(8,1);
%%
% Specify some options for the optimization function (fmincon).
% The default TolX is 1e-10. It ran successfully with exitflag=2 (Change in
% x was less than options.StepTolerance), so we reduce the tolerance in x.
options = optimset('MaxFunEvals',8000,'Display','Iter','TolX',1e-11);
%%
% Initialize timer.
tic
%%
% Perform the optimization of the truss (constrained optimization with
% fmincon).
[X,fval,exitflag,output,lambda] = fmincon(@Truss25objfun,x0,[],[],[],[], lb ,[],'Truss25confun',options)
%%
% Report elapsed time.
toc

%%
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


