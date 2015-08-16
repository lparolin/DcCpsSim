function Parameters = loadconstant(Parameters)
%LOADCONSTANT Generate constants for the simulation.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

    Parameters.CONSTANT = struct;
    Parameters.CONSTANT.SERVER_TIME_CONSTANT = 1/180;   % [1/s]
    Parameters.CONSTANT.AIR_HEAT_CAPACITY = 1.0035e3;   % [J/Kg K]
    Parameters.CONSTANT.AIR_DENSITY = 1.16;             % [kg/m^3] at 20C
    
    % data from Moore J. et al. "Making scheduling "cool": Temperature aware
    % resource assignement in data centers. Usenix Apr. 2005
    Parameters.CONSTANT.COP_DEFAULT_COEFFICIENTS = [0.0068; 0.0008; 0.458];
    Parameters.CONSTANT.FAN_POWER_MAX = 0;              % [W]
    Parameters.CONSTANT.SERVER_POWER_MAX = 350;         % [W]
    Parameters.CONSTANT.SERVER_AIRFLOW = 0.0597;        % [Kg/s] data estimated for a 1U server
    Parameters.CONSTANT.ZONE_TIN_MAX = 27;              % [C]
    Parameters.CONSTANT.ZONE_TIN_MIN = -Inf;            % [C]
    Parameters.CONSTANT.CRAC_TREF_MAX = 28;             % [C]
    Parameters.CONSTANT.CRAC_TREF_MIN = 5;              % [C]
    Parameters.CONSTANT.ELECTRICITY_COST_MAX = 0.3;     % [$/MWh]

    % Specific to the simulation
    Parameters.CONSTANT.CRAC_TIME_CONSTANT = ...
        3 * Parameters.CONSTANT.SERVER_TIME_CONSTANT;
    Parameters.CONSTANT.ENV_CLASS_1_TIME_CONSTANT = ...
        Parameters.CONSTANT.SERVER_TIME_CONSTANT;
end

