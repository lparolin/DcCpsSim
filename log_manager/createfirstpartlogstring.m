function firstPartString = createfirstpartlogstring(stackInformation, timeOfLog)
%CREATEFIRSTPARTLOGSTRING Create the first part of the string for the log

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% May 3rd 2011

% If the call has a stack with length < 2 then the call came from a debug
% operation and it won't contain useful stack information, so disregard it.
if length(stackInformation) > 1
    callingFunctionName = stackInformation(2).name;
    callingFunctionLineNumber = stackInformation(2).line;
    timeOfLogString = datestr(timeOfLog, 'HH:MM:SS');

%     firstPartString = [timeOfLogString ' ' num2str(timeOfLog) ' ' ...
%         callingFunctionName ':' num2str(callingFunctionLineNumber) ' === '];
    firstPartString = [timeOfLogString ' ' callingFunctionName ':' ...
        num2str(callingFunctionLineNumber)];
else
    firstPartString = '';
end
end

