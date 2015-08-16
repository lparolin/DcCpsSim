function newCellArray = createcelloftomsym(baseName, nCells, dimensions)
% NEWCELLARRAY Create a cell of tomSym objects.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

    newCellArray = cell(nCells, 1);
    for iCell = 1 : nCells
        newCellArray{iCell} = tom([baseName num2str(iCell - 1)], ...
            dimensions(1), dimensions(2));
    end
end

