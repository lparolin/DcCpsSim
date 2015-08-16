function Parameters = simulation_parameters(Parameters)
%SIMULATION_PARAMETERS Define the parameters for the simulation.

Parameters.nJobClasses = 1;
Parameters.nHwClasses = 1;
Parameters.normalizedJobArrivalRateMax = 0.4;    % nJobClasses X 1 vector
% when it equals 1, then all of the available resources in the data
% center are dedicated to execute job in that class
Parameters.normalizedElectricityCostMax = 1;
Parameters.normalizedQoSCostMax = -1;
Parameters.normalizedDropCostMax = 20;
Parameters.queueLengthMax = 4;      % This constraint is used by the optimization 
%   algorithm to bound the area where to look for optimal solutions

%% Simulation parameters
Parameters.Simulation = struct;
Parameters.Simulation.timeStep = 5;                                       % [s]
Parameters.Simulation.finalTime = Parameters.Simulation.timeStep * 3000;  % [s]
Parameters.Simulation.InitialState = struct;
Parameters.Simulation.InitialState.zoneOutputTemperature = 28;
Parameters.Simulation.InitialState.cracOutputTemperature = 24;
Parameters.Simulation.InitialState.queueLength = 0.1;
Parameters.Simulation.relativeControlTolerance = 5e-6;

%% Controller parameters
Parameters.Controller = struct;
Parameters.Controller.isParallelExeuctionRequired = false;
Parameters.Controller.poolSize = 1;       % number of workers for parallel code execution
Parameters.Controller.controllerType = 'coordinated'; %'baseline'; %'coordinated'; % 'uncoordinated', 'baseline', 'stabilized_coordinated'
Parameters.Controller.nHorizonTimeSteps = 8;
Parameters.Controller.timeStep = 15 * 60;% floor(Parameters.Simulation.finalTime / 100);               % [s]
Parameters.Controller.cracApproximationInitialTin = 31;
Parameters.Controller.cracApproximationInitialTout = 26;
Parameters.Controller.thermalSystemSingularvalueRatioThreshold = 0.05;
Parameters.Controller.trapezoidalApproximationNumberPoints = 3; % number of points
Parameters.Controller.trapezoidalApproximationOrder = 2; % number of points
% to use during the crac power consumption trapezoidal, set to +Inf to use
% the original, nonapproximated, CRAC power consumption function
% approximation

%% Options for the numeric solver
Parameters.Controller.Options.type = 'con';
Parameters.Controller.Options.solver = 'knitro';
Parameters.Controller.Options.use_d2c = 1;
Parameters.Controller.Options.use_H = 1;
Parameters.Controller.Options.scale = 1;
Parameters.Controller.Options.Prob.PriLevOpt = 1;
Parameters.Controller.Options.Prob.LargeScale = 1;
Parameters.Controller.Options.Prob.KNITRO.options.ALG = 1;
% Parameters.Controller.Options.Prob.KNITRO.options.DIRECTINTERVAL = 5; % Default 10
% Parameters.Controller.Options.Prob.KNITRO.options.LINSOLVER = 3;
% Parameters.Controller.Options.Prob.KNITRO.options.HONORBNDS = 1;  % enforces that the initial
                                            % point and all of the subsequent 
                                            % iterations satisfie the simple bounds 
                                            % on the variables
% Parameters.Controller.Options.Prob.KNITRO.options.MAXCGIT = 50;
 Parameters.Controller.Options.Prob.KNITRO.options.BAR_INITPT = 1; % shift initial point to improve the 
                                            % barrier alg. performance

% Parameters.Controller.Options.Prob.KNITRO.options.BAR_MAXBACKTRACK = 12; % Indicates the maximum allowable 
                                            % number of backtracks during the 
                                            % linesearch of the Interior/Direct 
                                            % algorithm before reverting to a 
                                            % CG step. Default 3

                                            
% Parameters.Controller.Options.Prob.KNITRO.options.BAR_MAXREFACTOR = 3; % indicates the maximum number 
                                              % of refactorizations of the KKT 
                                              % system per iteration of the 
                                              % Interior/Direct algorithm 
                                              % before reverting to a CG step.
                                              % Default 0

Parameters.Controller.Options.Prob.KNITRO.options.BLASOPTION = 1;
% Parameters.Controller.Options.Prob.KNITRO.options.DELTA = 10;       % Specifies the initial trust 
                                              % region radius scaling factor 
                                              % used to determine the initialtrust 
                                              % region size. Default value: 1.0e0.
% Parameters.Controller.Options.Prob.KNITRO.options.FEASTOL = 1.0e-7;
Parameters.Controller.Options.Prob.KNITRO.options.GRADOPT = 1;        % user provide gradient
Parameters.Controller.Options.Prob.KNITRO.options.HESSOPT = 1;        % user provide Hessian
Parameters.Controller.Options.Prob.KNITRO.options.MAXCROSSIT = 5;     % max cross iterations
Parameters.Controller.Options.Prob.KNITRO.options.MAXTIMEREAL = 40;   % time in sec. before stopping
Parameters.Controller.Options.Prob.KNITRO.options.MAXTIMECPU = 45;    % time in sec. before stopping
Parameters.Controller.Options.Prob.KNITRO.options.MSMAXTIMEREAL = 80; % time in sec. before stopping
Parameters.Controller.Options.Prob.KNITRO.options.MSMAXTIMECPU = 100; % time in sec. before stopping
Parameters.Controller.Options.Prob.KNITRO.options.MSENABLE = 1;
Parameters.Controller.Options.Prob.KNITRO.options.MSMAXSOLVES = 40;
Parameters.Controller.Options.Prob.KNITRO.options.OBJRANGE = 1e6;
%Parameters.Controller.Options.Prob.KNITRO.options.OPTTOL  = 1e-12;   % specifies the final relative 
%                                                 % stopping tolerance for the 
%                                                 % KKT (optimality) error
Parameters.Controller.Options.Prob.KNITRO.options.SCALE = 1;
% Parameters.Controller.Options.Prob.KNITRO.options.MAXIT = 1000; 

end

