function [ G ] = get_g_matrix( b, a, n, k )
% This function determines the generator matrix of a code

% ARGUMENTS
% Inputs:   - row vectors for filter coefficients b and a
%           - n, the code length
%           - k, the message length
% Outputs:  - (k x n) generator matrix G

% generate empty matrix for generator matrix
G = zeros(k, n);

impulse = cat(2, [1], zeros(1, n-1));
impulse_response = gffilter(b, a, impulse);

% construct generator matrix by shifting impulse response
row_i = impulse_response;
for i = 1:k
    G(i, :) = row_i;
    row_i = circshift(row_i, [1 1]);
    row_i(1) = 0; % replace the circularly wrapped part of the shift with 0
end

end

