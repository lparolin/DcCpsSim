function success = copydataforparametricanalysis(destinationFolder)
%COPYDATAFORPARAMETRICANALYSIS Copy data for parametric analysis.
%

% Luca Parolini
% <lparolin@andrew.cmu.edu>
%
%
% Mar. 23rd 2011

fileName = {'coordinated_data.mat', 'uncoordinated_data.mat', ...
    './layout/15.mat', 'generateairflowexchange.m', 'param_analysis/power_comparison.eps', ...
    'param_analysis/power_comparison.pdf','param_analysis/power_comparison.fig', 'param_analysis/power_comparison.png'};

destinationFileName = dir(destinationFolder);
isDestinationFolderEmpty = size(destinationFileName, 1) <= 2;


if isDestinationFolderEmpty
    for iFile = 1 : length(fileName)
        success = copyfile(fileName{iFile}, destinationFolder);
    end
else
    success = 0;
end
