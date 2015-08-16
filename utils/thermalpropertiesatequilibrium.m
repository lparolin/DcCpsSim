function ThermalDataAtEquilibrium = thermalpropertiesatequilibrium(DcData)
% checkthermalpropertiesatequilibrium(DcData) check thermal properties of the data
% center at the thermal equilibrium.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 20th 2011

ThermalData = struct;
% recirculation matrix
ThermalData.psiNN = DcData.psi{end}(DcData.zoneIdx, DcData.zoneIdx); 
% from CRAC to zones
ThermalData.psiNC = DcData.psi{end}(DcData.zoneIdx, DcData.cracIdx);

% ThermalData.zonePowerMin = 0; 
% ThermalData.zone = DcData.zonePowerMax;
% ThermalData.maxTin = DcData.zoneTinMax;
% ThermalData.trefMin = DcData.trefMin;

DcData.zonePowerMin =  zeros(DcData.nZones, 1);

tmpVec = DcData.powerToTemperatureCoefficient{end};
ThermalData.ci = tmpVec(DcData.zoneIdx);
ThermalData.ki = DcData.thermalTimeConstant(DcData.zoneIdx);

% compute tin and tout values at the thermal equilibrium
tinPowerMinTrefMin = computetinatequilibrium(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMin);
tinPowerMinTrefMax = computetinatequilibrium(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMax);
tinPowerMaxTrefMin = computetinatequilibrium(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMin);
tinPowerMaxTrefMax = computetinatequilibrium(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMax);

toutPowerMinTrefMin = computetoutatequilibrium(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMin);
toutPowerMinTrefMax = computetoutatequilibrium(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMax);
toutPowerMaxTrefMin = computetoutatequilibrium(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMin);
toutPowerMaxTrefMax = computetoutatequilibrium(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMax);

lwpiPowerMinTrefMin = computelwpi(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMin, DcData.trefMin, DcData.zoneTinMax);
lwpiPowerMinTrefMax = computelwpi(ThermalData, ...
    DcData.zonePowerMin, DcData.trefMax, DcData.trefMin, DcData.zoneTinMax);
lwpiPowerMaxTrefMin = computelwpi(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMin, DcData.trefMin, DcData.zoneTinMax);
lwpiPowerMaxTrefMax = computelwpi(ThermalData, ...
    DcData.zonePowerMax, DcData.trefMax, DcData.trefMin, DcData.zoneTinMax);

ThermalDataAtEquilibrium = struct;
ThermalDataAtEquilibrium.tinPowerMinTrefMin = tinPowerMinTrefMin;
ThermalDataAtEquilibrium.tinPowerMinTrefMax = tinPowerMinTrefMax;
ThermalDataAtEquilibrium.tinPowerMaxTrefMin = tinPowerMaxTrefMin;
ThermalDataAtEquilibrium.tinPowerMaxTrefMax = tinPowerMaxTrefMax;

ThermalDataAtEquilibrium.tinPowerMinTrefMin = toutPowerMinTrefMin;
ThermalDataAtEquilibrium.tinPowerMinTrefMax = toutPowerMinTrefMax;
ThermalDataAtEquilibrium.toutPowerMaxTrefMin = toutPowerMaxTrefMin;
ThermalDataAtEquilibrium.toutPowerMaxTrefMax = toutPowerMaxTrefMax;

ThermalDataAtEquilibrium.lwpiPowerMinTrefMin = lwpiPowerMinTrefMin;
ThermalDataAtEquilibrium.lwpiPowerMinTrefMax = lwpiPowerMinTrefMax;
ThermalDataAtEquilibrium.lwpiPowerMaxTrefMin = lwpiPowerMaxTrefMin;
ThermalDataAtEquilibrium.lwpiPowerMaxTrefMax = lwpiPowerMaxTrefMax;


function tin = computetinatequilibrium(ThermalData, ...
    zonePowerConsumption, cracTref)

tmpMat = (eye(size(ThermalData.psiNN,1)) - ThermalData.psiNN);

tin = (ThermalData.psiNN / tmpMat) * ...
    diag(ThermalData.ci ./ ThermalData.ki) * zonePowerConsumption + ...
    (tmpMat \ ThermalData.psiNC) * cracTref;


function tout = computetoutatequilibrium(ThermalData, ...
    zonePowerConsumption, cracTref)
% tout = computetoutatequilibrium(ThermalData, zonePowerConsumption, ...
%            cracTref)

% The function computes tout via the value of tin

tin = computetinatequilibrium(ThermalData, zonePowerConsumption, cracTref);
tout = tin + diag(ThermalData.ci ./ ThermalData.ki) * zonePowerConsumption;
