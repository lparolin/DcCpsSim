function Parameters = updategraph(Parameters, ~)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

arrayfun(@(x) refreshdata(x.Handle), Parameters.Graph.Figure);
drawnow expose;

end

% 
%     function updatefigure(FigureStruct)
%         arrayfun(@updateaxis, FigureStruct.Axis);
%     end
% 
%     function updateaxis(AxisStruct)
%         arrayfun(@updateLine, AxisStruct.Line);
%     end
% 
%     function updateLine(LineStruct)
%         iTime = Parameters.Simulation.iTime; %#ok<NASGU>
%         eval(['yData = squeeze(' LineStruct.sourceDataY ');']);
%         eval(['xData = squeeze(' LineStruct.sourceDataX ');']);
% 
%         set(LineStruct.Handle, 'YData', yData);
%         set(LineStruct.Handle, 'XData', xData);
%     end
% arrayfun(@updatefigure, Parameters.Graph.Figure);
