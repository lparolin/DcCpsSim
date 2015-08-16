function [DcData OptProblemData] = generateairflowexchange(DcData, ...
    weight, zerosInGamma)
%GENERATEAIRFLOWEXCHANGE Generate values of the matrix psi and gamma
%by solving a quadric optimization problem.
%
% DcData: struct which contains data about the data center
% weight: symmetric matrix to use for computing the values of gamma. If
% gamma has dimension N x N, then weights has dimension N^2 x N^2. 
% zerosInGamma: squared matrix of the same size as the matrix gamma
% composed by elements in {0,1}. If zerosInGamma(i,j)=0, then gamma(i,j)=0.


% Luca Parolini 
% <lparolin@andrew.cmu.edu>

OptProblemData = struct;

nNodes = DcData.nCracs + DcData.nZones + DcData.nEnvironments1 + ...
    DcData.nEnvironments2;

gamma = tom('gamma', nNodes, nNodes);
indexElementToZero = vec(zerosInGamma == 0);

constraints = { ...
    0 <= vec(gamma) <= 1 ...
    sum(gamma, 1) == 1 ...
    gamma(indexElementToZero) == 0 ...
    gamma * DcData.airFlow == DcData.airFlow ...
    };

costFunction = vec(gamma)' * weight * vec(gamma);

Options.Prob.KNITRO.options.FEASTOL = 1.0e-10;
[OptProblemData.solution, OptProblemData.result] = ...
    ezsolve(costFunction, constraints, [], Options);

DcData.gamma = OptProblemData.solution.gamma;
end
