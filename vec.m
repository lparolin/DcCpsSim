function out = vec(in)
% out = vec(in) Returns a vector version of the matrix in.
% 
% This function exists only for fixing a problem with the function vec().
% This function was defined by other toolboxes when I used the DcSimulator
% at CMU. Now it seems it does not exist anymore. We recreate the function
% here. 

% Luca Parolini, 16 August 2015

out = (in(:));
end