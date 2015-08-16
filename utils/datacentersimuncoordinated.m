% Data center simulator
% Luca Parolini <lparolin@andrew.cmu.edu> 
% 7th Feb. 2011
% 

function datacentersimuncoordinated

clc
clear all
close all
diary off

%% simulation variables
isDebugController = 0;      % debug the controller
isParallelExeuctionRequired = 1; poolSize = 8;       % number of workers for parallel code execution
layoutId = 15;
controllerType = 'uncoordinated'; % 'uncoordinated', 'baseline'
diaryFileName = ['./logs/datacentersimulation_' controllerType '_' ...
    datestr(now, 'yyyymmddTHHMMSS') '.log'];
diary(diaryFileName);

switch controllerType
    case 'coordinated'
        initializecontroller = @initializecoordinatedcontroller;
        synthesizecontrolinput = @synthesizecoordinatedcontrolinput;
    case 'uncoordinated'
        initializecontroller = @initializeuncoordinatedcontroller;
        synthesizecontrolinput = @synthesizeuncoordinatedcontrolinput;
        
    otherwise
        disp('Unknown controller');
        return
end


%% load data center data
DcData = initializedatacenterdata(layoutId);
DcData.controllerType = controllerType;
% compute cyber-physical index
disp(['Cyberphyisical index: ' num2str(DcData.cyberPhysicalIndex)]);

DcData.zoneTinMax = 27 * ones(DcData.nZones, 1);
DcData.zoneTinMin = 0 * ones(DcData.nZones, 1);
DcData.trefMin = 1 * ones(DcData.nCracs, 1);       % [C]
DcData.trefMax = 28 * ones(DcData.nCracs, 1);        % [C]

% check thermal properties of the data center at the thermal equilibrium
DataAtThermalEquilibrium = thermalpropertiesatequilibrium(DcData);

% show thermal properties
nDigits = 4;
disp('zonePwMax cracTrefMin');
strTinLabel = 'Tin (C)';
strTinValues = num2str(DataAtThermalEquilibrium.tinPowerMaxTrefMin, ...
    nDigits);
strTin = {strTinLabel; '-------------'; strTinValues};
strToutLabel = 'Tout (C)';
strToutValues = num2str(DataAtThermalEquilibrium.toutPowerMaxTrefMin, ...
    nDigits);
strTout = {strToutLabel, '--------', strToutValues};
disp([char(strTin) char(strTout)]);

%% Simulation and controller parameters
Parameters = struct;
Parameters.Simulation.finalTime = 5 * 24 * 60 * 60;    % [s]
Parameters.Simulation.timeStep = 0.1 * 60;             % [s]
Parameters.Simulation.simulationDelay = 3;             % [??] 
Parameters.Simulation.jobArrivalRateMax = 12 * 4 * ...
    ones(DcData.nJobClasses, 1);
%Parameters.Simulation.jobArrivalRateMax = 5 * ...
%    ones(DcData.nJobClasses, 1);
Parameters.Simulation.electricityCostMax = 50;          % [$ / MWh];
Parameters.Controller.nHorizonTimeSteps = 1;
Parameters.Controller.arrivalDelay = 3;
Parameters.Controller.timeStep = 30 * 60;               % [s] 30 * 60
Parameters.Controller.ratioOptimalResourceAllocation = 1;
Parameters.Controller.isDebugController = isDebugController;

% compute cost coefficients
maxZonePowerConsumption = sum(DcData.hwUsageToPowerCoefficient .* ...
    DcData.hwResourceMax, 2);
Parameters.Controller.maxZonePowerConsumption = maxZonePowerConsumption;
maxJouleCost = Parameters.Simulation.electricityCostMax /(3600*1e6); % [$/J]
maxZonePowerCost = maxJouleCost * maxZonePowerConsumption;         % [$/J]
Parameters.Simulation.maxZonePowerCost = maxZonePowerCost;      % [$/J]
Parameters.Simulation.scaledMaxZoneJouleCost = 1e-3;
Parameters.Simulation.energyScalingFactor = ...
    maxJouleCost / Parameters.Simulation.scaledMaxZoneJouleCost;
Parameters.Simulation.scaledMaxZoneEnergyCost = maxZonePowerConsumption * ...
    Parameters.Simulation.scaledMaxZoneJouleCost * ... 
    Parameters.Simulation.timeStep;

% Parameters.Controller.Q_drop = eye(DcData.nJobClasses) * 1e5 * 2e2;
% Parameters.Controller.Q_qos = eye(DcData.nHwClasses) * 2 * 1e5 * 2e2;

maxHwResourcesDifferencePerZone = max( sum(DcData.hwResourceMax, 2));
minHwResourcesDifferencePerZone = 0;
averageHwResourcesDifferencePerZone = (maxHwResourcesDifferencePerZone + ...
    minHwResourcesDifferencePerZone) / 2;
% Parameters.Controller.Q_qos = eye(DcData.nHwClasses) * 100 * ...
%    max(Parameters.Simulation.scaledMaxZoneEnergyCost) / ...
%    averageHwResourcesDifferencePerZone^2;
Parameters.Controller.Q_qos = eye(DcData.nHwClasses) * 1 * ...
    maxJouleCost * sum(maxZonePowerConsumption);
Parameters.Controller.Q_drop = maxJouleCost * sum(maxZonePowerConsumption) * 1e3;

initialQueueLength = 0 * ones(DcData.nZones * DcData.nJobClasses, 1);
initialZoneOutputTemperature = 26 * ones(DcData.nZones + DcData.nCracs + ...
    DcData.E1, 1); 
x0 = [initialQueueLength; initialZoneOutputTemperature];
Parameters.Simulation.temperatureIdx = ...
    length(initialQueueLength) + 1 : length(x0);

%% initialize simulation
SimulationData = initializesimulation(DcData, Parameters.Simulation, x0);
lengthTime = length(SimulationData.time);

%% initialize controller
Controller = initializecontroller(DcData, SimulationData, ...
    Parameters.Controller);

%% uncontrollable inputs
% arrival rate
SimulationData.jobArrivalRate = generatearrivalrate(DcData, Parameters);
%SimulationData.jobArrivalRate = repmat( ...
%    Parameters.Simulation.jobArrivalRateMax, 1, ...
%    lengthTime);
% electricity cost
%SimulationData.alpha_el = Parameters.Simulation.scaledMaxZoneJouleCost * ...
%    ones(lengthTime, 1);
SimulationData.alpha_el = maxJouleCost * ones(lengthTime, 1);
SimulationData.beta_el = SimulationData.alpha_el;
SimulationData.el_cost_bar = 40e3*ones(lengthTime, 1);

% load arrival noise
% load('arrival_noise_mat');
% if (size(arrival_noise,1) ~= nJobClasses) || (size(arrival_noise,2) ~= length(time))
%   disp('arrival_noise has to be regenerated...');
%   arrival_noise = rand(nJobClasses, length(time))*2-1;
%   save arrival_noise_mat arrival_noise;
% end

%% open matlab pool
isPoolRightSize = matlabpool('size') == poolSize;
if (~isPoolRightSize) && (isParallelExeuctionRequired)
    isPoolOpen = matlabpool('size') > 0;
    if isPoolOpen
        matlabpool close;
    end
    matlabpool('open', poolSize);
end

%% simulation
lengthTime = length(SimulationData.time);
%for iTime = 1 : lengthTime
iTime = 1;
while iTime <= lengthTime
    isNewInputRequired = mod(SimulationData.time(iTime), ...
        Parameters.Controller.timeStep) == 0;
    %if isNewInputRequired
        if iTime > 1
            updateSimulationTime = toc;
            disp(['Update simulation: ' num2str(updateSimulationTime)]);
            disp(' ');
        end
        disp(['Synthesize new control input. Iteration: ' ...
            num2str(iTime) ' of ' num2str(lengthTime)]);
        ControlInput = synthesizecontrolinput(DcData, SimulationData, ...
            Controller, iTime);
        tic
    %end
    [SimulationData iTime] = updatesimulationdata(DcData, SimulationData, ...
        ControlInput, Parameters, iTime);
end

diary off

% comp_time_vec = comp_time_vec(:,1:tmp_counter);
% obj_prob = obj_prob(:,1:tmp_counter);
% crac_state_time = crac_state_time(1:tmp_counter);
% total_pw = sum(pw,1)';
% idx_1 = beta_el < alpha_el;
% el_cost = max(alpha_el.*total_pw, ...
%     (alpha_el-beta_el).*el_cost_bar+ ...
%     beta_el.*total_pw);
%
%tmp_cost = min(alpha_el.*total_pw, ...
%    (alpha_el-beta_el).*el_cost_bar+ ...
%    beta_el.*total_pw);
%el_cost(idx_1)=tmp_cost(idx_1);
% total_cost = total_cost + el_cost;

dataFileName = [controllerType '_data'];
save(dataFileName);

%% plot data cell
disp('Generating graphs...');
generategraphs(DcData, SimulationData, Controller);
    
return

%% compare results
clear all

coord = load('coordinated_data');
uncoord = load('uncoordinated_data');

coordTotalPower = sum(coord.SimulationData.pw, 1)';
uncoordTotalPower = sum(uncoord.SimulationData.pw, 1)';

figureHandler = figure('name','Power consumption comparison','numbertitle','off'); 
    hold on
    plot(coord.SimulationData.time / 3600, ...
        coordTotalPower*1e-3, ...
        'Color','r','LineWidth',2, 'LineStyle', '-');
    plot(uncoord.SimulationData.time / 3600, ...
        uncoordTotalPower*1e-3, ...
        'Color','b','LineWidth',2, 'LineStyle', '--');
    xlabel(['Time (hr)'], 'FontSize',18);
    ylabel('Power Consumption (KW)', 'FontSize',18);
    lgd = legend('Coord.', 'Uncoord.');
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/power_comparison'];
    prepareandsavefigure(figName, axesHandler, figureHandler);


%% old compare results
clear all
close all
clc

coord = load('coord_data');
uncoord = load('uncoord_data');

new_req_res_coord = zeros(coord.nZones,coord.nJobClasses,length(coord.time));
new_assgn_res_coord = zeros(coord.nZones,coord.nJobClasses,length(coord.time));
for tt = 1 : length(coord.time)
    for hh = 1 : coord.nHwClasses
        for rr = 1 : coord.nZones % in order to behave like in the controller-used model
            % here we do not consider arrival and departures
            new_req_res_coord(rr,hh,tt) = sum(vec( ...
                squeeze(coord.l_tilde(rr,:,tt)/coord.Controller.dc.time_step ...
                +coord.arrival(rr,:,tt)/coord.dt)) ...
                .*vec(coord.jobHwRequirement(:,hh)));
            new_assgn_res_coord(rr,hh,tt) = sum(vec(coord.rho(rr,:,tt)).* ...
                vec(coord.normalizedJobHwRequirement(rr,:,hh)));
        end
    end
end

for tt = 1 : length(coord.time)
    for hh = 1 : uncoord.nHwClasses
        for rr = 1 : uncoord.nZones % in order to behave like in the controller-used model
            % here we do not consider arrival and departures
            new_req_res_uncoord(rr,hh,tt) = sum(vec( ...
                squeeze(uncoord.l_tilde(rr,:,tt)/uncoord.Controller.dc.time_step ...
                +uncoord.arrival(rr,:,tt)/uncoord.dt)) ...
                .*vec(coord.jobHwRequirement(:,hh)));
            new_assgn_res_uncoord(rr,hh,tt) = sum(vec(uncoord.rho(rr,:,tt)).* ...
                vec(uncoord.normalizedJobHwRequirement(rr,:,hh)));
        end
    end
end

% prod_mat_coord = tril(ones(length(coord.total_cost)));
% prod_mat_uncoord = tril(ones(length(uncoord.total_cost)));
fig_path = ['../fig/layout' num2str(coord.layoutId)];
if coord.time(end) > 5*60*60; % more than 5 hours, we show hours and not minutes
    time_factor = 60*60;
    time_string = 'hr';
else
    time_factor = 60;
    time_string = 'min';
end
t_min = coord.time(1)/time_factor;
t_max = coord.time(end)/time_factor;
set(0,'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');
time = coord.time;
colors = coord.colors;

fh = figure('name','Tin server','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    lgd_str = [];
    for ttt = 5 : 7
        plot(time/time_factor,coord.Tin(ttt,1:end-1),'Color', colors{ttt}, ...
         'LineWidth',1.5, 'LineStyle', '-','Tag','x');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
    plot(coord.time/time_factor,coord.Tin(ttt+1,1:end-1),'Color', colors{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
   lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    for ttt = 5 : 7
        plot(time/time_factor,uncoord.Tin(ttt,1:end-1),'Color', colors{ttt}, ...
         'LineWidth',2, 'LineStyle', '--','Tag','x');
    end
    plot(uncoord.time/time_factor,uncoord.Tin(ttt+1,1:end-1),'Color', colors{ttt+1}, ...
         'LineWidth',2, 'LineStyle', '--'); 
    
    plot(uncoord.time/time_factor, uncoord.serverTinMax, '-k','LineWidth',2);
    axis([t_min t_max -Inf Inf]);
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('T_{in} (nCracs)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/Tin_server_cmp_5_8'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/Tin_server_cmp_5_8'], 'fig');

fh = figure('name','Tin server_1_4','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    lgd_str = [];
    for ttt = 1 : 3
        plot(time/time_factor,coord.Tin(ttt,1:end-1),'Color', colors{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-','Tag','x');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
    plot(coord.time/time_factor,coord.Tin(ttt+1,1:end-1),'Color', colors{ttt+2}, ...
         'LineWidth',1.5, 'LineStyle', '-');
   lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    for ttt = 1 : 3
        plot(time/time_factor,uncoord.Tin(ttt,1:end-1),'Color', colors{ttt+1}, ...
         'LineWidth',2, 'LineStyle', '--','Tag','x');
    end
    plot(uncoord.time/time_factor,uncoord.Tin(ttt+1,1:end-1),'Color', colors{ttt+2}, ...
         'LineWidth',2, 'LineStyle', '--'); 
    
    plot(uncoord.time/time_factor, uncoord.serverTinMax, '-k','LineWidth',2);
    axis([t_min t_max -Inf Inf]);
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('T_{in} (nCracs)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/Tin_server_cmp_1_4'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/Tin_server_cmp_1_4'], 'fig');
      
fh = figure('name','HW','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    lgd_str = [];
    plot(uncoord.time(1:end-1)/time_factor, squeeze(mean(new_assgn_res_coord(:,1,1:end-1),1))./ ...
        (squeeze(mean(new_req_res_coord(:,1,1:end-1),1))),'Color', 'b', ...
         'LineWidth',2, 'LineStyle', '-');
  
    plot(uncoord.time(1:end-1)/time_factor, squeeze(mean(new_assgn_res_uncoord(:,1,1:end-1),1))./ ...
        (squeeze(mean(new_req_res_uncoord(:,1,1:end-1),1))),'Color', 'r', ...
         'LineWidth',1.5, 'LineStyle', '--');
     
    axis([t_min t_max -Inf Inf]);
    lgd =legend('Coord','Uncoord');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('Assigned/Required', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/hw_coord_uncoord_H1'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/hw_coord_uncoord_H1'], 'fig');    

 
fh = figure('name','Pw_server_crac','numbertitle','off'); 

    set(fh, 'color', 'white');
    hold on
    plot(time/time_factor,sum(coord.pw(1:8,:),1)*1e-3,'Color', 'r', ...
         'LineWidth',1.5, 'LineStyle', '-','Tag','x');
    plot(time/time_factor,sum(coord.pw(9:12,:),1)*1e-3,'Color', 'b', ...
         'LineWidth',1.5, 'LineStyle', '-','Tag','x');
    
    plot(time/time_factor,sum(uncoord.pw(1:8,:),1)*1e-3,'Color', 'r', ...
         'LineWidth',2, 'LineStyle', '--','Tag','x');
    plot(time/time_factor,sum(uncoord.pw(9:12,:),1)*1e-3,'Color', 'b', ...
         'LineWidth',2, 'LineStyle', '--','Tag','x');
    axis([t_min t_max -Inf Inf]);
    lgd = legend('Servers','CRACs');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('Power (KW)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/pw_server_crac_cmp_1_4'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/pw_server_crac_cmp_1_4'], 'fig');
    
    
fh = figure('name','Cqos','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    plot(time/time_factor,coord.cqos,'Color', 'b', ...
         'LineWidth',1.5, 'LineStyle', '-','Tag','x');

    plot(time/time_factor,uncoord.cqos,'Color', 'r', ...
         'LineWidth',2, 'LineStyle', '--','Tag','x');
    axis([t_min t_max -Inf Inf]);
%    lgd = legend('Servers','CRACs');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
%    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('QoS cost', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/qos_cmp_1_4'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/qos_cmp_1_4'], 'fig');   
    
fh = figure('name','avg Tref- avgTout','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    plot(coord.time(1:end-1)/time_factor,mean(coord.Tref(:,1:end-1),1),'Color', 'b', ...
         'LineWidth',1.5, 'LineStyle', '-');
    plot(uncoord.time(1:end-1)/time_factor,mean(uncoord.Tref(:,1:end-1),1),'Color', 'r', ...
         'LineWidth',2, 'LineStyle', '--');
    axis([t_min t_max -Inf Inf]);
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    lgd = legend('Coord','Uncoord');
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('T_{ref} (nCracs)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/avg_tref'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/avg_tref'], 'fig');
    
    
    
    
% fh = figure('name','Costs','numbertitle','off'); 
%     set(fh, 'color', 'white');
%     plot(coord.time(1:end-1)/60,coord.total_cost(1:end-1),'Color', 'r', ...
%             'LineWidth',2, 'LineStyle', '-');
%     hold on
%     plot(uncoord.time(1:end-1)/60,uncoord.total_cost(1:end-1),'Color', 'b', ...
%             'LineWidth',2, 'LineStyle', '--');
%     lgd = legend('Coord', 'Uncoord');
%     axes_h = gca; % gca get the current axis
%     set(axes_h,'YGrid','on');
%     set(axes_h,'TickDir', 'out');2
%     set(axes_h,'Box', 'off' );
%     set(axes_h,'FontSize',14);
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel('Time (min)', 'FontSize',18);
%     ylabel('Incremental cost', 'FontSize',18);
%     set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
%         get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
%     export_fig('./costs', '-eps', '-painters', ...
%             '-native', '-rgb', fh);
%     saveas(fh, './costs', 'fig');
%     
% rel_sav_cost = (-coord.total_cost+uncoord.total_cost)./uncoord.total_cost;
% rel_sav_pw = (-coord.total_pw+uncoord.total_pw)./uncoord.total_pw;
% fh = figure('name','Rel. cost saving','numbertitle','off'); 
%     set(fh, 'color', 'white');
%     hold on
%     plot(coord.time(1:end-1)/60,rel_sav_cost(1:end-1),'Color', 'b', ...
%             'LineWidth',2, 'LineStyle', '-');
% %     plot(coord.time(1:end-1)/60,rel_sav_pw(1:end-1),'Color', 'b', ...
% %             'LineWidth',2, 'LineStyle', '--');
% %     lgd = legend('Cost','Power');
%     axes_h = gca; % gca get the current axis
%     set(axes_h,'YGrid','on');
%     set(axes_h,'TickDir', 'out');
%     set(axes_h,'Box', 'off' );
%     set(axes_h,'FontSize',14);
% %     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel('Time (min)', 'FontSize',18);
%     ylabel('(Uncoord-Coord)/Uncoord', 'FontSize',18);
%     set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
%         get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
%     export_fig('./rel_pw', '-eps', '-painters', ...
%             '-native', '-rgb', fh);
%     saveas(fh, './rel_pw', 'fig');    
    
fh = figure('name','Power consumption','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(coord.time(1:end-1)/time_factor,coord.total_pw(1:end-1)*1e-3,'Color', 'r', ...
            'LineWidth',2, 'LineStyle', '-');
    hold on
    plot(uncoord.time(1:end-1)/time_factor,uncoord.total_pw(1:end-1)*1e-3,'Color', 'b', ...
            'LineWidth',2, 'LineStyle', '--');
    plot(time(1:end-1)/time_factor, uncoord.el_cost_bar(1:end-1)/1e3, '-k', 'LineWidth',2);
    lgd = legend('Coord', 'Uncoord', 'p(k)');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('Power (KW)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig('./power', '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, './power', 'fig');

 
% 
% total_cost_coord = prod_mat_coord*coord.total_cost;
% total_cost_uncoord = prod_mat_uncoord*uncoord.total_cost;
% fh = figure('name','Incremental cost','numbertitle','off'); 
%     set(fh, 'color', 'white');
%     plot(coord.time(1:end-1)/60,total_cost_coord(1:end-1),'Color', 'r', ...
%             'LineWidth',2, 'LineStyle', '-');
%     hold on
%     plot(uncoord.time(1:end-1)/60,total_cost_uncoord(1:end-1),'Color', 'b', ...
%             'LineWidth',2, 'LineStyle', '--');
%     lgd = legend('Coord', 'Uncoord');
%     axes_h = gca; % gca get the current axis
%     set(axes_h,'YGrid','on');
%     set(axes_h,'TickDir', 'out');
%     set(axes_h,'Box', 'off' );
%     set(axes_h,'FontSize',14);
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel('Time (min)', 'FontSize',18);
%     ylabel('Incremental cost', 'FontSize',18);
%     set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
%         get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
%     export_fig('./total_cost', '-eps', '-painters', ...
%             '-native', '-rgb', fh);
%     saveas(fh, './total_cost_comparison', 'fig');
%     
% total_cost_coord_exp = prod_mat_coord*coord.total_cost_exp;
% total_cost_uncoord_exp = prod_mat_uncoord*uncoord.total_cost_exp;
% fh = figure('name','Incremental expected cost','numbertitle','off'); 
%     set(fh, 'color', 'white');
%     plot(coord.time(1:end-1)/60,total_cost_coord_exp(1:end-1),'Color', 'r', ...
%             'LineWidth',2, 'LineStyle', '-');
%     hold on
%     plot(uncoord.time(1:end-1)/60,total_cost_uncoord_exp(1:end-1),'Color', 'b', ...
%             'LineWidth',2, 'LineStyle', '--');
%     lgd = legend('Coord', 'Uncoord');
%     axes_h = gca; % gca get the current axis
%     set(axes_h,'YGrid','on');
%     set(axes_h,'TickDir', 'out');
%     set(axes_h,'Box', 'off' );
%     set(axes_h,'FontSize',14);
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel('Time (min)', 'FontSize',18);
%     ylabel('Incremental expected cost', 'FontSize',18);
%     set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
%         get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
%     export_fig('./total_exp_cost', '-eps', '-painters', ...
%             '-native', '-rgb', fh);
%     saveas(fh, './total_exp_cost_comparison', 'fig');
    
    
rel_sav_cost = (-coord.el_cost+uncoord.el_cost)./uncoord.el_cost;
rel_pw = (-coord.total_pw+uncoord.total_pw)./uncoord.total_pw;
fh = figure('name','Rel. cost saving','numbertitle','off'); 
    set(fh, 'color', 'white');
    hold on
    plot(coord.time(1:end-1)/time_factor,rel_sav_cost(1:end-1),'Color', 'b', ...
            'LineWidth',2, 'LineStyle', '-');
    plot(coord.time(1:end-1)/time_factor,rel_pw(1:end-1),'Color', 'r', ...
            'LineWidth',2, 'LineStyle', '--');
    lgd = legend('Cost','Power');
    axis([t_min t_max -0.05 0.32]);
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' time_string ')'], 'FontSize',18);
    ylabel('(Uncoord-Coord)/Uncoord', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig('./rel_cost_pw', '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, './rel_cost_pw', 'fig');    
    
%% analyse the workload
clear all
close all
clc

coord = load('coord_data', 'arrival', 'layoutId', 'total_pw', 'pi', ...
    'hwResourceMax', 'Parameters.simulationDelay', 'dt_ctrl', 'dt', 'dt_new_arrival', 'rho', ...
    'colors');
uncoord = load('uncoord_data', 'arrival', 'layoutId', 'total_pw', 'pi', ...
    'hwResourceMax', 'Parameters.simulationDelay', 'dt_ctrl', 'dt', 'dt_new_arrival','rho');

% coord_workload = squeeze(sum(sum(coord.arrival,1),2));
% uncoord_workload = squeeze(sum(sum(coord.arrival,1),2));

coord.tmp_Pi_max = repmat(coord.hwResourceMax, [1, 1, size(coord.pi,3)]);
uncoord.tmp_Pi_max = repmat(uncoord.hwResourceMax, [1, 1, size(uncoord.pi,3)]);

tmp_coord_usage = mean(coord.pi ./ coord.tmp_Pi_max,2);
%tmp_coord_usage = sum(coord.rho,2);
coord.usage = squeeze(mean(tmp_coord_usage,1));

tmp_uncoord_usage = mean(uncoord.pi ./ uncoord.tmp_Pi_max,2);
%tmp_uncoord_usage = sum(uncoord.rho,2);
uncoord.usage = squeeze(mean(tmp_uncoord_usage,1));

coord.usage = coord.usage(coord.Parameters.simulationDelay*coord.dt_new_arrival/coord.dt:end);
uncoord.usage = uncoord.usage(uncoord.Parameters.simulationDelay*uncoord.dt_new_arrival/uncoord.dt:end);
coord.total_pw = coord.total_pw(coord.Parameters.simulationDelay*coord.dt_new_arrival/coord.dt:end);
uncoord.total_pw = uncoord.total_pw(coord.Parameters.simulationDelay*coord.dt_new_arrival/coord.dt:end);

clear tmp_coord_usage tmp_uncoord_usage;

fig_path = ['../fig/layout' num2str(coord.layoutId)];

set(0,'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');

savings = (uncoord.total_pw - coord.total_pw)./(coord.total_pw);

set(0,'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');

fh = figure('name','Power consumption','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage(1:end-1),uncoord.total_pw(1:end-1)/1e3,'Color', 'b', ...
            'LineWidth',2, 'LineStyle', 'none', 'Marker', '.');
    hold on
    plot(coord.usage(1:end-1),coord.total_pw(1:end-1)/1e3,'Color', 'r', ...
            'LineWidth',2, 'LineStyle', 'none', 'Marker', '.');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Usage', 'FontSize',18);
    ylabel('Power consumption (KW)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/power_vs_workload'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/power_vs_workload'], 'fig');
    saveas(fh, [fig_path '/power_vs_workload'], 'png');
    save2pdf([fig_path '/power_vs_workload'], fh, 600);
    
% generate mean values
th_workload = max(coord.usage)/1000; % threshold value
jj = 1;
while jj < length(coord.usage)
    idx_eq = (coord.usage <= (coord.usage(jj) + th_workload/2)) & ...
        (coord.usage >= (coord.usage(jj) - th_workload/2));
    mean_usage_val = mean(coord.usage(idx_eq));
    mean_pw_val = mean(coord.total_pw(idx_eq));
    idx_to_keep = [logical(ones(jj,1)); ~idx_eq(jj+1:end)];
    coord.usage = coord.usage(idx_to_keep);
    coord.total_pw = coord.total_pw(idx_to_keep);
    jj = jj + 1;
end
    
jj = 1;
while jj < length(uncoord.usage)
    idx_eq =  (uncoord.usage <= (uncoord.usage(jj) + th_workload/2)) & ...
        (uncoord.usage >= (uncoord.usage(jj) - th_workload/2));
    mean_usage_val = mean(uncoord.usage(idx_eq));
    mean_pw_val = mean(uncoord.total_pw(idx_eq));
    idx_to_keep = [logical(ones(jj,1)); ~idx_eq(jj+1:end)];
    uncoord.usage = uncoord.usage(idx_to_keep);
    uncoord.total_pw = uncoord.total_pw(idx_to_keep);
    jj = jj + 1;
end

savings = (uncoord.total_pw - coord.total_pw)./(coord.total_pw)*100;

fh = figure('name','Savings','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(coord.usage(1:end-1),savings(1:end-1),'Color', 'k', ...
         'LineWidth',2, 'LineStyle', '-', 'Marker', '.');
    axes_h = gca; % gca get the current axis
    %axis([-inf inf -0.1 1.1]);
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Utilization', 'FontSize',18);
    ylabel('Percentage power reduction', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/savings'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/savings'], 'fig');
    saveas(fh, [fig_path '/savings'], 'png');
    save2pdf([fig_path '/savings'], fh, 600);

fh = figure('name','Diff. Power cleaned','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage(1:end-1), 1e-3 * ...
        (uncoord.total_pw(1:end-1)-coord.total_pw(1:end-1)),'Color', 'k', ...
            'LineWidth',2, 'LineStyle', '-', 'Marker', '.');
    axes_h = gca; % gca get the current axis
    %axis([-inf inf -0.1 1.1]);
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Utilization', 'FontSize',18);
    ylabel('Coordinated-Uncoordianted (KW)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/diff_power_cleaned'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/diff_power_cleaned'], 'fig');
    saveas(fh, [fig_path '/diff_power_cleaned'], 'png');
    save2pdf([fig_path '/diff_power_cleaned'], fh, 600);
    
fh = figure('name','Power cleaned','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(coord.usage(1:end-1), 1e-3 * coord.total_pw(1:end-1),'Color', coord.colors{8}, ...
            'LineWidth',2, 'LineStyle', '-');
    hold on
    plot(uncoord.usage(1:end-1),1e-03 * uncoord.total_pw(1:end-1),'Color', coord.colors{10}, ...
            'LineWidth',2, 'LineStyle', '--');
    lgd = legend('Coord.', 'Uncoord.');
    axes_h = gca; % gca get the current axis
    %axis([-inf inf -0.1 1.1]);
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel('Utilization', 'FontSize',16);
    ylabel('Power (KW)', 'FontSize',16);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/power_cleaned'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/power_cleaned'], 'fig');
    saveas(fh, [fig_path '/power_cleaned'], 'png');
    save2pdf([fig_path '/power_cleaned'], fh, 600);
 
    
    
    
    
    
%% analyse the workload with respect to the base load
clear all
close all
clc

th_usage = 1e-2;        % threshold to distinguish usage

coord = load('coord_data', 'arrival', 'layoutId', 'total_pw', 'pi', ...
    'hwResourceMax', 'Parameters.simulationDelay', 'dt_ctrl', 'dt', 'dt_new_arrival', 'rho', ...
    'colors', 'pw', 'nZones', 'nCracs');
uncoord = load('uncoord_data', 'arrival', 'layoutId', 'total_pw', 'pi', ...
    'hwResourceMax', 'Parameters.simulationDelay', 'dt_ctrl', 'dt', 'dt_new_arrival','rho', ...
    'pw', 'nZones', 'nCracs');
base_line = load('base_line_data', 'arrival', 'layoutId', 'total_pw', 'pi', ...
    'hwResourceMax', 'Parameters.simulationDelay', 'dt_ctrl', 'dt', 'dt_new_arrival','rho', ...
    'pw', 'nZones', 'nCracs');

if coord.nZones ~= uncoord.nZones 
    disp('Coord and uncoord have different number of racks');
    return
end

if base_line.nZones ~= uncoord.nZones 
    disp('Baseline and uncoord have different number of racks');
    return
end
nZones = base_line.nZones;

if coord.nCracs ~= uncoord.nCracs 
    disp('Coord and uncoord have different number of CRACs');
    return
end

if base_line.nCracs ~= uncoord.nCracs 
    disp('Baseline and uncoord have different number of CRACs');
    return
end
nCracs = base_line.nCracs;

coord.pi = coord.pi(:,:,1:end-1);    % remove last point, is always 0 and wrong
uncoord.pi = uncoord.pi(:,:,1:end-1);   
base_line.pi = base_line.pi(:,:,1:end-1);   

coord.tmp_Pi_max = repmat(coord.hwResourceMax, [1, 1, size(coord.pi,3)]);
uncoord.tmp_Pi_max = repmat(uncoord.hwResourceMax, [1, 1, size(uncoord.pi,3)]);
base_line.tmp_Pi_max = repmat(base_line.hwResourceMax, [1, 1, size(base_line.pi,3)]);

tmp_coord_usage = mean(coord.pi ./ coord.tmp_Pi_max,2);
coord.usage = squeeze(mean(tmp_coord_usage,1));

tmp_uncoord_usage = mean(uncoord.pi ./ uncoord.tmp_Pi_max,2);
uncoord.usage = squeeze(mean(tmp_uncoord_usage,1));

tmp_base_load_usage = mean(base_line.pi ./ base_line.tmp_Pi_max,2);
base_line.usage = squeeze(mean(tmp_base_load_usage,1));

coord.usage = coord.usage(coord.Parameters.simulationDelay * ...
    coord.dt_new_arrival/coord.dt:end);
uncoord.usage = uncoord.usage(uncoord.Parameters.simulationDelay * ...
    uncoord.dt_new_arrival/uncoord.dt:end);
base_line.usage = base_line.usage(base_line.Parameters.simulationDelay * ...
    base_line.dt_new_arrival/base_line.dt:end);

coord.total_pw = coord.total_pw(coord.Parameters.simulationDelay * ...
    coord.dt_new_arrival/coord.dt:end);
coord.server_pw = squeeze(mean(coord.pw(1:nZones,:)));
coord.server_pw = coord.server_pw(coord.Parameters.simulationDelay * ...
    coord.dt_new_arrival/coord.dt:end);
coord.crac_pw = squeeze(mean(coord.pw(nZones+1:nZones+nCracs,:)));
coord.crac_pw = coord.crac_pw(coord.Parameters.simulationDelay * ...
    coord.dt_new_arrival/coord.dt:end);

uncoord.total_pw = uncoord.total_pw(uncoord.Parameters.simulationDelay * ...
    uncoord.dt_new_arrival/uncoord.dt:end);
uncoord.server_pw = squeeze(mean(coord.pw(1:nZones,:)));
uncoord.server_pw = coord.server_pw(uncoord.Parameters.simulationDelay * ...
    uncoord.dt_new_arrival/uncoord.dt:end);
uncoord.crac_pw = squeeze(mean(uncoord.pw(nZones+1:nZones+nCracs,:)));
uncoord.crac_pw = coord.crac_pw(uncoord.Parameters.simulationDelay * ...
    uncoord.dt_new_arrival/uncoord.dt:end);

base_line.total_pw = base_line.total_pw(base_line.Parameters.simulationDelay * ...
    base_line.dt_new_arrival/base_line.dt:end);
base_line.server_pw = squeeze(mean(coord.pw(1:nZones,:)));
base_line.server_pw = coord.server_pw(base_line.Parameters.simulationDelay * ...
    base_line.dt_new_arrival/base_line.dt:end);
base_line.crac_pw = squeeze(mean(base_line.pw(nZones+1:nZones+nCracs,:)));
base_line.crac_pw = coord.crac_pw(base_line.Parameters.simulationDelay * ...
    base_line.dt_new_arrival/base_line.dt:end);

% remove last point to match the length of the 'fixed' usage vector
coord.total_pw = coord.total_pw(1:end-1);
coord.server_pw = coord.server_pw(1:end-1);
coord.crac_pw = coord.crac_pw(1:end-1);

uncoord.total_pw = uncoord.total_pw(1:end-1);
uncoord.server_pw = uncoord.server_pw(1:end-1);
uncoord.crac_pw = uncoord.crac_pw(1:end-1);

base_line.total_pw = base_line.total_pw(1:end-1);
base_line.server_pw = base_line.server_pw(1:end-1);
base_line.crac_pw = base_line.crac_pw(1:end-1);

% remove higher usage data from the base_line algorithm
max_usage = max(max(coord.usage), max(uncoord.usage));
idx_to_keep = base_line.usage <= max_usage+th_usage;
base_line.usage = base_line.usage(idx_to_keep);
base_line.total_pw = base_line.total_pw(idx_to_keep);

clear tmp_coord_usage tmp_uncoord_usage;

fig_path = ['../fig/layout' num2str(coord.layoutId)];

set(0,'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');

% savings = (uncoord.total_pw - coord.total_pw)./(coord.total_pw);

set(0, 'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');
coord_color = coord.colors{8};
coord_marker = '';
coord_marker_size = 8;
uncoord_color = coord.colors{10};
uncoord_marker = '^';
uncoord_marker_size = 6;
base_line_color = coord.colors{13};
base_line_marker = '+';
base_line_marker_size = 10;

fh = figure('name','Power consumption','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(base_line.usage(1:end-1),base_line.total_pw(1:end-1)/1e3,'Color', base_line_color, ...
        'LineWidth',2, 'LineStyle', 'none', 'Marker', '.');
    hold on
    plot(uncoord.usage(1:end-1),uncoord.total_pw(1:end-1)/1e3,'Color', uncoord_color, ...
        'LineWidth',2, 'LineStyle', 'none', 'Marker', '.');
    plot(coord.usage(1:end-1),coord.total_pw(1:end-1)/1e3,'Color', coord_color, ...
        'LineWidth',2, 'LineStyle', 'none', 'Marker', '.');
    lgd = legend('Base line', 'Uncoord.', 'Coord.');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Usage', 'FontSize',18);
    ylabel('Power consumption (KW)', 'FontSize',18);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/power_vs_workload'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/power_vs_workload'], 'fig');
    saveas(fh, [fig_path '/power_vs_workload'], 'png');
    save2pdf([fig_path '/power_vs_workload'], fh, 600);
    
    
% generate mean values
th_workload = max(coord.usage)/1000; % threshold value
jj = 1;
while jj < length(coord.usage)
    idx_eq = (coord.usage <= (coord.usage(jj) + th_workload/2)) & ...
        (coord.usage >= (coord.usage(jj) - th_workload/2));
    mean_usage_val = mean(coord.usage(idx_eq));
    mean_pw_val = mean(coord.total_pw(idx_eq));
    idx_to_keep = [logical(ones(jj,1)); ~idx_eq(jj+1:end)];
    coord.usage = coord.usage(idx_to_keep);
    coord.total_pw = coord.total_pw(idx_to_keep);
    coord.server_pw = coord.server_pw(idx_to_keep);
    coord.crac_pw = coord.crac_pw(idx_to_keep);
    jj = jj + 1;
end
    
jj = 1;
while jj < length(uncoord.usage)
    idx_eq =  (uncoord.usage <= (uncoord.usage(jj) + th_workload/2)) & ...
        (uncoord.usage >= (uncoord.usage(jj) - th_workload/2));
    mean_usage_val = mean(uncoord.usage(idx_eq));
    mean_pw_val = mean(uncoord.total_pw(idx_eq));
    idx_to_keep = [logical(ones(jj,1)); ~idx_eq(jj+1:end)];
    uncoord.usage = uncoord.usage(idx_to_keep);
    uncoord.total_pw = uncoord.total_pw(idx_to_keep);
    uncoord.server_pw = uncoord.server_pw(idx_to_keep);
    uncoord.crac_pw = uncoord.crac_pw(idx_to_keep);
    jj = jj + 1;
end

jj = 1;
while jj < length(base_line.usage)
    idx_eq =  (base_line.usage <= (base_line.usage(jj) + th_workload/2)) & ...
        (base_line.usage >= (base_line.usage(jj) - th_workload/2));
    mean_usage_val = mean(base_line.usage(idx_eq));
    mean_pw_val = mean(base_line.total_pw(idx_eq));
    idx_to_keep = [logical(ones(jj,1)); ~idx_eq(jj+1:end)];
    base_line.usage = base_line.usage(idx_to_keep);
    base_line.total_pw = base_line.total_pw(idx_to_keep);
    base_line.server_pw = base_line.server_pw(idx_to_keep);
    base_line.crac_pw = base_line.crac_pw(idx_to_keep);
    jj = jj + 1;
end

% compute savings
% compare wokrload
end_for = min(length(uncoord.usage), length(coord.usage));

tt = 1;
for ll = 1 : end_for
    if abs((base_line.usage(tt) - uncoord.usage(tt)) < th_usage) & ...
       abs((base_line.usage(tt) - coord.usage(tt)) < th_usage)
        base_line.usage_2(tt) = base_line.usage(tt);
        base_line.total_pw_2(tt) = base_line.total_pw(tt);
        uncoord.usage_2(tt) = uncoord.usage(tt);
        uncoord.total_pw_2(tt) = uncoord.total_pw(tt);
        coord.usage_2(tt) = coord.usage(tt);
        coord.total_pw_2(tt) = coord.total_pw(tt);
        tt = tt + 1;    % increase tt
    end
end
    
coord_savings = (base_line.total_pw_2 - coord.total_pw_2)./ ...
    (base_line.total_pw_2);
uncoord_savings = (base_line.total_pw_2 - uncoord.total_pw_2)./ ...
    (base_line.total_pw_2);

fh = figure('name','Savings','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage(2:end),uncoord_savings(2:end),'Color', uncoord_color, ...
         'LineWidth',2, 'LineStyle', '-');
    hold on
    plot(coord.usage(2:end),coord_savings(2:end),'Color', coord_color, ...
         'LineWidth',2, 'LineStyle', '-');
    axes_h = gca; % gca get the current axis
    %axis([-inf inf -0.1 1.1]);
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Utilization', 'FontSize',18);
    ylabel('Percentage power reduction', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/savings'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/savings'], 'fig');
    saveas(fh, [fig_path '/savings'], 'png');
    save2pdf([fig_path '/savings'], fh, 600);

fh = figure('name','Diff. Power cleaned','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage(1:end-1), 1e-3 * ...
        (uncoord.total_pw(1:end-1)-coord.total_pw(1:end-1)),'Color', 'k', ...
            'LineWidth',2, 'LineStyle', '-', 'Marker', '.');
    axes_h = gca; % gca get the current axis
    %axis([-inf inf -0.1 1.1]);
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    xlabel('Utilization', 'FontSize',18);
    ylabel('Coordinated-Uncoordianted (KW)', 'FontSize',18);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/diff_power_cleaned'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/diff_power_cleaned'], 'fig');
    saveas(fh, [fig_path '/diff_power_cleaned'], 'png');
    save2pdf([fig_path '/diff_power_cleaned'], fh, 600);
    
fh = figure('name','Power cleaned','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(base_line.usage(1:end-1),base_line.total_pw(1:end-1)/1e3,'Color', base_line_color, ...
        'LineWidth',2, 'LineStyle', '-', ...
        'Marker', base_line_marker, 'MarkerSize', base_line_marker_size);
    hold on
    plot(uncoord.usage(1:end-1),1e-03 * uncoord.total_pw(1:end-1),'Color', coord.colors{10}, ...
            'LineWidth',2, 'LineStyle', '-','Marker', uncoord_marker, ...
            'MarkerSize', uncoord_marker_size);
    plot(coord.usage(1:end-1), 1e-3 * coord.total_pw(1:end-1),'Color', coord.colors{8}, ...
            'LineWidth',2, 'LineStyle', '-');
    lgd = legend('Baseline', 'Uncoord.','Coord.');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel('Utilization', 'FontSize',16);
    ylabel('Power (KW)', 'FontSize',16);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/power_cleaned'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/power_cleaned'], 'fig');
    saveas(fh, [fig_path '/power_cleaned'], 'png');
    save2pdf([fig_path '/power_cleaned'], fh, 600);

    
fh = figure('name','Power cleaned and savings','numbertitle','off'); 
    set(fh, 'color', 'white');
    bline = plot(base_line.usage(1:end-1),base_line.total_pw(1:end-1)/1e3, ...
        'Color', base_line_color, 'LineWidth',2, 'LineStyle', '-', ...
        'Marker', base_line_marker, 'MarkerSize', base_line_marker_size);
    hold on
    [ax, h1, h2] = plotyy(uncoord.usage(1:end-1),1e-03 * uncoord.total_pw(1:end-1), ...
        uncoord.usage(2:end),uncoord_savings(2:end));
    set(h1,'LineWidth',2, 'Color', uncoord_color, ...
        'LineStyle', '-','Marker', uncoord_marker, ...
            'MarkerSize', uncoord_marker_size);
    set(h2,'LineWidth',2, 'Color', uncoord_color, ...
        'LineStyle', '--','Marker', uncoord_marker, ...
            'MarkerSize', uncoord_marker_size);
    axes(ax(1));
    hold on
    cline = plot(coord.usage(1:end-1),1e-03 * coord.total_pw(1:end-1), ...
        'Color', coord_color,'LineStyle', '-');
    axes(ax(2));
    hold on
    plot(vec(coord.usage(2:end)),vec(coord_savings(2:end)), ...
        'Color', coord_color,'LineStyle', '--');
    set(get(ax(1),'Ylabel'),'String','Power (KW)', 'FontSize',16)
    set(get(ax(2),'Ylabel'),'String','Relative Savings', 'FontSize',16)
    set(get(ax(1),'Ylabel'), 'Color','k');
    set(ax(1),'YColor','k');
    set(get(ax(2),'Ylabel'), 'Color','k');
    set(ax(2),'YColor','k');
    xlabel('Utilization', 'FontSize',16);
    
    lgd = legend([bline, h1, cline], 'Baseline', 'Uncoord.','Coord.');
    axes_h = gca; % gca get the current axis
    set(ax(1),'YGrid','on');
    set(ax(1),'TickDir', 'out');
    set(ax(1),'Box', 'off' );
    set(ax(1),'FontSize',14);
    set(ax(1),'YTick',[0 250 500 750 1000]);
    set(ax(1),'XLim',[0 0.85]);
    
    set(ax(2),'TickDir', 'out');
    set(ax(2),'Box', 'off' );
    set(ax(2),'FontSize',14);
    set(ax(2),'YTick',[0 : 0.2 : 1]);
    set(ax(2),'YLim',[0 1]);
    set(ax(2),'XLim',[0 0.85]);
    
    set(lgd,'FontSize',16, 'Location', 'NorthWest');
    
    export_fig([fig_path '/power_combo_cleaned'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/power_combo_cleaned'], 'fig');
    saveas(fh, [fig_path '/power_combo_cleaned'], 'png');
    save2pdf([fig_path '/power_combo_cleaned'], fh, 600);    
    
    
fh = figure('name','Savings','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage(2:end),uncoord_savings(2:end),'Color', coord.colors{10}, ...
            'LineWidth',2, 'LineStyle', '-', 'Marker', uncoord_marker, ...
            'MarkerSize', uncoord_marker_size);
    hold on
    plot(coord.usage(2:end),coord_savings(2:end),'Color', coord.colors{8}, ...
            'LineWidth',2, 'LineStyle', '-');
    lgd = legend('Uncoord.','Coord.');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel('Utilization', 'FontSize',16);
    ylabel('Relative savings', 'FontSize',16);
    set(axes_h,'YTick',[0 : 0.2 : 1], 'YLim',[0 1]);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/rel_savings'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/rel_savings'], 'fig');
    saveas(fh, [fig_path '/rel_savings'], 'png');
    save2pdf([fig_path '/rel_savings'], fh, 600);    

    
fh = figure('name','Savings','numbertitle','off'); 
    set(fh, 'color', 'white');
    plot(uncoord.usage,uncoord.server_pw,'Color', uncoord_color, ...
            'LineWidth',2, 'LineStyle', '-', 'Marker', uncoord_marker, ...
            'MarkerSize', uncoord_marker_size);
    hold on
    plot(coord.usage,coord.server_pw,'Color', coord_color, ...
            'LineWidth',2, 'LineStyle', '-');
    lgd = legend('Uncoord.','Coord.');
    axes_h = gca; % gca get the current axis
    set(axes_h,'YGrid','on');
    set(axes_h,'TickDir', 'out');
    set(axes_h,'Box', 'off' );
    set(axes_h,'FontSize',14);
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel('Utilization', 'FontSize',16);
    ylabel('Server power', 'FontSize',16);
    set(axes_h,'YTick',[0 : 0.2 : 1], 'YLim',[0 1]);
    set(axes_h, 'Position', get(axes_h, 'OuterPosition') - ...
        get(axes_h, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
    export_fig([fig_path '/server_pw'], '-eps', '-painters', ...
            '-native', '-rgb', fh);
    saveas(fh, [fig_path '/server_pw'], 'fig');
    saveas(fh, [fig_path '/server_pw'], 'png');
    save2pdf([fig_path '/server_pw'], fh, 600); 
    
