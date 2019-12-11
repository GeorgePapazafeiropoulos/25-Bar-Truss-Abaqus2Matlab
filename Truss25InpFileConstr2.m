function Truss25InpFileConstr2(x)
%
% Construct Abaqus input file for the 25-bar truss optimization problem.
% 
% Syntax
%     Truss25InpFileConstr2(#x#);
%
% Description
%     This function creates the input file "Truss25ABAQUS2.inp" which is
%     run by Abaqus to analyse the 25-bar truss involved in the
%     optimization procedure of Matlab_Abaqus_25_Bar_Truss package.
%     
% Input parameters
%     #x# ([8 x 1]) is the vector containing the 8 design variables of
%         the 25-bar truss model.
% 
% Output parameters
%     (none)
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


% Open output file and start writing
OutputFileName = 'Truss25ABAQUS2.inp';
fileID = fopen(OutputFileName,'wt');

fprintf(fileID,' *HEADING\n');
fprintf(fileID,' 25 BAR TRUSS LOAD CASE 1 [T3D2]\n');
fprintf(fileID,' *PREPRINT,ECHO=NO,HISTORY=NO,MODEL=NO\n');
fprintf(fileID,' *NODE\n');
fprintf(fileID,' 1,-37.5,0,200\n');
fprintf(fileID,' 2,37.5,0,200\n');
fprintf(fileID,' 3,-37.5,37.5,100\n');
fprintf(fileID,' 4,37.5,37.5,100\n');
fprintf(fileID,' 5,37.5,-37.5,100\n');
fprintf(fileID,' 6,-37.5,-37.5,100\n');
fprintf(fileID,' 7,-100,100,0\n');
fprintf(fileID,' 8,100,100,0\n');
fprintf(fileID,' 9,100,-100,0\n');
fprintf(fileID,' 10,-100,-100,0\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E1\n');
fprintf(fileID,' 1, 1, 2   \n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E2\n');
fprintf(fileID,' 2, 4, 1\n');
fprintf(fileID,' 3, 2, 3\n');
fprintf(fileID,' 4, 2, 6\n');
fprintf(fileID,' 5, 1, 5\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E3\n');
fprintf(fileID,' 6, 2, 4\n');
fprintf(fileID,' 7, 2, 5\n');
fprintf(fileID,' 8, 1, 3\n');
fprintf(fileID,' 9, 1, 6\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E4\n');
fprintf(fileID,' 10, 3, 6\n');
fprintf(fileID,' 11, 5, 4\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E5\n');
fprintf(fileID,' 12, 3, 4\n');
fprintf(fileID,' 13, 5, 6\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E6\n');
fprintf(fileID,' 14, 3, 10\n');
fprintf(fileID,' 15, 7, 6\n');
fprintf(fileID,' 16, 9, 4\n');
fprintf(fileID,' 17, 8, 5\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E7\n');
fprintf(fileID,' 18, 7, 4\n');
fprintf(fileID,' 19, 3, 8\n');
fprintf(fileID,' 20, 10, 5\n');
fprintf(fileID,' 21, 9, 6\n');
fprintf(fileID,' *ELEMENT,TYPE=T3D2, ELSET=E8\n');
fprintf(fileID,' 22, 10, 6\n');
fprintf(fileID,' 23, 3, 7\n');
fprintf(fileID,' 24, 8, 4\n');
fprintf(fileID,' 25, 9, 5\n');
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E1\n');
fprintf(fileID,'  %s\n', [num2str(x(1),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E2\n');
fprintf(fileID,'  %s\n', [num2str(x(2),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E3\n');
fprintf(fileID,'  %s\n', [num2str(x(3),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E4\n');
fprintf(fileID,'  %s\n', [num2str(x(4),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E5\n');
fprintf(fileID,'  %s\n', [num2str(x(5),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E6\n');
fprintf(fileID,'  %s\n', [num2str(x(6),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E7\n');
fprintf(fileID,'  %s\n', [num2str(x(7),20),',']); 
fprintf(fileID,' *SOLID SECTION,MATERIAL=MAT, ELSET=E8\n');
fprintf(fileID,'  %s\n', [num2str(x(8),20),',']); 
fprintf(fileID,' *MATERIAL,NAME=MAT\n');
fprintf(fileID,' *ELASTIC\n');
fprintf(fileID,' 1.E4, \n');
fprintf(fileID,' *DENSITY\n');
fprintf(fileID,' 7.5E-4, \n');
fprintf(fileID,' *BOUNDARY\n');
fprintf(fileID,' 7,1,3\n');
fprintf(fileID,' 8,1,3\n');
fprintf(fileID,' 9,1,3\n');
fprintf(fileID,' 10,1,3\n');
fprintf(fileID,' *STEP\n');
fprintf(fileID,' *STATIC\n');
fprintf(fileID,' *CLOAD\n');
fprintf(fileID,' 1,1,0.\n');
fprintf(fileID,' 1,2,20.\n');
fprintf(fileID,' 1,3,-5.\n');
fprintf(fileID,' 2,1,0.\n');
fprintf(fileID,' 2,2,-20.\n');
fprintf(fileID,' 2,3,-5.\n');
fprintf(fileID,' **\n');
fprintf(fileID,' **Write results to *.fil file\n');
fprintf(fileID,' *FILE FORMAT, ASCII\n');
fprintf(fileID,' *NODE FILE\n');
fprintf(fileID,' RF, U\n');
fprintf(fileID,' *EL FILE\n');
fprintf(fileID,' S\n');
fprintf(fileID,' **\n');
fprintf(fileID,' *END STEP\n');

% Close output file
fclose(fileID);