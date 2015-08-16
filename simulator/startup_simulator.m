function startup_simulator()
%STARTUP_SIMULATOR Find and set the paths needed for the simulator.

% Luca Parolini 
% <lparolin@andrew.cmu.edu> 
% Apr. 18th 2011


rootPath = pwd;
addpath(rootPath); % add myself to the path
% folderName = {'data_center_data'};
%
% for iFolderName = folderName;
%    pathToAdd = fullfile(rootPath, iFolderName{:});
%    addpath(pathToAdd);
%    cd(rootPath);
% end

[~, myFolderName, ~] = fileparts(rootPath);
disp([upper(myFolderName) ' successfully installed']);
end