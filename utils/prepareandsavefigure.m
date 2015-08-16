function prepareandsavefigure(figName, axesHandler, ...
    figureHandler)
%PREPAREANDSAVEFIGURE Prepare and save figure.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 21st 2011
set(figureHandler, 'color', 'white');
set(axesHandler, 'YGrid', 'on');
set(axesHandler, 'TickDir', 'out');
set(axesHandler, 'Box', 'off' );
set(axesHandler, 'FontSize', 14);
set(axesHandler, 'Position', get(axesHandler, 'OuterPosition') - ...
    get(axesHandler, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
export_fig(figName, '-eps', '-png', '-pdf', '-painters', '-native', ...
    '-rgb', '-r150', figureHandler);
saveas(figureHandler, figName, 'fig');
end
