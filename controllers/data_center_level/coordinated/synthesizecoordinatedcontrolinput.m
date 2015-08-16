function Parameters = synthesizecoordinatedcontrolinput(Parameters, iTime)
%SYNTHESIZECOORDINATEDCONTROLINPUT Synthesize control input.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 21st 2011

persistent previousSolution;
persistent normalizedQueueLengthIdx;
persistent ToutIdx;
persistent OptimizationProblem;
persistent OptimalSolution;

if isempty(normalizedQueueLengthIdx)
    normalizedQueueLengthIdx = ...
        Parameters.Controller.StateVariablesIdx.normalizedQueueLength;
    ToutIdx = ...
        Parameters.Controller.StateVariablesIdx.Tout;
end

% generate predictions of future uncontrollable inputs
Parameters = generateandsetpredicteduncontrolledinput(Parameters, iTime);

% initial condition
% normalize queue length with respect to the controller sampling time
Parameters.Controller.OptimizationProblem.x_U(normalizedQueueLengthIdx) = ...
    vec(Parameters.Simulation.queueLength(:, :, iTime) / ...
    Parameters.Controller.timeStep);
Parameters.Controller.OptimizationProblem.x_L(normalizedQueueLengthIdx) = ...
    vec(Parameters.Simulation.queueLength(:, :, iTime) / ...
    Parameters.Controller.timeStep);

Parameters.Controller.OptimizationProblem.x_U(ToutIdx) = ...
    Parameters.Simulation.outputTemperature(:, iTime);
Parameters.Controller.OptimizationProblem.x_L(ToutIdx) = ...
    Parameters.Simulation.outputTemperature(:, iTime);

tic
if isempty(OptimizationProblem)
%      algorithmName = {'Interior/Direct'; 'Interior/Direct'; 'Interior/Direct'; ...
%          'Interior/Direct'; 'Interior/Direct'; 'Interior/Direct'; ...
%          'Interior/CG'; 'Active algorithm, SLQP'};
    % algorithmName = {'Auto'};
    algorithmName = {'Interior/Direct'};
    % algorithmName = {'Interior/Direct'; 'Interior/CG'; 'Active algorithm, SLQP'};
    % barMuRule = [1, 2, 3, 4, 5, 6, 0];          % mu rule to use with the
    % algorithms
    barMuRule = [];
    nAlgorithms = length(algorithmName);
    algorithm = zeros(nAlgorithms, 1);
    for iAlgorithm = 1 : nAlgorithms
        switch algorithmName{iAlgorithm}
            case 'Auto'
                algorithm(iAlgorithm) = 0;
            case 'Interior/Direct'
                algorithm(iAlgorithm) = 1;
            case 'Interior/CG'
                algorithm(iAlgorithm) = 2;
            case 'Active algorithm, SLQP'
                algorithm(iAlgorithm) = 3;
            otherwise
                algorithm(iAlgorithm) = -1;
                msgIdentComponent = upper(mfilename);
                msgIdentMnemonic = 'InputVariableCheck';
                msgIdent = [msgIdentComponent ':' msgIdentMnemonic];
                errorToThrow = ....
                    MException(msgIdent, 'Unknown algorithm.');
                logandthrowerror(errorToThrow);
        end
    end
    

    if ~isempty(previousSolution)
        Parameters.Controller.OptimizationProblem.x_0 = previousSolution;
    end

    Parameters.Controller.algorithmName = algorithmName;
    % clear the variable in order to assign it a new value
    clear('OptimizationProblem');
    for i = 1 : nAlgorithms
        OptimizationProblem(i) = Parameters.Controller.OptimizationProblem;
        OptimizationProblem(i).KNITRO.options.ALG = algorithm(i);
        if isempty(barMuRule)
            OptimizationProblem(i).KNITRO.options.BAR_MURULE = 6;
        else
            if  (algorithm(i) ~= 0) &&  ((i <= length(barMuRule)) && (algorithm(i) ~= 3))
                OptimizationProblem(i).KNITRO.options.BAR_MURULE = barMuRule(i);
            end
        end
    end
else
    % set lower and upper bounds
    OptimizationProblem = arrayfun(@(x)( setfield(x, 'x_L', ...
        Parameters.Controller.OptimizationProblem.x_L) ), ...
        OptimizationProblem, 'UniformOutput', true); %#ok<SFLD>
    
    OptimizationProblem = arrayfun(@(x)( setfield(x, 'x_U', ...
        Parameters.Controller.OptimizationProblem.x_L) ), ...
        OptimizationProblem, 'UniformOutput', true); %#ok<SFLD>
    
    OptimizationProblem = arrayfun(@(x)( setfield(x, 'x_0', ...
        Parameters.Controller.OptimizationProblem.x_0) ), ...
        OptimizationProblem, 'UniformOutput', true); %#ok<SFLD>
end

% FIXME solution should be an array of struct, but it is not easy to
% allocate in memory before entering in the for cicle
solution = cell(length(OptimizationProblem), 1);
PrintLevel = Parameters.Controller.Options.Prob.PriLevOpt;
controllerSolver = Parameters.Controller.Options.solver;

if Parameters.Controller.isParallelExeuctionRequired
    parfor iParProblem = 1 : length(OptimizationProblem)
        solution{iParProblem} = ...
            tomRun(controllerSolver, OptimizationProblem(iParProblem), ...
            PrintLevel);
    end
else
    for iParProblem = 1 : length(OptimizationProblem)
        solution{iParProblem} = ...
            tomRun(controllerSolver, OptimizationProblem(iParProblem), ...
            PrintLevel);
    end
end

for iProblem = 1 : length(OptimizationProblem)
    if (solution{iProblem}.MinorIter / solution{iProblem}.Iter) > 100
        logcomment(['Warning. sol{' num2str(iProblem) ...
            '}.MinorIter / sol{' num2str(iProblem) ...
            '}.Iter > 100. The problem may be badscaled.']);
    end
end

optimalValue = zeros(length(OptimizationProblem), 1);
for iAlgorithm = 1 : length(OptimizationProblem)
    if solution{iAlgorithm}.ExitFlag ~= 0
        optimalValue(iAlgorithm) = +Inf;
    else
        optimalValue(iAlgorithm) = solution{iAlgorithm}.f_k;
    end
end

[~, minSolutionIdx] = min(optimalValue);
realTime = zeros(length(OptimizationProblem), 1);

for iAlgorithm = 1 : length(OptimizationProblem)
    realTime(iAlgorithm) = solution{iAlgorithm}.REALtime;
end
[realTimeMax realTimeMaxIdx] = max(realTime);
[realTimeMin realTimeMinIdx] = min(realTime);

sol_time = toc;

disp(['-- Solving time: ' num2str(sol_time)]);

if nAlgorithms > 1
    isInteriorDirect = strcmp(Parameters.Controller.algorithmName{minSolutionIdx}, ...
        'Interior/Direct');
    if isInteriorDirect
        stringAlgorithm = [Parameters.Controller.algorithmName{minSolutionIdx} ...
            ' BAR MURULE: ' num2str(solution{minSolutionIdx}.Prob.KNITRO.options.BAR_MURULE)];

    else
        stringAlgorithm = Parameters.Controller.algorithmName{minSolutionIdx};
    end

disp(['-- Best algorithm: ' stringAlgorithm]);
disp(['-- Longest  computation time: ' num2str(realTimeMax) ...
    's   idx: ' num2str(realTimeMaxIdx)]);
disp(['-- Shortest computation time: ' num2str(realTimeMin) ...
    's   idx: ' num2str(realTimeMinIdx)]);
disp(['-- Average  computation time: ' num2str(mean(realTime)) 's']);

normalizedOptimal = abs(optimalValue / min(optimalValue));
valueToConsider = normalizedOptimal(~isinf(normalizedOptimal));
disp(['-- Minimum of the optimal: ' num2str(min(optimalValue))]);
disp(['-- Maximum of the normalized optimal: ' ...
    num2str(max(normalizedOptimal)) ' (' num2str(max(valueToConsider)) ')']);
disp(['-- Average of the normalized optimal: ' ...
    num2str(mean(normalizedOptimal)) ' (' num2str(mean(valueToConsider)) ')']);
disp(['-- STD of the normalized optimal: ' ...
    num2str(std(normalizedOptimal)) ' (' num2str(std(valueToConsider)) ')']);
else
    disp(['-- Computation time: ' num2str(realTime) 's']);
end
OptimalSolution = solution{minSolutionIdx};
Parameters.Controller.ControlInput = ...
    subs(Parameters.Controller.Variables, OptimalSolution);
% recast the crac power consumption so that it is similar to other
% powerconsumption values
nTimeSteps = size(Parameters.Controller.ControlInput.normalizedCracPowerConsumption, 1);
cracPowerCells = cell(nTimeSteps, 1);
cracPowerArrayTemp = cell2mat(Parameters.Controller.ControlInput.normalizedCracPowerConsumption);
for iTimeStep = 1 : nTimeSteps
    cracPowerCells{iTimeStep} = cracPowerArrayTemp(iTimeStep, :)';
end
    
previousSolution = OptimalSolution.x_k;

% rescale variables 
Parameters.Controller.ControlInput.zonePowerConsumption = cellfun( ...
    @(x) x / Parameters.Controller.powerScalingCoefficient, ...
    Parameters.Controller.ControlInput.normalizedZonePowerConsumption, ...
    'UniformOutput', false);
Parameters.Controller.ControlInput.cracPowerConsumption = cellfun( ...
    @(x) x / Parameters.Controller.powerScalingCoefficient, ...
    cracPowerCells, 'UniformOutput', false);
Parameters.Controller.ControlInput.dataCenterPowerConsumption = cellfun( ...
    @(x) x / Parameters.Controller.powerScalingCoefficient, ...
    Parameters.Controller.ControlInput.normalizedDataCenterPowerConsumption, ...
    'UniformOutput', false);
Parameters.Controller.ControlInput.queueLength = cellfun( ...
    @(x) x * Parameters.Controller.timeStep, ...
    Parameters.Controller.ControlInput.normalizedQueueLength, ...
    'UniformOutput', false);
Parameters.Controller.ControlInput.newQueueLength = cellfun( ...
    @(x) x * Parameters.Controller.timeStep, ...
    Parameters.Controller.ControlInput.normalizedNewQueueLength, ...
    'UniformOutput', false);
end


function Parameters = generateandsetpredicteduncontrolledinput(Parameters, iTime)
    % ratio between the controller time step (in seconds) and the simulation
    % time step (in seconds)
        
    timeStepRatio = Parameters.Controller.timeStep / ...
        Parameters.Simulation.timeStep;
    lengthTime = length(Parameters.Simulation.time);
    
    for iHorizonTimeStep = 1 : Parameters.Controller.nHorizonTimeSteps
        currentTimeIndex = iTime + (iHorizonTimeStep - 1) * timeStepRatio;
        finalTimeIndex = min(currentTimeIndex + timeStepRatio, lengthTime);
        % force currentTimeIndex to be lower than lengthTime
        currentTimeIndex = min(currentTimeIndex, lengthTime); 
        
        % job arrival rate
        averageJobArrivalRateValue = ...
            mean(Parameters.Simulation.jobArrivalRateToDataCenter(currentTimeIndex : finalTimeIndex));
        variableIdx = ...
                Parameters.Controller.PredictedVariablesIdx(iHorizonTimeStep).jobArrivalRateToDataCenter;
        Parameters.Controller.OptimizationProblem.x_L(variableIdx) = ...
            averageJobArrivalRateValue;
        Parameters.Controller.OptimizationProblem.x_U(variableIdx) = ...
            averageJobArrivalRateValue;
        
        if Parameters.Controller.considerCostOfElectricity 
            % cost of power consumption
            averageElectricityCostLow = ...
                mean(Parameters.Simulation.electricityCostLow(currentTimeIndex : finalTimeIndex));
            % cost is in [$/J] we map it into [$/time sample] and scale
            % according to the power scaling coefficient
            normalizedAverageElectricityCostLow = averageElectricityCostLow / ...
                Parameters.Controller.powerScalingCoefficient * ...
                Parameters.Controller.timeStep;
            variableIdx = ...
                    Parameters.Controller.PredictedVariablesIdx(iHorizonTimeStep).normalizedElectricityCostLow;
            Parameters.Controller.OptimizationProblem.x_L(variableIdx) = ...
                normalizedAverageElectricityCostLow;
            Parameters.Controller.OptimizationProblem.x_U(variableIdx) = ...
                normalizedAverageElectricityCostLow;

            % cost of power consumption
            averageElectricityCostHigh = ...
                mean(Parameters.Simulation.electricityCostHigh(currentTimeIndex : finalTimeIndex));
            % cost is in [$/J] we map it into [$/time sample] and scale
            % according to the power scaling coefficient
            normalizedAverageElectricityCostHigh = averageElectricityCostHigh / ...
                Parameters.Controller.powerScalingCoefficient * ...
                Parameters.Controller.timeStep;
            variableIdx = ...
                    Parameters.Controller.PredictedVariablesIdx(iHorizonTimeStep).normalizedElectricityCostHigh;
            Parameters.Controller.OptimizationProblem.x_L(variableIdx) = ...
                normalizedAverageElectricityCostHigh;
            Parameters.Controller.OptimizationProblem.x_U(variableIdx) = ...
                normalizedAverageElectricityCostHigh;

            % cost of power consumption
            averagePowerConsumptionThreshold = ...
                mean(Parameters.Simulation.powerConsumptionThreshold(currentTimeIndex : finalTimeIndex));
            normalizedAveragePowerConsumptionThreshold = averagePowerConsumptionThreshold * ...
                Parameters.Controller.powerScalingCoefficient;
            variableIdx = ...
                    Parameters.Controller.PredictedVariablesIdx(iHorizonTimeStep).normalizedPowerConsumptionThreshold;
            Parameters.Controller.OptimizationProblem.x_L(variableIdx) = ...
                normalizedAveragePowerConsumptionThreshold;
            Parameters.Controller.OptimizationProblem.x_U(variableIdx) = ...
                normalizedAveragePowerConsumptionThreshold;
        end
    end
end