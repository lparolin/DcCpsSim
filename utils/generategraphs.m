function generategraphs(DcData, SimulationData, Controller)
%GENERATEGRAPHS Generate graphs of the simulation.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 21st 2011


load('colorarray');     % load the color array
figPath = ['../fig/layout' num2str(DcData.layoutId) '/' DcData.controllerType];
close all

if SimulationData.time(end) > 5 * 60 * 60; % more than 5 hours, we show hours and not minutes
    timeFactor = 60 * 60;
    timeString = 'hr';
else
    timeFactor = 60;
    timeString = 'min';
end

t_min = SimulationData.time(1)/timeFactor;
t_max = SimulationData.time(end)/timeFactor;
set(0, 'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');



figureHandler = figure('name','Total predicted cost','numbertitle','off'); 
    hold on
    plot(SimulationData.time / timeFactor, ...
            SimulationData.total_cost, 'Color', 'k', ...
            'LineWidth',2, 'LineStyle', '-'); %#ok<*USENS>
    xlabel(['Time (' timeString ')'], 'FontSize', 18);
    ylabel('Total predicted cost', 'FontSize', 18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/total_predicted_csot'];
    prepareandsavefigure(figName, axesHandler, figureHandler);



figureHandler = figure('name','% jobs dropped','numbertitle','off'); 
    hold on
    tmp1 = squeeze(sum(SimulationData.s, 1) );
    for jj = 1 : DcData.nJobClasses
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            1 - tmp1(1, 1:end-1), 'Color', colorArray{1}, ...
            'LineWidth',2, 'LineStyle', '-'); %#ok<*USENS>
    end
    xlabel(['Time (' timeString ')'], 'FontSize', 18);
    ylabel('% jobs dropped', 'FontSize', 18);
    axis([-Inf Inf -0.1 1.1]);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/jobs_dropped_lowres'];
    prepareandsavefigure(figName, axesHandler, figureHandler);

figureHandler = figure('name','% jobs arrived','numbertitle','off'); 
    hold on
%     tmp1 = squeeze(sum(SimulationData.s, 1) );
    for jj = 1 : DcData.nJobClasses
        plot(SimulationData.time(1 : end - 1) / timeFactor, ...
            SimulationData.jobArrivalRate(jj, 1 : end - 1), ...
            'Color',colorArray{jj},'LineWidth',2, 'LineStyle', '-');
    end
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('Arrival rate (job/sec)', 'FontSize',18);
    lgd = legend('1', '2');
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/jobs_arrived'];
    prepareandsavefigure(figName, axesHandler, figureHandler);

figureHandler = figure('name','Total cost','numbertitle','off'); 
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.total_cost_exp(1:end-1),'Color', colorArray{1}, ...
            'LineWidth',2, 'LineStyle', '--');
    hold on
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.total_cost(1:end-1),'Color', colorArray{2}, ...
            'LineWidth',2, 'LineStyle', '--');
    lgd = legend('Exp.', 'Mes.');
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('Total cost', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/SimulationData.total_cost'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
        
figureHandler = figure('name','Electricity price','numbertitle','off'); 
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.alpha_el(1:end-1),'Color', colorArray{1}, ...
            'LineWidth',2, 'LineStyle', '-');
    hold on
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.beta_el(1:end-1),'Color', colorArray{2}, ...
            'LineWidth',2, 'LineStyle', '--');
    lgd = legend('\alpha_e(k)', '\beta_e(k)');
    set(lgd,'FontSize',16, 'Location', 'NorthEast');
    axis([t_min t_max 0 80]);
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('Electricity cost ($\MWh)', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/el_cost'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
    
figureHandler = figure('name','QoS cost','numbertitle','off'); 
    hold on
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.cqos(1:end-1),'Color', colorArray{1}, ...
            'LineWidth',2, 'LineStyle', '-');
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.cqos_exp(1:end-1),'Color', colorArray{2}, ...
            'LineWidth',2, 'LineStyle', '--');
    lgd = legend('Mes.', 'Exp.');
    set(lgd,'FontSize',16);
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('QoS cost', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/qos_cost'];
    prepareandsavefigure(figName, axesHandler, figureHandler);

% figureHandler = figure('name','Pw cost','numbertitle','off'); 
%     hold on
%     plot(SimulationData.time(1:end-1) / timeFactor, ...
%         SimulationData.el_cost(1:end-1), 'Color', colorArray{1}, ...
%         'LineWidth',2, 'LineStyle', '-');
%     plot(SimulationData.time(1:end-1) / timeFactor, ...
%         Controller.cpw_exp(1:end-1),'Color', colorArray{2}, ...
%         'LineWidth',2, 'LineStyle', '--');
%     lgd = legend('Mes.', 'Exp.');
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel(['Time (' timeString ')'], 'FontSize',18);
%     ylabel('Pw cost', 'FontSize',18);
%     axesHandler = gca; % gca get the current axis
%     figName = [figPath '/pw_cost'];
%     prepareandsavefigure(figName, axesHandler, figureHandler);
   
figureHandler = figure('name','Server power','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt = 1 : DcData.nZones-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            SimulationData.pw(ttt, 1:end-1) * 1e-3, 'Color', ...
            colorArray{ttt}, 'LineWidth',2, 'LineStyle', '--');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.pw(ttt+1, 1:end-1) * 1e-3, 'Color', ...
        colorArray{ttt+1}, 'LineWidth', 2, 'LineStyle', '--');
    lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('Power (KW)', 'FontSize',18);
    axis([t_min t_max -Inf Inf]);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/node_pw'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
   
figureHandler = figure('name','CRAC power','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time / timeFactor, ...
            SimulationData.pw(ttt,:) * 1e-3, 'Color', colorArray{ttt}, ...
            'LineWidth',2, 'LineStyle', '-');
        lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones) '''' ','];  %#ok<AGROW>
    end
    plot(SimulationData.time / timeFactor, ...
        SimulationData.pw(ttt+1,:) * 1e-3,'Color', colorArray{ttt+1}, ...
         'LineWidth',2, 'LineStyle', '-');
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            Controller.pw_exp(ttt,1:end-1) * 1e-3, 'Color', ...
            colorArray{ttt}, 'LineWidth',2, 'LineStyle', '--');
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.pw_exp(ttt+1,1:end-1) * 1e-3, 'Color', ...
        colorArray{ttt+1}, 'LineWidth',2, 'LineStyle', '--');
    axis([t_min t_max -Inf Inf]);
    lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones+1) ''''];
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            Controller.pw_exp(ttt,1:end-1)*1e-3, 'Color', ...
            colorArray{ttt}, 'LineWidth',2, 'LineStyle', '--');
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.pw_exp(ttt+1,1:end-1) * 1e-3,'Color', ...
        colorArray{ttt+1}, 'LineWidth',2, 'LineStyle', '--');
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('Power (KW)', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/crac_pw'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
       
figureHandler = figure('name','Tout server','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt =1 : DcData.nZones-1
        plot(SimulationData.time / timeFactor, SimulationData.T(ttt,1:end-1), ...
            'Color', colorArray{ttt}, 'LineWidth',1.5, 'LineStyle', '-');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
     plot(SimulationData.time / timeFactor, ...
         SimulationData.T(ttt+1,1:end-1),'Color', colorArray{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    for ttt =1 : DcData.nZones-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            Controller.T_exp(ttt,1:end-2),'Color', colorArray{ttt}, ...
         'LineWidth',2, 'LineStyle', '--');
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.T_exp(ttt+1,1:end-2),'Color', colorArray{ttt+1}, ...
         'LineWidth',2, 'LineStyle', '--');
    axis([t_min t_max -Inf Inf]);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize', 18);
    ylabel('T_{out} (C)', 'FontSize', 18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/Tout_server'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
    
figureHandler = figure('name','Tin server','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt =1 : DcData.nZones-1
        plot(SimulationData.time / timeFactor, SimulationData.Tin(ttt,1:end-1), ...
            'Color', colorArray{ttt}, 'LineWidth',1.5, 'LineStyle', '-');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
     plot(SimulationData.time / timeFactor, ...
         SimulationData.Tin(ttt+1,1:end-1),'Color', colorArray{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    axis([t_min t_max -Inf Inf]);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize', 18);
    ylabel('T_{in} (C)', 'FontSize', 18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/Tin_server'];
    prepareandsavefigure(figName, axesHandler, figureHandler);    
        
figureHandler = figure('name','Tout crac','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time / timeFactor, ...
            SimulationData.T(ttt,1:end-1),'Color', colorArray{ttt}, ...
         'LineWidth',1.5, 'LineStyle', '-');
        lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones) '''' ','];  %#ok<AGROW>
    end
    plot(SimulationData.time / timeFactor, ...
        SimulationData.T(ttt+1,1:end-1),'Color', colorArray{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            Controller.T_exp(ttt,1:end-2),'Color', colorArray{ttt}, ...
         'LineWidth',2, 'LineStyle', '--');
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.T_exp(ttt+1,1:end-2),'Color', colorArray{ttt+1}, ...
         'LineWidth',2, 'LineStyle', '--'); 
    lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones+1) ''''];
    axis([t_min t_max -Inf Inf]);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('T_{out} (C)', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/Tout_crac'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
    
figureHandler = figure('name','Tref','numbertitle','off'); 
    hold on
    lgd_str = [];
    for ttt =1 : DcData.nCracs-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            SimulationData.Tref(ttt,1:end-1),'Color', colorArray{ttt+DcData.nZones}, ...
         'LineWidth',2, 'LineStyle', '--');
        lgd_str = [lgd_str '''' num2str(ttt) '''' ','];  %#ok<AGROW>
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        SimulationData.Tref(ttt+1,1:end-1),'Color', colorArray{ttt+DcData.nZones+1}, ...
         'LineWidth',2, 'LineStyle', '--');
    lgd_str = [lgd_str '''' num2str(ttt+1) ''''];
    for ttt =1 : DcData.nCracs-1
        plot(SimulationData.time / timeFactor, ...
            SimulationData.Tin(ttt,1:end-1),'Color', colorArray{ttt+DcData.nZones}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    end
    plot(SimulationData.time / timeFactor, ...
        SimulationData.Tin(ttt+1,1:end-1),'Color', colorArray{ttt+DcData.nZones+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    
    axis([t_min t_max -Inf Inf]);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('T_{ref} (C)', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/Tref'];
    prepareandsavefigure(figName, axesHandler, figureHandler);

figureHandler = figure('name','Tin crac','numbertitle','off'); 
    hold on
    lgd_str = [];
    hold on
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time / timeFactor, ...
            SimulationData.Tin(ttt,1:end-1),'Color', colorArray{ttt}, ...
         'LineWidth',1.5, 'LineStyle', '-');
        lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones) '''' ','];  %#ok<AGROW>
    end
    plot(SimulationData.time / timeFactor, ...
        SimulationData.Tin(ttt+1,1:end-1),'Color', colorArray{ttt+1}, ...
         'LineWidth',1.5, 'LineStyle', '-');
    lgd_str = [lgd_str '''' num2str(ttt-DcData.nZones+1) ''''];
    for ttt =DcData.nZones+1 : DcData.nZones+DcData.nCracs-1
        plot(SimulationData.time(1:end-1) / timeFactor, ...
            Controller.Tin_exp(ttt,1:end-2),'Color', colorArray{ttt}, ...
            'LineWidth',2, 'LineStyle', '--');
    end
    plot(SimulationData.time(1:end-1) / timeFactor, ...
        Controller.Tin_exp(ttt+1,1:end-2),'Color', colorArray{ttt+1}, ...
        'LineWidth',2, 'LineStyle', '--');
    axis([t_min t_max -Inf Inf]);
    eval(['lgd = legend(' lgd_str ');']);
    set(lgd,'FontSize',16, 'Location', 'SouthEast');
    xlabel(['Time (' timeString ')'], 'FontSize',18);
    ylabel('T_{in} (C)', 'FontSize',18);
    axesHandler = gca; % gca get the current axis
    figName = [figPath '/Tin_crac'];
    prepareandsavefigure(figName, axesHandler, figureHandler);
   
% figureHandler = figure('name','Total pw','numbertitle','off'); 
%     hold on
%     plot(SimulationData.time(1:end-1) / timeFactor, ...
%         SimulationData.total_pw(1:end-1) / 1e3, 'LineWidth',2)
%     plot(SimulationData.time(1:end-1) / timeFactor, ...
%         Controller.sum(Controller.pw_exp(:,1:end-1),1) / 1e3, ...
%         '--r','LineWidth',2)
%     plot(SimulationData.time(1:end-1) / timeFactor, ...
%         SimulationData.el_cost_bar(1:end-1)/1e3, '-k', 'LineWidth',2);
%     axis([t_min t_max -Inf Inf]);
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel(['Time (' timeString ')'], 'FontSize',18);
%     ylabel('Power (KW)', 'FontSize',18);
%     figName = [figPath '/total_pw'];
%     prepareandsavefigure(figName, axesHandler, figureHandler);
    
    
 
%  figureHandler = figure('name','l0-lotilde','numbertitle','off'); 
%     hold on
%     plot(SimulationData.time / timeFactor, ...
%         squeeze(sum(sum(SimulationData.l(:,:,1:end-1) - ...
%         SimulationData.l_tilde(:,:,1:end-1),1),2)), 'LineWidth',2)
%     axis([t_min t_max -Inf Inf]);
%     set(lgd,'FontSize',16, 'Location', 'SouthEast');
%     xlabel(['Time (' timeString ')'], 'FontSize',18);
%     ylabel('Jobs', 'FontSize',18);
%     axesHandler = gca; % gca get the current axis
%     figName = [figPath '/ll_tilde'];
%     prepareandsavefigure(figName, axesHandler, figureHandler);

end

