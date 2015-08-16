function powerToTemperatureCoefficient = ...
    computepowertotemperaturecoefficient(DcData, newAirHeatCapacity)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

persistent AIR_HEAT_CAPACITY;

if nargin == 2
    AIR_HEAT_CAPACITY = newAirHeatCapacity;
end

powerToTemperatureCoefficient = DcData.thermalTimeConstant ./ ...
    DcData.airFlow .* AIR_HEAT_CAPACITY;

if (AIR_HEAT_CAPACITY == 0) && (nargin == 1)
    msgIdentComponent = upper(mfilename);
    msgIdentMnemonic = 'InputVariableCheck';
    msgIdent = [msgIdentComponent ':' msgIdentMnemonic];
    errorToThrow = MException(msgIdent, 'AIR_HEAT_CAPACITY non defined.');
    logandthrowerror(errorToThrow);
end


end

