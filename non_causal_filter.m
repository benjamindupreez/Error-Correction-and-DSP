function [ y ] = non_causal_filter( h, x, zero_pos )
% This function implements a non-causal filter with impulse response h
% The output of the filter is returned starting from time 0 and with the 
% same length as the input

% ARGUMENTS
% Inputs:   - x, the data to be filtered
%           - h, the impulse response of the non-causal filter
%           - zero_pos is an integer that indicates the position in the
%           given impulse response sequence h[n] that represents n = 0
% Outputs:  - y, the filtered data of the same length as x

y = gffilter(h, 1, cat(2, x, zeros(1, size(x, 2))));
y = y((zero_pos):(zero_pos + size(x, 2) - 1));
y = mod(y, 2);

end

