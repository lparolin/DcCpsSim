function Parameters = computediscretetimethermalmatrices(Parameters)
%COMPUTEDISCRETETIMETHERMALMATRICES Compute the discrete-time version of
%the matrices used for the thermal subsystem. 

% Luca Parolini
% <lparolin@andrew.cmu.edu>

    % extract relevant parameters
    zoneIdx = 1 : Parameters.DcData.nZones;
    cracIdx = Parameters.DcData.nZones + 1 : ...
        Parameters.DcData.nZones + Parameters.DcData.nCracs;
    
    % compute scaled coefficients
    scaledPowerToTemperatureCoefficient = ...
        Parameters.DcData.powerToTemperatureCoefficient(zoneIdx) / ...
        Parameters.Controller.powerScalingCoefficient;
        
    % compute continuous-time system
    ContinousTimeMatrices = struct;
    diagonalTempMatrix = diag([Parameters.DcData.thermalTimeConstant(zoneIdx); ...
        zeros(length(cracIdx), 1)]);
    ContinousTimeMatrices.a = -diag(Parameters.DcData.thermalTimeConstant) + ...
        diagonalTempMatrix * Parameters.DcData.psi;
    ContinousTimeMatrices.b = diag([scaledPowerToTemperatureCoefficient; ...
        Parameters.DcData.thermalTimeConstant(cracIdx); ...
    ]);
    ContinousTimeMatrices.c = Parameters.DcData.psi;
    ContinousTimeMatrices.d = [];
   
    DiscreteTimeMatrices = computeapproximationmatrices( ...
        ContinousTimeMatrices, Parameters.Controller.timeStep, ...
        Parameters.Controller.thermalSystemMatrixAThreshold, ...
        Parameters.Controller.thermalSystemSingularvalueRatioThreshold);
    
    Parameters.Controller.continousTimeMatrixA = ContinousTimeMatrices.a;
    Parameters.Controller.continousTimeMatrixB = ContinousTimeMatrices.b;
    Parameters.Controller.continousTimeMatrixC = ContinousTimeMatrices.c;
    
    Parameters.Controller.discreteTimeMatrixA = DiscreteTimeMatrices.a;
    Parameters.Controller.discreteTimeMatrixB = DiscreteTimeMatrices.b;
    Parameters.Controller.discreteTimeMatrixC = DiscreteTimeMatrices.c;
end


