function DcData = fixolddataformat(dcDataFileName)
%FIXOLDDATAFORMAT Generate a DcData struct from an old format layout data.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar.23rd 2011

DcData = struct;

data = load(dcDataFileName);

DcData.nCracs = data.C;
DcData.nRacks = data.R;
% DcData.E_1 = data.E1;
% DcData.E_2 = data.E2;
DcData.gamma = data.Gamma{end};
DcData.psi = data.Psi{end};
DcData.airFlow = data.flow{end};
% DcData.airDensity = data.air_density;
% DcData.crac_state_vec = data.crac_state_vec;
% DcData.env_position = data.env_position;
DcData.positionRack = data.rack_position;
DcData.positionCrac = data.cr_position;

%%%%%WORKAROUND%%%%%%
DcData.nZones = DcData.nRacks;  % we currently do not differentiate 
DcData.gamma = DcData.gamma;
% DcData.airFlow = DcData.airFlow;
% DcData.psi = DcData.psi(end);
% DcData.E1 = DcData.E_1;
% DcData.E2 = DcData.E_2;
DcData.nServersPerZone = 42 * 3 * ones(DcData.nZones, 1);    
%%%%%%%%%%%%%%%%%%%%%

end

