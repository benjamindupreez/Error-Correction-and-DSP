function [ Gout ] = make_g_systematic( Gin )
% This function accepts a generator matrix and puts it in the standard 
% sytematic form. Any linear block code has an equivalent G matrix in
% systematic form

% ARGUMENTS
% Inputs:   - (k x n) generator matrix G
% Outputs:  - (k x n) generator matrix G in systematic form

Gout = mod(rref(Gin), 2); % Gaussian elimination method

% Uncomment for the secondary method
%n = size(Gin, 2);
%k = size(Gin, 1);
%B = Gin(:,(n-k+1):n);
%Gout = mod(inv(B)*Gin, 2); % muliply inverse B with G

end

