function outputData = analyzemutliplesimulations(dataFileName, ...
    variablesToAnalyze, generateoutputdata, outputFileName)
%ANALYZEMUTLIPLESIMULATIONS Analyze results from multiple simulations.

% Luca Parolini 
% <lparolin@andrew.cmu.edu>

if nargin == 0 

dataFileName = {...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_35_52/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_33_44/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_05_32/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_02_39/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_01_37/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_00_37/variables' ...
    '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T14_48_39/variables' ...
    };

% 
% dataFileName = {...
%     '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_35_52/variables' ...
%     '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_33_44/variables' ...
%     };


% dataFileName = {...
%     '../data_center_data/DCO_like/data_and_figure/coordinated/02_13_2012T15_33_44/variables' ...
%     };

variablesToAnalyze = {'Parameters.Simulation.jobArrivalRateToDataCenter', ...
    'Parameters.Simulation.jobDepartureRate', ...
    'Parameters.Simulation.timeStep', ...
    'Parameters.Simulation.totalCost', ...
    'Parameters.Simulation.zonePowerConsumption', ...
    'Parameters.Simulation.cracPowerConsumption', ...
    'Parameters.Simulation.coefficientOfPerformance', ...
    'Parameters.DcData.jobDepartureRateMax', ...
    'Parameters.normalizedJobArrivalRateMax', ...
    };

generateoutputdata = @averagepowerconsumptionvsaverageuse;
outputFileName = './coordinated_1';
end

nFiles = length(dataFileName);
extractedVariable = cell(nFiles, 1);

for iFileName = 1 : nFiles
    disp(['Loading data from file number ' num2str(iFileName) '.']);
    extractedVariable{iFileName} = extractvariable(dataFileName{iFileName}, ...
        variablesToAnalyze);
end

outputData = generateoutputdata(extractedVariable, dataFileName, ...
    variablesToAnalyze);
save(outputFileName, 'outputData');
end


function outputData = averagepowerconsumptionvsaverageuse(variable, ...
    ~, variablesToAnalyze)
    nElements = length(variable);
    
    zonePowerIdx = find(strcmp(variablesToAnalyze, ...
        'Parameters.Simulation.zonePowerConsumption'));
    cracPowerIdx = find(strcmp(variablesToAnalyze, ...
        'Parameters.Simulation.cracPowerConsumption'));
    jobDepartureRateIdx = find(strcmp(variablesToAnalyze, ...
        'Parameters.Simulation.jobDepartureRate'));
    maxJobArrivalRateIdx = find(strcmp(variablesToAnalyze, ...
        'Parameters.DcData.jobDepartureRateMax'));
    normalizedJobArrivalRateIdx = find(strcmp(variablesToAnalyze, ...
        'Parameters.normalizedJobArrivalRateMax'));
    
    outputData(nElements) = struct('averageZonePower', [], ...
        'averageCracPower', [], ...
        'averageTotalPower', [], ...
        'averagePUE', [], ...
        'averageUse', [], ...
        'normalizedJobArrivalRate', []);
    for iElement = 1 : nElements
        averageValue = computeaveragevalue(variable{iElement}, ...
            [zonePowerIdx; cracPowerIdx; jobDepartureRateIdx], [2; 2; 3]);
        outputData(iElement).averageZonePower = averageValue{1};
        outputData(iElement).averageCracPower = averageValue{2};
        averageJobDepartureRate = averageValue{3};
        maxJobExecutionRate = vec(variable{iElement}{maxJobArrivalRateIdx}); %#ok<FNDSB>
        
        outputData(iElement).averageTotalPower = ...
            sum(outputData(iElement).averageZonePower) + ...
            sum(outputData(iElement).averageCracPower);
        outputData(iElement).averagePUE = ...
            outputData(iElement).averageTotalPower / ...
            sum(outputData(iElement).averageZonePower);
        outputData(iElement).averageUse =  mean(averageJobDepartureRate ./ maxJobExecutionRate);
        outputData(iElement).normalizedJobArrivalRate = ...
            variable{iElement}{normalizedJobArrivalRateIdx}; %#ok<FNDSB>
    end
end

function averageValue = computeaveragevalue(inputData, indexes, ...
    meanOverDimension, startIdx, endIdx)

    % inputData is a M x 1 cell
    % indexes is N x 1 vector whose elements ranges in the discrete
    % interval [1, M]. 
    % meanOverDimension is a N x 1 vector. meanOverDimension(i) = k means
    % that the mean of the i^{th} inputData will be computed over the
    % k^{th} dimension.
    % averageValue is a N x 1 cell. 
    
    if nargin < 3
        disp('Error. Not enough input given.');
        quit;
    end
    
    nData = length(indexes);
    if nargin < 4
        startIdx = zeros(nData, 1);
        for iData = 1 : nData
            dataLength = size(inputData{indexes(iData)}, ...
                meanOverDimension(iData));
            startIdx(iData) = floor(dataLength / 10) + 1;   % forget about initial point (avoid possible transients)
        end
    end
    
    if nargin < 5
        endIdx = zeros(nData, 1);
        for iData = 1 : nData
            dataLength = size(inputData{indexes(iData)}, ...
                meanOverDimension(iData));
            endIdx(iData) = ceil(dataLength * 9 / 10);   % forget about initial point (avoid possible transients)
        end
    end
    
    averageValue = cell(nData, 1);
    
    
    for iData = 1 : nData
        % tempIndex = zeros(size(inputData{indexes(iData)}));
        % for iDim = 1 : 
        newMatrixIndex = [repmat(':, ', 1, meanOverDimension(iData) -1) ...
            num2str(startIdx(iData)) ' : ' num2str(endIdx(iData)) ...
            repmat(' , :', 1, ndims(inputData{indexes(iData)}) - ...
            meanOverDimension(iData))];
        
        commandToEvaluate = ['mean(inputData{indexes(iData)}(' ...
            newMatrixIndex '), meanOverDimension(iData));'];
        averageValue{iData} = eval(commandToEvaluate);
    end
end

function loadedVariable = extractvariable(fileName, variableName)
%EXTRACTVARIABLE Load and extract variables from a .mat file.
% 
% loadedVariable: cell containing the required variables.
% fileName: name (and path) of the .mat file to load.
% variableName: cell containing the name of the variables that have to be
% loaded. If the variables are struct, then a cell of struct is returned.

    nVariables = length(variableName);
    parsedVariableName = cell(nVariables, 1);
    loadedVariable = cell(nVariables, 1);
        
    % parse variable, in case we deal with struct.
    % When loading a struct, we have to load the whole struct and then to keep
    % only the required fields
    nVariablesToLoad = 1;
    for iVariable = 1 : nVariables
        [parsedName ~] = ...
            strtok(variableName{iVariable}, '.');
        idxExactMatch = strcmp(parsedName, parsedVariableName);
        % if idxExactMatch is all false, then the variable name is new
        if all(~idxExactMatch);
            parsedVariableName{nVariablesToLoad} = parsedName;
            nVariablesToLoad = nVariablesToLoad + 1;
        end
    end
    parsedVariableName = parsedVariableName(1 : nVariablesToLoad - 1);
    if isempty(parsedVariableName)
        disp('Error. Variable names were wrongly parsed.');
        quit;
    end
    
    % we now remove from parsedVariableName, variables that have the same
    % name. For example if we want to load Parameters.Simulation.jobArrivalRateToDataCenter
    % and Parameters.Simulation.jobArrivalRateToZone, then
    % parsedVariableName contains just Parameters, two times. We can get
    % rid of one of the Parameters
    tempLoadedVariable = load(fileName, parsedVariableName{:});
    
    for iVariable = 1 : nVariables
        loadedVariable{iVariable} = getvariabledata(tempLoadedVariable, ...
            variableName{iVariable});
    end
end

function newVariable = getvariabledata(originalVariable, name)
    [parsedName remaining] = strtok(name, '.');
    if ~isempty(remaining) % still fields in the structure
        remaining = remaining(2 : end); % remove the first . in front of the remaining
        newVariable = getvariabledata(...
            originalVariable.(parsedName), remaining);
        % newVariable.(parsedName) = getvariabledata(...
        %    originalVariable.(parsedName), remaining);
    else
        newVariable = originalVariable.(parsedName);
    end
end