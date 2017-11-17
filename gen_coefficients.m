function [ b_mat, a_mat ] = gen_coefficients( M, N )
% This function generates all the possible filter coeffient combinations
% with numerator order M and denominator order N

% ARGUMENTS
% Inputs:   - numerator order N (integer)
%           - denominator order M (integer)
% Outputs:  - (2^(M+1) - 1, M+1) matrix b_mat with different b coefficient pairs as rows
%           - (2^N, N+1) matrix a_mat with different a coefficient pairs as rows

num_of_b_coefs = M+1;
num_of_a_coefs = N+1;

b_mat = gen_msg_book(num_of_b_coefs);
% slice off the first zeros row
b_mat = b_mat(2:size(b_mat, 1),:);

% a_0 should always be 1 -> generate a_1 to a_N first
if (N-1) > 0
    a_mat = gen_msg_book((num_of_a_coefs-1));
    % now append a_0 = 1 to the front of all the rows
    a_mat = cat(2, ones((2^(num_of_a_coefs-1)), 1), a_mat);
else
    a_mat = ones((2^(num_of_a_coefs-1)), 1);
end

end