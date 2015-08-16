function Values = computemeanwithrespecttovector( ...
    vector, threshold, OriginalValues)
%computemeanwithrespecttovector

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 23rd 2011

Values = OriginalValues;

valuesName = fieldnames(Values);
jj = 1;
while jj < length(vector)
    higherValue = vector(jj) + threshold / 2;
    lowerValue =  vector(jj) - threshold / 2;
    equalValuesIdx = (vector >= lowerValue) & (vector <= higherValue);
    meanValue = mean(vector(equalValuesIdx));
    vector(jj) = meanValue;
    idxToKeep = [true(jj, 1); ~equalValuesIdx(jj + 1 : end)];
    
    vector = vector(idxToKeep);
    
    for iValues = 1 : length(valuesName)
        tmpValues = Values.(valuesName{iValues});
        meanValue = mean(tmpValues(equalValuesIdx));
        tmpValues(jj) = meanValue;
        tmpValues = tmpValues(idxToKeep);
        Values.(valuesName{iValues}) = tmpValues;
    end
    jj = jj + 1;
end
Values.baseVector = vector;
end

