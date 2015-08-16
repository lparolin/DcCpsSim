% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Generate a data center with a thermal configuration similar to that of the data center observatory (DCO)

clear all
close all
clc

DcData = struct;

%% Constants
DcData.nRacks = 60;
DcData.nCracs = 8;
DcData.nZones = 8;
DcData.nEnvironments1 = 0;
DcData.nEnvironments2 = 0;

nNodes = DcData.nZones + DcData.nCracs;

zerosInGamma = ones(nNodes, nNodes);
zoneIdx = 1 : DcData.nZones;
cracIdx = DcData.nZones + 1 : DcData.nZones + DcData.nCracs;
zerosInGamma(zoneIdx, zoneIdx) = 0;

% CRAC 1 and 2
zerosInGamma(cracIdx(1 : 2), zoneIdx(3 : end)) = 0;
% CRAC 3 and 4
zerosInGamma(cracIdx(3 : 4), zoneIdx(1 : 2)) = 0;
zerosInGamma(cracIdx(3 : 4), zoneIdx(5 : end)) = 0;
% CRAC 5 and 6
zerosInGamma(cracIdx(5 : 6), zoneIdx(1 : 4)) = 0;
zerosInGamma(cracIdx(5 : 6), zoneIdx(7 : 8)) = 0;
% CRAC 7 and 8
zerosInGamma(cracIdx(7 : 8), zoneIdx(1 : 6)) = 0;

zerosInGamma(cracIdx, cracIdx) = 0;

%% weight
highWeightCoefficient = 4;
lowWeightCoefficient = 0.25;
normalCoefficient = 1;

lowWeight = normalCoefficient * lowWeightCoefficient;
highWeight = normalCoefficient * highWeightCoefficient;
normalWeight = normalCoefficient;

weightMatrix = ones(DcData.nZones + DcData.nCracs) * normalWeight;

weightMatrix(zoneIdx(1), cracIdx(1)) = lowWeight;
weightMatrix(zoneIdx(1), cracIdx([4, 8])) = highWeight;
weightMatrix(zoneIdx([2, 3]), cracIdx([2, 3])) = lowWeight;
weightMatrix(zoneIdx(4), cracIdx(4)) = lowWeight;
weightMatrix(zoneIdx(4), cracIdx([1, 5])) = highWeight;
weightMatrix(zoneIdx(5), cracIdx(5)) = lowWeight;
weightMatrix(zoneIdx(5), cracIdx([4, 8])) = highWeight;
weightMatrix(zoneIdx([6, 7]), cracIdx([6, 7])) = lowWeight;
weightMatrix(zoneIdx(8), cracIdx(8)) = lowWeight;
weightMatrix(zoneIdx(8), cracIdx([1, 4])) = highWeight;

weight = diag(vec(weightMatrix));

%% airFlows

% We know that airFlow*ctrmp_ct/(ktrm_ct)*airHeatCapacity = 1
% For every server we want a variation of 15C for 300W of power at regime
% we have: 15 = 1/(airFlow*airHeatCapacity)*pw ==> airFlow=pw/(15*airHeatCapacity)
% airFlow = 300/(15*airHeatCapacity)=0.0199 [Kg/s] (airFlow per server)
nominalServerAirflow = 0.02; % [Kg/s], data estimated for a 1U server
DcData.airFlow = zeros(nNodes, 1);

% Zones 1 - 4 have 9 racks each and zones 5 - 8 have 6 racks each.
DcData.nServersPerZone = [9 * ones(4, 1); 6 * ones(4, 1)] * 42;

DcData.airFlow(zoneIdx) = nominalServerAirflow * DcData.nServersPerZone;
% CRAC 1 - 4 cools 9 racks each
DcData.airFlow(cracIdx(1 : 4)) = nominalServerAirflow * 9 * 42;
% CRAC 5 - 8 cools 6 racks each
DcData.airFlow(cracIdx(5 : 8)) = nominalServerAirflow * 6 * 42;



%% generate the matrix gamma by solving a QP optimization problem
[DcData OptProblemData] = generateairflowexchange(DcData, weight, zerosInGamma);

% check matrix gamma
thresholdGamma = 1e-10;
isGammaInZeroOne = all((vec(DcData.gamma) > -thresholdGamma) & ...
    (vec(DcData.gamma) < 1 + thresholdGamma));
isGammaSumEqualToOne = all(abs(sum(DcData.gamma, 1) - 1) < thresholdGamma);
isGammaCorrect = isGammaSumEqualToOne && isGammaInZeroOne;
if ~isGammaCorrect
    disp('Values computed for DcData.gamma are out of threshold bounds.');
end

DcData.psi = diag(1./DcData.airFlow) * DcData.gamma * diag(DcData.airFlow);

%% add physical constraints
DcData.zoneTinMax = 27 * ones(DcData.nZones, 1);
DcData.zoneTinMin = -Inf * ones(DcData.nZones, 1);

DcData.cracTinMax = Inf * ones(DcData.nCracs, 1);
DcData.cracTinMin = -Inf * ones(DcData.nCracs, 1);

DcData.trefMax = 28 * ones(DcData.nCracs, 1);
DcData.trefMin = 5 * ones(DcData.nCracs, 1);

DcData.tinMax = [DcData.zoneTinMax; DcData.cracTinMax];
DcData.tinMin = [DcData.zoneTinMin; DcData.cracTinMin];

%% add parameters
DcData.zoneIdx = zoneIdx;
DcData.cracIdx = cracIdx;

% Coefficient of performance of the CRAC units
% data from Moore J. et al. "Making scheduling "cool": Temperature aware
% resource assignement in data centers. Usenix Apr. 2005
% COP = defaultCOP(1) * Tout^2 + defaultCOP(2) * Tout + defaultCOP(3)
defaultCOP = [0.0068; 0.0008; 0.458]; 
DcData.cop = repmat(defaultCOP', DcData.nCracs, 1);

defaultZoneThermalTimeConstant = 1/180;   % [1/s]
defaultCracThermalTimeConstant = 3 * defaultZoneThermalTimeConstant;
DcData.zoneThermalTimeConstant = defaultZoneThermalTimeConstant * ...
    ones(DcData.nZones, 1);
DcData.cracThermalTimeConstant = defaultCracThermalTimeConstant * ...
    ones(DcData.nCracs, 1);

DcData.thermalTimeConstant = [DcData.zoneThermalTimeConstant; ...
    DcData.cracThermalTimeConstant];

DcData.fanPowerConsumption = zeros(DcData.nCracs, 1);

%% save data
save('dco_data', 'DcData'); 