% Luca Parolini
% <lparolin@andrew.cmu.edu>

% 13th Apr. 2011

% Generate baseline simulation
% This code takes data center information from previously executed
% simulations and generate new simulation considering a baseline
% controller.

clear all;
close all
clc;

folderNameArray = {'./7', './2', './5'};

for iFolderNameArray = 1 : length(folderNameArray)
    clear SimulationData; % free memory
    SimulationData = struct;
    folderName = folderNameArray{iFolderNameArray};
    coordinatedData = load([folderName '/coordinated_data']);
    
    % generate new variables for the baseline controller
    SimulationData = coordinatedData.SimulationData;
    DcData = coordinatedData.DcData;
    Parameters = coordinatedData.Parameters;
    
    %% update the simulation
    lengthTime = length(SimulationData.time);
    iTime = 1;
    while iTime <= lengthTime
        if iTime > 1
            updateSimulationTime = toc;
            disp(['Update simulation: ' num2str(updateSimulationTime)]);
            disp(' ');
        end
        disp(['Synthesize new control input. Iteration: ' ...
            num2str(iTime) ' of ' num2str(lengthTime)]);
        ControlInput = synthesizebaselinecontrolinput(DcData, SimulationData, ...
            Controller, iTime);
        [SimulationData iTime] = updatesimulationdata(DcData, SimulationData, ...
            ControlInput, Parameters, iTime);
    end
    
    
    
    
    
    time = coordinatedData.SimulationData.time;
    T = zeros(size(coordinatedData.SimulationData.T);
    Tin = zeros(size(coordinatedData.SimulationData.T);
    pw = zeros(size(coordinatedData.SimulationData.T);
    l = zeros(size(coordinatedData.SimulationData.l);
    l_tilde = zeros(size(coordinatedData.SimulationData.l_tilde);
    pi = zeros(size(coordinatedData.SimulationData.pi);
    arrival = zeros(size(coordinatedData.SimulationData.arrival);
    departure = zeros(size(coordinatedData.SimulationData.departure);
    muf = zeros(size(coordinatedData.SimulationData.muf);
    Tref = zeros(size(coordinatedData.SimulationData.Tref);
    rho = zeros(size(coordinatedData.SimulationData.rho);
    
    Act  = 
    
    B1ct: {[12x12 double]}
                    B2ct: {[]}
                     Adt: {[12x12 double]}
                    B1dt: {[12x12 double]}
               finalTime: 432000
                timeStep: 6
         simulationDelay: 3
       jobArrivalRateMax: [2x1 double]
          jobArrivalRate: [2x72001 double]
                alpha_el: [72001x1 double]
                 beta_el: [72001x1 double]
             el_cost_bar: [72001x1 double]
    
    
    
    
    
    return
end