function cyberPhysicalIndex = computecyberphysicalindex(DcData)
%computecyberphysicalindex compute the cyber physical index of the data
%center.


% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 19th 2011



arrivalRateToPower = zeros(DcData.nZones, DcData.nJobClasses);
for iZone = 1 : DcData.nZones
    arrivalRateToPower(iZone, :) = ...
        DcData.hwUsageToPowerCoefficient(iZone,:) * DcData.jobHwRequirement;
end

% store arrivalRateToPower values in a block diagonal matrix
blockDiagonalTmp = zeros(DcData.nZones, ...
    DcData.nJobClasses * DcData.nZones);
for iZone = 1 : DcData.nZones
    colIdx = (iZone - 1) * DcData.nJobClasses + 1 : ...
        iZone * DcData.nJobClasses;
    blockDiagonalTmp(iZone, colIdx) = arrivalRateToPower(iZone, :);
end

ci = DcData.powerToTemperatureCoefficient(DcData.zoneIdx);
ki = DcData.thermalTimeConstant(DcData.zoneIdx);
diagonalTmp = diag(ci ./ ki);

psiNN = DcData.psi(DcData.zoneIdx, DcData.zoneIdx);
psiNC = DcData.psi(DcData.zoneIdx, DcData.cracIdx);
tmpToInv = eye(size(psiNN)) - psiNN;
sensMat = tmpToInv \ diagonalTmp * blockDiagonalTmp;

lambdaIntervalValue = DcData.jobArrivalRateMax - 0;
lambdaIntervalTmpMatrix = repmat(lambdaIntervalValue, ...
    DcData.nZones, DcData.nZones);
sensMat = sensMat ./ lambdaIntervalTmpMatrix;

% average values with respect to the workload class
tmpAvgMat = zeros(DcData.nZones * DcData.nJobClasses, DcData.nZones);
for iZone = 1 : DcData.nZones
    rowIdx = ((iZone - 1) * DcData.nJobClasses + 1) : ...
        (iZone * DcData.nJobClasses);
    tmpAvgMat(rowIdx, iZone) = 1;
end
tmpAvgMat = tmpAvgMat / DcData.nJobClasses;
Lnn = sensMat * tmpAvgMat; % averaged sensitivity matrix

dTindLambda = psiNN * Lnn;
dToutdLambda = Lnn;
dTindTref = tmpToInv \ psiNC;

TrefIntervalValue = DcData.trefMax - DcData.trefMin;
dTindTref = dTindTref ./ repmat(TrefIntervalValue',DcData.nZones, 1);
dToutdTref = dTindTref;    % same sensitivity

normdTinLambda = sqrt(sum(dTindLambda.^2, 2));
normdTinTref = sqrt(sum(dTindTref.^2, 2));
normdToutLambda = sqrt(sum(dToutdLambda.^2, 2));
normdToutTref = sqrt(sum(dToutdTref.^2, 2));

% tempMatrix = [normdTinLambda normdTinTref];
tempMatrix = [dTindLambda dTindTref];
dTinLambdaAverage = sum(dTindLambda, 2)/sqrt(DcData.nZones);
dTinTrefAverage = sum(dTindTref, 2)/sqrt(DcData.nCracs);
% totalNorm = sqrt(normdTinLambda.^2 + normdTinTref.^2);
totalNorm =  sqrt(sum(tempMatrix.^2, 2));

tempMatrix2 = [dToutdLambda dToutdTref];
dToutLambdaAverage = sum(dToutdLambda, 2)/sqrt(DcData.nZones);
dToutTrefAverage = sum(dToutdTref, 2)/sqrt(DcData.nCracs);
totalNorm2 =  sqrt(sum(tempMatrix2.^2, 2));


% cyberPhysicalIndex = var(diag(avgSensMat));
%cyberPhysicalIndex = std(normdTinLambda) / mean(normdTinLambda);
% cyberPhysicalIndex = std(normdTinLambda./normdTinTref);
tempNormalizedMatrix = tempMatrix ./ repmat(totalNorm, 1, size(tempMatrix, 2));
tmpNewCyberIndex = std(tempNormalizedMatrix, [], 1);
tmpNormalizingFactor = std([ones(6,1); zeros(6,1)]);
tmpNewCyberIndex = tmpNewCyberIndex / tmpNormalizingFactor;
projectedNorm = normdTinTref ./ totalNorm;
projectedNorm2 = normdToutTref ./ totalNorm2;
disp('===WARNING NORMALIZING OVER A FIXED VECTOR!!!===');
cyberPhysicalIndex = std(projectedNorm)/std([zeros(4,1); ones(4,1)]);% ./ norm(projectedNorm);
cyberPhysicalIndex2 = std(projectedNorm2)/std([zeros(4,1); ones(4,1)]);% ./ norm(projectedNorm);
%cyberPhysicalIndex = mean(tmpNewCyberIndex);

projectedNorm

disp(['Mean: ' num2str(mean(projectedNorm)) '   std:' num2str(std(projectedNorm))]);