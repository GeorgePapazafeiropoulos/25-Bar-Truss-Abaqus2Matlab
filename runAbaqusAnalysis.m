function runAbaqusAnalysis(inpFile,tub,tlb,varargin)
%
% Remote execution of Abaqus input file (*.inp) through Matlab.
% 
% Syntax
%     runAbaqusAnalysis(#inpFile#,#tub#,#tlb#,#varargin#)
%
% Description
%     This function runs the input file #inpFile#.inp in Abaqus. Abaqus
%     execution is started and afterwards Matlab execution halts, waiting
%     until any of the following events happens:
%     (1) Abaqus execution starts normally and the Abaqus *.lck file is
%     deleted. This is the normal case.
%     (2) Abaqus execution starts normally and the upper time limit #tub#
%     is exceeded (Abaqus execution is lagged). In this case, Abaqus
%     analysis is automatically terminated and executed again.
%     (3) Abaqus execution starts but the Abaqus *.lck file is not
%     generated, and the lower time limit #tlb# is exceeded (the execution
%     of the process SMASimUtility.exe is lagged). In this case, the
%     process SMASimUtility.exe is automatically killed and the Abaqus
%     analysis is executed again.
%     In this function Java variants of various Matlab commands are used
%     where possible, in order to avoid memory leaks which may cause lags
%     or crashes of Abaqus execution. Furthermore, the Java commands are
%     proven to be much more accurate than the corresponding Matlab
%     commands.
%     
% Input parameters
%     #inpFile# (row string) is the name of the Abaqus input file that is
%         executed, without the extension *.inp.
%     #tub# ([1 x 1]) is the time duration within which the Abaqus analysis
%         is allowed to be run. If this time limit is exceeded, Abaqus
%         analysis is automatically terminated and executed again.
%     #tlb# ([1 x 1]) is the time duration within which the Abaqus analysis
%         should be started. If the Abaqus analysis does not start within
%         this time limit, then the related process SMASimUtility.exe is
%         killed and the Abaqus analysis is executed again.
%     #varargin# ({1 x 1}) contains the name of the old job restart file if
%         the Abaqus analysis is a restart analysis.
% 
% Output parameters
%     None.
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


sw=false;
if nargin==4
    oldFile=varargin{1};
    str2exec=['abaqus job=',inpFile,' oldjob=',oldFile];
elseif nargin==3
    str2exec=['abaqus job=',inpFile];
else
    return
end

if exist([inpFile,'.inp'],'file')==2
    sw=true;
end

tic;
while sw
    
    % Update time counters
    tub=tub+toc;
    tlb=tlb+toc;
    
    % Delete any old redundant files
    %delete([inpFile,'.lck']);
    % java.io.File([inpFile,'.lck']).delete();
    % java.io.File([inpFile,'.023']).delete();
    % java.io.File([inpFile,'.mdl']).delete();
    % java.io.File([inpFile,'.cid']).delete();
    % java.io.File([inpFile,'.com']).delete();
    % java.io.File([inpFile,'.prt']).delete();
    % java.io.File([inpFile,'.sim']).delete();
    % java.io.File([inpFile,'.SMABulk']).delete();
    % java.io.File([inpFile,'.SMAFocus']).delete();
    % java.io.File([inpFile,'.SMAManifest']).delete();
    % java.io.File([inpFile,'.sta']).delete();
    % java.io.File([inpFile,'.stt']).delete();
    % java.io.File([inpFile,'.tmp']).delete();
    %
    % Delete any files containing results of previous run
    % java.io.File([inpFile,'.dat']).delete();
    % java.io.File([inpFile,'.fil']).delete();
    % java.io.File([inpFile,'.log']).delete();
    % java.io.File([inpFile,'.msg']).delete();
    % java.io.File([inpFile,'.odb']).delete();
    
    % Run the input file inpFile.inp with Abaqus
    [sta,cmdOut] = system(str2exec);
    
    % Pause Matlab execution in order for the lck file to be created
    %pause(2);
    java.lang.Thread.sleep(2*1000);
    
    % If the *.lck or *.023 file exists then halt Matlab execution
    swLCK=exist([inpFile,'.lck'],'file')==2;
    %swLCK=java.io.File([inpFile,'.lck']).exists();
    sw023=exist([inpFile,'.023'],'file')==2;
    %sw023=java.io.File([inpFile,'.023']).exists();
    while (swLCK || sw023) && (toc<tub)
        
        %pause(1)
        java.lang.Thread.sleep(1*1000);
        
        % the lck file has been created and Matlab halts in this loop.
        % Set sw to false to break the outer while loop and continue
        % the code execution.
        sw=false;
        %swLCK=exist([inpFile,'.lck'],'file')==2;
        swLCK=java.io.File([inpFile,'.lck']).exists();
        %sw023=exist([inpFile,'.023'],'file')==2;
        sw023=java.io.File([inpFile,'.023']).exists();
    end
    
    %pause(2)
    java.lang.Thread.sleep(2*1000);
    
    % In case that the lck file cannot be detected, then terminate
    % infinite execution of the outer while loop after a certain
    % execution time limit
    if sw && (toc>tlb)
        % Kill SMASimUtility.exe
        system('wmic process where name="SMASimUtility.exe" call terminate')
        %pause(4)
        java.lang.Thread.sleep(4*1000);
    end
    
    % If the *.lck or *.023 file exists after maximum time limit has been
    % exceeded, then try to kill the process pre.exe and delete any files
    % that have been generated from the analysis
    
    %swLCK=exist([inpFile,'.lck'],'file')==2;
    swLCK=java.io.File([inpFile,'.lck']).exists();
    %sw023=exist([inpFile,'.023'],'file')==2;
    sw023=java.io.File([inpFile,'.023']).exists();
    if swLCK || sw023
        
        % Kill pre.exe (SMAPreprocessing)
        system('wmic process where name="pre.exe" call terminate')
        %pause(4)
        java.lang.Thread.sleep(4*1000);
        
        % Delete lck file
        %delete([inpFile,'.lck']);
        %delete([inpFile,'.023']);
        java.io.File([inpFile,'.lck']).delete();
        java.io.File([inpFile,'.023']).delete();
        
        % Rerun the input file
        sw=true;
    end
end

end

