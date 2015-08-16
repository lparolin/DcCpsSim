% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Generate comparison figures

% Load coordinated data
% Load uncoordianted data
% Load baseline data

clear all

folderNameArray = {'1', '2', '5'};
fileNameToSave = 'baseline_data';
controllerDataFileName = {'coordinated_data', 'uncoordinated_data', ...
    'baseline_data'};
controllerName = {'Coord', 'Uncoord', 'Baseline'};
thresholdUsage = 1e-2;        % threshold to distinguish usage

powerData = cell(length(folderNameArray), length(controllerDataFileName));
usage = cell(length(folderNameArray), length(controllerDataFileName));
% functionName = 'computecyberphysicalindex';
%         getCyberphysicalIndex = str2func(functionName);


for iFolderName = 1 : length(folderNameArray)
    folderPath = ['./' folderNameArray{iFolderName}];
    for iController = 1 : length(controllerDataFileName)
        dataFileName = controllerDataFileName{iController};
        
        currentData = load([folderPath '/' dataFileName]);
        usage{iFolderNameArray, iController} = ...
            computeusage(currentData.DcData, currentData.SimulationData);
        
        nZones = currentData.DcData.nZones;
        nCracs = currentData.DcData.nCracs;
        psi = currentData.DcData.psi{end};

        currentData.DcData.powerToTemperatureCoefficient = ...
            currentData.DcData.powerToTemperatureCoefficient{end};

        jobArrivalRate = sum(currentData.SimulationData.jobArrivalRate, 1)';
        maxJobArrivalRate = max(jobArrivalRate);
        thresholdJobArrivalRate = maxJobArrivalRate / 100; % threshold value
    
        OriginalValues = struct;
        zoneIdx = currentData.DcData.zoneIdx;
        cracIdx = currentData.DcData.cracIdx;
        OriginalValues.serverPower = ...
            sum(currentData.SimulationData.pw(zoneIdx, :), 1)';
        OriginalValues.cracPower = ...
            sum(currentData.SimulationData.pw(cracIdx, :), 1)';
        OriginalValues.totalPower = ...
            sum(currentData.SimulationData.pw, 1)';
        %powerData = computemeanwithrespecttovector( ...
        %    jobArrivalRate, thresholdJobArrivalRate, OriginalValues); 
        powerData{iFolderNameArray, iController} = ...
            computemeanwithrespecttovector(usage{iFolderNameArray, ...
            iController}, thresholdUsage, OriginalValues); 
    end
end
return
fig_path = './';
