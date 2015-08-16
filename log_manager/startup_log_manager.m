function startup_log_manager()
%STARTUP_CONTROLLERS Find and set the paths needed for the controllers.

% Luca Parolini 
% <lparolin@andrew.cmu.edu> 
% May 3rd 2011


rootPath = pwd;
addpath(rootPath); % add myself to the path

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end