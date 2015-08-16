function functionHandle = createfunctionhandlers(pathAndFunctionFileName)
%CREATEFUNCTIONHANDLERS Create a function handle from the string
%pathAndFunctionFileName.
%
% functionHandle = createfunctionhandlers(pathAndFunctionFileName) 
%
% pathAndFunctionFileName: path to the function (with the function name) 
% for which the handle has to be created
% functionHanlde: handle for the function

% Luca Parolini 
% <lparolin@andrew.cmu.edu>

    currentPath = pwd;
    [functionPath, functionName, ~] = fileparts(pathAndFunctionFileName);
    cd(functionPath);
    functionHandle = str2func(functionName);
    cd(currentPath);

end

