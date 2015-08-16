function startup_data_center_level
%STARTUP_DATA_CENTER_LEVEL Find and set the paths needed for the data
%  center level controller.

% Luca Parolini 
% <lparolin@andrew.cmu.edu> 
% Apr. 18th 2011


rootPath = pwd;
% addpath(rootPath); % we don't need to add this folder to the path
folderName = {'common'};

for iFolderName = folderName;
    pathToAdd = fullfile(rootPath, iFolderName{:});
    addpath(pathToAdd);
    cd(rootPath);
end

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end
