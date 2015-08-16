function Parameters = initializesimulation(Parameters)
%initializesimulation(Parameters) allocates variables for 
% the simulation.


% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 20th 2011


%% This code needs major review
% nNodes = DcData.nZones + DcData.nCracs + DcData.E1 + DcData.E2;
% nPhysicalNodes = DcData.nZones + DcData.nCracs + DcData.E1;
% 
% Simulation = struct;
% 
% Simulation.time = 0 : Parameters.timeStep : Parameters.finalTime;
% lengthTime = length(Simulation.time);
% Simulation.T = zeros(nNodes, lengthTime + 1);   
% Simulation.Tin = zeros(nNodes, lengthTime + 1);
% Simulation.pw = zeros(nPhysicalNodes, lengthTime);
% Simulation.chi = zeros(DcData.nCracs, lengthTime);
% Simulation.l = zeros(DcData.nZones, DcData.nJobClasses, lengthTime + 1);
% Simulation.l_tilde = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.s = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.cqos = zeros(lengthTime, 1);
% Simulation.pi = zeros(DcData.nZones, DcData.nHwClasses, lengthTime);
% Simulation.arrival = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.departure = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.muf = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.cop = zeros(DcData.nCracs, lengthTime);
% Simulation.total_cost = zeros(lengthTime,1);
% Simulation.Tref = zeros(DcData.nCracs, lengthTime);
% Simulation.rho = zeros(DcData.nZones, DcData.nJobClasses, lengthTime);
% Simulation.req_resources_tmp = zeros(DcData.nZones, DcData.nHwClasses);
% Simulation.assgnd_resources_tmp = zeros(DcData.nZones, DcData.nHwClasses);
% 
% 
% % set initial values
% TmpVar = struct;
% TmpVar.name = 'outputTemperature';
% TmpVar.nodeId = DcData.zoneIdx;
% thermalIdx = getstateindex(DcData, TmpVar);
% Simulation.T(DcData.zoneIdx, 1) = x0(thermalIdx);
% 
% TmpVar.nodeId = DcData.cracIdx;
% thermalIdx = getstateindex(DcData, TmpVar);
% Simulation.T(DcData.cracIdx, 1) = x0(thermalIdx);
% 
% TmpVar.nodeId = DcData.environmentClassOneIdx;
% thermalIdx = getstateindex(DcData, TmpVar);
% Simulation.T(DcData.environmentClassOneIdx, 1) = x0(thermalIdx);
% 
% Simulation.Tin(:, 1) = DcData.psi{end} * Simulation.T(:, 1);
% TmpVar.name = 'queueLength';
% TmpVar.nodeId = DcData.zoneIdx;
% for iJobClass = 1 : DcData.nJobClasses
%     TmpVar.jobClass = iJobClass;
%     cyberIdx = getstateindex(DcData, TmpVar);
%     Simulation.l(:, iJobClass, 1) = x0(cyberIdx);
% end

%% Quick fix
Parameters.Simulation.time = 0 : Parameters.Simulation.timeStep : Parameters.Simulation.finalTime;
Simulation = Parameters.Simulation;
DcData = Parameters.DcData;

%% Old code
% compute discrete time evolution matrices
Simulation.Act = cell(length(DcData.psi),1);
Simulation.B1ct = cell(length(DcData.psi),1);
Simulation.B2ct = cell(length(DcData.psi),1);
Simulation.Adt = cell(length(DcData.psi),1);
Simulation.B1dt = cell(length(DcData.psi),1);
for kk = 1 : length(DcData.psi)
    %%%%% WORKAROUND %%%%%%
    if length(DcData.psi) == 1
        isCracActive = true(DcData.nCracs, 1);
    else
        isCracActive = (crac_active_from_state(kk, DcData.nCracs)==1);
    end
    %%%%%%%%%%%%%%%%%%%%%%%
    thermalTimeConstantTmp = DcData.thermalTimeConstant;
    thermalTimeConstantTmp(DcData.cracIdx) = ...
        thermalTimeConstantTmp(DcData.cracIdx) .* double(~isCracActive);
    
    %%% THIS WAS THE ORIGINAL CODE -- NOT WORKING %%
%     Simulation.Act{kk} = -diag(DcData.thermalTimeConstant) + ...
%         diag(thermalTimeConstantTmp) * DcData.psi{kk};
%     envNodeIdx = DcData.nZones + DcData.nCracs + 1 : ...
%         length(DcData.powerToTemperatureCoefficient{kk});
%     Simulation.B1ct{kk} = diag([ ...
%         DcData.powerToTemperatureCoefficient{kk}(DcData.zoneIdx); ...
%         double(isCracActive) .* DcData.thermalTimeConstant(DcData.cracIdx); ...
%         DcData.powerToTemperatureCoefficient{kk}(envNodeIdx)]);
%     %Simulation.B1ct{kk} = sparse(Simulation.B1ct{kk})
%     continuousTimeThermalSystem = ss(Simulation.Act{kk}, ...
%         Simulation.B1ct{kk} , DcData.psi{kk}, []);
%     discreteTimeThermalSystem = c2d(continuousTimeThermalSystem, ...
%         Parameters.timeStep, 'zoh');
%     Simulation.Adt{kk} = discreteTimeThermalSystem.a;
%     Simulation.B1dt{kk} = discreteTimeThermalSystem.b;
    
    %%% WORKAROUND - NO GUARANTEES ON CORRECTNESS
    Simulation.Act{kk} = -diag(DcData.thermalTimeConstant) + ...
        diag(thermalTimeConstantTmp) * DcData.psi;
    envNodeIdx = DcData.nZones + DcData.nCracs + 1 : ...
        length(DcData.powerToTemperatureCoefficient);
    Simulation.B1ct{kk} = diag([ ...
        DcData.powerToTemperatureCoefficient(DcData.zoneIdx); ...
        double(isCracActive) .* DcData.thermalTimeConstant(DcData.cracIdx); ...
        DcData.powerToTemperatureCoefficient(envNodeIdx)]);
    %Simulation.B1ct{kk} = sparse(Simulation.B1ct{kk})
    continuousTimeThermalSystem = ss(Simulation.Act{kk}, ...
        Simulation.B1ct{kk} , DcData.psi, []);
    discreteTimeThermalSystem = c2d(continuousTimeThermalSystem, ...
        Simulation.timeStep, 'zoh');
    Simulation.Adt{kk} = discreteTimeThermalSystem.a;
    Simulation.B1dt{kk} = discreteTimeThermalSystem.b;
end

Simulation.finalTime = Parameters.Simulation.finalTime;
Simulation.timeStep = Parameters.Simulation.timeStep;
%%% WORKAROUND
% Simulation.simulationDelay = Parameters.simulationDelay;
Simulation.simulationDelay = 0;
%%%%
Simulation.jobArrivalRateMax = Parameters.DcData.jobArrivalRateMax;

%% Copy back the structure
Parameters.Simulation = Simulation;
end

