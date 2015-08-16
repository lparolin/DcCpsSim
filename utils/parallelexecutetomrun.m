function [Solution ExecutionTime] = parallelexecutetomrun(algorithm, ...
    barMuRule, computationalPreviousSolution, Prob, solver, isDebug)
%PARALLELEXECUTETOMRUN Execute multiple sessions of tomRun in parallel.


% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 22nd 2011
ExecutionTime = struct;

if ~isempty(computationalPreviousSolution)
    Prob.x_0 = computationalPreviousSolution;
end

nAlgorithms = length(algorithm);
computationalOptProblem = cell(nAlgorithms, 1);
for i = 1 : nAlgorithms
    computationalOptProblem{i} = Prob;
    computationalOptProblem{i}.KNITRO.options.ALG = algorithm(i);
    if (i <= length(barMuRule)) && (algorithm(i) ~= 3)
        computationalOptProblem{i}.KNITRO.options.BAR_MURULE = barMuRule(i);
    end
end

controllerSolver = solver;
solutionTemp = cell(nAlgorithms, 1);
if isDebug
    for i = 1 : nAlgorithms
        PrintLevel = 2;  % no output shown
        solutionTemp{i} = tomRun(controllerSolver, ...
            computationalOptProblem{i}, PrintLevel);
        keyboard;
    end
else
    parfor i = 1 : nAlgorithms
        PrintLevel = 0;  % no output shown
            solutionTemp{i} = tomRun(controllerSolver, ...
        computationalOptProblem{i}, PrintLevel);
    end
end


computationalOptimalValue = zeros(nAlgorithms, 1);

for i = 1 : nAlgorithms
    if solutionTemp{i}.ExitFlag ~= 0
        computationalOptimalValue(i) = +Inf;
    else
        computationalOptimalValue(i) = solutionTemp{i}.f_k;
    end
end

[~, minSolutionIdx] = min(computationalOptimalValue);
realTime = zeros(nAlgorithms, 1);

for iAlgorithm = 1 : nAlgorithms
    realTime(iAlgorithm) = solutionTemp{iAlgorithm}.REALtime;
end
[realTimeMax realTimeMaxIdx] = max(realTime);
[realTimeMin realTimeMinIdx] = min(realTime);
ExecutionTime.realTimeMax = realTimeMax;
ExecutionTime.realTimeMaxIdx = realTimeMaxIdx;
ExecutionTime.realTimeMin = realTimeMin;
ExecutionTime.realTimeMinIdx = realTimeMinIdx;
ExecutionTime.realTimeMean = mean(realTime);


Solution = solutionTemp{minSolutionIdx};
Solution.idx = minSolutionIdx;
end

