function [ G ] = extract_g_matrix( b, a, C, systematic_f)
% This function extracts the generator matrix of a code, given the codebook
% and message length, k, of the code

% ARGUMENTS
% Inputs:   - row vectors for filter coefficients b and a
%           - (2^k x n) codebook matrix C
%           - optional boolean systematic_f specifying G should be further
%             manipulated into systematic form (default false)
%             block code (default is false)
% Outputs:  - (k x n) generator matrix G

% get the value of n
C_size = size(C);
k = log2(C_size(1));
n = C_size(2);

I = eye(k);

% generate empty matrix for generator matrix
G = zeros(k, n);

% append zeros to messages to ensure filter output is of length n
I = cat(2, I, zeros(k, (n - k)));

% generate generator matrix by filtering each row of I
for i = 1:k
    G(i,:) = gffilter(b, a, I(i,:));
end

if nargin == 4
    if systematic_f == true
        G = mod(rref(G), 2);
    end
end

end

