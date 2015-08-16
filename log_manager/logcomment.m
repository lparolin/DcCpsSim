function logcomment(stringToLog)
%LOGCOMMENT Generate a log of a comment


% Luca Parolini
% <lparolin@andrew.cmu.edu>

% May 3rd 2011

stackInformation = dbstack;
[timeString lineId] = createstringtoken(stackInformation, now);

% char(9) add a tab space 
% stringToLog = [firstPartString stringToLog];
stringToLog = [timeString ' ' stringToLog ' === ' lineId];
disp(stringToLog);  % show the string and via the diary function, log it
end

function [timeString lineId] = createstringtoken(stackInformation, timeOfLog)

% If the call has a stack with length < 2 then the call came from a debug
% operation and it won't contain useful stack information, so disregard it.
timeString = datestr(timeOfLog, 'HH:MM:SS');

    if length(stackInformation) > 1
        callingFunctionName = stackInformation(2).name;
        callingFunctionLineNumber = stackInformation(2).line;

        lineId = [callingFunctionName ':' num2str(callingFunctionLineNumber)];
    else
        lineId = '';
    end
end