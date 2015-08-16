function logandthrowerror(errorToLog) %(errorToLog, fileNameToLogTheError)
%LOGANDTHROWERROR Log the error, throw the error and exit
%
%  Usage example:
%    msgIdentComponent = upper(mfilename);
%    msgIdentMnemonic = 'InputVariableCheck';
%    msgIdent = [msgIdentComponent ':' msgIdentMnemonic];
%    errorToThrow = MException(msgIdent, 'Parameters.dataCenterDataPath is empty.');
%    logandthrowerror(errorToThrow);



% Luca Parolini
% <lparolin@andrew.cmu.edu>

% May 2nd 2011

% stackInformation = dbstack;
% firstPartString = createfirstpartlogstring(stackInformation, now);
stringToLog = [errorToLog.identifier ', ' errorToLog.message];
logcomment(stringToLog); 
closelogcomment();% close the diary
disp('Saving figures...');
evalin('base', 'savefigure(Parameters)');
% get base path to use
basePathToUse = evalin('base', 'getfield(Parameters, ''basePathToUse'')');
disp('Saving data...');
save([basePathToUse '/error_save_variables']);

throwAsCaller(errorToLog);
end

