function startup_utils()
%STARTUP_SIMULATOR Find and set the paths needed for the simulator.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

rootPath = pwd;
addpath(rootPath); % add myself to the path

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end