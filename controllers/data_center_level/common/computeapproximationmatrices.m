

function DiscreteTimeMatrix = computeapproximationmatrices( ...
    Matrix, timeStep, infinityNormThreshold, singularvalueRatioThreshold) %#ok<INUSD>
%COMPUTEAPPROXIMATIONMatrix Compute the value of the Matrix of the
%discerete-time LTI system that approximates the evolution of the
%continuous-time LTI system given at the input
%
% DiscreteTimeMatrix = computeapproximationMatrix(Matrix, timeStep, ...
%    infinityNormThreshold, singularvalueRatioThreshold)
% 
% Matrix: struct containing the continous-time LTI system, i.e., Matrix.a
% Matrix.b, Matrix.c, and Matrix.d .
% 
% timeStep: time step used in the discrete-time system.
% 
% infinityNormThreshold: threshold for the infinity norm of the
% discrete-time version of the matrix Matrix.a. If the infinity norm of
% the discrete-time matrix is lower than infinityNormThreshold, then no
% dynamics is considered in the discrete-time system.
%
% singularvalueRatioThreshold: defines the minimum allowed threshold
% between the singular values of the discrete-time version of the Matrix Matrix.a, Matrix.b, 
% Matrix.c, and Matrix.d and their maximum singular value. 
% For example, if DiscreteTimeMatrixTmp.a is the discrete-time version of Matrix.a,
% then DiscreteTimeMatrix.a is the matrix that best approximate
% DiscreteTimeMatrixTmp.a and such that all of its singular values are
% greater than max(singularValue(DiscreteTimeMatrixTmp.a)) * singularvalueRatioThreshold


    DiscreteTimeMatrix = struct;
    
    % discretize
    ContinousTimeSystem = ss(Matrix.a, Matrix.b, ...
        Matrix.c, Matrix.d);
    DiscreteTimeSystem = c2d(ContinousTimeSystem, ...
        timeStep, 'zoh');
    
    % Analyize thermal system dynamic with respect to the controller sampling
    % time
    
    % Simplify the matrix in order to avoid extremely large and small
    % eigenvalues
%     DiscreteTimeSystem.a = simplifymatrix(DiscreteTimeSystem.a, ...
%         singularvalueRatioThreshold);
%     DiscreteTimeSystem.b = simplifymatrix(DiscreteTimeSystem.b, ...
%         singularvalueRatioThreshold);
%     DiscreteTimeSystem.c = simplifymatrix(DiscreteTimeSystem.c, ...
%         singularvalueRatioThreshold);
%     DiscreteTimeSystem.d = simplifymatrix(DiscreteTimeSystem.d, ...
%         singularvalueRatioThreshold);
    
    if norm(DiscreteTimeSystem.a, Inf) < infinityNormThreshold
        % Controller time scale is so large that it is possible (and
        % computationally convenient) to neglect the dynamic of the thermal
        % part
        logcomment('No dynamic will be considered.');
        DiscreteTimeMatrix.a = sparse(size(Matrix.a, 1), ...
            size(Matrix.a, 2));
        DiscreteTimeMatrix.b = -Matrix.a \ Matrix.b;
    else
        DiscreteTimeMatrix.a = DiscreteTimeSystem.a;
        DiscreteTimeMatrix.b = DiscreteTimeSystem.b;
    end
    
    DiscreteTimeMatrix.c = DiscreteTimeSystem.c;
    DiscreteTimeMatrix.d = DiscreteTimeSystem.d;
end


function simplifiedMatrix = simplifymatrix(originalMatrix, ...
        singularvalueRatioThreshold)
    
    [U S V] = svd(originalMatrix);
    singularvalue = diag(S);
    minSingularvalue = min(singularvalue);
    maxSingularvalue = max(singularvalue);
    singularvalueRatio = minSingularvalue / maxSingularvalue;
    
    if singularvalueRatio < singularvalueRatioThreshold
        minAllowedSingularvalue = maxSingularvalue * singularvalueRatioThreshold;
        
        singularvalueIdxToRemove = singularvalue < minAllowedSingularvalue;
        singularvalue(singularvalueIdxToRemove) = 0;
    end
    simplifiedMatrix = U * diag(singularvalue) * V';
end

