function startup_dc_simulator()
%STARTUP_DC_SIMULATOR Find and set the paths needed for the data center 
%   simulator.

rootPath = pwd;
addpath(rootPath);

folderName = {'controllers', 'simulator', 'utils', 'log_manager'};

for iFolderName = folderName;
    newPathToAdd = fullfile(rootPath, iFolderName{:});
    cd(newPathToAdd);
    commandToExecute = ['startup_' iFolderName{:}];
    eval(commandToExecute);
    cd(rootPath);
end

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end