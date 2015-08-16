function startup_controllers()
%STARTUP_CONTROLLERS Find and set the paths needed for the controllers.

% Luca Parolini 
% <lparolin@andrew.cmu.edu> 
% Apr. 18th 2011


rootPath = pwd;
addpath(rootPath); % add myself to the path
folderName = {'data_center_level'};

for iFolderName = folderName;
    pathToControllerLevel = fullfile(rootPath, iFolderName{:});
    cd(pathToControllerLevel);
    commandToExecute = ['startup_' iFolderName{:}];
    eval(commandToExecute);
    cd(rootPath);
end

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end