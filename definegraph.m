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
%  Lines should be defined in invert order, from higher values to lowers.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

Parameters.Graph.Figure(14).name = 'Minimum cost function';
Parameters.Graph.Figure(14).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(14).Axis(1).position = [1, 1];
Parameters.Graph.Figure(14).Axis(1).xLabel = 'Iteration';
Parameters.Graph.Figure(14).Axis(1).yLabel = 'Cost function';
Parameters.Graph.Figure(14).Axis(1).Line(1).legendName = 'Cost function';
Parameters.Graph.Figure(14).Axis(1).Line(1).showInLegend = 'no';
Parameters.Graph.Figure(14).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(14).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(14).Axis(1).Line(1).sourceDataX = ...
    '1 : iTime';
Parameters.Graph.Figure(14).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.objectiveFunction(1 : iTime)';




Parameters.Graph.Figure(13).name = 'Predicted zone input temperature';
Parameters.Graph.Figure(13).Axis(2, 1).name = 'Departure and arrival';
Parameters.Graph.Figure(13).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(13).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(13).Axis(2, 1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(13).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(13).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(13).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(13).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(13).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(13).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(13).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(13).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(13).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(13).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(13).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(13).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(13).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(5, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(13).Axis(1).position = [1, 1];
Parameters.Graph.Figure(13).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(13).Axis(1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(13).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(13).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(13).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(13).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(13).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(13).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(13).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(13).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(13).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(13).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(13).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(13).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(13).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(13).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(13).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(13).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.inputTemperature(1, 1 : iTime)';




Parameters.Graph.Figure(12).name = 'Predicted Vs Simulated: total power consumption + PUE';
Parameters.Graph.Figure(12).Axis(2, 1).name = 'PUE';
Parameters.Graph.Figure(12).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(12).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(12).Axis(2, 1).yLabel = 'PUE';

Parameters.Graph.Figure(12).Axis(2, 1).Line(2).legendName = 'Predicted';
Parameters.Graph.Figure(12).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(12).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(12).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(2, 1).Line(2).sourceDataY = ...
    ['(sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Controller.Prediction.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(12).Axis(2, 1).Line(1).legendName = 'Simulated';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(2, 1).Line(1).sourceDataY = ...
    ['(sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(12).Axis(1).name = 'Zones and CRAC power';
Parameters.Graph.Figure(12).Axis(1).position = [1, 1];
Parameters.Graph.Figure(12).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(12).Axis(1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(12).Axis(1).Line(4).legendName = 'Zones - Predicted';
Parameters.Graph.Figure(12).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(12).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(12).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(1).Line(4).sourceDataY = ...
    'sum(Parameters.Controller.Prediction.zonePowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(12).Axis(1).Line(3).legendName = 'Cracs - Predicted';
Parameters.Graph.Figure(12).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(8, :);
Parameters.Graph.Figure(12).Axis(1).Line(3).lineStyle = '--';
Parameters.Graph.Figure(12).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(1).Line(3).sourceDataY = ...
    'sum(Parameters.Controller.Prediction.cracPowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(12).Axis(1).Line(2).legendName = 'Zones';
Parameters.Graph.Figure(12).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(12).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(12).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(12).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(12).Axis(1).Line(2).sourceDataY = ...
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



Parameters.Graph.Figure(11).name = 'Predicted zone power consumption';
Parameters.Graph.Figure(11).Axis(2, 1).name = 'Zones 5 - 8';
Parameters.Graph.Figure(11).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(11).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(11).Axis(2, 1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(11).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(8, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(7, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(6, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(5, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(11).Axis(1).position = [1, 1];
Parameters.Graph.Figure(11).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(11).Axis(1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(11).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(11).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(11).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(11).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(4, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(11).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(11).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(3, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(11).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(11).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(11).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(2, 1 : iTime) / 1e3';

Parameters.Graph.Figure(11).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(11).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(11).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(11).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(11).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(11).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Controller.Prediction.zonePowerConsumption(1, 1 : iTime) / 1e3';



Parameters.Graph.Figure(10).name = 'Total power consumption + PUE';
Parameters.Graph.Figure(10).Axis(2, 1).name = 'PUE';
Parameters.Graph.Figure(10).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(10).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(10).Axis(2, 1).yLabel = 'PUE';

Parameters.Graph.Figure(10).Axis(2, 1).Line(1).legendName = 'PUE';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).showInLegend = 'no';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(5, :);
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(2, 1).Line(1).sourceDataY = ...
    ['(sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) + ' ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1)) ./' ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1)'];

Parameters.Graph.Figure(10).Axis(1).name = 'Zones and CRAC power';
Parameters.Graph.Figure(10).Axis(1).position = [1, 1];
Parameters.Graph.Figure(10).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(10).Axis(1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(10).Axis(1).Line(2).legendName = 'Zones';
Parameters.Graph.Figure(10).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(10).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(10).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1).Line(2).sourceDataY = ...
    'sum(Parameters.Simulation.zonePowerConsumption(:, 1 : iTime),1) / 1e3';

Parameters.Graph.Figure(10).Axis(1).Line(1).legendName = 'Cracs';
Parameters.Graph.Figure(10).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(10).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(8, :);
Parameters.Graph.Figure(10).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(10).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(10).Axis(1).Line(1).sourceDataY = ...
    'sum(Parameters.Simulation.cracPowerConsumption(:, 1 : iTime),1) / 1e3';


Parameters.Graph.Figure(9).name = 'Zone power consumption';
Parameters.Graph.Figure(9).Axis(2, 1).name = 'Zones 5 - 8';
Parameters.Graph.Figure(9).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(9).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(9).Axis(2, 1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(9).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(8, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(7, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(6, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(5, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(9).Axis(1).position = [1, 1];
Parameters.Graph.Figure(9).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(9).Axis(1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(9).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(9).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(9).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(4, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(9).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(9).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(3, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(9).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(9).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(9).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(2, 1 : iTime) / 1e3';

Parameters.Graph.Figure(9).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(9).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(9).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(9).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(9).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(9).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.zonePowerConsumption(1, 1 : iTime) / 1e3';




Parameters.Graph.Figure(8).name = 'Dropped jobs';
Parameters.Graph.Figure(8).Axis(2, 1).name = 'Dropped jobs';
Parameters.Graph.Figure(8).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(8).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(2, 1).yLabel = 'Jobs';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).legendName = 'Class 2';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.red(2, :);
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 1).Line(2).sourceDataY = ...
    ['squeeze(sum(Parameters.Simulation.queueLength(:, 2, 1 : iTime) + ' ...
    '(Parameters.Simulation.jobArrivalRateToZone(:, 2, 1 : iTime) - ' ...
    'Parameters.Simulation.jobDepartureRate(:, 2, 1 : iTime) ) * ' ...
    'Parameters.Simulation.timeStep - ' ...
    'Parameters.Simulation.queueLength(:, 2, 2 : iTime + 1), 1))'];

Parameters.Graph.Figure(8).Axis(2, 1).Line(1).legendName = 'Class 1';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(3, :);
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(2, 1).Line(1).sourceDataY = ...
    ['squeeze(sum(Parameters.Simulation.queueLength(:, 1, 1 : iTime) + ' ...
    '(Parameters.Simulation.jobArrivalRateToZone(:, 1, 1 : iTime) - ' ...
    'Parameters.Simulation.jobDepartureRate(:, 1, 1 : iTime) ) * ' ...
    'Parameters.Simulation.timeStep - ' ...
    'Parameters.Simulation.queueLength(:, 1, 2 : iTime + 1), 1))'];

Parameters.Graph.Figure(8).Axis(1, 1).name = 'Dropped jobs';
Parameters.Graph.Figure(8).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(8).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(1, 1).yLabel = 'Dropped job rate (Job/s)';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).legendName = 'Class 2';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.red(2, :);
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 1).Line(2).sourceDataY = ...
    '1 - squeeze(sum(Parameters.Simulation.relativeJobAllocation(:, 2, 1 : iTime), 1))';

Parameters.Graph.Figure(8).Axis(1, 1).name = 'Dropped jobs';
Parameters.Graph.Figure(8).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(8).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(8).Axis(1, 1).yLabel = 'Dropped job rate (Job/s)';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).legendName = 'Class 1';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(3, :);
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(8).Axis(1, 1).Line(1).sourceDataY = ...
    '1 - squeeze(sum(Parameters.Simulation.relativeJobAllocation(:, 1, 1 : iTime), 1))';




Parameters.Graph.Figure(7).name = 'CRAC coefficient of performance';
Parameters.Graph.Figure(7).Axis(1).name = 'COP';
Parameters.Graph.Figure(7).Axis(1).position = [2, 2];
Parameters.Graph.Figure(7).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(7).Axis(1).yLabel = 'COP';

Parameters.Graph.Figure(7).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(7).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(1, :);
Parameters.Graph.Figure(7).Axis(1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.coefficientOfPerformance(4, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(7).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.green(1, :);
Parameters.Graph.Figure(7).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.coefficientOfPerformance(3, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(7).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(7).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.coefficientOfPerformance(2, 1 : iTime)';

Parameters.Graph.Figure(7).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(7).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(7).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(1, :);
Parameters.Graph.Figure(7).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(7).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(7).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.coefficientOfPerformance(1, 1 : iTime)';




Parameters.Graph.Figure(6).name = 'CRAC power consumption';
Parameters.Graph.Figure(6).Axis(1).name = 'Power consumption';
Parameters.Graph.Figure(6).Axis(1).position = [2, 2];
Parameters.Graph.Figure(6).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(6).Axis(1).yLabel = 'Power (KW)';

Parameters.Graph.Figure(6).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(6).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.yellow(1, :);
Parameters.Graph.Figure(6).Axis(1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(4, 1 : iTime) / 1e3';

Parameters.Graph.Figure(6).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(6).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.green(1, :);
Parameters.Graph.Figure(6).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(3, 1 : iTime) / 1e3';

Parameters.Graph.Figure(6).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(6).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(6).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(2, 1 : iTime) / 1e3';

Parameters.Graph.Figure(6).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(6).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(6).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(1, :);
Parameters.Graph.Figure(6).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(6).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(6).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.cracPowerConsumption(1, 1 : iTime) / 1e3';



Parameters.Graph.Figure(5).name = 'CRAC Output/Input and reference temperature';
Parameters.Graph.Figure(5).Axis(2, 2).name = 'CRAC 4';
Parameters.Graph.Figure(5).Axis(2, 2).position = [2, 2];
Parameters.Graph.Figure(5).Axis(2, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(2, 2).yLabel = 'CRAC_4 (C)';

Parameters.Graph.Figure(5).Axis(2, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(5).Axis(2, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(9, :);
Parameters.Graph.Figure(5).Axis(2, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(12, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(5).Axis(2, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(5).Axis(2, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(2, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(12, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(5).Axis(2, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(9, :);
Parameters.Graph.Figure(5).Axis(2, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(4, 1 : iTime)';


Parameters.Graph.Figure(5).Axis(1, 2).name = 'CRAC 3';
Parameters.Graph.Figure(5).Axis(1, 2).position = [1, 2];
Parameters.Graph.Figure(5).Axis(1, 2).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(1, 2).yLabel = 'CRAC_3 (C)';

Parameters.Graph.Figure(5).Axis(1, 2).Line(3).legendName = 'Output';
Parameters.Graph.Figure(5).Axis(1, 2).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 2).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(8, :);
Parameters.Graph.Figure(5).Axis(1, 2).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1, 2).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 2).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(11, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1, 2).Line(2).legendName = 'Input';
Parameters.Graph.Figure(5).Axis(1, 2).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 2).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(5).Axis(1, 2).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(1, 2).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 2).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(11, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1, 2).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(5).Axis(1, 2).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 2).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(5).Axis(1, 2).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1, 2).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 2).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(3, 1 : iTime)';


Parameters.Graph.Figure(5).Axis(2, 1).name = 'CRAC 2';
Parameters.Graph.Figure(5).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(5).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(2, 1).yLabel = 'CRAC_2 (C)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(7, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(10, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(10, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(2, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(7, :);
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(2, 1 : iTime)';


Parameters.Graph.Figure(5).Axis(1, 1).name = 'CRAC 1';
Parameters.Graph.Figure(5).Axis(1, 1).position = [1, 1];
Parameters.Graph.Figure(5).Axis(1, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(5).Axis(1, 1).yLabel = 'CRAC_1 (C)';

Parameters.Graph.Figure(5).Axis(1, 1).Line(3).legendName = 'Output';
Parameters.Graph.Figure(5).Axis(1, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(5).Axis(1, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(9, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1, 1).Line(2).legendName = 'Input';
Parameters.Graph.Figure(5).Axis(1, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(5).Axis(1, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(5).Axis(1, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(9, 1 : iTime)';

Parameters.Graph.Figure(5).Axis(1, 1).Line(1).legendName = 'Ref.';
Parameters.Graph.Figure(5).Axis(1, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(5).Axis(1, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(6, :);
Parameters.Graph.Figure(5).Axis(1, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(5).Axis(1, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(5).Axis(1, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.referenceTemperature(1, 1 : iTime)';

Parameters.Graph.Figure(4).name = 'Zone input temperature';
Parameters.Graph.Figure(4).Axis(2, 1).name = 'Departure and arrival';
Parameters.Graph.Figure(4).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(4).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(4).Axis(2, 1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(5, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(4).Axis(1).position = [1, 1];
Parameters.Graph.Figure(4).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(4).Axis(1).yLabel = 'Input temperature (C)';

Parameters.Graph.Figure(4).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(4).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(4).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(4).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(4).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(4).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(4).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(4).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(4).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(4).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(4).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(4).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(4).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(4).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.inputTemperature(1, 1 : iTime)';

Parameters.Graph.Figure(3).name = 'Zone Output temperature';
Parameters.Graph.Figure(3).Axis(2, 1).name = 'Departure and arrival';
Parameters.Graph.Figure(3).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(3).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(3).Axis(2, 1).yLabel = 'Output temperature (C)';

Parameters.Graph.Figure(3).Axis(2, 1).Line(4).legendName = '8';
Parameters.Graph.Figure(3).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.purple(1, :);
Parameters.Graph.Figure(3).Axis(2, 1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(3).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(8, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(2, 1).Line(3).legendName = '7';
Parameters.Graph.Figure(3).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.lightBlue(1, :);
Parameters.Graph.Figure(3).Axis(2, 1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(3).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(7, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(2, 1).Line(2).legendName = '6';
Parameters.Graph.Figure(3).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.brown(1, :);
Parameters.Graph.Figure(3).Axis(2, 1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(3).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(6, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(2, 1).Line(1).legendName = '5';
Parameters.Graph.Figure(3).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(3).Axis(2, 1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(3).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(5, 1 : iTime)';


Parameters.Graph.Figure(3).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(3).Axis(1).position = [1, 1];
Parameters.Graph.Figure(3).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(3).Axis(1).yLabel = 'Output temperature (C)';

Parameters.Graph.Figure(3).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(3).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.blue(4, :);
Parameters.Graph.Figure(3).Axis(1).Line(4).lineStyle = '--';
Parameters.Graph.Figure(3).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(4, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(3).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(3).Axis(1).Line(3).lineStyle = '-';
Parameters.Graph.Figure(3).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(3, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(3).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(2, :);
Parameters.Graph.Figure(3).Axis(1).Line(2).lineStyle = '--';
Parameters.Graph.Figure(3).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(2, 1 : iTime)';

Parameters.Graph.Figure(3).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(3).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(3).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.blue(8, :);
Parameters.Graph.Figure(3).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(3).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(3).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.outputTemperature(1, 1 : iTime)';


Parameters.Graph.Figure(2).name = 'Total departure and arrival rate';
Parameters.Graph.Figure(2).Axis(1).name = 'Departure and arrival';
Parameters.Graph.Figure(2).Axis(1).position = [1, 1];
Parameters.Graph.Figure(2).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(2).Axis(1).yLabel = 'Job rate';

Parameters.Graph.Figure(2).Axis(1).Line(3).legendName = 'Execution';
Parameters.Graph.Figure(2).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.green(1, :);
Parameters.Graph.Figure(2).Axis(1).Line(3).lineStyle = '--';
Parameters.Graph.Figure(2).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(3).sourceDataY = ...
    'squeeze(sum(Parameters.Simulation.jobExecutionRate(:, 1, 1 : iTime), 1))';

Parameters.Graph.Figure(2).Axis(1).Line(2).legendName = 'Departure';
Parameters.Graph.Figure(2).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.red(1, :);
Parameters.Graph.Figure(2).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(2).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(2).sourceDataY = ...
    'squeeze(sum(Parameters.Simulation.jobDepartureRate(:, 1, 1 : iTime), 1))';

Parameters.Graph.Figure(2).Axis(1).Line(1).legendName = 'Arrival';
Parameters.Graph.Figure(2).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(2).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.green(7, :);
Parameters.Graph.Figure(2).Axis(1).Line(1).lineStyle = '-';
Parameters.Graph.Figure(2).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(2).Axis(1).Line(1).sourceDataY = ...
    'squeeze(sum(Parameters.Simulation.jobArrivalRateToZone(:, 1, 1 : iTime), 1))';


Parameters.Graph.Figure(1).name = 'Queue Length';
Parameters.Graph.Figure(1).Axis(2, 1).name = 'Zone 5-8';
Parameters.Graph.Figure(1).Axis(2, 1).position = [2, 1];
Parameters.Graph.Figure(1).Axis(2, 1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(1).Axis(2, 1).yLabel = 'Job';

Parameters.Graph.Figure(1).Axis(2, 1).Line(4).legendName = '5';
Parameters.Graph.Figure(1).Axis(2, 1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(2, 1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.green(5, :);
Parameters.Graph.Figure(1).Axis(2, 1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(1).Axis(2, 1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(2, 1).Line(4).sourceDataY = ...
    'Parameters.Simulation.queueLength(5, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(2, 1).Line(3).legendName = '6';
Parameters.Graph.Figure(1).Axis(2, 1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(2, 1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(6, :);
Parameters.Graph.Figure(1).Axis(2, 1).Line(3).lineStyle = '--';
Parameters.Graph.Figure(1).Axis(2, 1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(2, 1).Line(3).sourceDataY = ...
    'Parameters.Simulation.queueLength(6, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(2, 1).Line(2).legendName = '7';
Parameters.Graph.Figure(1).Axis(2, 1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(2, 1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(7, :);
Parameters.Graph.Figure(1).Axis(2, 1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(1).Axis(2, 1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(2, 1).Line(2).sourceDataY = ...
    'Parameters.Simulation.queueLength(7, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(2, 1).Line(1).legendName = '8';
Parameters.Graph.Figure(1).Axis(2, 1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(2, 1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(8, :);
Parameters.Graph.Figure(1).Axis(2, 1).Line(1).lineStyle = '--';
Parameters.Graph.Figure(1).Axis(2, 1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(2, 1).Line(1).sourceDataY = ...
    'Parameters.Simulation.queueLength(8, 1, 1 : iTime)';



Parameters.Graph.Figure(1).Axis(1).name = 'Zone 1-4';
Parameters.Graph.Figure(1).Axis(1).position = [1, 1];
Parameters.Graph.Figure(1).Axis(1).xLabel = 'Time (hr)';
Parameters.Graph.Figure(1).Axis(1).yLabel = 'Job';

Parameters.Graph.Figure(1).Axis(1).Line(4).legendName = '4';
Parameters.Graph.Figure(1).Axis(1).Line(4).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(1).Line(4).color = ...
    Parameters.Graph.DefaultValue.Color.green(5, :);
Parameters.Graph.Figure(1).Axis(1).Line(4).lineStyle = '-';
Parameters.Graph.Figure(1).Axis(1).Line(4).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(1).Line(4).sourceDataY = ...
    'Parameters.Simulation.queueLength(4, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(1).Line(3).legendName = '3';
Parameters.Graph.Figure(1).Axis(1).Line(3).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(1).Line(3).color = ...
    Parameters.Graph.DefaultValue.Color.red(3, :);
Parameters.Graph.Figure(1).Axis(1).Line(3).lineStyle = '--';
Parameters.Graph.Figure(1).Axis(1).Line(3).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(1).Line(3).sourceDataY = ...
    'Parameters.Simulation.queueLength(3, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(1).Line(2).legendName = '2';
Parameters.Graph.Figure(1).Axis(1).Line(2).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(1).Line(2).color = ...
    Parameters.Graph.DefaultValue.Color.green(7, :);
Parameters.Graph.Figure(1).Axis(1).Line(2).lineStyle = '-';
Parameters.Graph.Figure(1).Axis(1).Line(2).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(1).Line(2).sourceDataY = ...
    'Parameters.Simulation.queueLength(2, 1, 1 : iTime)';

Parameters.Graph.Figure(1).Axis(1).Line(1).legendName = '1';
Parameters.Graph.Figure(1).Axis(1).Line(1).showInLegend = 'yes';
Parameters.Graph.Figure(1).Axis(1).Line(1).color = ...
    Parameters.Graph.DefaultValue.Color.red(8, :);
Parameters.Graph.Figure(1).Axis(1).Line(1).lineStyle = '--';
Parameters.Graph.Figure(1).Axis(1).Line(1).sourceDataX = ...
    'Parameters.Simulation.time(1 : iTime) / 3600';
Parameters.Graph.Figure(1).Axis(1).Line(1).sourceDataY = ...
    'Parameters.Simulation.queueLength(1, 1, 1 : iTime)';


end

