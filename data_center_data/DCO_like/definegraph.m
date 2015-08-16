function Parameters = definegraph(Parameters)
%DEFINEGRAPH Prepare data structure for the graphs generated in the
%simulation.
%  Parameters.Graph.Figure(x): struct that contains the data related
%    to the x^{th} figure. 
%  Parameters.Graph.Figure(x).name: Name of the figure, also used in the
%    caption
%  Parameters.Graph.Figure(x).Axis(y): struct that contains the data for
%    the y^{th} axis. 
%  Parameters.Graph.Figure(x).Axis(y).position: position of the y^{th} axis
%  Parameters.Graph.Figure(x).Axis(y).xLabel: label of the x axis
%  Parameters.Graph.Figure(x).Axis(y).yLabel: label of the y axis
%  Parameters.Graph.Figure(x).Axis(y).Line(k): struct that contains the
%    data for the k^{th}4 line
% 
%  In order to improve the performance of the script, Figure, Axis, and
%  Lines should be defined in inverted order, from higher to lower values.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

% define some colors

departureZone1 = Parameters.Graph.DefaultValue.Color.green(1, :);
tinZone1 = Parameters.Graph.DefaultValue.Color.green(2, :);
toutZone1 = Parameters.Graph.DefaultValue.Color.green(3, :);
powerZone1 = Parameters.Graph.DefaultValue.Color.green(1, :);

departureZone2 = Parameters.Graph.DefaultValue.Color.red(1, :);
tinZone2 = Parameters.Graph.DefaultValue.Color.red(2, :);
toutZone2 = Parameters.Graph.DefaultValue.Color.red(3, :);
powerZone2 = Parameters.Graph.DefaultValue.Color.red(1, :);

departureZone3 = Parameters.Graph.DefaultValue.Color.blue(1, :);
tinZone3 = Parameters.Graph.DefaultValue.Color.blue(2, :);
toutZone3 = Parameters.Graph.DefaultValue.Color.blue(3, :);
powerZone3 = Parameters.Graph.DefaultValue.Color.blue(1, :);

departureZone4 = Parameters.Graph.DefaultValue.Color.brown(1, :);
tinZone4 = Parameters.Graph.DefaultValue.Color.brown(2, :);
toutZone4 = Parameters.Graph.DefaultValue.Color.brown(3, :);
powerZone4 = Parameters.Graph.DefaultValue.Color.brown(1, :);

departureZone5 = Parameters.Graph.DefaultValue.Color.yellow(1, :);
tinZone5 = Parameters.Graph.DefaultValue.Color.yellow(2, :);
toutZone5 = Parameters.Graph.DefaultValue.Color.yellow(3, :);
powerZone5 = Parameters.Graph.DefaultValue.Color.yellow(1, :);

departureZone6 = Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
tinZone6 = Parameters.Graph.DefaultValue.Color.lightBlue(2, :);
toutZone6 = Parameters.Graph.DefaultValue.Color.lightBlue(3, :);
powerZone6 = Parameters.Graph.DefaultValue.Color.lightBlue(1, :);

departureZone7 = Parameters.Graph.DefaultValue.Color.purple(1, :);
tinZone7 = Parameters.Graph.DefaultValue.Color.purple(2, :);
toutZone7 = Parameters.Graph.DefaultValue.Color.purple(3, :);
powerZone7 = Parameters.Graph.DefaultValue.Color.purple(1, :);

departureZone8 = Parameters.Graph.DefaultValue.Color.green(5, :);
tinZone8 = Parameters.Graph.DefaultValue.Color.green(6, :);
toutZone8 = Parameters.Graph.DefaultValue.Color.green(7, :);
powerZone8 = Parameters.Graph.DefaultValue.Color.green(5, :);


powerCrac1 = Parameters.Graph.DefaultValue.Color.green(5, :);
powerCrac2 = Parameters.Graph.DefaultValue.Color.red(5, :);
powerCrac3 = Parameters.Graph.DefaultValue.Color.blue(5, :);
powerCrac4 = Parameters.Graph.DefaultValue.Color.brown(5, :);
powerCrac5 = Parameters.Graph.DefaultValue.Color.yellow(5, :);
powerCrac6 = Parameters.Graph.DefaultValue.Color.lightBlue(5, :);
powerCrac7 = Parameters.Graph.DefaultValue.Color.purple(5, :);
powerCrac8 = Parameters.Graph.DefaultValue.Color.green(8, :);





Parameters.Graph.Figure(12).name = 'Zone and CRAC power consumption';
Parameters.Graph.Figure(12).Axis(2, 1).name = 'PUE';
Parameters.Graph.Figure(12).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(12).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(12).Axis(2, 1).yLabel = 'PUE';

Parameters.Graph.Figure(12).Axis(2, 1).Line(1).legendName = 'PUE';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).showInLegend = 'no';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).lineStyle = '--';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).sourceDataY = ...
    ['(sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Controller.Prediction.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(12).Axis(1, 1).name = 'Power consumption';
Parameters.Graph.Figure(12).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(12).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(12).Axis(1, 1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(12).Axis(1, 1).Line(2).legendName = 'Zones';
Parameters.Graph.Figure(12).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(1, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(12).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(12).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(1, 1).Line(2).sourceDataY = ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(12).Axis(1).Line(1).legendName = 'Cracs';
Parameters.Graph.Figure(12).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(8, :);
Parameters.Graph.Figure(12).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(12).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(1).Line(1).sourceDataY = ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1) / 1e3';







Parameters.Graph.Figure(11).name = 'Crac power consumption';
Parameters.Graph.Figure(11).Axis(2, 1).name = 'Crac 5 - 8';
Parameters.Graph.Figure(11).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(11).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(11).Axis(2, 1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(11).Axis(2, 1).Line(4).legendName = 'Crac_8';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).color = ...
    powerCrac8;
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(8, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(3).legendName = 'CRAC_7';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).color = ...
    powerCrac7;
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(7, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(2).legendName = 'CRAC_6';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).color = ...
    powerCrac6;
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(6, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(1).legendName = 'CRAC_5';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).color = ...
    powerCrac5;
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(5, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(1, 1).name = 'Crac 1 - 4';
Parameters.Graph.Figure(11).Axis(1, 1).position = [2, 1];
Parameters.Graph.Figure(11).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(11).Axis(1, 1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(11).Axis(1, 1).Line(4).legendName = 'CRAC_4';
Parameters.Graph.Figure(11).Axis(1, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1, 1).Line(4).color = ...
    powerCrac4;
Parameters.Graph.Figure(11).Axis(1, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(4, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(1, 1).Line(3).legendName = 'CRAC_3';
Parameters.Graph.Figure(11).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1, 1).Line(3).color = ...
    powerCrac3;
Parameters.Graph.Figure(11).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(3, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(1, 1).Line(2).legendName = 'CRAC_2';
Parameters.Graph.Figure(11).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1, 1).Line(2).color = ...
    powerCrac2;
Parameters.Graph.Figure(11).Axis(1, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(2, 1 : iTime)*1e-3';

Parameters.Graph.Figure(11).Axis(1, 1).Line(1).legendName = 'CRAC_1';
Parameters.Graph.Figure(11).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1, 1).Line(1).color = ...
    powerCrac1;
Parameters.Graph.Figure(11).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(1, 1 : iTime)*1e-3';






Parameters.Graph.Figure(10).name = 'Zone power consumption';
Parameters.Graph.Figure(10).Axis(2, 1).name = 'Zone 5 - 8';
Parameters.Graph.Figure(10).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(10).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(10).Axis(2, 1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(10).Axis(2, 1).Line(4).legendName = 'Zone_8';
Parameters.Graph.Figure(10).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(2, 1).Line(4).color = ...
    powerZone8;
Parameters.Graph.Figure(10).Axis(2, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(8, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(2, 1).Line(3).legendName = 'Zone_7';
Parameters.Graph.Figure(10).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(2, 1).Line(3).color = ...
    powerZone7;
Parameters.Graph.Figure(10).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(7, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(2, 1).Line(2).legendName = 'Zone_6';
Parameters.Graph.Figure(10).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(2, 1).Line(2).color = ...
    powerZone6;
Parameters.Graph.Figure(10).Axis(2, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(6, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(2, 1).Line(1).legendName = 'Zone_5';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).color = ...
    powerZone5;
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(5, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(1, 1).name = 'Zone 1 - 4';
Parameters.Graph.Figure(10).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(10).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(10).Axis(1, 1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(10).Axis(1, 1).Line(4).legendName = 'Zone_4';
Parameters.Graph.Figure(10).Axis(1, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1, 1).Line(4).color = ...
    powerZone4;
Parameters.Graph.Figure(10).Axis(1, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(1, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(4, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(1, 1).Line(3).legendName = 'Zone_3';
Parameters.Graph.Figure(10).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1, 1).Line(3).color = ...
    powerZone3;
Parameters.Graph.Figure(10).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(3, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(1, 1).Line(2).legendName = 'Zone_2';
Parameters.Graph.Figure(10).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1, 1).Line(2).color = ...
    powerZone2;
Parameters.Graph.Figure(10).Axis(1, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(2, 1 : iTime)*1e-3';

Parameters.Graph.Figure(10).Axis(1, 1).Line(1).legendName = 'Zone_1';
Parameters.Graph.Figure(10).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1, 1).Line(1).color = ...
    powerZone1;
Parameters.Graph.Figure(10).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(1, 1 : iTime)*1e-3';





Parameters.Graph.Figure(9).name = 'Zone Output/Input temperature';
Parameters.Graph.Figure(9).Axis(2, 1).name = 'Zone 1 - 4';
Parameters.Graph.Figure(9).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(9).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(9).Axis(2, 1).yLabel = 'Temperature (C)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(8).legendName = 'Tout_8';
Parameters.Graph.Figure(9).Axis(2, 1).Line(8).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(8).color = ...
    toutZone8;
Parameters.Graph.Figure(9).Axis(2, 1).Line(8).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(8).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(8).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(7).legendName = 'Tin_8';
Parameters.Graph.Figure(9).Axis(2, 1).Line(7).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(7).color = ...
    tinZone8;
Parameters.Graph.Figure(9).Axis(2, 1).Line(7).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(7).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(7).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(6).legendName = 'Tout_7';
Parameters.Graph.Figure(9).Axis(2, 1).Line(6).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(6).color = ...
    toutZone7;
Parameters.Graph.Figure(9).Axis(2, 1).Line(6).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(6).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(6).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(5).legendName = 'Tin_7';
Parameters.Graph.Figure(9).Axis(2, 1).Line(5).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(5).color = ...
    tinZone7;
Parameters.Graph.Figure(9).Axis(2, 1).Line(5).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(5).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(5).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(4).legendName = 'Tout_6';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).color = ...
    toutZone6;
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(3).legendName = 'Tin_6';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).color = ...
    tinZone6;
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(2).legendName = 'Tout_5';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).color = ...
    toutZone5;
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(5, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(1).legendName = 'Tin_5';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).color = ...
    tinZone5;
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(5, 1 : iTime)';


Parameters.Graph.Figure(9).Axis(1, 1).name = 'Zone 1 - 4';
Parameters.Graph.Figure(9).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(9).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(9).Axis(1, 1).yLabel = 'Temperature (C)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(8).legendName = 'Tout_4';
Parameters.Graph.Figure(9).Axis(1, 1).Line(8).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(8).color = ...
    toutZone4;
Parameters.Graph.Figure(9).Axis(1, 1).Line(8).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1, 1).Line(8).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(8).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(7).legendName = 'Tin_4';
Parameters.Graph.Figure(9).Axis(1, 1).Line(7).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(7).color = ...
    tinZone4;
Parameters.Graph.Figure(9).Axis(1, 1).Line(7).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1, 1).Line(7).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(7).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(6).legendName = 'Tout_3';
Parameters.Graph.Figure(9).Axis(1, 1).Line(6).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(6).color = ...
    toutZone3;
Parameters.Graph.Figure(9).Axis(1, 1).Line(6).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1, 1).Line(6).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(6).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(5).legendName = 'Tin_3';
Parameters.Graph.Figure(9).Axis(1, 1).Line(5).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(5).color = ...
    tinZone3;
Parameters.Graph.Figure(9).Axis(1, 1).Line(5).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1, 1).Line(5).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(5).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(4).legendName = 'Tout_2';
Parameters.Graph.Figure(9).Axis(1, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(4).color = ...
    toutZone2;
Parameters.Graph.Figure(9).Axis(1, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(3).legendName = 'Tin_2';
Parameters.Graph.Figure(9).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(3).color = ...
    tinZone2;
Parameters.Graph.Figure(9).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(2).legendName = 'Tout_1';
Parameters.Graph.Figure(9).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(2).color = ...
    toutZone1;
Parameters.Graph.Figure(9).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(1, 1 : iTime)';

Parameters.Graph.Figure(9).Axis(1, 1).Line(1).legendName = 'Tin_1';
Parameters.Graph.Figure(9).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1, 1).Line(1).color = ...
    tinZone1;
Parameters.Graph.Figure(9).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(1, 1 : iTime)';





Parameters.Graph.Figure(8).name = 'CRAC Output/Input and reference temperature';
Parameters.Graph.Figure(8).Axis(2, 2).name = 'CRAC 8';
Parameters.Graph.Figure(8).Axis(2, 2).position = [2, 2];
Parameters.Graph.Figure(8).Axis(2, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(2, 2).yLabel = 'CRAC_8 (C)';

Parameters.Graph.Figure(8).Axis(2, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(8).Axis(2, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(9, :);
Parameters.Graph.Figure(8).Axis(2, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(16, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(2, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(8).Axis(2, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(8).Axis(2, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(8).Axis(2, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(16, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(2, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(8).Axis(2, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(8).Axis(2, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(8, 1 : iTime)';


Parameters.Graph.Figure(8).Axis(1, 2).name = 'CRAC 7';
Parameters.Graph.Figure(8).Axis(1, 2).position = [1, 2];
Parameters.Graph.Figure(8).Axis(1, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(1, 2).yLabel = 'CRAC_7 (C)';

Parameters.Graph.Figure(8).Axis(1, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(8).Axis(1, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(8, :);
Parameters.Graph.Figure(8).Axis(1, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(15, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(1, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(8).Axis(1, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(8).Axis(1, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(8).Axis(1, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(15, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(1, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(8).Axis(1, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(8).Axis(1, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(7, 1 : iTime)';


Parameters.Graph.Figure(8).Axis(2, 1).name = 'CRAC 6';
Parameters.Graph.Figure(8).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(8).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(2, 1).yLabel = 'CRAC_6 (C)';

Parameters.Graph.Figure(8).Axis(2, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(8).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(7, :);
Parameters.Graph.Figure(8).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(14, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(2, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(14, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(2, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(6, 1 : iTime)';


Parameters.Graph.Figure(8).Axis(1, 1).name = 'CRAC 5';
Parameters.Graph.Figure(8).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(8).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(1, 1).yLabel = 'CRAC_5 (C)';

Parameters.Graph.Figure(8).Axis(1, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(8).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(8).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(13, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(1, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(13, 1 : iTime)';

Parameters.Graph.Figure(8).Axis(1, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(5, 1 : iTime)';






































Parameters.Graph.Figure(7).name = 'CRAC Output/Input and reference temperature';
Parameters.Graph.Figure(7).Axis(2, 2).name = 'CRAC 4';
Parameters.Graph.Figure(7).Axis(2, 2).position = [2, 2];
Parameters.Graph.Figure(7).Axis(2, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(7).Axis(2, 2).yLabel = 'CRAC_4 (C)';

Parameters.Graph.Figure(7).Axis(2, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(7).Axis(2, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(9, :);
Parameters.Graph.Figure(7).Axis(2, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(2, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(12, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(2, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(7).Axis(2, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(7).Axis(2, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(7).Axis(2, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(12, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(2, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(7).Axis(2, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(7).Axis(2, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(2, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(4, 1 : iTime)';


Parameters.Graph.Figure(7).Axis(1, 2).name = 'CRAC 3';
Parameters.Graph.Figure(7).Axis(1, 2).position = [1, 2];
Parameters.Graph.Figure(7).Axis(1, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(7).Axis(1, 2).yLabel = 'CRAC_3 (C)';

Parameters.Graph.Figure(7).Axis(1, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(7).Axis(1, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(8, :);
Parameters.Graph.Figure(7).Axis(1, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(11, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(7).Axis(1, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(7).Axis(1, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(7).Axis(1, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(11, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(7).Axis(1, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(7).Axis(1, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(3, 1 : iTime)';


Parameters.Graph.Figure(7).Axis(2, 1).name = 'CRAC 2';
Parameters.Graph.Figure(7).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(7).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(7).Axis(2, 1).yLabel = 'CRAC_2 (C)';

Parameters.Graph.Figure(7).Axis(2, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(7).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(7, :);
Parameters.Graph.Figure(7).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(10, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(2, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(7).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(7).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(7).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(10, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(2, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(7).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(7).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(2, 1 : iTime)';


Parameters.Graph.Figure(7).Axis(1, 1).name = 'CRAC 1';
Parameters.Graph.Figure(7).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(7).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(7).Axis(1, 1).yLabel = 'CRAC_1 (C)';

Parameters.Graph.Figure(7).Axis(1, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(7).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(7).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(9, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(7).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(7).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(7).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(9, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(7).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(7).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(1, 1 : iTime)';

























Parameters.Graph.Figure(6).name = 'Dropped jobs';
Parameters.Graph.Figure(6).Axis(2, 1).name = 'Dropped jobs';
Parameters.Graph.Figure(6).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(6).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(6).Axis(2, 1).yLabel = 'Jobs';
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).legendName = 'Class 1';
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(3, :);
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(2, 1).Line(1).sourceDataY = ...
    ['squeeze(sum(Parameters.Simulation.queueLength(:, 1, 1 : iTime) + ' ...
    '(Parameters.Simulation.jobArrivalRateToZone(:, 1, 1 : iTime) - ' ...
    'Parameters.Simulation.jobDepartureRate(:, 1, 1 : iTime) ) * ' ...
    'Parameters.Simulation.timeStep - ' ...
    'Parameters.Simulation.queueLength(:, 1, 2 : iTime + 1), 1))'];

Parameters.Graph.Figure(6).Axis(1, 1).name = 'Dropped jobs';
Parameters.Graph.Figure(6).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(6).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(6).Axis(1, 1).yLabel = 'Dropped job rate (Job/s)';
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).legendName = 'Class 1';
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(3, :);
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(1, 1).Line(1).sourceDataY = ...
    '1 - squeeze(sum(Parameters.Simulation.relativeJobAllocation(:, 1, 1 : iTime), 1))';







Parameters.Graph.Figure(5).name = 'Predicted zone input temperature';
Parameters.Graph.Figure(5).Axis(2, 1).name = 'Departure and arrival';
Parameters.Graph.Figure(5).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(5).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(2, 1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(5).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(5, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(5).Axis(1).position = [1, 1];
Parameters.Graph.Figure(5).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(5).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(5).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(5).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(5).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(5).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(5).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(5).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(5).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(5).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(1, 1 : iTime)';






Parameters.Graph.Figure(4).name = 'Queue length';
Parameters.Graph.Figure(4).Axis(2, 1).name = 'Queue length';
Parameters.Graph.Figure(4).Axis(2, 1).position = [1, 1];
Parameters.Graph.Figure(4).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(4).Axis(2, 1).yLabel = 'Length (job)';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).legendName = 'Zone 1';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).color = departureZone1;
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(1, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(3).legendName = 'Zone 2';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).color = departureZone2;
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(2, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(2).legendName = 'Zone 3';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).color = departureZone3;
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(3, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(1).legendName = 'Zone 4';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).color = departureZone4;
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(4, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1, 1).name = 'Queue length';
Parameters.Graph.Figure(4).Axis(1, 1).position = [2, 1];
Parameters.Graph.Figure(4).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(4).Axis(1, 1).yLabel = 'Length (job)';
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).legendName = 'Zone 5';
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).color = departureZone5;
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(1, 1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(5, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1, 1).Line(3).legendName = 'Zone 6';
Parameters.Graph.Figure(4).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1, 1).Line(3).color = departureZone6;
Parameters.Graph.Figure(4).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(1, 1).Line(3).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(6, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1, 1).Line(2).legendName = 'Zone 7';
Parameters.Graph.Figure(4).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1, 1).Line(2).color = departureZone7;
Parameters.Graph.Figure(4).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(1, 1).Line(2).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(7, 1, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1, 1).Line(1).legendName = 'Zone 8';
Parameters.Graph.Figure(4).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1, 1).Line(1).color = departureZone8;
Parameters.Graph.Figure(4).Axis(1, 1).Line(1).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(1, 1).Line(1).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(4).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.queueLength(8, 1, 1 : iTime)';




Parameters.Graph.Figure(3).name = 'Minimum cost function';
Parameters.Graph.Figure(3).Axis(1).name = 'Minimum cost function';
Parameters.Graph.Figure(3).Axis(1).position = [1, 1];
Parameters.Graph.Figure(3).Axis(1).xLabel = 'Iteration';
Parameters.Graph.Figure(3).Axis(1).yLabel = 'Cost function';
Parameters.Graph.Figure(3).Axis(1).Line(1).legendName = 'Cost function';
Parameters.Graph.Figure(3).Axis(1).Line(1).showInLegend = 'no';
Parameters.Graph.Figure(3).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(3).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(3).Axis(1).Line(1).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(3).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.objectiveFunction(1 : iTime)';

Parameters.Graph.Figure(2).name = 'Predicted Vs Simulated: total power consumption + PUE';
Parameters.Graph.Figure(2).Axis(2, 1).name = 'PUE';
Parameters.Graph.Figure(2).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(2).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(2).Axis(2, 1).yLabel = 'PUE';

Parameters.Graph.Figure(2).Axis(2, 1).Line(2).legendName = 'Predicted';
Parameters.Graph.Figure(2).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(2).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(2).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(2, 1).Line(2).sourceDataY = ...
    ['(sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Controller.Prediction.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(2).Axis(2, 1).Line(1).legendName = 'Simulated';
Parameters.Graph.Figure(2).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(2).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(2).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(2, 1).Line(1).sourceDataY = ...
    ['(sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(2).Axis(1).name = 'Zones and CRAC power';
Parameters.Graph.Figure(2).Axis(1).position = [1, 1];
Parameters.Graph.Figure(2).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(2).Axis(1).yLabel = 'Power (kW)';

Parameters.Graph.Figure(2).Axis(1).Line(4).legendName = 'Zones - Predicted';
Parameters.Graph.Figure(2).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(2).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(2).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(4).sourceDataY = ...
    'sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(2).Axis(1).Line(3).legendName = 'Cracs - Predicted';
Parameters.Graph.Figure(2).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(8, :);
Parameters.Graph.Figure(2).Axis(1).Line(3).lineStyle = '--';
Parameters.Graph.Figure(2).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(3).sourceDataY = ...
    'sum(Parameters.Controller.Prediction.cracPowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(2).Axis(1).Line(2).legendName = 'Zones';
Parameters.Graph.Figure(2).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(2).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(2).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(2).sourceDataY = ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(2).Axis(1).Line(1).legendName = 'Cracs';
Parameters.Graph.Figure(2).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(8, :);
Parameters.Graph.Figure(2).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(2).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(1).sourceDataY = ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(1).name = 'Total power consumption + PUE';
Parameters.Graph.Figure(1).Axis(1).name = 'PUE';
Parameters.Graph.Figure(1).Axis(1).position = [2, 1];
Parameters.Graph.Figure(1).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(1).Axis(1).yLabel = 'PUE';

Parameters.Graph.Figure(1).Axis(1).Line(1).legendName = 'PUE';
Parameters.Graph.Figure(1).Axis(1).Line(1).showInLegend = 'no';
Parameters.Graph.Figure(1).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(1).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(1).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(1).Line(1).sourceDataY = ...
    ['(sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1)'];

end

