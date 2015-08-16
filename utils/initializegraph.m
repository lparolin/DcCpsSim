function Parameters = initializegraph(Parameters)
%INITIALIZEGRAPH Initialize the graph structure

Parameters.Graph.DefaultValue.Color.green = [101 245 101; 151 245 101; ...
    102 220 88; 86 186 74;  74 186 99; 98 242 130; 55 137 57; 91 212 86; ...
    48 120 51; 98 203 82] / 255;
Parameters.Graph.DefaultValue.Color.red = [161 32 32; 225 45 78; ...
    225 90 114; 225 47 112; 141 6 5; 248 97 84; 249 32 84;  174 63 89; ...
    237 113 56; 237 56 145] / 255;
Parameters.Graph.DefaultValue.Color.blue = [52 52 245; 91 65 255; ...
    65 92 255; 44 76 167; 23 100 232; 0 53 143; 54 23 238; 101 75 255; ...
    27 7 143; 66 99 255] / 255;
Parameters.Graph.DefaultValue.Color.brown = [139 39 9; 175 120 104; ...
    131 52 44; 98 43 38; 143 51 17; 135 84 65; 162 124 110; 178 108 21; ...
    126 72 3; 178 130 89] / 255;
Parameters.Graph.DefaultValue.Color.yellow = [217 219 19; 191 192 33; ...
    224 207 41; 207 191 34; 231 176 19; 173 179 89; 182 195 0; 195 183 0; ...
    218 185 69; 248 214 80] / 255;
Parameters.Graph.DefaultValue.Color.lightBlue = [0 203 196; 0 155 203; ...
    63 212 197; 45 225 244; 152 217 224; 68 142 196; 29 129 252; ...
    15 185 203; 25 146 227; 0 153 189] / 255;
Parameters.Graph.DefaultValue.Color.purple = [199 34 185; 234 114 224; ...
    157 68 150; 255 97 242; 172 0 158; 147 43 97; 185 0 191; 147 65 197; ...
    113 0 181; 198 86 176] / 255;

set(0, 'DefaultFigureColor','white')
set(0, 'DefaultFigureUnits', 'inches');
set(0, 'DefaultFigurePosition', [2 2 7.5 5]);
set(0, 'DefaultFigurePaperPositionMode', 'auto');

Parameters.Graph.DefaultValue.Figure.name = ''; 
Parameters.Graph.DefaultValue.Figure.path = './'; 
% Parameters.Graph.DefaultValue.Figure.exportFigParameters = ...
%    '''-png'', ''-pdf'', ''-painters'', ''-rgb'', ''-r200''';
Parameters.Graph.DefaultValue.Figure.Axis.name = ''; 
Parameters.Graph.DefaultValue.Figure.Axis.position = ''; 
Parameters.Graph.DefaultValue.Figure.Axis.xLabel = ''; 
Parameters.Graph.DefaultValue.Figure.Axis.fontSize = 12;
Parameters.Graph.DefaultValue.Figure.Axis.xFontSize = 16; 
Parameters.Graph.DefaultValue.Figure.Axis.yLabel = ''; 
Parameters.Graph.DefaultValue.Figure.Axis.yFontSize = 16; 
Parameters.Graph.DefaultValue.Figure.Axis.position = [1 1]; 
Parameters.Graph.DefaultValue.Figure.Axis.legendLocation = 'Best'; 
Parameters.Graph.DefaultValue.Figure.Axis.legendFontSize = 14;
Parameters.Graph.DefaultValue.Figure.Axis.Line.legendName = ''; 
Parameters.Graph.DefaultValue.Figure.Axis.Line.showInLegend = 'no'; 
Parameters.Graph.DefaultValue.Figure.Axis.Line.color = [0, 0, 0,];  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.lineStyle = '-';  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.lineWidth = 2;  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.marker = 'none';  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.markerEdgeColor = [0, 0, 0];  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.markerFaceColor = [0, 0, 0];  % black
Parameters.Graph.DefaultValue.Figure.Axis.Line.markerSize = 8;  % black

Parameters = definegraph(Parameters);


Parameters.Graph.Figure = arrayfun(@generateandpreparefigure, ...
    Parameters.Graph.Figure);
drawnow;

    function FigureStruct = generateandpreparefigure(FigureStruct)
        FigureStruct.Handle = figure('name', FigureStruct.name, ...
            'numbertitle','off'); 
        set(FigureStruct.Handle, 'color', 'white');

        [nHorizontalAxes nVerticalAxes] = size(FigureStruct.Axis);
        %nLines = 0;
        for iHorizontalAxis = 1 : nHorizontalAxes
            for iVerticalAxis = 1 : nVerticalAxes
                nCurrentAxis = iVerticalAxis + nVerticalAxes * (iHorizontalAxis - 1);
                FigureStruct.Axis(nCurrentAxis).Handle = ...
                    subplot(nHorizontalAxes, nVerticalAxes, nCurrentAxis);

                defaultAxisFieldName = ...
                    fieldnames(Parameters.Graph.DefaultValue.Figure.Axis);
                for iFieldName = 1 : length(defaultAxisFieldName)
                    if (~isfield(FigureStruct.Axis(nCurrentAxis), ...
                            defaultAxisFieldName(iFieldName))) || ...
                        (isempty(FigureStruct.Axis(nCurrentAxis).(defaultAxisFieldName{iFieldName})))
                        % add the missing field with the default value
                        FigureStruct.Axis(nCurrentAxis).(defaultAxisFieldName{iFieldName}) = ...
                            Parameters.Graph.DefaultValue.Figure.Axis.(defaultAxisFieldName{iFieldName});
                    end
                end

                % set the figure parent of the axis
                set(FigureStruct.Axis(nCurrentAxis).Handle, 'Parent', ...
                    FigureStruct.Handle);
                set(get(FigureStruct.Axis(nCurrentAxis).Handle, 'XLabel'), ...
                    'FontSize', FigureStruct.Axis(nCurrentAxis).xFontSize);
                set(get(FigureStruct.Axis(nCurrentAxis).Handle, 'YLabel'), ...
                    'FontSize', FigureStruct.Axis(nCurrentAxis).yFontSize);

                set(FigureStruct.Axis(nCurrentAxis).Handle, 'YGrid', 'on');
                set(FigureStruct.Axis(nCurrentAxis).Handle, 'TickDir', 'out');
                set(FigureStruct.Axis(nCurrentAxis).Handle, 'Box', 'off' );

                set(FigureStruct.Axis(nCurrentAxis).Handle, 'FontSize', ...
                    FigureStruct.Axis(nCurrentAxis).fontSize);

                %add x and y label
                set(get(FigureStruct.Axis(nCurrentAxis).Handle, 'XLabel'), ...
                    'String', FigureStruct.Axis(nCurrentAxis).xLabel);
                set(get(FigureStruct.Axis(nCurrentAxis).Handle, 'YLabel'), ...
                    'String', FigureStruct.Axis(nCurrentAxis).yLabel);

                set(FigureStruct.Axis(nCurrentAxis).Handle,'LooseInset', ...
                    get(FigureStruct.Axis(nCurrentAxis).Handle,'TightInset'));

                axisHandleTemporary = FigureStruct.Axis(nCurrentAxis).Handle * ...
                    ones(size(FigureStruct.Axis(nCurrentAxis).Line));
                FigureStruct.Axis(nCurrentAxis).Line = ...
                    arrayfun(@generateandprepareplot, ...
                    FigureStruct.Axis(nCurrentAxis).Line, axisHandleTemporary);

                % add legend
                legendName = arrayfun(@(x) x.legendName, ...
                    FigureStruct.Axis(nCurrentAxis).Line, 'Uniform', false);
                FigureStruct.Axis(nCurrentAxis).legendHandle = legend(legendName);
                set(FigureStruct.Axis(nCurrentAxis).legendHandle, 'Location', ...
                    FigureStruct.Axis(nCurrentAxis).legendLocation);
                set(FigureStruct.Axis(nCurrentAxis).legendHandle, 'FontSize', ...
                    FigureStruct.Axis(nCurrentAxis).legendFontSize);
            end
        end
    end

    function LineStruct = generateandprepareplot(LineStruct, AxisHandler)
        defaultLineFieldName = ...
            fieldnames(Parameters.Graph.DefaultValue.Figure.Axis.Line);
        for iFieldName = 1 : length(defaultLineFieldName)
            if (~isfield(LineStruct, defaultLineFieldName(iFieldName))) || ...
                (isempty(LineStruct.(defaultLineFieldName{iFieldName})))
                % add the missing field with the default value
                LineStruct.(defaultLineFieldName{iFieldName}) = ...
                    Parameters.Graph.DefaultValue.Figure.Axis.Line.(defaultLineFieldName{iFieldName});
            end
        end
        hold on
        LineStruct.Handle = plot(AxisHandler, 0, 0, 'Color', ...
            LineStruct.color, 'LineStyle', LineStruct.lineStyle, ...
            'LineWidth', LineStruct.lineWidth, ...
            'Marker', LineStruct.marker, ...
            'MarkerEdgeColor', LineStruct.markerEdgeColor, ...
            'MarkerFaceColor', LineStruct.markerFaceColor, ...
            'MarkerSize', LineStruct.markerSize);
        set(LineStruct.Handle, 'XDataSource', LineStruct.sourceDataX);
        set(LineStruct.Handle, 'YDataSource', LineStruct.sourceDataY);
    end
end