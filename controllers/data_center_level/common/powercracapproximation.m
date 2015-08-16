function [powerCracAverage constraints limits]= powercracapproximation(Parameters)
% 
%POWERCRACAPPROXIMATION Approximate average CRAC power consumption over a time interval.
%
%Compute the expected CRAC power consumption with a trapezoidal
%   approximation

% Luca Parolini 
% <lparolin@andrew.cmu.edu>


persistent Adt
persistent Bdt 
persistent Cdt 
nPoints = Parameters.nPoints;

constraints = cell(nPoints, 1);
limits = cell(nPoints, 1);

if isempty(Adt)
    Act = Parameters.temperatureEvolutionMatrixContinuousTime;
    Bct = Parameters.InputToStateMatrixContinuousTime;
    Cct = Parameters.StateToOutputMatrixContinuousTime;
    dt = Parameters.samplingTime / Parameters.nPoints;
    continuousTimeSys = ss(Act, Bct, Cct, []);              % create a cont. time system
    discreteTimeSys = c2d(continuousTimeSys, dt, 'zoh');    % create the eq. discrete time sys
    Adt = discreteTimeSys.a; Bdt = discreteTimeSys.b; Cdt = discreteTimeSys.c;
    clear continuousTimeSys discreteTimeSys
end

tin = cell(nPoints, 1);
tout = cell(nPoints, 1);
powerCracPartial = cell(nPoints, 1);
[pwBasePower gradient Hessian d3pwdTout3] = ...
            cracpowerconsumptionthirdorderapproximation(Parameters.tin0, ...
            Parameters.tout0, Parameters.cop, Parameters.coefficient);

for iStep = 1 : Parameters.nPoints
    tout{iStep} = tom(['toutCrac' '_' num2str(Parameters.idx) '_' num2str(Parameters.currentTimeStep) '_' num2str(iStep) ...
        '_of_' num2str(Parameters.nPoints)], length(Parameters.currentT0), 1);
end
        
tout{1} = Parameters.currentT0;       % initialize variable
tin{1} = Cdt*tout{1};
dtout = tout{1}(Parameters.cracIdx) - Parameters.tout0; 
dtin = tin{1}(Parameters.cracIdx) - Parameters.tin0; 
powerCracPartial{1} = pwBasePower + gradient' * [dtin; dtout] + ...
    1/2 * [dtin; dtout]' * Hessian * [dtin; dtout] + ...
    1/6 * dtout^3 * d3pwdTout3;

powerCracPartialAverage = 0;
for k = 1 : nPoints - 1
    if isscalar(Parameters.pwEnv) && (Parameters.pwEnv == 0)
        tout{k+1} = Adt * tout{k} + Bdt * [Parameters.nodePower; ...
            Parameters.Tref];
    else
        tout{k+1} = Adt * tout{k} + Bdt * [Parameters.nodePower; ...
            Parameters.Tref; Parameters.pwEnv];
    end
    
    tin{k+1} = Cdt * tout{k+1};
    dtout = tout{k+1}(Parameters.cracIdx) - Parameters.tout0; 
    dtin = tin{k+1}(Parameters.cracIdx) - Parameters.tin0; 
    powerCracPartial{k+1} = pwBasePower + gradient' * [dtin; dtout] + ...
        1/2 * [dtin; dtout]' * Hessian * [dtin; dtout] + ...
        1/6 * dtout^3 * d3pwdTout3;
    
    powerCracPartialAverage = powerCracPartialAverage + ...
        (powerCracPartial{k} + powerCracPartial{k+1}) / 2;
    
end
powerCracAverage = powerCracPartialAverage / (nPoints-1);

end

