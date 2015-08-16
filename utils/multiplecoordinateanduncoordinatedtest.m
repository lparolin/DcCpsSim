% Go through each dir an generate new coordinated and new uncoordinated
% algorithm tests

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 27th 2011

clear all
clc
close all

dirNum = 13:16;
%dirNum = 12;
baseDirectoryName = './param_analysis';
destinationDirectoryName = '.';
% resultFileName = {'layout/15.mat'; 'coordinated_data.mat'; ...
%     'uncoordinated_data.mat'};
resultFileName = {'layout/15.mat'; 'coordinated_data.mat'};

for iDirNum = 1 : length(dirNum);
    sourceDirectoryName = [baseDirectoryName '/' num2str(dirNum(iDirNum))];
    isCopySuccess = copyfile([sourceDirectoryName '/' '15.mat'], ...
        './layout');
    if ~isCopySuccess
        disp(['Unable to copy ' sourceDirectoryName '15.mat' ' to ' ...
            destinationDirectoryName]);
        return
    end
    % execute coordinated and uncoordinated algorithm
    disp(['Executing coordinated algorithm, folder: ' sourceDirectoryName]);
    datacentersimcoordinated;
    %disp(['Executing uncoordinated algorithm, folder: ' sourceDirectoryName]);
    %datacentersimuncoordinated;
    
%     % generate comparison figures
%     coord = load(['./coordinated_data']);
%     uncoord = load(['./uncoordinated_data']);
%     
%     coordTotalPower = sum(coord.SimulationData.pw, 1)';
%     uncoordTotalPower = sum(uncoord.SimulationData.pw, 1)';
%     
%     figPath = sourceDirectoryName;
%     figureHandler = figure('name',['Power consumption comparison: ' ...
%         sourceDirectoryName],'numbertitle','off');
%     hold on
%     plot(coord.SimulationData.time / 3600, ...
%         coordTotalPower*1e-3, ...
%         'Color','r','LineWidth',2, 'LineStyle', '-');
%     plot(uncoord.SimulationData.time / 3600, ...
%         uncoordTotalPower*1e-3, ...
%         'Color','b','LineWidth',2, 'LineStyle', '--');
%     xlabel('Time (hr)', 'FontSize',18);
%     ylabel('Power Consumption (KW)', 'FontSize',18);
%     lgd = legend('Coord.', 'Uncoord.');
%     set(lgd,'FontSize',16, 'Location', 'NorthEast');
%     axesHandler = gca; % gca get the current axis
%     figName = [figPath '/power_comparison'];
%     prepareandsavefigure(figName, axesHandler, figureHandler);
    
    sourceDirectoryName = '.';
    destinationDirectoryName = [baseDirectoryName '/' num2str(dirNum(iDirNum))];
    % copy result files
    for iResultFile = 1 : length(resultFileName)
        fileName = resultFileName{iResultFile};
        isCopySuccess = copyfile([sourceDirectoryName '/' fileName], ...
            destinationDirectoryName);
        if ~isCopySuccess
            disp(['Unable to copy ' sourceDirectoryName '/' fileName ' to ' ...
                destinationDirectoryName]);
            return
        end
    end
   
end

disp('Executed all of the require simulations');


