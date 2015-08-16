% Main script of DcSim, a data center simulator.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

%% clear workspace
clear all
close all
clc

Parameters = struct;

if 1
%% data center case to study
% [pwd '/data_center_data/IFAC_layout.mat'];

% define the path to the .mat file that contains the DcData struct
Parameters.dataCenterDataPath = [pwd '/data_center_data/DCO_like/dco_data.mat'];

Parameters.baseDataAndFigureFolder = [pwd '/data_center_data/DCO_like/data_and_figure'];
Parameters.simulationParameterFile = [pwd '/data_center_data/DCO_like/simulation_parameters.m'];
Parameters.defineGraphFile = [pwd '/data_center_data/DCO_like/definegraph.m'];

%% Set path
startup_dc_simulator();

%% Generate the function handle
Parameters.definesimulationparameter = createfunctionhandlers(Parameters.simulationParameterFile);
Parameters.generategraph = createfunctionhandlers(Parameters.defineGraphFile);

%% define the parameters for this simulation
Parameters = Parameters.definesimulationparameter(Parameters);
Parameters.basePathToUse = [Parameters.baseDataAndFigureFolder '/' ...
    Parameters.Controller.controllerType '/' ...
    datestr(now, 'mm_dd_yyyyTHH_MM_SS')];
Parameters.figureFolderName = [Parameters.basePathToUse '/figure'];

%% initialize the log manager
initializelogmanager(Parameters);
    
%% initialize other components
Parameters = loadconstant(Parameters);
Parameters = loadandpreparedatacenterdata(Parameters);
Parameters = initializegraph(Parameters);
Parameters = initializesimulation(Parameters);
Parameters = initializecontroller(Parameters);

else
    startup_dc_simulator();
    rootPath = pwd;
    cd('./controllers/data_center_level/coordinated/');
	startup_coordinated_controller;
	cd(rootPath);    
    load('temp_problem');
end

%% simulation
Parameters.Simulation.ticStart = tic;
lengthTime = length(Parameters.Simulation.time);

iTime = 1;
synthesizenewcontrolinput = Parameters.Controller.synthesizecontrolinput;
RefreshGraphTimer = timer('TimerFcn', @(x,y)drawnow('expose'), 'Period', 1);
start(RefreshGraphTimer);

while iTime <= lengthTime
    isNewInputRequired = mod(Parameters.Simulation.time(iTime), ...
        Parameters.Controller.timeStep) == 0;
    if isNewInputRequired
        if iTime > 1
            updateSimulationTime = toc;
            logcomment(['Update simulation: ' num2str(updateSimulationTime)]);
        end
        logcomment(['Synthesize new control input. Iteration: ' ...
            num2str(iTime) ' of ' num2str(lengthTime)]);
        Parameters = synthesizenewcontrolinput(Parameters, iTime);
        tic
        Parameters = applynewcontrolinput(Parameters, iTime);
    end
    [Parameters iTime] = updatesimulationdata(Parameters, iTime);
    Parameters = updategraph(Parameters, iTime);
    iTime = iTime + 1;
end
Parameters.Simulation.elapsedTime = toc(Parameters.Simulation.ticStart);

stop(RefreshGraphTimer);
delete(RefreshGraphTimer);
clear('RefreshGraphTimer');

% convert time values in hrs, min, sec
if Parameters.Simulation.elapsedTime > 3600
    timeHr = floor(Parameters.Simulation.elapsedTime / 3600);
    remainingTime = Parameters.Simulation.elapsedTime - timeHr * 3600;
    timeMin = floor(remainingTime / 60);
    timeSec = remainingTime - timeMin * 60;
    logcomment(['Time to complete the simulation: ' ...
        num2str(timeHr) ' hr  ' num2str(timeMin) ' min  ' num2str(round(timeSec)) ' s']);
else
    
    if Parameters.Simulation.elapsedTime > 60
        timeMin = floor(Parameters.Simulation.elapsedTime/ 60);
        timeSec = Parameters.Simulation.elapsedTime - timeMin * 60;
        logcomment(['Time to complete the simulation: ' ...
            num2str(timeMin) ' min  ' num2str(round(timeSec)) ' s']);
    else
        timeMin = floor(Parameters.Simulation.elapsedTime  / 60);
        timeSec = remainingTime - timeMin * 60;
        logcomment(['Time to complete the simulation: ' ...
            num2str(Parameters.Simulation.elapsedTime) ' s']);
    end
end

logcomment('Simulation completed.');

logcomment('Saving figures...');
savefigure(Parameters);
logcomment('Figure saved. Saving simulation data...');
save([Parameters.basePathToUse '/variables']);
closelogcomment();
disp('All data and figures saved.');