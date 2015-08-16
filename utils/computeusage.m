function usage = computeusage(DcData, SimulationData)
%COMPUTEUSAGE Compute usage of the data center racks.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 23rd 2011

lengthHwUsageOverTime = size(SimulationData.pi, 3);
% usage = squeeze(mean(SimulationData.pi./ ...
%     repmat(DcData.hwUsageToPowerCoefficient, ...
%     [1, 1, lengthHwUsageOverTime]), 2));


usage = squeeze(mean(SimulationData.pi./ ...
    repmat(DcData.hwResourceMax, ...
    [1, 1, lengthHwUsageOverTime]), 2));

end

