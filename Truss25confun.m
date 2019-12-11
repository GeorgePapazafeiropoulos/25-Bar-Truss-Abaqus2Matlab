function [c,ceq] = Truss25confun(X)
%
% Constraint function for the 25-bar truss optimization problem.
% 
% Syntax
%     [#c#,#ceq#] = Truss25confun(#x#);
%
% Description
%     This function calculates the inequalities and equalities which define
%     the constraints imposed on the fmincon optimization function
%     (built-in in MATLAB). If #c# is lower than zero then the constraints
%     regarding inequalities are considered to be satified. If #ceq# is
%     equal to zero, then the constraints regarding equalities are
%     considered to be satisfied.
%     
% Input parameters
%     #x# ([8 x 1]) is the vector containing the 8 design variables of
%         the 25-bar truss model.
% 
% Output parameters
%     #c# ([#n# x 1]) is the left hand sides of the #n# inequalities of the
%         form: #y#<=0, based on the values of the design variables as
%         specified in #x#.
%     #ceq# ([#m# x 1]) is the errors of the #m# equalities included in the
%         constraints, based on the values of the design variables as
%         specified in #x#. For the 25-bar truss optimization problem,
%         there are not any equality constraints, thus #ceq#=[].
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


global m j f
% set the stress and displacement limits of the 25-bar truss (maximum
% stress, minimum stress, maximum absolute value of horizontal displacment,
% maximum absolute value of the vertical displacement).
maxstress=40;
minstress=-[35.092;11.59;11.59;11.59;11.59;17.305;17.305;17.305;17.305;35.092;35.092;35.092;35.092;6.759;6.759;6.759;6.759;6.959;6.959;6.959;6.959;11.082;11.082;11.082;11.082];
DmaxX=0.35;
DmaxY=0.35;
DmaxZ=0.35;

%%
% Load case 1
% Construct the Abaqus input file Truss25ABAQUS1.inp
Truss25InpFileConstr1(X)
% Run the input file Truss25ABAQUS1.inp with Abaqus
%!abaqus job=Truss25ABAQUS1
runAbaqusAnalysis('Truss25ABAQUS1',60,3)
% Assign all lines of the Truss25ABAQUS1.fil file in an one-row string
% (after Abaqus analysis terminates)
Rec = Fil2str('Truss25ABAQUS1.fil');
% Obtain the element axial forces
EleStresses1 = Rec11(Rec);
% Obtain the nodal displacements
out2 = Rec101(Rec);
NodalDisplacements1=out2(:,2:4);
% Delete the files of last Abaqus run to avoid Abaqus abort when it
% tries to rewrite them
java.io.File('Truss25ABAQUS1.inp').delete();
java.io.File('Truss25ABAQUS1.fil').delete();
java.io.File('Truss25ABAQUS1.prt').delete();
java.io.File('Truss25ABAQUS1.com').delete();
java.io.File('Truss25ABAQUS1.sim').delete();
% Calculate the maximum nodal displacements
maxabsNodDisplX1=max(abs(NodalDisplacements1(:,1)));
maxabsNodDisplY1=max(abs(NodalDisplacements1(:,2)));
maxabsNodDisplZ1=max(abs(NodalDisplacements1(:,3)));

% Load case 2
% Construct the Abaqus input file Truss25ABAQUS2.inp
Truss25InpFileConstr2(X)
% Run the input file Truss25ABAQUS2.inp with Abaqus
%!abaqus job=Truss25ABAQUS2
runAbaqusAnalysis('Truss25ABAQUS2',60,3)
% Assign all lines of the Truss25ABAQUS2.fil file in an one-row string
% (after Abaqus analysis terminates)
Rec = Fil2str('Truss25ABAQUS2.fil');
% Obtain the element axial forces
EleStresses2 = Rec11(Rec);
% Obtain the nodal displacements
out2 = Rec101(Rec);
NodalDisplacements2=out2(:,2:4);
% Delete the files of last Abaqus run to avoid Abaqus abort when it
% tries to rewrite them
java.io.File('Truss25ABAQUS2.fil').delete();
java.io.File('Truss25ABAQUS2.prt').delete();
java.io.File('Truss25ABAQUS2.com').delete();
java.io.File('Truss25ABAQUS2.sim').delete();

%%
% Calculate the maximum nodal displacements
maxabsNodDisplX2=max(abs(NodalDisplacements2(:,1)));
maxabsNodDisplY2=max(abs(NodalDisplacements2(:,2)));
maxabsNodDisplZ2=max(abs(NodalDisplacements2(:,3)));
% Assemble the constraints
c = [max(max(EleStresses1),max(EleStresses2))-maxstress; 
    -min(EleStresses1,EleStresses2)+minstress; 
    max(maxabsNodDisplX1,maxabsNodDisplX2)-DmaxX; 
    max(maxabsNodDisplY1,maxabsNodDisplY2)-DmaxY; 
    max(maxabsNodDisplZ1,maxabsNodDisplZ2)-DmaxZ]; 
ceq = [];

% Save all variables, clear and reload to save memory
evalin('base','save(''Abaqus2MatlabVars'')');
evalin('base','clear java');
evalin('base','load(''Abaqus2MatlabVars'')');

% Plot of free memory
n = java.lang.Runtime.getRuntime.freeMemory;
m=[m,n];
figure( f );
fig = gcf; % current figure handle
fig.Name='Runtime Free Memory';
fig.NumberTitle='off';
plot( m );
drawnow;
j=j+1;


end