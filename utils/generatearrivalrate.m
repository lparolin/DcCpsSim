function jobArrivalRate = generatearrivalrate(DcData, Parameters)
%GENERATEARRIVALRATE Generate job arrival rate.

% Luca Parolini
% <lparolin@andrew.cmu.edu>

% Mar. 20th 2011


timeTmp = 0 : Parameters.Simulation.timeStep : ...
    Parameters.Simulation.finalTime;
lengthTime = length(timeTmp);
dt = Parameters.Simulation.timeStep;
ctrl_arrival_delay = Parameters.Simulation.simulationDelay;

%disp('=======Generating arrival rate with changes for Luca!!!! =======');
%disp('=======Generating arrival rate with changes for Luca!!!! =======');
%disp('=======Generating arrival rate with changes for Luca!!!! =======');
dt_new_arrival = Parameters.Controller.timeStep * 4;
rate_arrival_dc = zeros(1, lengthTime);
%ctrl_time = 0 : dt_new_arrival : t_end;
max_idx = ceil(lengthTime/2);


for jj = ctrl_arrival_delay+1 : (lengthTime*dt/dt_new_arrival)
    idx_init = (jj-1) * dt_new_arrival/dt+1;
    idx_end = jj * dt_new_arrival/dt;
    rate_arrival_dc(idx_init:idx_end) = ...
        timeTmp(idx_init-ctrl_arrival_delay * dt_new_arrival/dt) ...
        .* Parameters.Simulation.jobArrivalRateMax(1) ./ timeTmp(max_idx);
end
idx_end = min(idx_end, length(rate_arrival_dc));
rate_arrival_dc(idx_end : end) = rate_arrival_dc(idx_end - 1);
idx_zero = rate_arrival_dc == 0;
idx_non_zero = rate_arrival_dc > 0;
min_non_zero = min(rate_arrival_dc(idx_non_zero));
rate_arrival_dc(idx_zero) = min_non_zero/2;
jobArrivalRate = repmat(rate_arrival_dc, DcData.nJobClasses, 1);

scalingCoefficient = Parameters.Simulation.jobArrivalRateMax(1) ./ ...
    max(max(jobArrivalRate));

%%%% Workaround %%%%
% This code fix the job arrival rate max value
jobArrivalRate = jobArrivalRate  * scalingCoefficient;
%%%%%%%%%%%%%%%%%%%%
end

