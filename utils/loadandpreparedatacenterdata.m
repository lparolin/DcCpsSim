function Parameters = loadandpreparedatacenterdata(Parameters)
% LOADANDPREPAREDATACENTERDATA Load and prepare data center data for the
% simulation
%
%   Parameters = loadandpreparedatacenterdata(Parameters)
%   Parameters is a struct data type. Parameters must have the following
%   fields:
%
%     Parameters.dataCenterDataPath: path to the mat file with the data
%     center data. The mat file must contain a struct data called DcData
%     
%     Parameters.baseDataAndFigureFolder: path to the basefolder where data
%     and figures generated during the simulation will be stored. Inside
%     the basefolder the simulator will create multiple additional folders.
%     Every simulation generates a different set of folders within
%     basefolder.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

if isempty(Parameters.dataCenterDataPath)
    msgIdentComponent = upper(mfilename);
    msgIdentMnemonic = 'InputVariableCheck';
    msgIdent = [msgIdentComponent ':' msgIdentMnemonic];
    errorToThrow = MException(msgIdent, 'Parameters.dataCenterDataPath is empty.');
    logandthrowerror(errorToThrow);
end

% load layout data
load(Parameters.dataCenterDataPath, 'DcData');
% check if DcData has been loaded
isDcDataLoaded = exist('DcData', 'var') == 1;  % EXIST('A', 'var') returns 1 if A is a 
                                        % variable in the workspace
if ~isDcDataLoaded
    % old file format, fix it
    DcData = fixolddataformat(Parameters.dataCenterDataPath);
    logcomment('Fixed old data center format.')
end

DcData.nNodes = DcData.nZones + DcData.nCracs + DcData.nEnvironments1 + ...
    DcData.nEnvironments2;

if ~isfield(DcData, 'environmentClassOneIdx');
    DcData.environmentClassOneIdx = zeros(0);
    logcomment('Fixed indexes for environmet nodes');
end

% Parameters added specific to the current simulation
DcData.nHwClasses = Parameters.nHwClasses;
DcData.nJobClasses = Parameters.nJobClasses;

%% Data center specific variables
DcData.jobArrivalRateMax = Parameters.normalizedJobArrivalRateMax .* ...
    ones(DcData.nJobClasses, 1);
DcData.hwResourceMax = 100 * ones(DcData.nZones, DcData.nHwClasses);
DcData.jobHwRequirementNormalized = repmat(sum(DcData.hwResourceMax, 1)', 1, ...
    DcData.nJobClasses) / 2;

%% Variable check
if ~isfielddefinedandrightsize(DcData, 'tinMax', [DcData.nNodes, 1])
    DcData.tinMax = [ ...
        Parameters.CONSTANT.ZONE_TIN_MAX * ones(DcData.nZones, 1); ...
        +Inf * ones(DcData.nCracs, 1); ...
        +Inf * ones(DcData.nEnvironments1, 1)];
    logcomment('Fixed maximum node input temperature.');
end

if ~isfielddefinedandrightsize(DcData, 'tinMin', [DcData.nNodes, 1])
    DcData.tinMin = [ ...
        Parameters.CONSTANT.ZONE_TIN_MIN * ones(DcData.nZones, 1); ...
        -Inf * ones(DcData.nCracs, 1); ...
        -Inf * ones(DcData.nEnvironments1, 1); ...
        -Inf * ones(DcData.nEnvironments2, 1)];
    logcomment('Fixed minimum node input temperature.');
end

if ~isfielddefinedandrightsize(DcData, 'trefMax', [DcData.nCracs, 1])
    DcData.trefMax = Parameters.CONSTANT.CRAC_TREF_MAX * ...
        ones(DcData.nCracs, 1);
    logcomment('Fixed maximum reference temperature.');
end    
    
if ~isfielddefinedandrightsize(DcData, 'trefMin', [DcData.nCracs, 1])
    DcData.trefMin = Parameters.CONSTANT.CRAC_TREF_MIN * ...
        ones(DcData.nCracs, 1);
    logcomment('Fixed minimum reference temperature.');
end    

if ~isfielddefinedandrightsize(DcData, 'zoneTinMax', [DcData.nZones, 1])
    DcData.zoneTinMax = DcData.tinMax(DcData.zoneIdx);
    logcomment('Fixed maximum zone input temperature.');
end  

if ~isfielddefinedandrightsize(DcData, 'zoneTinMin', [DcData.nZones, 1])
    DcData.zoneTinMin = DcData.tinMin(DcData.zoneIdx);
    logcomment('Fixed minimum zone input temperature.');
end

isDefined = isfield(DcData, 'cop');
if isDefined
    isRightSize = size(DcData.cop, 1) == DcData.nCracs;
end
isFieldDefinedAndRightSize = isDefined && isRightSize;

if ~isFieldDefinedAndRightSize
    DcData.cop = repmat(Parameters.CONSTANT.COP_DEFAULT_COEFFICIENTS', ...
        DcData.nCracs, 1);
    logcomment('Fixed coefficients of CRAC''s COP');
end

if ~isfielddefinedandrightsize(DcData, 'thermalTimeConstant', [DcData.nNodes, 1])
% We know that airFlow*ctrmp_ct/(ktrm_ct)*airHeatCapacity = 1
% For every server we want a variation of 15C for 300W of power at regime
% we have: 15 = 1/(airFlow*airHeatCapacity)*pw ==> airFlow=pw/(15*airHeatCapacity)
% airFlow = 300/(15*airHeatCapacity)=0.0199 [Kg/s] (airFlow per server)
% here we have 42 server per rack and 3 racks per node
% therefore the airFlow per node is 0.0199*42*3=2.5074 [Kg/s]
% and the coefficient 
% ctrmp_ct = ktrm_ct/(flow_node*airHeatCapacity)
DcData.thermalTimeConstant = [...
    Parameters.CONSTANT.SERVER_TIME_CONSTANT * ones(nZones, 1); ...
    Parameters.CONSTANT.CRAC_TIME_CONSTANT * ones(nCracs, 1); ...
    Parameters.CONSTANT.ENV_CLASS_1_TIME_CONSTANT * ones(DcData.nEnvironments1, 1)];
    
    logcomment('Fixed thermal time constants');
end

%DcData.powerToTemperatureCoefficient = cell(length(DcData.airFlow), 1);
physicalNodeIdx  = [DcData.zoneIdx(:); DcData.cracIdx(:); ...
    DcData.environmentClassOneIdx(:)];   % index of node with physical meaning

% Anonymous function, we loose a little bit of efficiency. It would be
% faster if we use an external function. This way though, the code is
% simpler to maintain.
DcData.computepowertotemperaturecoefficient = ...
    @(DataStructure) (DataStructure.thermalTimeConstant ./ ...
    (DataStructure.airFlow(physicalNodeIdx) .* ...
    Parameters.CONSTANT.AIR_HEAT_CAPACITY) );
DcData.powerToTemperatureCoefficient = ...
    DcData.computepowertotemperaturecoefficient(DcData);

DcData.fanPowerConsumption = Parameters.CONSTANT.FAN_POWER_MAX * ...
    ones(DcData.nCracs, 1);

DcData.zonePowerMax = Parameters.CONSTANT.SERVER_POWER_MAX * ...
    DcData.nServersPerZone; % [W]

% compute cyber-physical index
% DcData.cyberPhysicalIndex = computecyberphysicalindex(DcData);
%DcData.powerConsumptionEnvironmentNodeClass1 = zeros(DcData.E1, 1);        

%% Data center variables
DcData.zoneIdx = (1 : DcData.nZones)'; % zone indexes
DcData.cracIdx = (DcData.zoneIdx(end) + 1 : ...
    DcData.zoneIdx(end) + DcData.nCracs)';

% short notation for some variables
nJobClasses = DcData.nJobClasses;
nHwClasses = DcData.nHwClasses;                                  
nZones = DcData.nZones;
% nCracs = DcData.nCracs;

%% FIXME
hwUsageMaxTemporary = repmat(DcData.hwResourceMax, 1, nJobClasses);
jobHwRequirementTemporary = repmat(vec(DcData.jobHwRequirementNormalized')', ...
    nZones, 1);
jobDepartureRateMaxTemporary = hwUsageMaxTemporary ./ jobHwRequirementTemporary;
% reshape the matrix so that it becomes nZones x nHwClasses x nJobClasses
jobDepartureRateMaxTemporary = reshape(jobDepartureRateMaxTemporary, [nZones, ...
    nHwClasses, nJobClasses]);
DcData.jobDepartureRateMax = squeeze(max(jobDepartureRateMaxTemporary, [], 2));

DcData.hwUsageToPowerCoefficient = zeros(nZones, nHwClasses);
% compute the coefficients to get the zone power consumption from the
% amount of hardware they use
for iZone = 1 : nZones
    DcData.hwUsageToPowerCoefficient(iZone, :) = ...
        DcData.zonePowerMax(iZone) * ones(1, DcData.nHwClasses) ./ ...
        sum(DcData.hwResourceMax(iZone, :) ); %temporary changed
end

DcData.jobDepartureRateToPowerConsumption = ...
    DcData.hwUsageToPowerCoefficient * DcData.jobHwRequirementNormalized;

Parameters.DcData = DcData;
end

function isFieldRight = isfielddefinedandrightsize(DcData, fieldName, sizeField)
    isFieldRight = false;
    isFieldDefined = isfield(DcData, fieldName);
    if isFieldDefined    
        isFieldRight = size(DcData.(fieldName)) == sizeField;
    end
end