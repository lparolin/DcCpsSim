function crac_vec=crac_active_from_state(crac_state, C)
% function crac_vec=crac_active_from_state(crac_state, C)
% The function returns a Cx1 vector where crac_vec(i)=1 if crac i is active
% in state crac_state and 0 otherwise
% C: number of crac nodes in the system
% crac_state: current global crac state (1:2^C)

% Luca Parolini <lparolin@andrew.cmu.edu>
% Oct. 16th 2009

crac_vec = zeros(C,1);
crac_state = crac_state - 1;
if crac_state < 0
    disp('--crac_active_from_state-- Error. crac_state < 0');
    return
end

if crac_state >= 2^C
    disp('--crac_active_from_state-- Error. crac_state > 2^C');
    return
end

% code = dec2bin(crac_state,C);               % get binary value, least significant bit associated to CRAC C
                                            % most significant bit associated to CRAC
                                            % code is opposite. if code(i)=1 then
                                            % CRAC(i) state is on
                                            % NOTE: this code and num_c_active HAVE to
                                            % use different way to get code. NOTE THE
                                            % ~index instruction!!!
%crac_vec = vec(double((code == '1')));
crac_vec = double(vec(dec2bin(crac_state,C)))-'0';
return


