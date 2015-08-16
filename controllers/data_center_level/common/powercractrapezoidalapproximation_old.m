function powerCracAverage = powerCracTrapezoidalApproximation(Parameters)
% 
% Act, Bct, Cct, Tout, pw_node, Tref, ...
%         pw_env, T_end, cop_func_pointer, flow, cp)
%UNTITLED pw_crac = std_crac_pw_trap_approx(Act, Bct, Psi, Tout, Tref, ...
%        pw_node, pw_env, Tend)
%   Compute the expected CRAC power consumption with a trapezoidal
%   approximation


% Luca Parolini 
% <lparolin@andrew.cmu.edu>


persistent Adt
persistent Bdt 
persistent Cdt 
nPoints = Parameters.nPoints;

if isempty(Adt)
    Act = Parameters.temperatureEvolutionMatrixContinuousTime;
    Bct = Parameters.InputToStateMatrixContinuousTime;
    Cct = Parameters.StateToOutputMatrixContinuousTime;
    dt = Parameters.samplingTime / Parameters.nPoints;
    continuousTimeSys = ss(Act, Bct, Cct, []);       % create a cont. time system
    discreteTimeSys = c2d(continuousTimeSys, dt, 'zoh');    % create the eq. discrete time sys
    Adt = discreteTimeSys.a; Bdt = discreteTimeSys.b; Cdt = discreteTimeSys.c;
    clear continuousTimeSys discreteTimeSys
end

tin = cell(nPoints, 1);
tout = cell(nPoints, 1);
powerCracPartial = cell(nPoints, 1);
% tin = zeros(length(Tout), nPoints);
% tout = zeros(length(Tout), nPoints);
% pw_partial = zeros(length(Tout), nPoints);

tout{1} = Parameters.currentT0;       % initialize variable
tin{1} = Cdt*tout{1};    
powerCracPartial{1} = Parameters.cracPowerFunctionPointer( ...
    Parameters.cracPowerFunctionParameters, tin{1}, tout{1});

for k = 1 : nPoints - 1
    if isscalar(Parameters.pwEnv) && (Parameters.pwEnv == 0)
        tout{k+1} = Adt * tout{k} + Bdt * [Parameters.nodePower; ...
            Parameters.Tref];
        %tout(:, k+1) = Adt * tout(:, k) + Bdt * [pw_node; Tref];
    else
        tout{k+1} = Adt * tout{k} + Bdt * [Parameters.nodePower; ...
            Parameters.Tref; Parameters.pwEnv];
%        tout(:, k+1) = Adt * tout(:, k) + Bdt * [pw_node; Tref; pw_env];
    end
    
    tin{k+1} = Cdt * tout{k+1};
    powerCracPartial{k+1} = Parameters.cracPowerFunctionPointer( ...
        Parameters.cracPowerFunctionParameters, tin{k}, tout{k});
        powerCracPartialAverage = powerCracPartialAverage + ...
        1/2 * (powerCracPartial{k+1} + powerCracPartial{k}) ;
%      tin(:, k+1) = Cdt * tout(:, k+1);
%      pw_partial(:, k+1) = ...
%          (tin(:, k+1) - tout(:, k+1))./cop_func_pointer(tout(:, k+1));
%      partial_sum = 1/2 * (pw_partial(:, k+1) + pw_partial(:, k));
% 
end
powerCracAverage = powerCracPartialAverage / (nPoints-1);
end

