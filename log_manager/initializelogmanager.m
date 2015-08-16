function Parameters = initializelogmanager(Parameters)
%INITIALIZELOGMANAGER Initialize log manager. 
%   InputParameters is a struct. 
%   InputParameters.logFileName is a string which contains
%   the path and the name of the file where the log will be stored.


% Luca Parolini
% <lparolin@andrew.cmu.edu>

% May 3rd 2011
    Parameters.LogParameters = struct;
    Parameters.LogParameters.logFolder = Parameters.basePathToUse;
    Parameters.LogParameters.logFileName = [datestr(now, 'yyyymmddTHHMMSS') ...
        '.log'];
    
    % Create folder for logs
    [isPathCreated, messageString, messageId] = ...
        mkdir(Parameters.LogParameters.logFolder);
    if ~isPathCreated
        errorToThrow = MException(messageId, messageString);
        throw(errorToThrow);
    end

    logFileNameAndPath = [Parameters.LogParameters.logFolder '/' ...
        Parameters.LogParameters.logFileName];
    diary(logFileNameAndPath);
    logcomment('Log Manager Initialized.');
end

